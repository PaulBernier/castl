var assert = require("assert");

var trees = new Array("redwood", "bay", "cedar", "oak", "maple");
assert(0 in trees)
assert(3 in trees)
assert(!(6 in trees))
assert(!("bay" in trees))
assert("length" in trees)

var mycar = {
    make: "Honda",
    model: "Accord",
    year: 1998
};
assert("make" in mycar)
assert("model" in mycar)

var mycar = {
    make: "Honda",
    model: "Accord",
    year: 1998
};
delete mycar.make;
assert(!("make" in mycar));

var trees = new Array("redwood", "bay", "cedar", "oak", "maple");
delete trees[3];
assert(!(3 in trees));

assert("toString" in {});
