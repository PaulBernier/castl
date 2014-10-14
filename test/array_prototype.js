var assert = require("assert");

// Push
var arr = new Array(20, 21, 22, 23, 24);

assert(arr.push(25) === 6);
assert(arr[5] === 25);

assert(arr.push(26, 27, 28, 29) === 10);
assert(arr[9] === 29);

assert(arr.push() === 10);
assert(arr.length === 10);

// Pop
var arr2 = new Array();
assert(typeof arr2.pop() === "undefined");
arr2 = [1, 2, 3, 4];
var ret = arr2.pop();
assert(ret === 4);
assert(arr2.length === 3);
assert(typeof arr2[3] === "undefined");

// Join

var arr3 = ["a", "b", "c"];
var joint = arr3.join("!");
assert(joint === "a!b!c");
joint = arr3.join();
assert(joint === "a,b,c");
joint = arr3.join("");
assert(joint === "abc");
arr3 = [1, , 3, 4, 5, , , ];
joint = arr3.join(":");
assert(joint === "1::3:4:5::");
arr3 = [1, , 3, 4, 5, ];
joint = arr3.join(":");
assert(joint === "1::3:4:5");
arr3 = [1, , 3, 4, 5];
joint = arr3.join(":");
assert(joint === "1::3:4:5");

// Shift
var arr4 = ["a", "b", "c", "d"];
assert(arr4[0] === "a");
ret = arr4.shift();
assert(ret === "a");
assert(arr4.length === 3);
assert(arr4[0] === "b");
assert(typeof arr4[3] === "undefined");
arr4 = [];
ret = arr4.shift();
assert(typeof ret === "undefined");

// Unshift
var arr5 = [1, 2];
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
var arr6 = ["a", "b", "c", "d", "e", "f"];
ret = arr6.splice(0, 0, "z");
assert(ret.length === 0);
assert(arr6.length === 7);
assert(arr6[0] === "z");
assert(arr6[6] === "f");

arr6 = ["a", "b", "c", "d", "e", "f"];
ret = arr6.splice(-2, 2, "art", "tra");
assert(ret.length === 2);
assert(arr6.length === 6);
assert(arr6[0] === "a");
assert(arr6[4] === "art");
assert(arr6[5] === "tra");

arr6 = ["a", "b", "c", "d", "e", "f"];
ret = arr6.splice(-10);
assert(ret.length === 6);
assert(arr6.length === 0);

var myFish = ["angel", "clown", "mandarin", "surgeon"];

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
var arr7 = [1, 2, 3, 4, 5];
ret = arr7.reverse();
assert(ret[0] === 5);
assert(ret[1] === 4);
assert(ret[2] === 3);
assert(ret[3] === 2);
assert(ret[4] === 1);
arr7 = [1, 2, 3, 4];
ret = arr7.reverse();
assert(ret[0] === 4);
assert(ret[1] === 3);
assert(ret[2] === 2);
assert(ret[3] === 1);

// Slice
var arr8 = [0, 1, 2, 3, 4, 5];
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

var arr9 = [2, 5, 8, 1, 4];
assert(!arr9.some(isBigEnough));
arr9 = [12, 5, 8, 1, 4];
assert(arr9.some(isBigEnough));

arr9 = [0,0,0];
assert(!arr9.some(function(e){return e}));

// Every
var arr10 = [12, 5, 8, 130, 44];
assert(!arr10.every(isBigEnough));
arr10 = [12, 54, 18, 130, 44];
assert(arr10.every(isBigEnough));

arr10 = [0,0,0];
assert(!arr10.some(function(e){return e}));

// indexOf
var arr11 = [1, 2, 3, 4];
assert(arr11.indexOf(1) === 0);
assert(arr11.indexOf(1, 1) === -1);
assert(arr11.indexOf(1, 10) === -1);
assert(arr11.indexOf(1, -1) === -1);
assert(arr11.indexOf(1, -4) === 0);
assert(arr11.indexOf(1, -6) === 0);

// lastIndexOf
var arr11bis = [2, 5, 9, 2];
assert(arr11bis.lastIndexOf(2) === 3);
assert(arr11bis.lastIndexOf(2, 1) === 0);
assert(arr11bis.lastIndexOf(2, 10) === 3);
assert(arr11bis.lastIndexOf(2, -1) === 3);
assert(arr11bis.lastIndexOf(2, -4) === 0);
assert(arr11bis.lastIndexOf(2, -6) === -1);

// sort
var arr12 = [8, -6, 11, 1];
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

arr12 = [10, -6, -11, 2];
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

arr12 = [10, -6, -11, 2];
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

arr12 = [10, -6, -11, 2];
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

arr12 = ["C", -6, 11, 2, -30, "b", 100000];
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

arr12 = [1, 2, undefined, -3, , 11, , -7, 23, ];
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
var arr13 = [1, "a", 5]
assert(arr13.toString() === "1,a,5");

// concat
var arr14 = ["test", 6];
ret = arr14.concat();
assert(arr14.length === 2);
assert(ret[0] === "test");

ret = arr14.concat("u", 67);
assert(arr14.length === 2);
assert(ret.length === 4);
assert(ret[0] === "test");
assert(ret[2] === "u");
assert(ret[3] === 67);

ret = arr14.concat(["r", 99, 77]);
assert(arr14.length === 2);
assert(ret.length === 5);
assert(ret[0] === "test");
assert(ret[2] === "r");
assert(ret[3] === 99);
assert(ret[4] === 77);

ret = arr14.concat(["r", 99, 77], [], ["yo"]);
assert(arr14.length === 2);
assert(ret.length === 6);
assert(ret[0] === "test");
assert(ret[2] === "r");
assert(ret[3] === 99);
assert(ret[4] === 77);
assert(ret[5] === "yo");

ret = arr14.concat(["r", 99, 77], 11, ["yo"]);
assert(arr14.length === 2);
assert(ret.length === 7);
assert(ret[0] === "test");
assert(ret[2] === "r");
assert(ret[3] === 99);
assert(ret[4] === 77);
assert(ret[5] === 11);
assert(ret[6] === "yo");

arr14 = [];
ret = arr14.concat(["yo"], "yo2");
assert(arr14.length === 0);
assert(ret.length === 2);
assert(ret[0] === "yo");
assert(ret[1] === "yo2");

// map

var arr15 = [1, 4, 9];
var doubles = arr15.map(function (num) {
    return num * 2;
});
assert(arr15.length === 3);
assert(arr15[0] === 1);
assert(doubles.length === 3);
assert(doubles[0] === 2);

var map = Array.prototype.map;
var a = map.call("Hello World", function (x) {
    return x.charCodeAt(0);
});
// [72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100]
assert(a[0] === 72);
assert(a[6] === 87);
assert(a[10] === 100);

ret = ["1", "2", "3"].map(parseInt);
// [1, NaN, NaN]
assert(ret[0] === 1);
assert(Number.isNaN(ret[1]));
assert(Number.isNaN(ret[2]));

function returnInt(element) {
    return parseInt(element, 10);
}

ret = ["1", "2", "3"].map(returnInt);
assert(ret[0] === 1);
assert(ret[1] === 2);
assert(ret[2] === 3);

// filter
var arr16 = [12, 5, 8, 130, 44];

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
ret = [];

function logArrayElements(element, index, array) {
        ret.push("a[" + index + "] = " + element);
    }
    [2, 5, 9].forEach(logArrayElements);

assert(ret[0] === "a[0] = 2");
assert(ret[1] === "a[1] = 5");
assert(ret[2] === "a[2] = 9");

var myArray = ['toto', 'samantha'];
var myArray2 = [];

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

ret = [];
var forEach = Array.prototype.forEach;
forEach.call("test", function (i) {
    ret.push(i)
});

assert(ret[0] === "t");
assert(ret[1] === "e");
assert(ret[2] === "s");
assert(ret[3] === "t");

// Reduce
var total = [0, 1, 6, 3].reduce(function (a, b) {
    return a + b;
});
assert(total === 10);

total = [0, 1, 6, 3].reduce(function (a, b) {
    return a + b;
}, 5);
assert(total === 15);

ret = [].reduce(function (a, b) {
    return 1
}, 21)
assert(ret === 21);
ret = [13].reduce(function (a, b) {
    return 1
})
assert(ret === 13);

var total = [1, null, 1, , 6, , 3].reduce(function (a, b) {
    return a + b;
});

assert(total === 11);

// Reduce right
total = [0, 1, 2, 3, 4].reduceRight(function(previousValue, currentValue, index, array) {
  return previousValue * currentValue + previousValue;
});
assert(total === 96);

total = [0, 1, 2, 3, 4].reduceRight(function(previousValue, currentValue, index, array) {
  return previousValue * currentValue + previousValue;
}, 11);
assert(total === 1320);

var flattened = [
    [0, 1],
    [2, 3],
    [4, 5]
].reduce(function (a, b) {
    return a.concat(b);
});

assert(flattened[0] === 0);
assert(flattened[1] === 1);
assert(flattened[2] === 2);
assert(flattened[3] === 3);
assert(flattened[4] === 4);
assert(flattened[5] === 5);

// Handle holes

var a = new Array(1);
var result = 0;

a.forEach(function(value, index, object) {
  result++;
});

a.map(function(value, index, object) {
    result++;
});

a.some(function(value, index, object) {
  result++;
});

a.filter(function(value, index, object) {
  result++;
});

// None of these should have iterated.
assert(result === 0);

// Test this in callback function when no thisArf is specified

var a = [1,2,3,4]

a.map(function(e){return this.parseInt("2") * e});
a.filter(function(e){return this.parseInt("2") * e > 4});
a.reduce(function(p, c){return this.parseInt("2") * (p + c)});
a.forEach(function(e) {this.parseInt("77")});
a.some(function(){this.parseInt("77")});
a.every(function(){this.parseInt("77")});
