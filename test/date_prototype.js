var assert = require("assert");

var date = new Date(1989, 2, 15, 22, 15, 1, 233);

assert(date.getDate() === 15);
assert(date.getDay() === 3);
assert(date.getFullYear() === 1989);
assert(date.getHours() === 22);
assert(date.getMilliseconds() === 233);
assert(date.getMinutes() === 15);
assert(date.getMonth() === 2);

var theBigDay = new Date(1980, 6, 7);
theBigDay.setUTCDate(24);
assert(theBigDay.getUTCDate() === 24);
assert(theBigDay.getUTCMonth() === 6);
theBigDay.setUTCDate(36);
assert(theBigDay.getUTCDate() === 5);
assert(theBigDay.getUTCMonth() === 7);

theBigDay = new Date(1980, 6, 7);
theBigDay.setFullYear(2001);
assert(theBigDay.getFullYear() === 2001);

theBigDay = new Date(1980, 6, 7);
theBigDay.setHours(5);
assert(theBigDay.getHours() === 5);
theBigDay.setHours(44);
assert(theBigDay.getDate() === 8);
assert(theBigDay.getHours() === 20);

theBigDay = new Date(1980, 6, 7);
theBigDay.setMinutes(5);
assert(theBigDay.getMinutes() === 5);
assert(theBigDay.getHours() === 0);
theBigDay.setMinutes(88);
assert(theBigDay.getDate() === 7);
assert(theBigDay.getHours() === 1);
assert(theBigDay.getMinutes() === 28);

theBigDay = new Date(1980, 6, 7);
theBigDay.setMonth(11);
assert(theBigDay.getMonth() === 11);
assert(theBigDay.getFullYear() === 1980);
theBigDay.setMonth(20);
assert(theBigDay.getMonth() === 8);
assert(theBigDay.getFullYear() === 1981);

theBigDay = new Date(1980, 6, 7);
theBigDay.setSeconds(11);
assert(theBigDay.getSeconds() === 11);
assert(theBigDay.getMinutes() === 0);
theBigDay.setSeconds(200);
assert(theBigDay.getSeconds() === 20);
assert(theBigDay.getMinutes() === 3);

theBigDay = new Date(1980, 6, 7, 3, 15, 55, 123);
theBigDay.setMilliseconds(11);
assert(theBigDay.getDate() === 7);
assert(theBigDay.getFullYear() === 1980);
assert(theBigDay.getHours() === 3);
assert(theBigDay.getMilliseconds() === 11);
assert(theBigDay.getMinutes() === 15);
assert(theBigDay.getMonth() === 6);
assert(theBigDay.getSeconds() === 55);

theBigDay.setMilliseconds(2100);
assert(theBigDay.getDate() === 7);
assert(theBigDay.getFullYear() === 1980);
assert(theBigDay.getHours() === 3);
assert(theBigDay.getMilliseconds() === 100);
assert(theBigDay.getMinutes() === 15);
assert(theBigDay.getMonth() === 6);
assert(theBigDay.getSeconds() === 57);

theBigDay = new Date(1980, 6, 7);
var sameAsBigDay = new Date();
sameAsBigDay.setTime(theBigDay.getTime());
assert(theBigDay.getTime() === sameAsBigDay.getTime());

// Year between 0 and 100
date = new Date(55, 2, 15);
assert(date.getFullYear() === 1955);
date = new Date(0, 2, 15);
assert(date.getFullYear() === 1900);
date = new Date(99, 2, 15);
assert(date.getFullYear() === 1999);
date = new Date(100, 2, 15);
assert(date.getFullYear() === 100)
