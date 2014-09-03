var assert = require('assert');

// Latin-1 Supplement
var fÿz = 21;
assert(fÿz === 21);

// Conflict with jssupport lib
var jssupport = 21;
assert(("1" + 1) === "11"); // Will use jssupport.add

// Conflict with Lua keywords
var and = 21;
assert(and === 21);
var elseif = 21;
assert(elseif === 21);
var end = 21;
assert(end === 21);
var goto = 21;
assert(goto === 21);
var local = 21;
assert(local === 21);
var nil = 21;
assert(nil === 21);
var not = 21;
assert(not === 21);
var or = 21;
assert(or === 21);
var repeat = 21;
assert(repeat === 21);
var then = 21;
assert(then === 21);
var until = 21;
assert(until === 21);

// $ in variable names
$_POST = "php is a good old language";
assert($_POST === "php is a good old language");

// sanitizing a member expression
var test = {};
test.end = {};
test.end.end = 2;
test.f = {};
test.f.end = function () {
    return "ok"
};
test.f.end("hum");
test.f["end"]("hum");

assert(test.end.end === 2);
assert(test.f.end("hum") === "ok");
assert(test.f["end"]("hum") === "ok");

test._toto = 6;
assert(test._toto === 6);
test._toto = function () {
    return "ok"
};
assert(test._toto() === "ok");
assert(test["_toto"]() === "ok");

test["or"] = 11;
assert(test.or === 11);
