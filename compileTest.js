var castl = require("./castl.js");
var fs = require('fs');
// Require Esprima as default parser
var parser = require('esprima');
// var parser = require('acorn');
var filename = process.argv[2];

// Read code from js file
fs.readFile(filename, 'utf8', function (err, data) {
    if (err) {
        return console.log(err);
    }

    var position = data.indexOf('\n');

    if (position !== -1) {
        var firstLine = data.substr(0, position).trim();

        if (firstLine === "var assert = require('assert');" ||
                firstLine === "var assert = require(\"assert\");") {
            // Skip first line
            data = data.substr(position + 1);

            var syntax = "";
            try {
                syntax = parser.parse(data);
            } catch (e) {
                throw new Error("Couldn't parse JS code");
            }

            var compiledCode = castl.compileAST(syntax).compiled;
            compiledCode = compiledCode.replace(/assert\(this,/g, "assert(");
            compiledCode = "local assert, print = assert, print\n" + compiledCode;

            // Write compiled code
            var luaFilename = filename;
            // Remove js extension
            luaFilename = luaFilename.substring(0, luaFilename.length - 2);
            luaFilename += "lua";

            fs.writeFile(luaFilename, compiledCode, function (err) {
                if (err) { // if error, report
                    console.log(err);
                }
            });
        } else {
            throw new Error("First line of file must be 'var assert = require('assert');' ");
        }
    } else {
        throw new Error("No lines in the file");
    }

});
