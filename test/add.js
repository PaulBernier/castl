var assert = require("assert");

var c = "Hello";
c += (1 < 2) ? "s" : "o";
assert(c === "Hellos");

assert(8 + 9 === 17);
assert("8" + "3" === "83");
assert(8 + "3" === "83");
assert("3" + 8 === "38");
assert(null + 8 === 8);
assert(null + "8" === "null8");
assert(8 + null === 8);
assert("8" + null === "8null");
