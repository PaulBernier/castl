var assert = require("assert");

var a, x, y;
var r = 10;

with(Math) {
    var p = PI;
    a = PI * r * r;
    x = r * cos(PI);
    y = r * sin(PI / 2);
    assert(Math instanceof Object);
}

assert(a > 314.1 && a < 314.2);
assert(x == -10);
assert(y == 10);
assert(p < 3.15 && p > 3.14);
assert(Math instanceof Object);
