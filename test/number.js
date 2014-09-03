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
