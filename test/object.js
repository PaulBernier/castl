var assert = require("assert");

var o = {};

// definedProperty
Object.defineProperty(o, "a", {
    value: 37,
    writable: true,
    enumerable: true,
    configurable: true
});

assert(o.a === 37);

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
