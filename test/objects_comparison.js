var assert = require("assert");

assert(0 < new Boolean(true));
assert(!(0 < new Boolean(false)));
assert(!(new Boolean(true) < 1));
assert(new Boolean(false) < 1);
assert("0" < new Boolean(true));
assert(!("0" < new Boolean(false)));
assert(!(new Boolean(true) < "1"));
assert(new Boolean(false) < "1");
assert(false < new Boolean(true));
assert(!(false < new Boolean(false)));
assert(!(new Boolean(true) < true));
assert(new Boolean(false) < true);

assert(0 < new Number(1));
assert(!(0 < new Number(0)));
assert(!(new Number(1) < 1));
assert(new Number(0) < 1);
assert("0" < new Number(1));
assert(!("0" < new Number(0)));
assert(!(new Number(1) < "1"));
assert(new Number(0) < "1");
assert(0 < new Number(1));
assert(!(0 < new Number(0)));
assert(!(new Number(1) < 1));
assert(new Number(0) < 1);

assert(0 < new String("1"));
assert(!(0 < new String("0")));
assert(!(new String("1") < 1));
assert(new String("0") < 1);
assert("0" < new String("1"));
assert(!("0" < new String("0")));
assert(!(new String("1") < "1"));
assert(new String("0") < "1");
assert(0 < new String("1"));
assert(!(0 < new String("0")));
assert(!(new String("1") < 1));
assert(new String("0") < 1);

var d1 = new Date(1989, 3, 15);
var d2 = new Date(1989, 3, 16);
assert(d1 < d2);

var o1 = {valueOf: function(){return "a"}};
var o2 = {valueOf: function(){return "b"}};

assert(o1 < o2);

var o3 = {toString: function(){return "a"}};
var o4 = {toString: function(){return "b"}};

assert(o3 < o4);

var o5 = {valueOf: function(){return "b"}, toString: function(){return "a";}};
var o6 = {valueOf: function(){return "a"}, toString: function(){return "b";}};

assert(o5 > o6);


