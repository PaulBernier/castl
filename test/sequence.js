var assert = require("assert");

var a = (7, 5);
assert(a === 5);

var b = 12;
var c = (b = 3, 4);
assert(b === 3);
assert(c === 4);

// Multiple coma
var d = (1, 2, 3, 4);
assert(d === 4);

// Examples from: http://javascriptweblog.wordpress.com/2011/04/04/the-javascript-comma-operator/

//////////////
// Example 1
//////////////

var r = [],
    n = 0,
    a = 0,
    b = 1,
    next;

function nextFibonacci() {
    next = a + b;
    return b = (a = b, next);
}

while (n++ < 10) {
    r.push(nextFibonacci());
}

// r = [1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
assert(r[0] === 1);
assert(r[6] === 21);
assert(r[9] === 89);

//////////////
// Example 2
//////////////

for (
    var i = 2, r = [0, 1]; i < 15; r.push(r[i - 1] + r[i - 2]), i++
);

// r = [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377]
assert(r[0] === 0);
assert(r[9] === 34);
assert(r[14] === 377);
assert(typeof r[15] === "undefined");

//////////////
// For fun
//////////////

//~ function renderCurve() {
//~ for(var a = 1, b = 10; a*b; a++, b--)
//~ console.log(new Array(a*b).join('*'));
//~ }
//~ 
//~ renderCurve();
