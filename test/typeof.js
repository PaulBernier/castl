var assert = require("assert");

var a = 1;
var b = "test";
var c = true;

assert(typeof a === "number");
assert(typeof b === "string");
assert(typeof c === "boolean");
assert(typeof null === "object");

function f() {};
assert(typeof f === "function");

var o = {};
assert(typeof o === "object");
var o2 = new Object();
assert(typeof o2 === "object");
var o3 = Object.create(Object.prototype);
assert(typeof o3 === "object");
