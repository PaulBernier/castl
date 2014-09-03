var assert = require('assert');

// Basic test
var a = true;
var nota = false;
if (!a)
    assert(false);

if (b)
    assert(false);

var b = "test";

if (!(b === "test"))
    assert(false);

if (b !== "test")
    assert(false);

// Equality and strict equality
var c = 21;

if (c == "21")
    assert(true);
else
    assert(false);

if (c === "21")
    assert(false);
else
    assert(true);

// UpdateExpression in if
var i = -1;
var j = -1;

if (j++)
    assert(true);
else
    assert(false);

if (j++)
    assert(false);
else
    assert(true);

if (++i)
    assert(false);
else
    assert(true);

if (++i)
    assert(true);
else
    assert(false);

// 0 and "" are false in lua
if (0)
    assert(false);
else
    assert(true);

if ("")
    assert(false);
else
    assert(true);

// negation

var zero = !!0
if (zero)
    assert(false);
else
    assert(true);

zero = !0
if (zero)
    assert(true);
else
    assert(false);

assert(!0);
assert(!"");
assert(!!0 === false);
assert(!!"" === false);
