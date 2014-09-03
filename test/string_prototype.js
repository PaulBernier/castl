var assert = require("assert");

// Upper case
var str = "abcdef";
assert(str.toUpperCase() === "ABCDEF");
assert("abcdef".toUpperCase() === "ABCDEF");

// Lower case
str = "AZERTY";
assert(str.toLowerCase() === "azerty");
assert("AZERTY".toLowerCase() === "azerty");

// Char at
str = "abcedf";
assert(str.charAt() === "a");
assert(str.charAt(1) === "b");
assert("abcedf".charAt() === "a");

// CharCodeAt
str = "abcedf";
assert(str.charCodeAt() === 97);
assert(str.charCodeAt(1) === 98);
assert("abcedf".charCodeAt() === 97);

// Substr
str = "abcdefghij";

assert(str.substr(1, 0) === "");
assert(str.substr(1, 2) === "bc");
assert(str.substr(-3, 2) === "hi");
assert(str.substr(-3) === "hij");
assert(str.substr(1) === "bcdefghij");
assert(str.substr(-20, 2) === "ab");
assert(str.substr(20, 2) === "");
assert("abcdefghij".substr(1, 0) === "");
assert(str.substr(-55, 2) === "ab");

// Substring
var anyString = "Mozilla";

assert(anyString.substring(1) === "ozilla");
assert(anyString.substring(-5) === "Mozilla");
assert(anyString.substring(-1, 3) === "Moz");
assert(anyString.substring(3, 0) === "Moz");
assert(anyString.substring(4, 7) === "lla");
assert(anyString.substring(7, 4) === "lla");
assert(anyString.substring(0, 6) === "Mozill");
assert(anyString.substring(0, 7) === "Mozilla");
assert(anyString.substring(0, 10) === "Mozilla");
assert(anyString.substring(3, 3) === "");
assert("Mozilla".substring(1) === "ozilla");

// Slice
str = "The morning is upon us.";
assert(str.slice(1) === "he morning is upon us.");
assert(str.slice(1, 1) === "");
assert(str.slice(2, 3) === "e");
assert(str.slice(3, 2) === "");
assert(str.slice(-3, 2) === "");
assert(str.slice(-3) === "us.");
assert(str.slice(-3, -1) === "us");
assert(str.slice(0, -1) === "The morning is upon us");
assert("The morning is upon us.".slice(1) === "he morning is upon us.");
assert(str.slice(-30) === "The morning is upon us.");
assert(str.slice(0, -30) === "");

// indexOf
str = "The morning is upon us. T44";
assert(str.indexOf("T") === 0);
assert(str.indexOf("not in") === -1);
assert(str.indexOf("the") === -1);
assert(str.indexOf("morning") === 4);
assert(str.indexOf("") === 0);
assert(str.indexOf("", -7) === 0);
assert(str.indexOf("", 4) === 4);
assert(str.indexOf("", 100) === str.length);
assert(str.indexOf("is", -21) === 12);
assert(str.indexOf(4, -21) === 25);
assert(str.indexOf(44, -21) === 25);
assert("The morning is upon us. T44".indexOf("T") === 0);

// lastIndexOf
str = "canal"
assert(str.lastIndexOf("a") === 3);
assert(str.lastIndexOf("a", 2) === 1);
assert(str.lastIndexOf("a", 0) === -1);
assert(str.lastIndexOf("a", -10) === -1);
assert(str.lastIndexOf("x") === -1);
assert(str.lastIndexOf("x", -3) === -1);
assert(str.lastIndexOf("") === 5);
assert(str.lastIndexOf("", 4) === 4);
assert(str.lastIndexOf("", 1) === 1);
assert(str.lastIndexOf("", 0) === 0);
assert(str.lastIndexOf("", -2) === 0);
assert("canal".lastIndexOf("a") === 3);

str = "Blue Whale, Killer Whale";
assert(str.lastIndexOf("blue") === -1);

// Concat
str = "Hello";
var ret = str.concat(" my dear,", " my name is", " ", "", "Paul", "");
assert(ret === "Hello my dear, my name is Paul");
assert(str === "Hello");
var ret = str.concat("");
assert(ret === "Hello");
assert("foo".concat("bar") === "foobar");

// Trim
str = " str";
assert(str.trim() === "str");
str = "str ";
assert(str.trim() === "str");
str = " str ";
assert(str.trim() === "str");
str = "        str        ";
assert(str.trim() === "str");
assert(" str   ".trim() === "str");

// replace and split with RegExp: refer to test/string_regexp file

// replace
str = "Welcome home my friend";
assert(str.replace("friend", "brother") === "Welcome home my brother");
assert(str.replace("friend", "old chap") === "Welcome home my old chap");
assert(str.replace("friend", "$& and $ $$ $$$ $$$$ old $1 chap$") === "Welcome home my friend and $ $ $$ $$ old $1 chap$");

str = "old old old"
assert(str.replace("old", "young") === "young old old");

// split
str = "abc,der;f,df!kl;m?rr";

// special case 1
ret = str.split();
assert(ret[0] === str);
assert(ret.length === 1);

// special case 2
ret = str.split("");
assert(ret[0] === "a");
assert(ret[3] === ",");
assert(ret.length === str.length);

ret = "".split("!");
assert(ret[0] === "");
assert(ret.length === 1);

ret = str.split(",");
assert(ret[0] === "abc");
assert(ret[1] === "der;f");
assert(ret[2] === "df!kl;m?rr");
assert(ret.length === 3);

ret = str.split(",", 2);
assert(ret[0] === "abc");
assert(ret[1] === "der;f");
assert(ret.length === 2);

ret = str.split(",", 0);
assert(typeof (ret[0]) === "undefined");
assert(ret.length === 0);

ret = str.split(",", -5);
assert(ret[0] === "abc");
assert(ret[1] === "der;f");
assert(ret[2] === "df!kl;m?rr");
assert(ret.length === 3);

ret = str.split(",", 13);
assert(ret[0] === "abc");
assert(ret[1] === "der;f");
assert(ret[2] === "df!kl;m?rr");
assert(ret.length === 3);

// Test with magic chars of Lua
str = "abc.def.ghi";
ret = str.split(".");
assert(ret[0] === "abc");
assert(ret[1] === "def");
assert(ret[2] === "ghi");
assert(ret.length === 3);

str = "abc%def%ghi";
ret = str.split("%");
assert(ret[0] === "abc");
assert(ret[1] === "def");
assert(ret[2] === "ghi");
assert(ret.length === 3);

str = "abc$def$ghi";
ret = str.split("$");
assert(ret[0] === "abc");
assert(ret[1] === "def");
assert(ret[2] === "ghi");
assert(ret.length === 3);

// search and match are in test/string_regexp file
