var assert = require("assert");

// Inline object construction
var obj = {
    att: 0,
    method: function (z) {
        return z
    },
    21: 1337,
    "_str": "yolo",
    end: "GG"
}

assert(obj.att === 0);
assert(obj.method(7) === 7);
assert(obj[21] === 1337);
assert(obj._str === "yolo");
assert(obj["_str"] === "yolo");
assert(obj.end === "GG");
assert(obj["end"] === "GG");

// Accessors
var a = {
    b: {
        c: function (z) {
            return z;
        }
    }
};

assert(a.b.c(21) === 21);
assert(a["b"].c(21) === 21);
assert(a.b["c"](21) === 21);

// Object.create and prototype
obj.prototype = {
    p: "inherited"
}

var obj2 = Object.create(obj.prototype);
assert(obj2.p === "inherited");
assert(typeof obj2.att === "undefined");
assert(typeof obj2[21] === "undefined");
assert(typeof obj2 === "object");
assert(obj2 instanceof Object);

// New
function MyClass(z) {
    this.att = z;
    this.str = "blabla";

    return 21;
}

// Used as a function
assert(MyClass(1) === 21);
assert(typeof MyClass === "function");
assert(MyClass instanceof Function);

// Behavior of new with return value in constructor
function fun() {
    this.a = 12;
    return {
        a: 42
    };
}

var newFun = new fun();
assert(newFun.a === 42);

function fun2() {
    this.a = 12;

    return function () {
        return 7
    };
}

var newFun2 = new fun2();
assert(newFun2() === 7);
assert(newFun2.a !== 12);

// Instance
var myClassInstance = new MyClass(77);
assert(typeof myClassInstance === "object");
assert(myClassInstance.att === 77);
assert(myClassInstance.str === "blabla");
assert(myClassInstance instanceof MyClass);
assert(myClassInstance instanceof Object);

// Inheritance
MyClass.prototype.yo = "yo";

function MyClass2() {
    this.myOwnAtt = 888;
}

// MyClass2 inherits from MyClass
MyClass2.prototype = Object.create(MyClass.prototype);

var myClass2Instance = new MyClass2();

assert(myClass2Instance.myOwnAtt === 888);
assert(myClass2Instance.yo === "yo"); // Inherited attribute
assert(typeof myClass2Instance.att === "undefined"); // Not inherited
assert(typeof myClass2Instance.str === "undefined"); // Not inherited
assert(myClass2Instance instanceof MyClass2);
assert(myClass2Instance instanceof MyClass);
assert(myClass2Instance instanceof Object);
