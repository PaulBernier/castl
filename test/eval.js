var assert = require("assert");

// global
i = 12;
samename = 90;
samename2 = 111;

// upvalue
var j = 1337;
var samename = 990;
var samename2 = 1111;

(function () {
    // local
    var k = 21
    var samename = 9900;
    // global
    l = 77;

    assert(eval("i = i + 2; j = j + 2; k = k + 2; l = l + 2; samename = samename + 2; samename2 = samename2 + 2") === 1113);

    assert(i === 14);
    assert(j === 1339);
    assert(k === 23);
    assert(l === 79);
    assert(samename === 9902);
    assert(samename2 === 1113);
})()

assert(i === 14);
assert(j === 1339);
assert(l === 79);
assert(samename === 990);
assert(samename2 === 1113);

var call = eval('"abcde".replace("a", "Z");');
assert(call === "Zbcde");

var pi = eval("with(Math){PI.toFixed(7)}");
assert(pi === "3.1415927");

var a;
b = eval("a = 5");
assert(a === 5);
assert(b === 5);
