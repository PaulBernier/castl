var assert = require("assert");

i = 12;

var f = new Function("i++");
f();
f();
assert(i === 14);

var f2 = new Function("return 9");
assert(f2() === 9);

var f3 = new Function("return arguments[0] * 2");
assert(f3(8,9,10) === 16);

var f4 = new Function("a", "b", "return a * b");
assert(f4(8,9,10) === 72);
