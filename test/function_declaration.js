var assert = require("assert");

assert(fun2() === 44);

function fun() {
    return 44;
}

function fun2() {
    return fun();
}

var f3, f6;

assert(f() === 7);

function f() {
    return 7;
}

f2 = function () {
    return 9;
}

f3 = function () {
    return 11;
}

f4 = function f5() {
    return 13;
}

f6 = function f7() {
    return 15;
}

assert(f4() === 13);
assert(f6() === 15);

((function () {

    var f9;

    assert(f10() === 17);

    function f10() {
        return 17;
    }

    f8 = function () {
        return 19;
    }

    f9 = function () {
        return 111;
    }

    assert(f10() === 17);
    assert(f8() === 19);
    assert(f9() === 111);

})())

assert(f8() === 19);
