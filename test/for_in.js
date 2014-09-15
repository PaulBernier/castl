var assert = require("assert");

// Object
var obj = {
    a: 1,
    b: 2,
    c: 3,
    21: 33
};

var arr = [];
for (var prop in obj) {
    arr.push(prop);
}

assert(arr.indexOf("a") > -1);
assert(arr.indexOf("b") > -1);
assert(arr.indexOf("c") > -1);
assert(arr.indexOf("21") > -1);

// Test break
arr = [];
for (var prop in obj) {
    break;
    arr.push(prop);
}
assert(arr.length === 0);

// Test continue
arr = [];
for (var prop in obj) {
    continue;
    arr.push(prop);
}
assert(arr.length === 0);

arr = [];
for (var prop = 21 in obj) {
    arr.push(prop);
}

assert(arr.indexOf("a") > -1);
assert(arr.indexOf("b") > -1);
assert(arr.indexOf("c") > -1);
assert(arr.indexOf("21") > -1);

arr = [];
for (prop2 in obj) {
    arr.push(prop2);
}

assert(arr.indexOf("a") > -1);
assert(arr.indexOf("b") > -1);
assert(arr.indexOf("c") > -1);
assert(arr.indexOf("21") > -1);

// array
var array = ["a", "b", "c"];
array.prop = "prop";
arr = [];
for (prop in array) {
    arr.push(prop);
}

assert(arr.indexOf("0") > -1);
assert(arr.indexOf("1") > -1);
assert(arr.indexOf("2") > -1);
assert(arr.indexOf("prop") > -1);
assert(arr.indexOf("length") === -1);

// String
var str = "abcedf";
arr = [];
for (prop in str) {
    arr.push(prop);
}
assert(arr.indexOf("0") > -1);
assert(arr.indexOf("1") > -1);
assert(arr.indexOf("5") > -1);
assert(arr.indexOf("6") === -1);
assert(arr.indexOf("length") === -1);

var str = new String("abcedf");
arr = [];
for (prop in str) {
    arr.push(prop);
}
assert(arr.indexOf("0") > -1);
assert(arr.indexOf("1") > -1);
assert(arr.indexOf("5") > -1);
assert(arr.indexOf("6") === -1);
assert(arr.indexOf("length") === -1);

// Inherited
var triangle = {
    a: 1,
    b: 2,
    c: 3
};

function ColoredTriangle() {
    this.color = "red";
}

ColoredTriangle.prototype = triangle;

var obj = new ColoredTriangle();

arr = []
for (var prop in obj) {
    if (obj.hasOwnProperty(prop)) {
        arr.push(prop);
    }
}

assert(arr.indexOf("color") > -1);
assert(arr.indexOf("a") === -1);
assert(arr.indexOf("b") === -1);
assert(arr.indexOf("c") === -1);

arr = []
for (var prop in obj) {
    arr.push(prop);
}

assert(arr.indexOf("color") > -1);
assert(arr.indexOf("a") > -1);
assert(arr.indexOf("b") > -1);
assert(arr.indexOf("c") > -1);
