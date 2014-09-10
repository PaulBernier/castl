var assert = require("assert");

var numObj = 12345.6789;

// toFixed
assert(numObj.toFixed() === "12346");
assert(numObj.toFixed(1) === "12345.7");
assert(numObj.toFixed(6) === "12345.678900");

numObj = 1.23e+20;
assert(numObj.toFixed(2) === "123000000000000000000.00");
numObj = 123000000000000000000;
assert(numObj.toFixed(2) === "123000000000000000000.00");
numObj = 1.23e-10;
assert(numObj.toFixed(2) === "0.00");
numObj = 2.34;
assert(numObj.toFixed(1) === "2.3");
numObj = -2.34;
assert(numObj.toFixed(1) === "-2.3");

assert(12345.6789.toFixed(2) === "12345.68");

// toPrecision
var numObj = 5.123456;
assert(numObj.toPrecision() === "5.123456");
assert(numObj.toPrecision(5) === "5.1235");
assert(numObj.toPrecision(2) === "5.1");
assert(numObj.toPrecision(1) === "5");
assert((1234.5).toPrecision(2) === "1.2e+3");

try{
    numObj.toPrecision(0);
}catch(e){
    assert(e.name == "RangeError");
}

try{
    numObj.toPrecision(22);
}catch(e){
    assert(e.name == "RangeError");
}

// toExponential
var numObj = 77.1234;

assert(numObj.toExponential(0) === "8e+1"); 
assert(numObj.toExponential() === "7.71234e+1");
assert(numObj.toExponential(4) === "7.7123e+1");
assert(numObj.toExponential(2) === "7.71e+1");
assert((77.1234).toExponential() === "7.71234e+1");
assert((77).toExponential() === "7.7e+1");

try{
    numObj.toExponential(-1); 
}catch(e){
    assert(e.name === "RangeError");
}

