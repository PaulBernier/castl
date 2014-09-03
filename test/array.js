var assert = require("assert");

var a = new Array(21);
var b = new Array(21, "pp", "test");
var c = Array(21);
var d = Array(21, "foo", "bar");
var e = [];
var f = [8, 12, "abs"];

assert(a.length === 21);
assert(typeof a[0] === "undefined");

assert(b.length === 3);
assert(b[0] === 21);
assert(b[2] === "test");
assert(typeof b[3] === "undefined");

assert(c.length === 21);
assert(typeof c[0] === "undefined");

assert(d.length === 3);
assert(d[0] === 21);
assert(d[2] === "bar");
assert(typeof d[3] === "undefined");

assert(e.length === 0);
assert(typeof e[0] === "undefined");

assert(f.length === 3);
assert(f[0] === 8);

a[11] = "doctor";
assert(a[11] === "doctor");

// Instance of
assert(Array instanceof Object);
assert(a instanceof Array);
assert(b instanceof Array);
assert(c instanceof Array);
assert(d instanceof Array);
assert(e instanceof Array);
assert(f instanceof Array);

e[1336] = "foo";
assert(e.length === 1337);

var g = [2, 3, , 5];
assert(typeof g[2] === "undefined");

assert(Array.isArray(a));
assert(Array.isArray(c));
assert(Array.isArray(e));

var dumbObject = {};
assert(!Array.isArray(dumbObject));
