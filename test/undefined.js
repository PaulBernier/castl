var assert = require("assert");

var a = undefined;

assert(a === undefined);
assert(typeof(a) === "undefined");

assert(Number.isNaN(a + 2));
assert(Number.isNaN(2 + a));
assert(Number.isNaN(a - 2));
assert(Number.isNaN(2 - a));
assert(Number.isNaN(a / 2));
assert(Number.isNaN(2 / a));
assert(Number.isNaN(a * 2));
assert(Number.isNaN(2 * a));
assert(Number.isNaN(a % 2));
assert(Number.isNaN(2 % a));

assert(Number.isNaN(a + true));
assert(Number.isNaN(true + a));
assert(Number.isNaN(a - true));
assert(Number.isNaN(true - a));
assert(Number.isNaN(a / true));
assert(Number.isNaN(true / a));
assert(Number.isNaN(a * true));
assert(Number.isNaN(true * a));
assert(Number.isNaN(a % true));
assert(Number.isNaN(true % a));

assert(!(a < 4));
assert(!(a > 4));
assert(!(a <= 4));
assert(!(a >= 4));
assert(!(a < -4));
assert(!(a > -4));
assert(!(a <= -4));
assert(!(a >= -4));
assert(!(4 < a));
assert(!(4 > a));
assert(!(4 <= a));
assert(!(4 >= a));
assert(!(-4 < a));
assert(!(-4 > a));
assert(!(-4 <= a));
assert(!(-4 >= a));

assert(!(a < "str"));
assert(!(a > "str"));
assert(!(a <= "str"));
assert(!(a >= "str"));
assert(!("str" < a));
assert(!("str" > a));
assert(!("str" <= a));
assert(!("str" >= a));

assert(("str" + a) === "strundefined");
assert((a + "str") === "undefinedstr");
assert(("2" + a) === "2undefined");
assert(Number.isNaN("str" - a));
assert(Number.isNaN(a - "str"));
