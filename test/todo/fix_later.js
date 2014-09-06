var assert = require("assert");

// string mixup
var str = new String("hum");
assert(typeof str === "object");
assert(str[0] === "h");
assert(str[1] === "u");
assert(str[2] === "m");
var str = "abcdef";
assert(!(str instanceof String));
var str2 = String(72);
assert(!(str2 instanceof String));
var str3 = String("hum");
assert(!(str3 instanceof String));
assert(!(str3 instanceof Object));
var str4 = new String(72);
assert(typeof str4 === "object");
var str5 = new String("hum");
assert(typeof str5 === "object");

var a = "abcd";
assert(typeof a["00"] == "undefined");
