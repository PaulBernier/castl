var assert = require("assert");

// abs
assert(Math.abs(-6) === 6);
assert(Math.abs(7) === 7);
assert(Math.abs(null) === 0);
assert(Math.abs("-5") === 5);
assert(Number.isNaN(Math.abs("str")));
assert(Number.isNaN(Math.abs()));
