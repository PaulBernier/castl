var assert = require("assert");

// stringify
assert(JSON.stringify(undefined) === undefined);
assert(JSON.stringify(null) === "null");
assert(JSON.stringify({}) === "{}");
assert(JSON.stringify(0) === "0");
assert(JSON.stringify(21) === "21");
assert(JSON.stringify(true) === "true");
assert(JSON.stringify(false) === "false");
assert(JSON.stringify("foo") === '"foo"');
assert(JSON.stringify([1, "false", false]) === '[1,"false",false]');
assert(JSON.stringify({
    x: 5
}) === '{"x":5}');
assert(JSON.stringify(null) === 'null');
assert(JSON.stringify(undefined) === undefined);

// ordering of keys pb
// var test = {x: 3, t: ["op", true, "true", null, {k: 8}], j: true, uu: {arg: "yol"}}
// console.log(JSON.stringify(test));
// assert(JSON.stringify(test) === '{"x":3,"t":["op",true,"true",null,{"k":8}],"j":true,"uu":{"arg":"yol"}}')

// parse
var ret = JSON.parse('{"a": [11, "z"]}');
assert(ret.a[0] === 11);
assert(ret.a[1] === "z");
assert(ret.a.length === 2);
assert(ret instanceof Object);
assert(ret.a.push("t"));

ret = JSON.parse('true');
assert(ret);
assert(typeof (ret) === "boolean");

ret = JSON.parse('"foo"');
assert(ret === "foo")

ret = JSON.parse('[1, 5, "false"]');
assert(ret instanceof Array);
assert(ret[0] === 1);
assert(ret[1] === 5);
assert(ret[2] === "false");

ret = JSON.parse('null');
assert(ret === null);

test = '{"glossary":{"title":"example glossary","GlossDiv":{"title":"S","GlossList":{"GlossEntry":{"ID":"SGML","SortAs":"SGML","GlossTerm":"Standard Generalized Markup Language","Acronym":"SGML","Abbrev":"ISO 8879:1986","GlossDef":{"para":"A meta-markup language, used to create markup languages such as DocBook.","GlossSeeAlso":["GML","XML"]},"GlossSee":"markup"}}}}}';

ret = JSON.parse(test);
assert(ret.glossary.GlossDiv.GlossList.GlossEntry.GlossDef.GlossSeeAlso[0] === "GML");

// reversibility
// works but order of keys doesn't match
//assert(JSON.stringify(JSON.parse(test)) === test);
