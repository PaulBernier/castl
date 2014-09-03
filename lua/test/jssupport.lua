local jssupport = require("castl.jssupport")

assert(jssupport.equal(15,"15") == true)
assert(jssupport.equal("15",15) == true)

assert(jssupport.add(15,15) == 30)
assert(jssupport.add("15",15) == "1515")
assert(jssupport.add(15,"15") == "1515")
assert(jssupport.add("15","15") == "1515")

assert(jssupport.boolean("str") == true)
assert(jssupport.boolean(1) == true)
assert(jssupport.boolean("0") == true)
assert(jssupport.boolean(0) == false)
assert(jssupport.boolean("") == false)
assert(jssupport.boolean(0/0) == false)

local a = jssupport.null
assert(((jssupport.typeof(a)) == "object"))
assert((a == jssupport.null))
assert((a ~= nil))
assert((jssupport.equal(a,nil)))

print("TESTS DONE")
