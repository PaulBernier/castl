var assert = require('assert');

var path = false;
var path2 = false;

// Normal switch
var test = "B";
switch (test) {
case "A":
    assert(false);
    break;
case "B":
    path = true;
    break;
default:
    assert(false);
}
assert(path)

// Strict equality in switch test
path = false;
var test2 = 0;
switch (test2) {
case "0":
    assert(false);
    break;
default:
    path = true;
}
assert(path);

// Empty switch
switch (test) {}

// Switch without default
var test3 = "A"
path = false;
switch (test3) {
case "A":
    path = true;
    break;
case "B":
    assert(false);
    break;
}
assert(path);

// value not handled
var test4 = "Z";
switch (test4) {
case "A":
    assert(false);
    break;
}

// Switch with default only
path = false;
switch (test) {
    default: path = true;
}
assert(path)

// Break in default 
path = false;
switch (test) {
    default: path = true;
    break;
}
assert(path)

// Case whihout break;
var test5 = "A";
path = false;
switch (test5) {
case "A":
case "B":
    path = true;
    break;
}
assert(path)

// Default placed first
var test6 = "B";
path = false;
switch (test6) {
    default: assert(false);
case "A":
    assert(false);
    break;
case "B":
    path = true;
    break;
}
assert(path);

// More complex expression as test

var test7 = 21
path = false;
switch (test7) {
case (function () {
    return 42;
})():
    assert(false);
    break;
case (function () {
    return 21;
})():
    path = true;
    break
default:
    assert(false);
}
assert(path);

// Bonus

var test8 = "C"
path = false;
path2 = false;

switch (test8) {
case "A":
    assert(false);
default:
    path = true;
case "B":
    path2 = true;
}
assert(path && path2);

var test9 = "B";
path = false;
path2 = false;
switch (test9) {
case "A":
    assert(false);
case "B":
    path = true;
default:
    path2 = true;
}
assert(path && path2);

var test10 = "B";
path = false;
switch (test10) {
    default: assert(false);
case "A":
    assert(false);
case "B":
    path = true;
}

assert(path);

var test11 = "B";
path = false;
switch (test11) {
    default: assert(false);
case "A":
    assert(false);
case "B":
    path = true;
    break;
}
assert(path);

var i = 3;
var a = [];
while(i){
    switch(i--){
        case 3:
            a.push(3);
            break;
        case 2:
            a.push(2);
            break;
        case 1:
            a.push(1);
            break;
    }
}
assert(a.length === 3);
assert(a[0] === 3);
assert(a[1] === 2);
assert(a[2] === 1);
