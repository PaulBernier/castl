var assert = require("assert");

x = 42;
var y = 43;
myobj = {
    h: 4,
    k: 5
};

assert(delete x);
assert(typeof x === "undefined");
//assert(!(delete y));
assert(delete myobj.h);
assert(typeof myobj.h === "undefined");
assert(delete myobj);
assert(typeof myobj === "undefined");

function Foo() {}
Foo.prototype.bar = 42;
var foo = new Foo();

assert(delete foo.bar);
assert(typeof foo.bar !== "undefined");
assert(delete Foo.prototype.bar);
assert(typeof foo.bar === "undefined");
