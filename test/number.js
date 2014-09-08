var assert = require("assert");

var n = Number(3);
assert(n === 3);

var m = Number("6");
assert(m === 6);

// isFinite
assert(!Number.isFinite(Infinity));
assert(!Number.isFinite(NaN));
assert(!Number.isFinite(-Infinity));
assert(Number.isFinite(0));
assert(Number.isFinite(2e64));
assert(!Number.isFinite("0"));

// isNan

assert(Number.isNaN(NaN));
assert(Number.isNaN(Number.NaN));
assert(Number.isNaN(0 / 0));

assert(!Number.isNaN(undefined));
assert(!Number.isNaN({}));
assert(!Number.isNaN(true));
assert(!Number.isNaN(null));
assert(!Number.isNaN(37));
assert(!Number.isNaN("37"));
assert(!Number.isNaN("37.37"));
assert(!Number.isNaN(""));
assert(!Number.isNaN(" "));
assert(!Number.isNaN("NaN"));
assert(!Number.isNaN("blabla"));

// + and - as unary operator:
assert(typeof(-"4") === "number");
assert(typeof(+"4") === "number");
assert(typeof(+(new Date())) === "number");
assert(typeof(-(new Date())) === "number");

/////
var n = Number(7)
var m = new Number(77)
var o = 88

assert(n == 7);
assert(m == 77);
assert(o == 88);
assert(n === 7);
assert(!(m === 77));
assert(o === 88);
assert(typeof(n) === "number");
assert(typeof(m) === "object");
assert(typeof(o) === "number");
assert(n.toString() === "7");
assert(m.toString() === "77");
assert(o.toString() === "88");
assert(-n === -7);
assert(-m === -77);
assert(-o === -88);

