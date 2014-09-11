#!/usr/bin/env node

var castl = require("../castl.js");
var fs = require('fs');
var filename = process.argv[2];
var parserName = process.argv[3];
var nodejs = process.argv[4] === "true";
var luajit = process.argv[5] === "true";
var tolerant = process.argv[6];

var parser = require(parserName);

var options = {}
if (tolerant === "true") {
    if (parserName === "esprima") {
        options.tolerant = true
    } else if (parserName === "acorn") {
        options.allowReturnOutsideFunction = true
        options.allowTrailingCommas = true
    }
}

// Read code from js file
fs.readFile(filename, 'utf8', function (err, data) {
    if (err) {
        console.log("Error reading file " + filename, err);
        process.exit(1);
    }

    var syntax = "";
    try {
        syntax = parser.parse(data, options);
    } catch (e) {
        throw new SyntaxError("Couldn't parse JS code");
    }

    var options = {jit: luajit};
    var compiledCode = castl.compileAST(syntax, options).compiled;
    var finalCode = [];

    // Set environment
    if (nodejs) {
        finalCode.push("_nodejs = true;");
    }
    if (luajit) {
        finalCode.push("local _ENV = require(\"castl.runtime\");");
        finalCode.push("return setfenv(function(...)");
        finalCode.push(compiledCode);
        if (nodejs) {
            finalCode.push("return exports;");
        }
        finalCode.push("end, _ENV)();");
    } else {
        finalCode.push("local _ENV = require(\"castl.runtime\");");
        finalCode.push(compiledCode);
        if (nodejs) {
            finalCode.push("return exports;");
        }
    }

    console.log(finalCode.join("\n"));
});
