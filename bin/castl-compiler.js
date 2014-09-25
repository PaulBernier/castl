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
var mini = process.argv[9] === "true";
var annotation = process.argv[10] === "true";

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

var annotations = {};
if (annotation) {
    castlOptions.annotation = true;

    if (parserName === "esprima") {
        parserOptions.comment = true;
        parserOptions.loc = true;

        function processEsprimaComments(comments) {
            const regexp = /@(\S*)/;
            var i, comment, castlComment;
            for (i = 0; i < comments.length; ++i) {
                comment = regexp.exec(comments[i].value);
                if (comment !== null) {
                    annotations[comments[i].loc.start.line] = comment[1];
                }
            }
        }
    } else if (parserName === "acorn") {
        parserOptions.onComment = function (block, text, start, end, loc) {
            const regexp = /@(\S*)/;
            var comment = regexp.exec(text);
            if (comment !== null) {
                annotations[loc.line] = comment[1];
            }
        };
        parserOptions.locations = true;
    }
}

// Read code from js file
fs.readFile(filename, 'utf8', function (err, data) {
    if (err) {
        console.log("Error reading file " + filename, err);
        process.exit(1);
    }

    var ast;
    try {
        ast = parser.parse(data, parserOptions);

        if (annotation && parserName === "esprima") {
            processEsprimaComments(ast.comments);
        }

        // Minify AST
        if (mini) {
            var esmangle = require("esmangle");
            ast = esmangle.mangle(ast);
        }
    } catch (e) {
        throw new SyntaxError("Couldn't parse JS code" + e);
    }

    var compiledCode = castl.compileAST(ast, castlOptions, annotations).compiled;
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
            finalCode.push("return module.exports;");
        }
        finalCode.push("end, _ENV)();");
    } else {
        finalCode.push("local _ENV = require(\"castl.runtime\");");
        finalCode.push(compiledCode);
        if (nodejs) {
            finalCode.push("return module.exports;");
        }
    }

    console.log(finalCode.join("\n"));
});
