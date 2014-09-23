var assert = require("assert");

var a, x, y;
var r = 10;

with(Math) {
    var p = PI;
    a = PI * r * r;
    x = r * cos(PI);
    y = r * sin(PI / 2);
    assert(Math instanceof Object);
}

assert(a > 314.1 && a < 314.2);
assert(x == -10);
assert(y == 10);
assert(p < 3.15 && p > 3.14);
assert(Math instanceof Object);

var thisGlobal, thisWith
var f = function () {
    thisGlobal = this;
}
f();

with(3.1267) {
    assert(toPrecision(2) === "3.1");
    var f2 = function () {
        assert(toPrecision(2) === "3.1");
        thisWith = this;
    };
    f2();
}

assert(thisGlobal === thisWith);

var obj = {
    mark: 33
}
obj.lulz = function () {
    return this;
}

with(obj) {
    assert(lulz().mark === 33);
}

try {
    with(undefined) {}
} catch (e) {
    assert(e instanceof TypeError);
}

try {
    with(null) {}
} catch (e) {
    assert(e instanceof TypeError);
}

// new index
var o = {p1: 3}

with(o){
    k = 11;// new global variable
    p1 = 12; // p1 property of o
    assert(p1 === 12);
}

assert(k === 11);
assert(o.p1 === 12);
