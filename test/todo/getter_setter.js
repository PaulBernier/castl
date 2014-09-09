var assert = require("assert");

var f = {get test () {return 12}};

assert(f.test === 12);
f.test = 33;
assert(f.test === 12);
