#!/usr/bin/env node

/*
    Copyright (c) 2014, Paul Bernier

    CASTL is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    CASTL is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.
    You should have received a copy of the GNU Lesser General Public License
    along with CASTL. If not, see <http://www.gnu.org/licenses/>.
*/

(function () {
    "use strict";
    process.env['LUA_PATH'] = process.env['LUA_PATH'] + ";/usr/local/lib/node_modules/castl/lua/?.lua;/usr/lib/node_modules/castl/lua/?.lua;";

    var fs = require("fs");
    var path = require("path");
    var execSync = require('child_process').execSync;
    var castl = require("./castl.js");

    /*********************************
     *
     * handle parameters and options
     *
     * *******************************/

    var program = require('commander');
    program
        .option('--jit', 'Test using LuaJIT')
        .option('--acorn', 'Test using Acorn')
        .parse(process.argv);

    var parserName = program.acorn ? "acorn" : "esprima";
    var parser = require(parserName);

    // Parser options
    var parserOptions = {};
    if (parserName === "esprima") {
        parserOptions.loc = true;
    } else if (parserName === "acorn") {
        parserOptions.locations = true;
    }

    // Castl options
    var castlOptions = {
        jit: program.jit,
        evalMode: false,
        debug: true,
        heuristic: false
    };

    /**************************
     *
     * Get list of test files
     *
     * ************************/

    function addJsFilesFromFolder(filesList, folderPath) {
        var dirfiles = fs.readdirSync(folderPath);
        for (i = 0; i < dirfiles.length; ++i) {
            file = dirfiles[i];
            if (path.extname(file) === ".js") {
                filesList.push(folderPath + file);
            }
        }
    }

    var i, file;
    var files = [];
    if (program.args.length > 0) {
        files = program.args;
    } else {
        addJsFilesFromFolder(files,"./test/");
        addJsFilesFromFolder(files,"./test/issues/");
    }

    /**************************
     *
     * Test each file
     *
     * ************************/

    // Padding functions
    function padRight(n, width) {
        n = n + '';
        return n.length >= width ? n : n + new Array(width - n.length + 1).join(" ");
    }

    function padLeft(str, padding) {
        return new Array(padding).join(" ") + str;
    }

    var total = files.length;
    var width = (total + '').length + 2;
    var offset = 60;
    var code, testHeader, failed = [];
    for (i = 0; i < total; ++i) {
        file = files[i];
        testHeader = padRight((i + 1) + ".", width) + file;
        process.stdout.write(testHeader);

        // 1. Execute js file
        code = execSync("nodejs " + file);
        if (code > 0) {
            console.log("--> Compilation of js code failed!");
            failed.push({
                src: file,
                code: 1
            });
            continue;
        }

        // 2. Compile JS to Lua
        try {
            compileTest(file);
        } catch (e) {
            console.log(e.stack);
            console.log("--> Compilation of js code failed!");
            failed.push({
                src: file,
                code: 2
            });
            continue;
        }

        // 3. Execute lua code compiled
        if (program.jit) {
            code = execSync("luajit " + file + ".lua");
        } else {
            code = execSync("lua5.2 " + file + ".lua");
        }

        if (code > 0) {
            console.log("--> Execution of lua code failed!");
            failed.push({
                src: file,
                code: 3
            });
            continue;
        }

        console.log(padLeft("--> Everything Is AWESOME!!!", offset - testHeader.length));
    }

    function compileTest(filename) {
        var data = fs.readFileSync(filename, 'utf8');

        var position = data.indexOf('\n');

        if (position !== -1) {
            var firstLine = data.substr(0, position).trim();

            if (firstLine === "var assert = require('assert');" ||
                firstLine === "var assert = require(\"assert\");") {
                // Skip first line
                data = data.replace(/^[^\n]*\n/, "\n");

                var syntax = "";
                try {
                    syntax = parser.parse(data, parserOptions);
                } catch (e) {
                    throw new SyntaxError("Couldn't parse JS code");
                }

                var compiledCode = castl.compileAST(syntax, castlOptions).compiled;
                compiledCode = compiledCode.replace(/assert\(_ENV,/g, "assert(");
                var finalCode = ["local assert, print = assert, print"];

                // Set environment
                if (program.jit) {
                    finalCode.push("local _ENV = require(\"castl.runtime\");");
                    finalCode.push("return setfenv(function(...)");
                    finalCode.push(compiledCode);
                    finalCode.push("end, _ENV)();");
                } else {
                    finalCode.push("local _ENV = require(\"castl.runtime\");");
                    finalCode.push(compiledCode);
                }

                fs.writeFileSync(filename + ".lua", finalCode.join("\n"));
            } else {
                throw new Error("First line of file must be 'var assert = require('assert');' ");
            }
        } else {
            throw new Error("No lines in the file");
        }
    }

    /**************************
     *
     * Display result
     *
     * ************************/

    console.log("----------------------------------------------");
    if (program.jit) {
        console.log("Report (LuaJIT):");
    } else {
        console.log("Report (Lua 5.2):");
    }

    var success = total - failed.length;
    console.log("Passed: " + success + "/" + total + "\n");
    if (success !== total) {
        console.log("Failed: " + failed.length);
        failed.forEach(function (test) {
            console.log("-" + test.src + " - Code: " + test.code);
        });
    }
}());
