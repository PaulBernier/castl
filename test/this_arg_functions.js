var assert = require("assert");

function B() {}

B.prototype.foo = function(callback) {
    callback();
}

B.prototype.bar = function() {}

var b = new B();

b.foo(function() {
    // `this` should not equal `b`
    assert(typeof(this.bar) === "undefined");
})

// Access environment via this inside a function
function f() {
    return this.parseInt("44")
}

assert(f() === 44);

function f2() {
    this.z = 12;
}

f2()

function f3() {
    return this.z
}

assert(f3() === 12);

// This when function is a member expression
var o = {
    parseInt: function() {
        return 77
    }
}
o.f = function() {
    return this.parseInt("44");
}

assert(o.f() === 77);
