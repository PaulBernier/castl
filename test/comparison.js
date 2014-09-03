var assert = require("assert");

assert(2 < 4);
assert(2 <= 4);
assert(!(2 > 4));
assert(!(2 >= 4));

// Strings

assert("2" < "4");
assert("2" <= "4");
assert(!("2" > "4"));
assert(!("2" >= "4"));

// Strings and numbers

assert(2 < "4");
assert("2" < 4);
assert(2 <= "4");
assert("2" <= 4);
assert(!(2 > "4"));
assert(!("2" > 4));
assert(!(2 >= "4"));
assert(!("2" >= 4));
assert("4" < "awba");
assert(!("4" > "awba"));
assert(!(4 < "awba"));
assert(!(4 > "awba"));

// null
assert(!(2 < null));
assert(null < 2);
assert(-2 < null);
assert(!(null < -2));
assert(!("2" < null));
assert(null < "2");
assert("-2" < null);
assert(!(null < "-2"));
assert(!("fez" < null));
assert(!(null < "fez"));
assert(!("fez" < null));
assert(!(null < "fez"));

// boolean
assert(!(1 < true));
assert(!(true < 1));
assert(1 <= true);
assert(true <= 1);
assert(!(1 < false));
assert(false < 1);
assert(!(1 <= false));
assert(false <= 1);
assert(0 < true);
assert(!(true < 0));
assert(0 <= true);
assert(!(true <= 0));
assert(!(0 < false));
assert(!(false < 0));
assert(0 <= false);
assert(false <= 0);
assert(false < true);
assert(!(true < false));

assert(!("1" < true));
assert(!(true < "1"));
assert("1" <= true);
assert(true <= "1");
assert(!("1" < false));
assert(false < "1");
assert(!("1" <= false));
assert(false <= "1");
assert("0" < true);
assert(!(true < "0"));
assert("0" <= true);
assert(!(true <= "0"));
assert(!("0" < false));
assert(!(false < "0"));
assert("0" <= false);
assert(false <= "0");
assert(false < true);
assert(!(true < false));
