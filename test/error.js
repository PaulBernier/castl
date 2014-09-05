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
