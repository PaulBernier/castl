var assert = require("assert");

var a = new Error("Whoops!");

assert(a.name === "Error");
assert(a.message === "Whoops!");
assert(a.toString() === "Error: Whoops!");
assert(a instanceof Error);

try {
    throw a;
} catch (e) {
    assert(e.name === "Error");
    assert(e.message === "Whoops!");
    assert(e.toString() === "Error: Whoops!");
    assert(e instanceof Error);
}

// SyntaxError
try{
    throw SyntaxError("syntax");
}catch(e) {
    assert(e.message === "syntax");
    assert(e.name === "SyntaxError");
}

// TypeError
try{
    throw TypeError("type");
}catch(e) {
    assert(e.message === "type");
    assert(e.name === "TypeError");
}

// SyntaxError
try{
    throw RangeError("range");
}catch(e) {
    assert(e.message === "range");
    assert(e.name === "RangeError");
}

// SyntaxError
try{
    throw ReferenceError("reference");
}catch(e) {
    assert(e.message === "reference");
    assert(e.name === "ReferenceError");
}

// URIError
try{
    throw URIError("reference");
}catch(e) {
    assert(e.message === "reference");
    assert(e.name === "URIError");
}

// EvalError
try{
    throw EvalError("reference");
}catch(e) {
    assert(e.message === "reference");
    assert(e.name === "EvalError");
}

//
var a = new RangeError("yolo");
assert(a instanceof Error);
assert(a.toString === RangeError.prototype.toString);
assert(a.toString === Error.prototype.toString);
assert(!(RangeError.prototype === Error.prototype));
