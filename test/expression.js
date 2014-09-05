var assert = require("assert");

// This is an example to compile

var b = "azerty";
var c = {
    j: "piou"
};
var d = 20;
var f = function () {
    return "RTT"
};

// case "AssignmentExpression":
assert((a = "abcd").replace("b", "Y") === "aYcd");
// case "Identifier":
assert((b).replace("z", "B") === "aBerty");
// case "Literal":
assert(("luap").replace("l", "L") === "Luap");
// case "UnaryExpression":
assert((typeof "rr").replace("string", "hack") === "hack");
// case "BinaryExpression":
assert(("a" + "b").replace("a", "Z") === "Zb");
// case "LogicalExpression":
assert(("aaaah" || "ohhhh").replace("a", "Z") === "Zaaah");
// case "MemberExpression":
assert((c.j).replace("u", "uuuuuuuuuu") === "piouuuuuuuuuu");
// case "CallExpression":
assert((f()).replace("RTT", "work") === "work");
// case "NewExpression":
assert((new Boolean()).toString() === "false");
// case "ThisExpression":
assert((this).toString() === "[object Object]");
// case "ObjectExpression":
assert(({
    att: 21
}).hasOwnProperty("att"));
// case "UpdateExpression":
assert((d++).toString() === "20");
assert((++d).toString() === "22");
// case "ArrayExpression":
assert(([4, 7]).toString() === "4,7");
// case "ConditionalExpression":
assert((true ? "hehe" : "hoho").replace("e", "a") === "hahe");
// case "SequenceExpression":
assert(("joe", "henry", "dad").replace("d", "D") === "Dad");
