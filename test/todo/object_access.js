var assert = require("assert");

// Weak typing
var o = {
    0: 0,
    "0": "zero",
    1: 1,
    "1": "one",
    2: 2,
    "3": "three",
    true: "VRAI",
    false: "FAUX"
};

assert(o[true] === "VRAI");
assert(o[false] === "FAUX");
assert(o[0] === "zero");
assert(o["0"] === "zero");
assert(o[1] === "one");
assert(o["1"] === "one");
assert(o[2] === 2);
assert(o["2"] === 2);
assert(o[3] === "three");
assert(o["3"] === "three");

function f1() {
    return 0
}

function f2() {
    return "0"
}

function f3() {
    return 1
}

function f4() {
    return "1"
}

function f5() {
    return 2
}

function f6() {
    return "2"
}

function f7() {
    return 3
}

function f8() {
    return "3"
}

assert(o[f1()] === "zero");
assert(o[f2()] === "zero");
assert(o[f3()] === "one");
assert(o[f4()] === "one");
assert(o[f5()] === 2);
assert(o[f6()] === 2);
assert(o[f7()] === "three");
assert(o[f8()] === "three");
