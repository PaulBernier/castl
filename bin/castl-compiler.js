#!/usr/bin/env node

var castl = require("../castl.js");
var fs = require('fs');
var filename = process.argv[2];
var parserName = process.argv[3];
var nodejs = process.argv[4] === "true";
var luajit = process.argv[5] === "true";
var tolerant = process.argv[6] === "true";
var debug = process.argv[7] === "true";
var evalMode = process.argv[8] === "true";

var parser = require(parserName);

var parserOptions = {}
var castlOptions = {
    jit: luajit,
    evalMode: evalMode
};

if (tolerant) {
    if (parserName === "esprima") {
        parserOptions.tolerant = true
    } else if (parserName === "acorn") {
        parserOptions.allowReturnOutsideFunction = true
        parserOptions.allowTrailingCommas = true
    }
}

if (debug) {
    castlOptions.debug = true;
    if (parserName === "esprima") {
        parserOptions.loc = true;
    } else if (parserName === "acorn") {
        parserOptions.locations = true;
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
        syntax = parser.parse(data, parserOptions);
    } catch (e) {
        throw new SyntaxError("Couldn't parse JS code");
    }

    var compiledCode = castl.compileAST(syntax, castlOptions).compiled;
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
