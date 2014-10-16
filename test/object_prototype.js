var assert = require("assert");

// hasOwnProperty
var o = new Object();
o.prop = 'exists';

function changeO() {
    o.newprop = o.prop;
    delete o.prop;
}

assert(o.hasOwnProperty('prop'));
changeO();
assert(!o.hasOwnProperty('prop'));

o = new Object();
o.prop = 'exists';
assert(o.hasOwnProperty('prop'));
assert(!o.hasOwnProperty('toString'));
assert(!o.hasOwnProperty('hasOwnProperty'));

var foo = {
    hasOwnProperty: function () {
        return false;
    },
    bar: 'Here be dragons'
};

assert(!foo.hasOwnProperty('bar'));
assert(({}).hasOwnProperty.call(foo, 'bar'));
assert(Object.prototype.hasOwnProperty.call(foo, 'bar'));

function f(){};
f.a = 21;
assert(f.hasOwnProperty("a"));

// toString

var toString = Object.prototype.toString;

var obj = {};
var str = "";
var num = 12;
var bool = true;
var array = [1, 2, 3];
var fun = function () {}

assert(toString.call(undefined) === "[object Undefined]");
assert(toString.call(null) === "[object Null]");
assert(toString.call(array) === "[object Array]");
assert(toString.call(bool) === "[object Boolean]");
assert(toString.call(num) === "[object Number]");
assert(toString.call(str) === "[object String]");
assert(toString.call(obj) === "[object Object]");

// IsPrototypeOf
var o = new Object()
assert(Object.prototype.isPrototypeOf(o))
assert(!Object.isPrototypeOf(o))

function Fee() {
}

function Fi() {
}
Fi.prototype = new Fee();

function Fo() {
}
Fo.prototype = new Fi();

function Fum() {
}
Fum.prototype = new Fo();

var fum = new Fum();


assert(Fee.prototype.isPrototypeOf(fum))
assert(Fi.prototype.isPrototypeOf(fum))
assert(Fo.prototype.isPrototypeOf(fum))
assert(Fum.prototype.isPrototypeOf(fum))

