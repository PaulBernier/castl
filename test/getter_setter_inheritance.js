var assert = require("assert");

var Base = function(){};
Base.prototype = {get g () {return this.att}, set s (v) {this.z = v}};

var instance = new Base();

assert(instance.g === undefined);
instance.att = 21;
assert(instance.g === 21);

instance.s = 44;
assert(Base.prototype.z === undefined);
assert(instance.z === 44);
assert(Base.prototype.s === undefined);
assert(instance.s=== undefined );
