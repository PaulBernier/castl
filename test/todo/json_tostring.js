var assert = require("assert");

var a = JSON.stringify({
    toJSON: function () { return "foo"; }
})

assert(a === '"foo"');

var b = JSON.stringify({z:
    {toJSON: function () { return 21; }}
})

assert(b === '{"z":21}');

var c = JSON.stringify({
    w: function(){ return "66"},
    q: "tt"
})

assert(c === '{"q":"tt"}')
