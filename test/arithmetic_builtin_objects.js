var assert = require("assert");

var a = new Number(7);
var b = new String("7");
var c = new Boolean(true);

assert(a + 3 === 10);
assert(3 + a === 10);
assert(a - 3 === 4);
assert(3 - a === -4);
assert(a * 3 === 21);
assert(3 * a === 21);
assert(a / 3 === 7/3);
assert(3 / a === 3/7);

assert(b + 3 === "73");
assert(3 + b === "37");
assert(b - 3 === 4);
assert(3 - b === -4);
assert(b * 3 === 21);
assert(3 * b === 21);
assert(b / 3 === 7/3);
assert(3 / b === 3/7);

assert(c + 3 === 4);
assert(3 + c === 4);
assert(c - 3 === -2);
assert(3 - c === 2);
assert(c * 3 === 3);
assert(3 * c === 3)
assert(c / 3 === 1/3)
assert(3 / c === 3)
