var assert = require("assert");

var o = {};

// Constructor

var n = Object(7);
var m = new Object(7);
var o = {};

assert(n == 7);
assert(m == 7);
assert(!(n === 7));
assert(!(m === 7));
assert(typeof(n) === "object");
assert(typeof(m) === "object");
assert(n instanceof Number);
assert(m instanceof Number);
assert(n.toString() === "7");
assert(m.toString() === "7");
assert(-n === -7);
assert(-m === -7);
assert(Number.isNaN(-o));

var s = Object("str");
var s2 = new Object("str");
assert(s instanceof String);
assert(s2 instanceof String);

var b = Object(true);
var b2 = new Object(true);
assert(b instanceof Boolean);
assert(b2 instanceof Boolean);

// definedProperty
Object.defineProperty(o, "a", {
    value: 37,
    writable: true,
    enumerable: true,
    configurable: true
});

assert(o.a === 37);

var tostr = {toString: function(){return "mark"}}
Object.defineProperty(o, tostr, {
    value: 33,
    writable: true,
    enumerable: true,
    configurable: true
});

assert(o.mark === 33);

// definedProperties
Object.defineProperties(o, {
    "property1": {
        value: "yop",
        writable: true
    },
    "property2": {
        value: "Hello",
        writable: false
    }
});

assert(o.property1 === "yop");
assert(o.property2 === "Hello");

// create
var o2 = Object.create(Object.prototype, {
    "z": {
        value: "z",
        writable: true
    },
    "r": {
        value: "r",
        writable: false
    }
});

assert(o2.z === "z");
assert(o2.r === "r");

// keys
var arr = ["a", "b", "c"];
var keys = Object.keys(arr);
assert(keys.indexOf("0") > -1);
assert(keys.indexOf("1") > -1);
assert(keys.indexOf("2") > -1);

var obj = {
    0: "a",
    1: "b",
    2: "c"
};
keys = Object.keys(obj);
assert(keys.indexOf("0") > -1);
assert(keys.indexOf("1") > -1);
assert(keys.indexOf("2") > -1);

obj = {
    100: "a",
    2: "b",
    7: "c"
};
keys = Object.keys(obj);
assert(keys.indexOf("100") > -1);
assert(keys.indexOf("7") > -1);
assert(keys.indexOf("2") > -1);

obj = {
    "lol": "a",
    2: "b",
    7: "c"
};
keys = Object.keys(obj);
assert(keys.indexOf("lol") > -1);
assert(keys.indexOf("7") > -1);
assert(keys.indexOf("2") > -1);

// getPrototypeOf
obj = {};
assert(Object.getPrototypeOf(obj) === Object.prototype);
arr = [];
assert(Object.getPrototypeOf(arr) === Array.prototype);
var num = new Number(6);
assert(Object.getPrototypeOf(num) === Number.prototype);
var str = new String("6");
assert(Object.getPrototypeOf(str) === String.prototype);
var bool = new Boolean(true);
assert(Object.getPrototypeOf(bool) === Boolean.prototype);
var fun = function () {};
assert(Object.getPrototypeOf(fun) === Function.prototype);

var MyClass = function () {};
var instance = new MyClass();
assert(Object.getPrototypeOf(instance) === MyClass.prototype);

// function as argument of Object.methods
var f = function(){};
f.a = 21;
var z = Object.create(f);
assert(typeof(z) === "object");
assert(z.a == 21);
Object.keys(f);
z = Object.getOwnPropertyDescriptor(f, "a");
assert(z.value === 21);
z = Object.getOwnPropertyDescriptor(f, "e");
assert(z === undefined);
Object.defineProperty(f, "b", {value: 99, writable: true, enumerable: true});
assert(f.b === 99);
Object.getOwnPropertyNames(f);
assert(Object.getPrototypeOf(f) === Function.prototype);

