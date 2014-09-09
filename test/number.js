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

// Static properties
assert(Number.MAX_VALUE === 1.7976931348623157e+308);
assert(Number.MIN_VALUE === 5e-324);
assert(Number.isNaN(Number.NaN));
assert(Number.NEGATIVE_INFINITY === -Infinity);
assert(Number.POSITIVE_INFINITY === Infinity);

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
assert(!(n instanceof Number));
assert(m instanceof Number);
assert(!(o instanceof Number));
assert(n.toString() === "7");
assert(m.toString() === "77");
assert(o.toString() === "88");
assert(-n === -7);
assert(-m === -77);
assert(-o === -88);

