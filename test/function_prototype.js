var assert = require("assert");

// Call

var myFun = function (a, b, c) {
    return a + b + c;
}

assert(myFun.call(undefined, 1, 1, 1) === 3);

var myFun2 = function () {
    return 21;
}

assert(myFun2.call(undefined) === 21)

// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call
// Test 1
function Product(name, price) {
    this.name = name;
    this.price = price;

    if (price < 0)
        throw ('Cannot create product ' + name + ' with a negative price');
    return this;
}

function Food(name, price) {
    Product.call(this, name, price);
    this.category = 'food';
}

Food.prototype = Object.create(Product.prototype);

function Toy(name, price) {
    Product.call(this, name, price);
    this.category = 'toy';
}

Toy.prototype = Object.create(Product.prototype);

var cheese = new Food('feta', 5);
var fun = new Toy('robot', 40);

assert(cheese.name === "feta");
assert(cheese.price === 5);
assert(fun.name === "robot");
assert(fun.price === 40);

var animals = [{
    species: 'Lion',
    name: 'King'
}, {
    species: 'Whale',
    name: 'Fail'
}];

// Test 2
var lines = []
for (var i = 0; i < animals.length; i++) {
    (function (i) {
        this.print = function () {
            lines.push('#' + i + ' ' + this.species + ': ' + this.name);
        }
        this.print();
    }).call(animals[i], i);
}

assert(lines[0] === "#0 Lion: King");
assert(lines[1] === "#1 Whale: Fail");

// Bind

var f = function (a, b, c) {
    return a * b * c;
}

var f2 = f.bind(undefined, 21)
assert(f2(6, 7, 8) === 882)

this.x = 9;
var module = {
    x: 81,
    getX: function () {
        return this.x;
    }
};

module.getX(); // 81

var getX = module.getX;
getX();

var boundGetX = getX.bind(module);
assert(boundGetX() === 81);

//
function list() {
    return Array.prototype.slice.call(arguments);
}

var list1 = list(1, 2, 3);

var leadingThirtysevenList = list.bind(undefined, 37);

var list2 = leadingThirtysevenList(); // [37]
var list3 = leadingThirtysevenList(1, 2, 3); // [37, 1, 2, 3]
assert(list2.length === 1);
assert(list2[0] === 37);
assert(list3.length === 4);
assert(list3[0] === 37);
assert(list3[1] === 1);
assert(list3[2] === 2);
assert(list3[3] === 3);

// Apply

assert(myFun.apply(undefined, [1, 2, 3]) === 6);
assert(myFun2.apply(undefined) === 21);

//
Function.prototype.construct = function (aArgs) {
    var fConstructor = this,
        fNewConstr = function () {
            fConstructor.apply(this, aArgs);
        };
    fNewConstr.prototype = fConstructor.prototype;
    return new fNewConstr();
};

function MyConstructor() {
    for (var nProp = 0; nProp < arguments.length; nProp++) {
        this["property" + nProp] = arguments[nProp];
    }
}

var myArray = [4, "Hello world!", false];
var myInstance = MyConstructor.construct(myArray);

assert(myInstance.property1 === "Hello world!");
assert(myInstance instanceof MyConstructor);
