var assert = require("assert");

var a = [1,2,3,4];
current = 0;
++(a[++current]);

assert(current === 1);
assert(a[0] === 1);
assert(a[1] === 3);
assert(a[2] === 3);
assert(a[3] === 4);

a = [1,2,3,4];
current = 0;
z = ++(a[++current]);
assert(current === 1);
assert(z === 3);
assert(a[0] === 1);
assert(a[1] === 3);
assert(a[2] === 3);
assert(a[3] === 4);

a = [1,2,3,4];
current = 0;
z = (a[current++])++;

assert(current === 1);
assert(z === 1);
assert(a[0] === 2);
assert(a[1] === 2);
assert(a[2] === 3);
assert(a[3] === 4);
