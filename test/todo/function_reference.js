var assert = require("assert");

var Class = {
    create: function () {
        return function () {}
    }
};
var o = Class.create();
var o2 = Class.create();
assert(!(o === o2));

var arr = [];
for(var i = 0 ;i<2 ; ++i) {
    arr[i] = function(){};
}
assert(!(arr[0] === arr[1]));
