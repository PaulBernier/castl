var assert = require('assert');

var a = 0;

if (true) {
    a = 1;
}
assert(a === 1);

if (false) {
    a = 2;
} else {
    a = 3;
}

assert(a === 3);

if (false) {
    a = 4;
} else if (false) {
    a = 5;
} else if (true) {
    a = 6;
}

assert(a === 6);

if (false) {
    a = 7;
} else if (false) {
    a = 8;
} else if (false) {
    a = 9;
} else {
    a = 10;
}

assert(a === 10);
