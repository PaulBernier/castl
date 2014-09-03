var assert = require("assert");

var m = 12;
n = 3;

var toBeMasked1 = "visible";
var toBeMasked2 = "visible";

function playFun() {
    assert(m === 11);
    assert(n === 3);
    assert(typeof j === "undefined");

    assert(typeof tt === "undefined");
    assert(toBeMasked1 === "visible");
    assert(typeof toBeMasked2 === "undefined");

    var tt = 777;
    tt = 456;

    // Mask
    toBeMasked1 = "masked";
    var toBeMasked2 = "masked";
}

m = 11;
playFun();
freeVar = 8;
var j = "defined";
