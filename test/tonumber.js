var assert = require("assert");

var o = {};
var f = function(){return 3};
var arr = [2,3];
var b = true;
var n = 7;
var s1 = "ji";
var s2 = "99";
var u = undefined;

assert(Number.isNaN(-o));
assert(Number.isNaN(-f));
assert(Number.isNaN(-arr));
assert(-b === -1);
assert(-n === -7);
assert(Number.isNaN(-s1));
assert(-s2 === -99);
assert(Number.isNaN(-u));

var arr2 = new Array(23, 11);
var b2 = new Boolean(true);
var date = new Date(89, 3, 15);
var err = new Error("Message");
var f2 = new Function("return 9");
var n2 = new Number(333);
var o2 = new Object({});
var regexp = new RegExp("8","g");
var s3 = new String("hihi");

assert(Number.isNaN(-arr2));
assert(-b2 === -1);
// depends on timezone
// assert(-date === -608594400000);
assert(Number.isNaN(-err));
assert(Number.isNaN(-f2));
assert(-n2 === -333);
assert(Number.isNaN(-o2));
assert(Number.isNaN(-regexp));
assert(Number.isNaN(-s3));
