var assert = require("assert");

var numObj = 12345.6789;

assert(numObj.toFixed() === "12346");
assert(numObj.toFixed(1) === "12345.7");
assert(numObj.toFixed(6) === "12345.678900");

numObj = 1.23e+20;
assert(numObj.toFixed(2) === "123000000000000000000.00");
numObj = 1.23e-10;
assert(numObj.toFixed(2) === "0.00");
numObj = 2.34;
assert(numObj.toFixed(1) === "2.3");
numObj = -2.34;
assert(numObj.toFixed(1) === "-2.3");

assert(12345.6789.toFixed(2) === "12345.68");
