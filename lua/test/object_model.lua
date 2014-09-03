local core_objects = require("castl.core_objects")
local jssupport = require("castl.jssupport")
local Object = require("castl.constructor.object")
local Function = require("castl.constructor.function")

local a = core_objects.obj({a = 12})

a.prototype = core_objects.obj({
    b = 1337
})

assert(jssupport.typeof(a) == "object")

local b = Object:create(a.prototype)

assert(jssupport.typeof(b) == "object")
assert(a.a == 12 and a.b == nil)
assert(b.a == nil and b.b == 1337)


local MyClass = function(this, arg)
    this.test = "this is a string"
    this.test2 = arg
end


MyClass.prototype.special = "special!"

-- Act as a regular function
MyClass({},7)

assert(jssupport.typeof(MyClass) == "function")

local c = core_objects.new(MyClass, 6)

assert(jssupport.typeof(c) == "object")
assert(c.test == "this is a string")
assert(c.test2 == 6)

local MyClass2 = function(this, arg)
    this.test3 = "inherit"
    this.test4 = arg
end

MyClass2.prototype = Object:create(MyClass.prototype)

local d = core_objects.new(MyClass2, 1337)

assert(d.test == nil)
assert(d.test2 == nil)
assert(d.test3 == "inherit")
assert(d.test4 == 1337)
assert(d.special == "special!")

-- Instance of
assert(core_objects.instanceof(d, MyClass2))
assert(core_objects.instanceof(d, MyClass))
assert(not core_objects.instanceof(c, MyClass2))
assert(core_objects.instanceof(c,MyClass))

assert(not core_objects.instanceof(MyClass, MyClass2))
assert(not core_objects.instanceof(MyClass2, MyClass))

assert(core_objects.instanceof(MyClass, Function))
assert(core_objects.instanceof(MyClass2, Function))

assert(core_objects.instanceof(Function, Object))

assert(core_objects.instanceof(a, Object))
assert(core_objects.instanceof(b, a))

assert(core_objects.instanceof(b, Object))
assert(core_objects.instanceof(c, Object))
assert(core_objects.instanceof(d, Object))
