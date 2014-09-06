var assert = require("assert");

var o = {
    toString: function () {
        return "foo"
    }
}

// Replace by undefined
var str = "xx".replace("x");
assert(str === "undefinedx");
var str = "xx".replace(/x/g);
assert(str === "undefinedundefined");

// Replace by number
var str = "xx".replace("x", 7);
assert(str === "7x");
var str = "xx".replace(/x/g, 7);
assert(str === "77");

// Replace by boolean
var str = "xx".replace("x", true);
assert(str === "truex");
var str = "xx".replace(/x/g, true);
assert(str === "truetrue");

// Replace by object
var str = "xx".replace("x", o);
assert(str === "foox");
var str = "xx".replace(/x/g, o);
assert(str === "foofoo");
var str = "xx".replace("x", {});
assert(str === "[object Object]x");
var str = "xx".replace(/x/g, {});
assert(str === "[object Object][object Object]");

// Replace by regexp
var str = "xx".replace("x", /abcdef/g);
assert(str === "/abcdef/gx");
var str = "xx".replace(/x/g, /abcdef/g);
assert(str === "/abcdef/g/abcdef/g");

// Function which doesn't return a string

var str = "x".replace(/x/, function () {
    return {};
});
assert(str === "[object Object]");

var str = "x".replace(/x/, function () {
    return /abcdef/g;
});
assert(str === "/abcdef/g");

var str = "x".replace("x", function () {
    return {};
});
assert(str === "[object Object]");

var str = "x".replace("x", function () {
    return /abcdef/g;
});
assert(str === "/abcdef/g");

// This context of replacer functin
function f() {
    this.z = 13;
}

f();

var str = "x".replace(/x/, function () {
    return this.z;
});
assert(str === "13");
