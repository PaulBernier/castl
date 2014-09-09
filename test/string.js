var assert = require("assert");

// NB: type string and object String are mixed up in CAST
// commented lines are a result of this

var str = "abcdef";
assert(typeof str === "string");
assert(str.length === 6);
assert(str[0] === "a");
assert(str[5] === "f");
assert(typeof str[21] === "undefined");
assert(!(str instanceof String));

var str2 = String(72);
assert(typeof str2 === "string");
assert(str2 === "72");
assert(str2[0] === "7");
assert(!(str2 instanceof String));

var str3 = String("hum");
assert(typeof str3 === "string");
assert(str3 === "hum");
assert(str3[1] === "u");
assert(!(str3 instanceof String));
assert(!(str3 instanceof Object));

var str4 = new String(72);
assert(typeof str4 === "object");
assert(str4.toString() === "72");
assert(str4[1] === "2");
assert(str4 instanceof String);
assert(str4 instanceof Object);

var str5 = new String("hum");
assert(typeof str5 === "object");
assert(str5.toString() === "hum");
assert(str5[1] === "u");
assert(str5 instanceof String);
assert(str5 instanceof Object);

var MyClass = function () {};
MyClass.prototype.toString = function () {
    return "custom toString"
};
var instance = new MyClass();
var str6 = String(instance);
assert(str6 === "custom toString");

var str7 = new String(instance);
assert(str7.toString() === "custom toString");

// strings are immutable
var str8 = "blabla";
str8.ptdr = 12;
assert(str8.ptdr === undefined);
str8[0] = 'v';
assert(str8[0] === "b");

// fromCharCode
assert(String.fromCharCode(65, 66, 67) === "ABC");
assert(String.fromCharCode(65, "66", 67) === "ABC");


///////
var n = String("foo");
var m = new String("bar");
var o = "abwabwa";

assert(n == "foo");
assert(m == "bar");
assert(o == "abwabwa");
assert(n === "foo");
assert(!(m === "bar"));
assert(o === "abwabwa");
assert(typeof(n) === "string");
assert(typeof(m) === "object");
assert(typeof(o) === "string");
assert(!(n instanceof String));
assert(m instanceof String);
assert(!(o instanceof String));
assert(n.toString() === "foo");
assert(m.toString() === "bar");
assert(o.toString() === "abwabwa");
assert(Number.isNaN(-n));
assert(Number.isNaN(-m));
assert(Number.isNaN(-o));
