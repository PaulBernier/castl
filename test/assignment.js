var assert = require("assert");

var x = [1,5,11];
var j = 0, z;

for (i = 0 ;i<2 ; ++i) {
    z = x[j] = x[j] + x[++j]
}
assert(z === 16);
assert(j === 2);
assert(x[0] === 6);
assert(x[1] === 16);
assert(x[2] === 11);

var position = 1;
var z = [7, 88, 12];
z[++position] -= 23;
assert(position === 2);
assert(z[0] === 7);
assert(z[1] === 88);
assert(z[2] === -11);

position = 1;
z = [7, 88, 12];
z[position++] -= 23;
assert(position === 2);
assert(z[0] === 7);
assert(z[1] === 65);
assert(z[2] === 12);

position = 0;
z = [7, 65, 12];
g = z[++position] -= z[++position] * 2;
assert(position === 2);
assert(g === 41);

position = 1;
z = [7, 88, 12];
z[++position] -= ++position;
assert(position === 3);
assert(z[0] === 7);
assert(z[1] === 88);
assert(z[2] === 9);

position = 1;
z = [7, 88, 12];
z[++position] -= position++;
assert(position === 3);
assert(z[0] === 7);
assert(z[1] === 88);
assert(z[2] === 10);
assert(position === 3);

// 8 types of assignment
// a = 2;
// a += 2;
// a[index] = 2;
// a[index] += 2;

// z = (a = 2);
// z = (a[index] = 2);
// z = (a -= 2);
// z = (a[index] -= 2);
