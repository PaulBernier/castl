var castl = require("./castl.js");
var fs = require('fs');
var filename = process.argv[2];
var parser = require(process.argv[3]);
var nodejs = process.argv[4];
var luajit = process.argv[5];

// Read code from js file
fs.readFile(filename, 'utf8', function (err, data) {
    if (err) {
        return console.log(err);
    }

    var syntax = "";
    try {
        syntax = parser.parse(data);
    } catch (e) {
        throw new Error("Couldn't parse JS code");
    }

    var compiledCode = castl.compileAST(syntax).compiled;
    var finalCode = [];


    // Set environment
    if (nodejs === "true") {
        finalCode.push("_nodejs = true");
    }
    if (luajit === "true") {
        finalCode.push("return setfenv(function(...)");
        finalCode.push(compiledCode);
        if (nodejs === "true") {
            finalCode.push("return exports");
        }
        finalCode.push("end, require(\"castl.runtime\"))()");
    } else {
        finalCode.push("_ENV = require(\"castl.runtime\")");
        finalCode.push(compiledCode);
        if (nodejs === "true") {
            finalCode.push("return exports");
        }
    }
    
    console.log(finalCode.join("\n"));
});
