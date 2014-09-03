var assert = require("assert");

// Encode
assert(encodeURI("http://www.google.com/a file with spaces.html") === "http://www.google.com/a%20file%20with%20spaces.html");
assert(encodeURIComponent("http://www.google.com/a file with spaces.html") === "http%3A%2F%2Fwww.google.com%2Fa%20file%20with%20spaces.html");

var param1 = encodeURIComponent("http://xyz.com/?a=12&b=55");
var url = "http://www.domain.com/?param1=" + param1 + "&param2=99";
assert(url === "http://www.domain.com/?param1=http%3A%2F%2Fxyz.com%2F%3Fa%3D12%26b%3D55&param2=99");

// Decode
assert(decodeURI("http://www.google.com/a%20file%20with%20spaces.html") === "http://www.google.com/a file with spaces.html");
assert(decodeURIComponent("http%3A%2F%2Fwww.google.com%2Fa%20file%20with%20spaces.html") === "http://www.google.com/a file with spaces.html");
assert(decodeURIComponent(param1) === "http://xyz.com/?a=12&b=55");

// Special chars
assert(encodeURI("+") === "+");
assert(encodeURIComponent("+") === "%2B");
assert(decodeURI("%2B") === "%2B");
assert(decodeURIComponent("%2B") === "+");
assert(decodeURI("+") === "+");
assert(decodeURIComponent("+") === "+");

assert(encodeURI("#") === "#");
assert(encodeURIComponent("#") === "%23");
assert(decodeURI("%23") === "%23");
assert(decodeURIComponent("%23") === "#");
assert(decodeURI("#") === "#");
assert(decodeURIComponent("#") === "#");

assert(encodeURI("!") === "!");
assert(encodeURIComponent("!") === "!");
assert(decodeURI("!") === "!");
assert(decodeURIComponent("!") === "!");
assert(decodeURI("%21") === "!");
assert(decodeURIComponent("%21") === "!");

assert(encodeURI("$") === "$");
assert(encodeURIComponent("$") === "%24");
assert(decodeURI("$") === "$");
assert(decodeURI("%24") === "%24");
assert(decodeURIComponent("$") === "$");
assert(decodeURIComponent("%24") === "$");

assert(encodeURI(".") === ".");
assert(encodeURIComponent(".") === ".");
assert(decodeURI(".") === ".");
assert(decodeURIComponent(".") === ".");
assert(decodeURI("%2E") === ".");
assert(decodeURIComponent("%2E") === ".");

assert(encodeURI("%") === "%25");
assert(encodeURIComponent("%") === "%25");
assert(decodeURI("%25") === "%");
assert(decodeURIComponent("%25") === "%");
