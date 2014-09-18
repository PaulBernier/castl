var assert = require("assert");

var MyClass = function () {}
MyClass.prototype = Object.create(Array.prototype)
var instance = new MyClass()

// Push
var arr = new MyClass();
arr.push(20, 21, 22, 23, 24)

assert(arr.push(25) === 6);
assert(arr[5] === 25);

assert(arr.push(26, 27, 28, 29) === 10);
assert(arr[9] === 29);

assert(arr.push() === 10);
assert(arr.length === 10);

// Pop
var arr2 = new MyClass();
assert(typeof arr2.pop() === "undefined");
arr2.push(1, 2, 3, 4);
var ret = arr2.pop();
assert(ret === 4);
assert(arr2.length === 3);
assert(typeof arr2[3] === "undefined");

// Join

var arr3 = new MyClass();
arr3.push("a", "b", "c");
var joint = arr3.join("!");
assert(joint === "a!b!c");
joint = arr3.join();
assert(joint === "a,b,c");
joint = arr3.join("");
assert(joint === "abc");
arr3 = new MyClass();
arr3.push(1, undefined, 3, 4, 5, undefined, undefined);
joint = arr3.join(":");
assert(joint === "1::3:4:5::");
arr3 = new MyClass();
arr3.push(1, undefined, 3, 4, 5);
joint = arr3.join(":");
assert(joint === "1::3:4:5");
arr3 = new MyClass();
arr3.push(1, undefined, 3, 4, 5);
joint = arr3.join(":");
assert(joint === "1::3:4:5");

// Shift
var arr4 = new MyClass();
arr4.push("a", "b", "c", "d");
assert(arr4[0] === "a");
ret = arr4.shift();
assert(ret === "a");
assert(arr4.length === 3);
assert(arr4[0] === "b");
assert(typeof arr4[3] === "undefined");
arr4 = new MyClass();
ret = arr4.shift();
assert(typeof ret === "undefined");

// Unshift
var arr5 = new MyClass();
arr5.push(1, 2);
ret = arr5.unshift();
assert(ret === 2);
assert(arr5.length === 2);
assert(arr5[0] === 1);
ret = arr5.unshift(0);
assert(ret === 3);
assert(arr5.length === 3);
assert(arr5[0] === 0);
assert(arr5[2] === 2);
ret = arr5.unshift(-2, -1);
assert(ret === 5);
assert(arr5.length === 5);
assert(arr5[0] === -2);
assert(arr5[2] === 0);

// Splice
var arr6 = new MyClass();
arr6.push("a", "b", "c", "d", "e", "f");
ret = arr6.splice(0, 0, "z");
assert(ret.length === 0);
assert(arr6.length === 7);
assert(arr6[0] === "z");
assert(arr6[6] === "f");

arr6 = new MyClass();
arr6.push("a", "b", "c", "d", "e", "f");
ret = arr6.splice(-2, 2, "art", "tra");
assert(ret.length === 2);
assert(arr6.length === 6);
assert(arr6[0] === "a");
assert(arr6[4] === "art");
assert(arr6[5] === "tra");

arr6 = new MyClass();
arr6.push("a", "b", "c", "d", "e", "f");
ret = arr6.splice(-10);
assert(ret.length === 6);
assert(arr6.length === 0);

var myFish = new MyClass();
myFish.push("angel", "clown", "mandarin", "surgeon");

var removed = myFish.splice(2, 0, "drum");
assert(myFish.length === 5);
assert(myFish[0] === "angel");
assert(myFish[1] === "clown");
assert(myFish[2] === "drum");
assert(myFish[3] === "mandarin");
assert(myFish[4] === "surgeon");
assert(removed.length === 0);

removed = myFish.splice(3, 1);
assert(myFish.length === 4);
assert(myFish[0] === "angel");
assert(myFish[1] === "clown");
assert(myFish[2] === "drum");
assert(myFish[3] === "surgeon");
assert(removed.length === 1);
assert(removed[0] === "mandarin");

removed = myFish.splice(2, 1, "trumpet");
assert(myFish.length === 4);
assert(myFish[0] === "angel");
assert(myFish[1] === "clown");
assert(myFish[2] === "trumpet");
assert(myFish[3] === "surgeon");
assert(removed.length === 1);
assert(removed[0] === "drum");

removed = myFish.splice(0, 2, "parrot", "anemone", "blue");
assert(myFish.length === 5);
assert(myFish[0] === "parrot");
assert(myFish[1] === "anemone");
assert(myFish[2] === "blue");
assert(myFish[3] === "trumpet");
assert(myFish[4] === "surgeon");
assert(removed.length === 2);
assert(removed[0] === "angel");
assert(removed[1] === "clown");

removed = myFish.splice(3, 9999);
assert(myFish.length === 3);
assert(myFish[0] === "parrot");
assert(myFish[1] === "anemone");
assert(myFish[2] === "blue");
assert(removed.length === 2);
assert(removed[0] === "trumpet");
assert(removed[1] === "surgeon");

// Reverse
var arr7 = new MyClass();
arr7.push(1, 2, 3, 4, 5);

ret = arr7.reverse();
assert(ret[0] === 5);
assert(ret[1] === 4);
assert(ret[2] === 3);
assert(ret[3] === 2);
assert(ret[4] === 1);
arr7 = new MyClass();
arr7.push(1, 2, 3, 4);
ret = arr7.reverse();
assert(ret[0] === 4);
assert(ret[1] === 3);
assert(ret[2] === 2);
assert(ret[3] === 1);

// Slice
var arr8 = new MyClass();
arr8.push(0, 1, 2, 3, 4, 5);

ret = arr8.slice(0);
assert(ret.length === 6);
assert(ret[0] === 0);
assert(ret[5] === 5);

ret = arr8.slice(-2);
assert(ret.length === 2);
assert(ret[0] === 4);
assert(ret[1] === 5);

ret = arr8.slice(1, 3);
assert(ret.length === 2);
assert(ret[0] === 1);
assert(ret[1] === 2);

ret = arr8.slice(1, 999);
assert(ret.length === 5);
assert(ret[0] === 1);
assert(ret[1] === 2);
assert(ret[4] === 5);

ret = arr8.slice(1, -3);
assert(ret.length === 2);
assert(ret[0] === 1);
assert(ret[1] === 2);

ret = arr8.slice(5, 2);
assert(ret.length === 0);

ret = arr8.slice(-5, -2);
assert(ret.length === 3);
assert(ret[0] === 1);
assert(ret[2] === 3);

ret = arr8.slice(-63, -61);
assert(ret.length === 0);

ret = arr8.slice(-8);
assert(ret.length === 6);
assert(ret[0] === 0);

// Some
function isBigEnough(element, index, array) {
    return (element >= 10);
}

var arr9 = new MyClass();
arr9.push(2, 5, 8, 1, 4);
assert(!arr9.some(isBigEnough));
arr9 = new MyClass();
arr9.push(12, 5, 8, 1, 4);
assert(arr9.some(isBigEnough));

arr9 = [0,0,0];
assert(!arr9.some(function(e){return e}));

// Every
var arr10 = new MyClass();
arr10.push(12, 5, 8, 130, 44);
assert(!arr10.every(isBigEnough));
arr10 = new MyClass();
arr10.push(12, 54, 18, 130, 44);
assert(arr10.every(isBigEnough));

arr10 = [0,0,0];
assert(!arr10.some(function(e){return e}));

// indexOf
var arr11 = new MyClass();
arr11.push(1, 2, 3, 4);
assert(arr11.indexOf(1) === 0);
assert(arr11.indexOf(1, 1) === -1);
assert(arr11.indexOf(1, 10) === -1);
assert(arr11.indexOf(1, -1) === -1);
assert(arr11.indexOf(1, -4) === 0);
assert(arr11.indexOf(1, -6) === 0);

// sort
var arr12 = new MyClass();
arr12.push(8, -6, 11, 1);
ret = arr12.sort();
assert(ret === arr12);
assert(ret == arr12);
assert(arr12.length === 4);
assert(ret.length === 4);
assert(ret[0] === -6);
assert(ret[1] === 1);
assert(ret[2] === 11);
assert(ret[3] === 8);
assert(arr12[0] === -6);
assert(arr12[1] === 1);
assert(arr12[2] === 11);
assert(arr12[3] === 8);

arr12 = new MyClass();
arr12.push(10, -6, -11, 2);
ret = arr12.sort(function (a, b) {
    return a - b
});
assert(ret === arr12);
assert(ret == arr12);
assert(arr12.length === 4);
assert(ret.length === 4);
assert(ret[0] === -11);
assert(ret[1] === -6);
assert(ret[2] === 2);
assert(ret[3] === 10);
assert(arr12[0] === -11);
assert(arr12[1] === -6);
assert(arr12[2] === 2);
assert(arr12[3] === 10);

arr12 = new MyClass();
arr12.push(10, -6, -11, 2);
ret = arr12.sort(function (a, b) {
    return a > b
});
assert(ret === arr12);
assert(ret == arr12);
assert(arr12.length === 4);
assert(ret.length === 4);
assert(ret[0] === -11);
assert(ret[1] === -6);
assert(ret[2] === 2);
assert(ret[3] === 10);
assert(arr12[0] === -11);
assert(arr12[1] === -6);
assert(arr12[2] === 2);
assert(arr12[3] === 10);

arr12 = new MyClass();
arr12.push(10, -6, -11, 2);
ret = arr12.sort(function (a, b) {
    return a < b
});
assert(ret === arr12);
assert(ret == arr12);
assert(arr12.length === 4);
assert(ret.length === 4);
assert(ret[0] === 10);
assert(ret[1] === 2);
assert(ret[2] === -6);
assert(ret[3] === -11);
assert(arr12[0] === 10);
assert(arr12[1] === 2);
assert(arr12[2] === -6);
assert(arr12[3] === -11);

arr12 = new MyClass();
arr12.push("C", -6, 11, 2, -30, "b", 100000);
ret = arr12.sort();
assert(ret === arr12);
assert(ret == arr12);
assert(arr12.length === 7);
assert(arr12[0] === -30);
assert(arr12[1] === -6);
assert(arr12[2] === 100000);
assert(arr12[3] === 11);
assert(arr12[4] === 2);
assert(arr12[5] === "C");
assert(arr12[6] === "b");

arr12 = new MyClass();
arr12.push(1, 2, undefined, -3, undefined, 11, undefined, -7, 23);
ret = arr12.sort();
assert(ret === arr12);
assert(ret == arr12);
assert(arr12.length === 9);
assert(arr12[0] === -3);
assert(arr12[1] === -7);
assert(arr12[2] === 1);
assert(arr12[3] === 11);
assert(arr12[4] === 2);
assert(arr12[5] === 23);
assert(arr12[6] === undefined);
assert(arr12[7] === undefined);
assert(arr12[8] === undefined);

// toString
var arr13 = new MyClass();
arr13.push(1, "a", 5);
assert(arr13.toString() === "1,a,5");

// concat
var arr14 = new MyClass();
arr14.push("test", 6);
ret = arr14.concat();
assert(arr14.length === 2);
assert(ret[0][0] === "test");
assert(ret[0][1] === 6);

ret = arr14.concat("u", 67);
assert(arr14.length === 2);
assert(ret.length === 3);
assert(ret[0][0] === "test");
assert(ret[0][1] === 6);
assert(ret[1] === "u");
assert(ret[2] === 67);

ret = arr14.concat(["r", 99, 77]);
assert(arr14.length === 2);
assert(ret.length === 4);
assert(ret[0][0] === "test");
assert(ret[0][1] === 6);
assert(ret[1] === "r");
assert(ret[2] === 99);
assert(ret[3] === 77);

ret = arr14.concat(["r", 99, 77], [], ["yo"]);
assert(arr14.length === 2);
assert(ret.length === 5);
assert(ret[0][0] === "test");
assert(ret[0][1] === 6);
assert(ret[1] === "r");
assert(ret[2] === 99);
assert(ret[3] === 77);
assert(ret[4] === "yo");

ret = arr14.concat(["r", 99, 77], 11, ["yo"]);
assert(arr14.length === 2);
assert(ret.length === 6);
assert(ret[0][0] === "test");
assert(ret[0][1] === 6);
assert(ret[1] === "r");
assert(ret[2] === 99);
assert(ret[3] === 77);
assert(ret[4] === 11);
assert(ret[5] === "yo");

arr14 = new MyClass();
ret = arr14.concat(["yo"], "yo2");
assert(arr14.length === 0);
assert(ret.length === 3);
assert(ret[1] === "yo");
assert(ret[2] === "yo2");

// map
var arr15 = new MyClass();
arr15.push(1, 4, 9);

var doubles = arr15.map(function (num) {
    return num * 2;
});
assert(arr15.length === 3);
assert(arr15[0] === 1);
assert(doubles.length === 3);
assert(doubles[0] === 2);

var map = MyClass.prototype.map;
var a = map.call("Hello World", function (x) {
    return x.charCodeAt(0);
});
// [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100]
assert(a[0] === 72);
assert(a[6] === 87);
assert(a[10] === 100);

var arrMap = new MyClass();
arrMap.push("1", "2", "3");
ret = arrMap.map(parseInt);
// [1, NaN, NaN]
assert(ret[0] === 1);
assert(Number.isNaN(ret[1]));
assert(Number.isNaN(ret[2]));

function returnInt(element) {
    return parseInt(element, 10);
}

ret = arrMap.map(returnInt);
assert(ret[0] === 1);
assert(ret[1] === 2);
assert(ret[2] === 3);

// filter
var arr16 = new MyClass();
arr16.push(12, 5, 8, 130, 44);

function isBigEnough(element) {
    return element >= 10;
}

var filtered = arr16.filter(isBigEnough);
assert(arr16.length === 5);
assert(filtered.length === 3);
assert(filtered[0] === 12);
assert(filtered[1] === 130);
assert(filtered[2] === 44);

arr16 = [0,0,0];
assert(arr16.filter(function(e){return e}).length === 0);

// forEach
ret = new MyClass();

function logArrayElements(element, index, array) {
    ret.push("a[" + index + "] = " + element);
}

arrForEach = new MyClass();
arrForEach.push(2, 5, 9);
arrForEach.forEach(logArrayElements);

assert(ret[0] === "a[0] = 2");
assert(ret[1] === "a[1] = 5");
assert(ret[2] === "a[2] = 9");

var myArray = new MyClass();
myArray.push('toto', 'samantha');

var myArray2 = new MyClass();

function makeArray(element, index) {
    this[index] = element.toUpperCase();
}

myArray.forEach(makeArray, myArray2);

assert(myArray2[0] === "TOTO");
assert(myArray2[1] === "SAMANTHA");
assert(myArray[0] === "toto");
assert(myArray[1] === "samantha");

function copy(o) {
    var copy = Object.create(Object.getPrototypeOf(o));
    var propNames = Object.getOwnPropertyNames(o);

    propNames.forEach(function (name) {
        var desc = Object.getOwnPropertyDescriptor(o, name);
        Object.defineProperty(copy, name, desc);
    });

    return copy;
}

var o1 = {
    a: 1,
    b: 2
};
var o2 = copy(o1);
assert(o1 !== o2);
assert(o1.a === o2.a);
assert(o1.b === o2.b);

ret = new MyClass();
var forEach = MyClass.prototype.forEach;
forEach.call("test", function (i) {
    ret.push(i)
});

assert(ret[0] === "t");
assert(ret[1] === "e");
assert(ret[2] === "s");
assert(ret[3] === "t");

// Reduce
var arrReduce = new MyClass();
arrReduce.push(0, 1, 6, 3);
var total = [0, 1, 6, 3].reduce(function (a, b) {
    return a + b;
});
assert(total === 10);

arrReduce = new MyClass();
arrReduce.push(0, 1, 6, 3);
total = arrReduce.reduce(function (a, b) {
    return a + b;
}, 5);
assert(total === 15);

arrReduce = new MyClass();
ret = arrReduce.reduce(function (a, b) {
    return 1
}, 21)
assert(ret === 21);
arrReduce = new MyClass();
arrReduce.push(13);
ret = arrReduce.reduce(function (a, b) {
    return 1
})
assert(ret === 13);

arrReduce = new MyClass();
arrReduce.push([0, 1], [2, 3], [4, 5]);
var flattened = arrReduce.reduce(function (a, b) {
    return a.concat(b);
});

assert(flattened[0] === 0);
assert(flattened[1] === 1);
assert(flattened[2] === 2);
assert(flattened[3] === 3);
assert(flattened[4] === 4);
assert(flattened[5] === 5);
