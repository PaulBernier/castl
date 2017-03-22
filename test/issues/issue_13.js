var assert = require("assert");
// https://github.com/PaulBernier/castl/issues/13
var i = 0;
var a = ++i && true;
assert(i === 1);
assert(a === true);

i = -1;
a = ++i && true;
assert(i === 0);
assert(a === 0);

i = 0;
a = i++ && true;
assert(i === 1);
assert(a === 0);

i = -1;
a = i++ && true;
assert(i === 0);
assert(a === true);

///////// OR

var j = 1;
var b = j++ || true;
assert(j === 2);
assert(b === 1);

j = 1;
b = ++j || true;
assert(j === 2);
assert(b === 2);

j = -1;
b = j++ || true;
assert(j === 0);
assert(b === -1);

j = -1;
b = ++j || true;
assert(j === 0);
assert(b === true);
