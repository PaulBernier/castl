var assert = require("assert");

// tonumber
assert(Number.isNaN(-(/g/)));

// instanceof
var re = /\d/g;
assert(re instanceof RegExp);
re = new RegExp("\\d", "gi");
assert(re instanceof RegExp);

// test
var str = "abcd32fzei8fzeji9";

re = /\d/g;

assert(re.test(str));
assert(re.lastIndex === 5);
assert(re.test(str));
assert(re.lastIndex === 6);
assert(re.test(str));
assert(re.lastIndex === 11);

var str2 = "3";

assert(!re.test(str2));
assert(re.lastIndex === 0);

re = /\d/;
assert(re.test(str2));
assert(re.lastIndex === 0);

assert(re.test(str));
assert(re.lastIndex === 0);
assert(re.test(str));
assert(re.lastIndex === 0);

assert(!re.test("abdef"));
assert(re.lastIndex === 0);

re = /(\d)+/g;
assert(re.test("abcd47fd"));
assert(re.lastIndex === 6);

// exec

re = /d(b+)(d)/ig;
var result = re.exec("cdbBdbsbz");
assert(result.length === 3);
assert(result[0] === "dbBd");
assert(result[1] === "bB");
assert(result[2] === "d");
assert(re.lastIndex === 5);
assert(result.index === 1);
assert(result.input === "cdbBdbsbz");

re = /d(b+)(d)/i;
result = re.exec("cdbBdbsbz");
assert(result.length === 3);
assert(result[0] === "dbBd");
assert(result[1] === "bB");
assert(result[2] === "d");
assert(re.lastIndex === 0);
assert(result.index === 1);
assert(result.input === "cdbBdbsbz");

re = /d(b+)(d)/;
result = re.exec("cdbBdbsbz");
assert(result === null);

var myRe = /ab*/g;
var str = "abbcdefabh";
var myArray;
var ret = [];
while ((myArray = myRe.exec(str)) !== null) {
    var msg = "Found " + myArray[0] + ".  ";
    msg += "Next match starts at " + myRe.lastIndex;
    ret.push(msg);
}

assert(ret.length === 2);
assert(ret[0] === "Found abb.  Next match starts at 3");
assert(ret[1] === "Found ab.  Next match starts at 9");

var matches = /(hello \S+)/.exec('This is a hello world!');
assert(matches[0] === "hello world!");

// difference of behavior between string.match and regexp.exec
var re_once = /([a-z])([A-Z])/;
var re_glob = /([a-z])([A-Z])/g;

str = "aAbBcC";

ret = str.match(re_once);
assert(ret.length === 3);
assert(ret[0] === "aA");
assert(ret[1] === "a");
assert(ret[2] === "A");
assert(ret.index === 0);
assert(ret.input === str);

ret = str.match(re_glob);
assert(ret.length === 3);
assert(ret[0] === "aA");
assert(ret[1] === "bB");
assert(ret[2] === "cC");
assert(typeof (ret.index) === "undefined");
assert(typeof (ret.input) === "undefined");

ret = re_once.exec(str);
assert(ret.length === 3);
assert(ret[0] === "aA");
assert(ret[1] === "a");
assert(ret[2] === "A");
assert(ret.index === 0);
assert(ret.input === str);
assert(re_once.lastIndex === 0);

ret = re_once.exec(str);
assert(ret.length === 3);
assert(ret[0] === "aA");
assert(ret[1] === "a");
assert(ret[2] === "A");
assert(ret.index === 0);
assert(ret.input === str);
assert(re_once.lastIndex === 0);

ret = re_glob.exec(str);
assert(ret.length === 3);
assert(ret[0] === "aA");
assert(ret[1] === "a");
assert(ret[2] === "A");
assert(ret.index === 0);
assert(ret.input === str);
assert(re_glob.lastIndex === 2);

ret = re_glob.exec(str);
assert(ret.length === 3);
assert(ret[0] === "bB");
assert(ret[1] === "b");
assert(ret[2] === "B");
assert(ret.index === 2);
assert(ret.input === str);
assert(re_glob.lastIndex === 4);

ret = re_glob.exec(str);
assert(ret.length === 3);
assert(ret[0] === "cC");
assert(ret[1] === "c");
assert(ret[2] === "C");
assert(ret.index === 4);
assert(ret.input === str);
assert(re_glob.lastIndex === 6);
