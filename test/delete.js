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


var o = {a: { get b () {return 7}}};
assert(o["a"].b === 7);
assert(delete o["a"].b);
assert(o["a"].b === undefined);

o = {f: {get g () {return 7}}};
assert(o.f.g === 7);
assert(delete o.f.g);
assert(o.f.g === undefined);

o = {b: {get c () {return 7}}};
assert(o.b["c"] === 7);
assert(delete o.b["c"]);
assert(o.b["c"] === undefined);

k = {l: "u"}
o = {get u () {return 7}};
assert(o[k["l"]] === 7);
assert(delete o[k["l"]]);
assert(o[k["l"]] === undefined);

var kk = "t";
var ll = "yo";
o = {t: {t: { get yo (){return 7}}}}
assert(o[kk].t[ll] === 7);
assert(delete o[kk].t[ll]);
assert(o[kk].t[ll] === undefined);

