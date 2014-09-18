var assert = require("assert");

var a = new RegExp("rr", "gim");
var b = new RegExp(a);
var c = RegExp(a);

assert(a.source === "rr");
assert(a.global === true);
assert(a.ignoreCase === true);
assert(a.multiline === true);

assert(b.source === "rr");
assert(b.global === true);
assert(b.ignoreCase === true);
assert(b.multiline === true);

assert(c.source === "rr");
assert(c.global === true);
assert(c.ignoreCase === true);
assert(c.multiline === true);

assert(!(a === b));
assert(a === c);

var d = new RegExp({toString: function(){return "test"}});
assert(d.source === "test");
