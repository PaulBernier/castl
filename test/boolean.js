var assert = require("assert");

var a = Boolean(true);
assert(a);

var b = new Boolean(true);
assert(b);
assert(b.toString() === "true");

var c = Boolean(false);
assert(!c);

var d = new Boolean(false);
assert(d);
assert(d.toString() === "false");

var e = new Boolean(c);
assert(e);
assert(e.toString() === "false");

var f = Boolean(c);
assert(!f);

var g = Boolean({});
assert(g);

var h = Boolean();
assert(!h);

var i = new Boolean();
assert(i);
assert(i.toString() === "false");

//////
var n = Boolean(7)
var m = new Boolean(77)
var o = true

assert(n == true);
assert(m == true);
assert(o == true);
assert(n === true);
assert(!(m === true));
assert(o === true);
assert(typeof(n) === "boolean");
assert(typeof(m) === "object");
assert(typeof(o) === "boolean");
assert(!(n instanceof Boolean));
assert(m instanceof Boolean);
assert(!(o instanceof Boolean));
assert(n.toString() === "true");
assert(m.toString() === "true");
assert(o.toString() === "true");
assert(-n === -1);
assert(-m === -1);
assert(-o === -1);
