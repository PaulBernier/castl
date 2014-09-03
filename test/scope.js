var assert = require("assert");

// No block scope in Lua
function f() {
    if (true) {
        var a = 12;
        assert(a === 12);
    }
    assert(a === 12);
}
f();

// Use of variable before declaration
function oh() {

    var t = function () {
        assert(a === 1);
    }

    var a = 1;

    t();
}
oh();

function one() {
    assert(b === 1)
    assert(typeof a === "undefined")
}

var b = 1;
one();
var a = 21;
