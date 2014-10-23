var assert = require("assert");

// Upper case
var str = new String("abcdef");
assert(str.toUpperCase() === "ABCDEF");

// Lower case
str = new String("AZERTY");
assert(str.toLowerCase() === "azerty");

// Char at
str = new String("abcedf");
assert(str.charAt() === "a");
assert(str.charAt(1) === "b");

// CharCodeAt
str = new String("abcedf");
assert(str.charCodeAt() === 97);
assert(str.charCodeAt(1) === 98);

// Substr
str = new String("abcdefghij");

assert(str.substr(1, 0) === "");
assert(str.substr(1, 2) === "bc");
assert(str.substr(-3, 2) === "hi");
assert(str.substr(-3) === "hij");
assert(str.substr(1) === "bcdefghij");
assert(str.substr(-20, 2) === "ab");
assert(str.substr(20, 2) === "");
assert(str.substr(-55, 2) === "ab");

// Substring
var anyString = new String("Mozilla");

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

// Slice
str = new String("The morning is upon us.");
assert(str.slice(1) === "he morning is upon us.");
assert(str.slice(1, 1) === "");
assert(str.slice(2, 3) === "e");
assert(str.slice(3, 2) === "");
assert(str.slice(-3, 2) === "");
assert(str.slice(-3) === "us.");
assert(str.slice(-3, -1) === "us");
assert(str.slice(0, -1) === "The morning is upon us");
assert(str.slice(-30) === "The morning is upon us.");
assert(str.slice(0, -30) === "");

// indexOf
str = new String("The morning is upon us. T44");
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

// lastIndexOf
str = new String("canal");
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

str = new String("Blue Whale, Killer Whale");
assert(str.lastIndexOf("blue") === -1);

// Concat
str = new String("Hello");
var ret = str.concat(" my dear,", " my name is", " ", "", "Paul", "");
assert(ret === "Hello my dear, my name is Paul");
var ret = str.concat("");
assert(ret === "Hello");

// Trim
str = new String(" str");
assert(str.trim() === "str");
str = new String("str ");
assert(str.trim() === "str");
str = new String(" str ");
assert(str.trim() === "str");
str = new String("        str        ");
assert(str.trim() === "str");

// replace and split with RegExp: refer to test/string_regexp file

// replace
str = new String("Welcome home my friend");
assert(str.replace("friend", "brother") === "Welcome home my brother");
assert(str.replace("friend", "old chap") === "Welcome home my old chap");
assert(str.replace("friend", "$& and $ $$ $$$ $$$$ old $1 chap$") === "Welcome home my friend and $ $ $$ $$ old $1 chap$");

str = new String("old old old");
assert(str.replace("old", "young") === "young old old");

// split
str = new String("abc,der;f,df!kl;m?rr");

// special case 1
ret = str.split();
assert(ret[0] === "abc,der;f,df!kl;m?rr");
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

str = "abcdadha";
ret = str.split("a");
assert(ret.length === 4);
assert(ret[0] === "");
assert(ret[1] === "bcd");
assert(ret[2] === "dh");
assert(ret[3] === "");

// Test with magic chars of Lua
str = new String("abc.def.ghi");
ret = str.split(".");
assert(ret[0] === "abc");
assert(ret[1] === "def");
assert(ret[2] === "ghi");
assert(ret.length === 3);

str = new String("abc%def%ghi");
ret = str.split("%");
assert(ret[0] === "abc");
assert(ret[1] === "def");
assert(ret[2] === "ghi");
assert(ret.length === 3);

str = new String("abc$def$ghi");
ret = str.split("$");
assert(ret[0] === "abc");
assert(ret[1] === "def");
assert(ret[2] === "ghi");
assert(ret.length === 3);

// Anchor, link, small
assert("Anchor".anchor("castl") === '<a name="castl">Anchor</a>');
assert("castlua".link("http://www.castlua.com") === '<a href="http://www.castlua.com">castlua</a>');
assert("petit".small() === '<small>petit</small>');


// search and match are in test/string_regexp file
