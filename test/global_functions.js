var assert = require("assert");

// isFinite
assert(!isFinite(Infinity));
assert(!isFinite(NaN));
assert(!isFinite(-Infinity));
assert(isFinite(0));
assert(isFinite(2e64));
assert(isFinite("0"));

// IsNan
assert(isNaN(NaN));
assert(isNaN(undefined));
assert(isNaN({}));
assert(isNaN({
    a: 11
}));
assert(isNaN(isNaN));

assert(!isNaN(true));
assert(!isNaN(null));
assert(!isNaN(37));
assert(!isNaN({valueOf: function(){return 3}}));
assert(isNaN({}));

// strings
assert(isNaN("NaN"));
assert(!isNaN("37"));
assert(!isNaN("37.37"));
assert(!isNaN(""));
assert(!isNaN(" "));
assert(isNaN("blabla"));

//assert(isNaN(new Date());                // false
//assert(isNaN(new Date().toString());     // true

// parseFloat

assert(parseFloat("3.14") === 3.14);
assert(parseFloat("314e-2") === 3.14);
assert(parseFloat("0.0314E+2") === 3.14);
assert(isNaN(parseFloat("FF2")));

// parseInt

assert(parseInt(" 0xF", 16) === 15);
assert(parseInt(" F", 16) === 15);
assert(parseInt("17", 8) === 15);
assert(parseInt(021, 8) === 15);
assert(parseInt("015", 10) === 15);
assert(parseInt(15.99, 10) === 15);
assert(parseInt("FXX123", 16) === 15);
assert(parseInt("1111", 2) === 15);
assert(parseInt("15*3", 10) === 15);
assert(parseInt("15e2", 10) === 15);
assert(parseInt("15px", 10) === 15);
assert(parseInt("12", 13) === 15);

assert(isNaN(parseInt("Hello", 8)));
assert(isNaN(parseInt("546", 2)));

assert(parseInt("-F", 16) === -15);
assert(parseInt("-0F", 16) === -15);
assert(parseInt("-0XF", 16) === -15);
assert(parseInt(-15.1, 10) === -15);
assert(parseInt(" -17", 8) === -15);
assert(parseInt(" -15", 10) === -15);
assert(parseInt("-1111", 2) === -15);
assert(parseInt("-15e1", 10) === -15);
assert(parseInt("-12", 13) === -15);

assert(parseInt("0e0", 16) === 224);
