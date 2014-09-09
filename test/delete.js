var assert = require("assert");

x = 42;
var y = 43;
myobj = {
    h: 4,
    k: 5
};

var myobj2 = {
    h: 4,
    k: 5
};

assert(delete x);
assert(typeof x === "undefined");
assert(!(delete y));
assert(y === 43);
assert(delete myobj.h);
assert(typeof myobj.h === "undefined");
assert(delete myobj);
assert(typeof myobj === "undefined");

assert(delete myobj2.h);
assert(typeof myobj2.h === "undefined");
assert(!(delete myobj2));
assert(typeof myobj2 === "object");

function Foo() {}
Foo.prototype.bar = 42;
var foo = new Foo();

assert(delete foo.bar);
assert(typeof foo.bar !== "undefined");
assert(delete Foo.prototype.bar);
assert(typeof foo.bar === "undefined");

// Delete getter/setter

var o = {get p () {return 12}, set s (v) {}}

assert(o.p === 12);
assert(delete o.p);
assert(delete o.s);
assert(typeof(o.p) === "undefined");
assert(typeof(o.s) === "undefined");
