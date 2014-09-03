var assert = require("assert");

// replace
var re = /apples/gi;
var str = "Apples are round, and apples apples are juicy. \nApples";
var newstr = str.replace(re, "oranges");
assert(newstr === "oranges are round, and oranges oranges are juicy. \noranges");

re = /apples/g;
newstr = str.replace(re, "oranges");
assert(newstr === "Apples are round, and oranges oranges are juicy. \nApples");

re = /apples/;
newstr = str.replace(re, "oranges");
assert(newstr === "Apples are round, and oranges apples are juicy. \nApples");

re = /^apples/;
newstr = str.replace(re, "oranges");
assert(newstr === "Apples are round, and apples apples are juicy. \nApples");

re = /^apples/gi;
newstr = str.replace(re, "oranges");
assert(newstr === "oranges are round, and apples apples are juicy. \nApples");

re = /^apples/gim;
newstr = str.replace(re, "oranges");
assert(newstr === "oranges are round, and apples apples are juicy. \noranges");

// replace nothing
assert("abcd3fzei8fzeji9".replace(/toto/, "lol") === "abcd3fzei8fzeji9");
assert("abcd3fzei8fzeji9".replace("toto", "lol") === "abcd3fzei8fzeji9");

// swap
var re = /(\w+)\s(\w+)/;
var str = "John Smith";
var newstr = str.replace(re, "$2, $1");
assert(newstr === "Smith, John");

function replacer(match, p1, p2, p3, offset, string) {
    // p1 is nondigits, p2 digits, and p3 non-alphanumerics
    return [p1, p2, p3].join(' - ');
}
var newString = "abc12345#$*%".replace(/([^\d]*)(\d*)([^\w]*)/, replacer);
assert(newString === "abc - 12345 - #$*%")

newString = "abc12345#$*%".replace((/([^\d]*)(\d*)([^\w]*)/), "--$1--$2--$3--");
assert(newString === "--abc--12345--#$*%--");

newString = "abc12345yyy".replace(/([^\d]*)(\d*)([^\w]*)/, "T$&T");
assert(newString === "Tabc12345Tyyy");

newString = "you owe me 20€".replace(/(20€)/, "25$");
assert(newString === "you owe me 25$");

newString = "you owe me 20€".replace(/(20€)/, "25$$1");
assert(newString === "you owe me 25$1");

newString = "you owe me 20€".replace(/(20€)/, "25$$$");
assert(newString === "you owe me 25$$");

newString = "you owe me 20€".replace(/(20€)/, "25$1");
assert(newString === "you owe me 2520€");

newString = "you owe me 20€".replace(/20(€)/, "25$$$$$1");
assert(newString === "you owe me 25$$€");

assert("abCdcgc".replace(/c/, "Y", "gi") === "abCdYgc");

assert("abCdcgc".replace("c", function (letter) {
    return "C"
}) === "abCdCgc")
assert("abCdcgc".replace("c", function (letter) {
    return "|" + letter + "|"
}) === "abCd|c|gc")
assert("aabaabaa".replace(/a(.)a/, function (match, letter) {
    return "|" + match + "|" + letter + "|"
}) === "a|aba|b|abaa")

// split
var names = "Harry Trump ;Fred Barney; Helen Rigby ; Bill Abel ;Chris Hand ";
var re = /\s*;\s*/;
var nameList = names.split(re);
assert(nameList.length === 5);
assert(nameList[0] === "Harry Trump");
assert(nameList[2] === "Helen Rigby");
assert(nameList[4] === "Chris Hand ");

str = "123T323T00"
re = /t/;
ret = str.split(re);
assert(ret[0] === str);
assert(ret.length === 1);
re = /t/i;
ret = str.split(re);
assert(ret[0] === "123");
assert(ret.length === 3);

// string doesn't contain separator
ret = "abcd3fzei8fzeji9".split(";");
assert(ret.length === 1);
assert(ret[0] === "abcd3fzei8fzeji9");

// with captures
var myString = "Hello 14 word. Sentence number 2.";
var splits = myString.split(/(\d)(\d)/);
assert(splits.length === 4);
assert(splits[0] === "Hello ");
assert(splits[1] === "1");
assert(splits[2] === "4");
assert(splits[3] === " word. Sentence number 2.");

splits = myString.split(/(\d+)/);
assert(splits.length === 5);
assert(splits[0] === "Hello ");
assert(splits[1] === "14");
assert(splits[2] === " word. Sentence number ");
assert(splits[3] === "2");
assert(splits[4] === ".");

splits = myString.split(/\d+/);
assert(splits.length === 3);
assert(splits[0] === "Hello ");
assert(splits[1] === " word. Sentence number ");
assert(splits[2] === ".");

// search
assert("fdg4hu4".search(/\d/) === 3);
assert("fdg4hu4".search(/t/) === -1);
assert("fdug4hu4".search(/u/g) === 2);
assert("fdug4hu4".search("u") === 2);

// match
var str = "For more information, see Chapter 3.4.5.1";
var re = /(chapter \d+(\.\d)*)/i;
var found = str.match(re);

assert(found.length === 3);
assert(found[0] === "Chapter 3.4.5.1");
assert(found[1] === "Chapter 3.4.5.1");
assert(found[2] === ".1");
assert(found.index === 26);
assert(found.input === "For more information, see Chapter 3.4.5.1");

re = /(chapter \d+(\.\d)*)/gi;
found = str.match(re);

assert(found.length === 1);
assert(found[0] === "Chapter 3.4.5.1");
assert(typeof (found.index) === "undefined");
assert(typeof (found.input) === "undefined");

str = "lol h lol h";
re = /h/g;
found = str.match(re);
assert(found.length === 2);
assert(found[0] === "h");
assert(found[1] === "h");
assert(typeof (found.index) === "undefined");
assert(typeof (found.input) === "undefined");

re = /h/;
found = str.match(re);
assert(found.length === 1);
assert(found[0] === "h");
assert(found.index === 4);
assert(found.input === "lol h lol h");

str = "abcd3fzei8fzeji9";
re = /\w(\d)\w/g;
found = str.match(re);

assert(found.length === 2);
assert(found[0] === "d3f");
assert(found[1] === "i8f");
assert(typeof (found.index) === "undefined");
assert(typeof (found.input) === "undefined");

re = /\w(\d)\w/;
found = str.match(re);
assert(found.length === 2);
assert(found[0] === "d3f");
assert(found[1] === "3");
assert(found.index === 3);
assert(found.input === "abcd3fzei8fzeji9");

str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
re = /[A-E]/gi;
matches_array = str.match(re);
assert(matches_array.length === 10);
assert(matches_array[0] === "A");
assert(matches_array[1] === "B");
assert(matches_array[5] === "a");

// no match: return null
str = "abcd3fzei8fzeji9";
re = /Z(\d)Z/;
found = str.match(re);
assert(found === null);
re = /Z(\d)Z/g;
found = str.match(re);
assert(found === null);
