var assert = require("assert");

var a = "sup";
var b = 12;
var c = true;
var d = [2, 3, 4, 5];
var e = {
    r: 1,
    3: "hum"
};
var f = /\d/gi;
var g = new Date(1989, 3, 13);

function h(a, b) {
    var foo = 12;
    return foo
};
var i = arguments;

// impossible to easily test __tostring metamethod
//console.log(a);
assert(a.toString() === "sup");
//console.log(b);
assert(b.toString() === "12");
assert(b.toString(2) === "1100");
//console.log(c);
assert(c.toString() === "true");
//console.log(d);
assert(d.toString() === "2,3,4,5");
//console.log(e);
assert(e.toString() === "[object Object]");
//console.log(f);
assert(f.toString() === "/\\d/gi");
//console.log(g);
// depends on Locale
//assert(g.toString() === "Thu Apr 13 1989 00:00:00 GMT+0200 (CEST)");
//console.log(h);
// not really supported by runtime
//assert(h.toString());
//console.log(i);
assert(i.toString() === "[object Arguments]");

var tostr = Object.prototype.toString;
assert(tostr.call(a) === "[object String]");
assert(tostr.call(b) === "[object Number]");
assert(tostr.call(c) === "[object Boolean]");
assert(tostr.call(d) === "[object Array]");
assert(tostr.call(e) === "[object Object]");
assert(tostr.call(f) === "[object RegExp]");
assert(tostr.call(g) === "[object Date]");
assert(tostr.call(h) === "[object Function]");
assert(tostr.call(i) === "[object Arguments]");
