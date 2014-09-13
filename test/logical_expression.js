var assert = require("assert");

var a = false || "ok";
assert(a === "ok");
var b = "ok" || false;
assert(b === "ok");
var c = "ok" || "ok2";
assert(c === "ok");
var d = false || null;
assert(d === null);


var a = null && "ok";
assert(a === null);
var b = "ok" && null;
assert(b === null);
var c = "ok" && "ok2";
assert(c === "ok2");
var d = null && false ;
assert(d === null);
