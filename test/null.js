var assert = require('assert');

var a = null;
assert(typeof a === "object");
assert(a === null);

var b; // undefined

assert(a !== b);
assert(a == b);

assert((a + 35) === 35);
assert((a - 35) === -35);
assert((a / 35) === 0);
assert((a * 35) === 0);
assert((a % 35) === 0);

assert((25 + a) === 25);
assert((25 - a) === 25);
assert((25 / a) === Infinity);
assert((25 * a) === 0);
assert(Number.isNaN(25 % a));

assert((a + "35") === "null35");
assert((a - "35") === -35);
assert(("35" + null) === "35null");
assert(("35" - a) === 35);

assert((a + "foo") === "nullfoo");
assert(Number.isNaN(a - "foo"));
assert(Number.isNaN(a / "foo"));
assert(Number.isNaN(a * "foo"));
assert(Number.isNaN(a % "foo"));

assert(!(2 < null));
assert(null < 2);
assert(-2 < null);
assert(!(null < -2));
assert(!("2" < null));
assert(null < "2");
assert("-2" < null);
assert(!(null < "-2"));
assert(!("fez" < null));
assert(!(null < "fez"));
assert(!("fez" < null));
assert(!(null < "fez"));
