#!/usr/bin/env node

var castl = require("../castl.js");
var fs = require('fs');
var filename = process.argv[2];
var parserName = process.argv[3];
var nodejs = process.argv[4];
var luajit = process.argv[5];
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
        throw new Error("Couldn't parse JS code");
    }

    var compiledCode = castl.compileAST(syntax).compiled;
    var finalCode = [];

    // Set environment
    if (nodejs === "true") {
        finalCode.push("_nodejs = true;");
    }
    if (luajit === "true") {
        finalCode.push("return setfenv(function(...)");
        finalCode.push(compiledCode);
        if (nodejs === "true") {
            finalCode.push("return exports;");
        }
        finalCode.push("end, require(\"castl.runtime\"))();");
    } else {
        finalCode.push("_ENV = require(\"castl.runtime\");");
        finalCode.push(compiledCode);
        if (nodejs === "true") {
            finalCode.push("return exports;");
        }
    }

    console.log(finalCode.join("\n"));
});
