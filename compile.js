var castl = require("./castl.js");
var fs = require('fs');
var filename = process.argv[2];
var parser = require(process.argv[3]);

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
    if (process.argv[4] === "true") {
        compiledCode = "_nodejs = true\n" + compiledCode + "\nreturn exports";
    }

    console.log(compiledCode);
});
