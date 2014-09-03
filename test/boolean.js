var assert = require("assert");

var a = Boolean(true);
assert(a);

var b = new Boolean(true);
assert(b);

var c = Boolean(false);
assert(!c);

var d = new Boolean(false);
assert(d);

var e = new Boolean(c);
assert(e);

var f = Boolean(c);
assert(!f);

var g = Boolean({});
assert(g);
