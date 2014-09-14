var assert = require("assert");

var ret = [];
var i, j

// break loop1
loop1:
    for (i = 0; i < 3; i++) { //The first for statement is labeled "loop1"
        loop2: for (j = 0; j < 3; j++) { //The second for statement is labeled "loop2"
            if (i == 1 && j == 1) {
                break loop1;
            }
            ret.push(i, j);
        }
    }

assert(ret.length === 8);
assert(ret[0] === 0);
assert(ret[1] === 0);
assert(ret[2] === 0);
assert(ret[3] === 1);
assert(ret[4] === 0);
assert(ret[5] === 2);
assert(ret[6] === 1);
assert(ret[7] === 0);
assert(i === 1);
assert(j === 1);

// break loop2
ret = []
loop1:
    for (i = 0; i < 3; i++) { //The first for statement is labeled "loop1"
        loop2: for (j = 0; j < 3; j++) { //The second for statement is labeled "loop2"
            if (i == 1 && j == 1) {
                break loop2;
            }
            ret.push(i, j);
        }
    }

assert(ret.length === 14);
assert(ret[0] === 0);
assert(ret[1] === 0);
assert(ret[2] === 0);
assert(ret[3] === 1);
assert(ret[4] === 0);
assert(ret[5] === 2);
assert(ret[6] === 1);
assert(ret[7] === 0);
assert(ret[8] === 2);
assert(ret[9] === 0);
assert(ret[10] === 2);
assert(ret[11] === 1);
assert(ret[12] === 2);
assert(ret[13] === 2);
assert(i === 3);
assert(j === 3);

// Continue loop1
ret = []
loop1:
    for (i = 0; i < 3; i++) { //The first for statement is labeled "loop1"
        loop2: for (j = 0; j < 3; j++) { //The second for statement is labeled "loop2"
            if (i == 1 && j == 1) {
                continue loop1;
            }
            ret.push(i, j);
        }
    }

assert(ret.length === 14);
assert(ret[0] === 0);
assert(ret[1] === 0);
assert(ret[2] === 0);
assert(ret[3] === 1);
assert(ret[4] === 0);
assert(ret[5] === 2);
assert(ret[6] === 1);
assert(ret[7] === 0);
assert(ret[8] === 2);
assert(ret[9] === 0);
assert(ret[10] === 2);
assert(ret[11] === 1);
assert(ret[12] === 2);
assert(ret[13] === 2);
assert(i === 3);
assert(j === 3);

// Continue loop2
ret = []
loop1:
    for (i = 0; i < 3; i++) { //The first for statement is labeled "loop1"
        loop2: for (j = 0; j < 3; j++) { //The second for statement is labeled "loop2"
            if (i == 1 && j == 1) {
                continue loop2;
            }
            ret.push(i, j);
        }
    }

assert(ret.length === 16);
assert(ret[0] === 0);
assert(ret[1] === 0);
assert(ret[2] === 0);
assert(ret[3] === 1);
assert(ret[4] === 0);
assert(ret[5] === 2);
assert(ret[6] === 1);
assert(ret[7] === 0);
assert(ret[8] === 1);
assert(ret[9] === 2);
assert(ret[10] === 2);
assert(ret[11] === 0);
assert(ret[12] === 2);
assert(ret[13] === 1);
assert(ret[14] === 2);
assert(ret[15] === 2);
assert(i === 3);
assert(j === 3);

// Not iteration statement
i, j = 0, j;
label1:{
    i = 54;
    break label1;
    j = 21;
}

assert(i === 54);
assert(j === 0);
