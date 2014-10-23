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

process.env['LUA_PATH'] = process.env['LUA_PATH'] + ";/usr/local/lib/node_modules/castl/lua/?.lua;";

var exec = require('child_process').exec;
var path = require("path");
var parsername = "esprima";
var execute = true;
var outputname;

/**********************
 *
 * handle parameters
 *
 * *******************/

var program = require('commander');
program
    .usage('[options] <file>')
    .option('-v, --verbose', 'Verbose, print the compiled code to be run')
    .option('-o, --output [name]', 'Output the generated Lua code in a file. The default output name is <filename>.lua')
    .option('-b, --bytecode', 'If -o option is active the outputted code is in Lua/LuaJIT bytecode')
    .option('-v, --verbose', 'Verbose, print the compiled code to be run')
    .option('-n, --linenumber', 'Print line numbers if -v or --cat options are active')
    .option('-a, --annotation', 'Use annotations to optimize generated code')
    .option('-g, --heuristic', 'Enable heuristic compilation')
    .option('--cat', 'Don\'t execute, just print the code that would be run')
    .option('--jit', 'Compile for LuaJIT (and execute with LuaJIT instead of Lua 5.2 interpreter)')
    .option('--mini', 'Minify AST using Esmangle before compiling. Size of outputted file is shrunk')
    .option('--debug', 'Add comments in the Lua code referring to the line number of the original statement in the JS file')
    .option('--acorn', 'use Acorn parser. If not specified Esprima is used')
    .option('--strict', 'Make Esprima and Acorn not error-tolerant')
    .option('--node', 'Add a very basic support of NodeJS \'require\' system')
    .parse(process.argv);

var filename = program.args.length > 0 ? program.args[0] : "code.js";

if (program.acorn) {
    parsername = "acorn";
}

if (program.cat) {
    execute = false;
    program.verbose = true;
}

if (program.output) {
    execute = false;
    if (typeof (program.output) === "string") {
        outputname = program.output;
    } else {
        outputname = filename + ".lua";
    }
}

/**********************
 *
 * Transpile JS to Lua
 *
 * *******************/

var parser = require(parsername);
var castl = require("../castl.js");
var fs = require('fs');

// Options for CASTL
var castlOptions = {
    jit: program.jit,
    evalMode: false,
    heuristic: program.heuristic,
    debug: program.debug,
    annotation: program.annotation
};

// Options for parser
var parserOptions = {};

if (!program.strict) {
    if (parsername === "esprima") {
        parserOptions.tolerant = true;
    } else if (parsername === "acorn") {
        parserOptions.allowReturnOutsideFunction = true;
        parserOptions.allowTrailingCommas = true;
    }
}

if (program.debug || program.heuristic || program.annotation) {
    // Enable location
    if (parsername === "esprima") {
        parserOptions.loc = true;
    } else if (parsername === "acorn") {
        parserOptions.locations = true;
    }
}

var annotations = {};
if (program.annotation) {
    if (parsername === "esprima") {
        parserOptions.comment = true;

        function processEsprimaComments(comments) {
            var regexp = /@(\S*)/;
            var i, comment;
            for (i = 0; i < comments.length; ++i) {
                comment = regexp.exec(comments[i].value);
                if (comment !== null) {
                    annotations[comments[i].loc.start.line] = comment[1];
                }
            }
        }
    } else if (parsername === "acorn") {
        parserOptions.onComment = function (block, text, start, end, loc) {
            var regexp = /@(\S*)/;
            var comment = regexp.exec(text);
            if (comment !== null) {
                annotations[loc.line] = comment[1];
            }
        };
    }
}

// Read, parse and transpile JS code

var data = fs.readFileSync(filename, 'utf8');
var ast, compiledCode;
try {
    ast = parser.parse(data, parserOptions);

    if (program.annotation && parsername === "esprima") {
        processEsprimaComments(ast.comments);
    }

    // Minify AST
    if (program.mini) {
        var esmangle = require("esmangle");
        ast = esmangle.mangle(ast);
    }

    compiledCode = castl.compileAST(ast, castlOptions, annotations).compiled;
} catch (e) {
    throw new SyntaxError("Couldn't transpile JS code: " + e);
}

// Add environment
var finalCode = [];

if (program.node) {
    finalCode.push("_nodejs = true;");
}
if (program.jit) {
    finalCode.push("local _ENV = require(\"castl.runtime\");");
    finalCode.push("return setfenv(function(...)");
    if (program.node) {
        finalCode.push("local module = _obj({exports = _obj({})})");
        finalCode.push("local exports = module.exports");
    }
    finalCode.push(compiledCode);
    if (program.node) {
        finalCode.push("return module.exports;");
    }
    finalCode.push("end, _ENV)();");
} else {
    finalCode.push("local _ENV = require(\"castl.runtime\");");
    if (program.node) {
        finalCode.push("local module = _obj({exports = _obj({})})");
        finalCode.push("local exports = module.exports");
    }
    finalCode.push(compiledCode);
    if (program.node) {
        finalCode.push("return module.exports;");
    }
}

var transpiledCode = finalCode.join("\n");

/******************************
 *
 * Actions on transpiled code
 *
 * ***************************/

// Padding function
function pad(n, width) {
    n = n + '';
    return n.length >= width ? n : n + new Array(width - n.length + 1).join(" ");
}

if (program.verbose) {
    if (program.jit) {
        console.log("-- Lua code (LuaJIT):");
    } else {
        console.log("-- Lua code (Lua 5.2):");
    }
    console.log("--------------------------------------------------------------------");
    if (!program.linenumber) {
        console.log(transpiledCode);
    } else {
        var lines = transpiledCode.split("\n");
        var width = (lines.length + '').length;
        var i;
        for (i = 0; i < lines.length; ++i) {
            console.log("%s    %s", pad(i + 1, width), lines[i]);
        }
    }
    console.log("\n--------------------------------------------------------------------");
}

var tmpFilename = path.dirname(filename) + "/." + path.basename(filename) + ".lua";

if (program.output || execute) {
    fs.writeFileSync(tmpFilename, transpiledCode, "utf8");
}

var execCallback = function (error, stdout, stderr) {
    if (stdout) console.log(stdout);
    if (stderr) console.log(stderr);
    if (error !== null) {
        if (fs.existsSync(tmpFilename)) fs.unlinkSync(tmpFilename);
        process.exit(8);
    }
}

if (program.output) {
    // Output to bytecode
    if (program.bytecode) {
        // LuaJIT bytecode
        if (program.jit) {
            exec("luajit -b " + tmpFilename + " " + outputname, execCallback);
        } else { // Lua 5.2 bytecode
            exec("luac5.2 -o " + outputname + " " + tmpFilename, execCallback);
        }
    } else { // Output to text
        fs.writeFileSync(outputname, transpiledCode, "utf8");
    }
}

if (execute) {
    if (program.jit) {
        if (program.verbose)
            console.log("-- Execution output (LuaJIT):");
        exec("luajit " + tmpFilename, execCallback);
    } else {
        if (program.verbose)
            console.log("-- Execution output (Lua 5.2):");
        exec("lua5.2 " + tmpFilename, execCallback);
    }
}

if (program.output || execute) {
    if (fs.existsSync(tmpFilename)) fs.unlinkSync(tmpFilename);
}
