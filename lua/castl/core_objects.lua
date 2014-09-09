--[[
    Copyright (c) 2014, Paul Bernier
    
    CASTL is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    CASTL is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.
    You should have received a copy of the GNU Lesser General Public License
    along with CASTL. If not, see <http://www.gnu.org/licenses/>.
--]]

-- [[ CASTL JS core objects submodule]] --

local internal = require("castl.internal")
local objectProto = require("castl.prototype.object")
local functionProto = require("castl.prototype.function")
local arrayProto = require("castl.prototype.array")
local booleanProto = require("castl.prototype.boolean")
local numberProto = require("castl.prototype.number")
local stringProto = require("castl.prototype.string")
local dateProto = require("castl.prototype.date")
local errorProto = require("castl.prototype.error.error")
local rangeErrorProto = require("castl.prototype.error.range_error")
local referenceErrorProto = require("castl.prototype.error.reference_error")
local syntaxErrorProto = require("castl.prototype.error.syntax_error")
local typeErrorProto = require("castl.prototype.error.type_error")
local regexpProto = require("castl.prototype.regexp")
local jssupport = require("castl.jssupport")
local errorHelper = require("castl.modules.error_helper")

local RegExp, Boolean, Number, String

local coreObjects = {}
-- Dependencies
local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset
local debug = debug
local type, max, strlen, strsub, tonumber, pack, tinsert, concat = type, math.max, string.len, string.sub, tonumber, table.pack, table.insert, table.concat
local next, tostring = next, tostring
local require, error = require, error

_ENV = nil

-- Core objects metatables
local objectMt, arrayMt = {}, {}
local booleanMt, numberMt, stringMt = {}, {}, {}
local functionMt, undefinedMt = {}, {}

-- Hidden field _prototype keep reference to inherited table
objectMt._prototype = objectProto
functionMt._prototype = functionProto
arrayMt._prototype = arrayProto

coreObjects.objectToString = function(o)
    local ret = {"{ "}
    local elements = {}

    for key in coreObjects.props(o) do
        local k = key
        local v = o[key]

        if type(k) == "number" then
            k = "'" .. tostring(k) .. "'"
        else
            k = tostring(k)
        end

        if type(v) == "string" then
            v = "'" .. tostring(v) .. "'"
        else
            v = tostring(v)
        end

        tinsert(elements, k .. ": " .. v)

    end
    tinsert(ret, concat(elements, ", "))
    tinsert(ret, " }")

    return concat(ret, "")
end

--[[
    Object metatable
--]]

objectMt.__index = function(self, key)
    return internal.get(self, objectProto, key)
end

objectMt.__newindex = function(self, key, value)
    internal.put(self, key, value)
end

objectMt.__tostring = function(self)
    return coreObjects.objectToString(self)
end

objectMt.__tonumber = function(self)
    return jssupport.NaN
end

--[[
    Function metatable
--]]

local functionsProxyObjects = {}

setmetatable(functionsProxyObjects, {__mode = 'k'})

function coreObjects.getFunctionProxy(fun)
    local proxy = rawget(functionsProxyObjects, fun)
    if not proxy then
        proxy = coreObjects.obj({})
        rawset(functionsProxyObjects, fun, proxy)
    end
    return proxy
end

functionMt.__index = function(self, key)
    local proxy = coreObjects.getFunctionProxy(self)

    -- prototype attribute of functions should always "exist"
    if key == 'prototype' then
        if proxy.prototype == nil then
            proxy.prototype = coreObjects.obj({constructor = self})
        end
        return proxy.prototype
    end

    local value = rawget(proxy, key)
    if value ~= nil then
        return value
    end

    return internal.get(proxy, functionProto, key)
end

functionMt.__newindex = function(self, key, value)
    local proxy = coreObjects.getFunctionProxy(self)
    internal.put(proxy, key, value)
end

functionMt.__tostring = function(self)
    -- TODO: approximation
    return "[Function]"
end

functionMt.__tonumber = function(self)
    return jssupport.NaN
end

debug.setmetatable((function () end), functionMt)

--[[
    Array metatable
--]]

arrayMt.__index = function(self, key)
    return internal.get(self, arrayProto, key)
end

arrayMt.__newindex = function(self, key, value)
    if type(key) == 'number' then
        local length = rawget(self, 'length') or 0
        rawset(self, 'length', max(length, key + 1))
    end
    internal.put(self, key, value)
end

arrayMt.__tostring = function(self)
    local str = ""
    local bound = self.length - 1
    for i = 0, bound do
        if self[i] ~= nil then
            if type(self[i]) == "string" then
                str = str .. "'" .. self[i] .."'"
            else
                str = str .. tostring(self[i])
            end
        end
        if i ~= bound then
            str = str .. ","
        end
    end

    return "[ " .. str .. " ]"
end

arrayMt.__tonumber = function(self)
    return jssupport.NaN
end

--[[
    Boolean metatable
--]]

booleanMt.__index = function(self, key)
    return internal.get(nil, booleanProto, key)
end

-- immutable
booleanMt.__newindex = function(self, key) end

booleanMt.__lt = function(a, b)
    local numValueA = a and 1 or 0

    if type(b) == "boolean" then
        local numValueB = b and 1 or 0
        return numValueA < numValueB
    end

    return numValueA < b
end

booleanMt.__tonumber = function(self)
    return self and 1 or 0
end

booleanMt.__le = function(a, b)
    local numValueA = a and 1 or 0

    if type(b) == "boolean" then
        local numValueB = b and 1 or 0
        return numValueA <= numValueB
    end

    return numValueA <= b
end

debug.setmetatable(true, booleanMt)

--[[
    Number metatable
--]]

numberMt.__index = function(self, key)
    return internal.get(nil, numberProto, key)
end

-- immutable
numberMt.__newindex = function(self, key) end

numberMt.__lt = function(a, b)
    if b == nil then
        return false
    end
    if type(b) == "string" then
        return a < tonumber(b)
    end
    if type(b) == "boolean" then
        local numValue = b and 1 or 0
        return a < numValue
    end
    if b == jssupport.null then
        return a < 0
    end

    return false
end

numberMt.__le = function(a, b)
    if b == nil then
        return false
    end
    if type(b) == "string" then
        return a <= tonumber(b)
    end
    if type(b) == "boolean" then
        local numValue = b and 1 or 0
        return a <= numValue
    end
    if b == jssupport.null then
        return a <= 0
    end

    return false
end

debug.setmetatable(0, numberMt)

--[[
    String metatable
--]]

stringMt.__index = function(self, key)

    local length = strlen(self)

    if key == "length" then
        return length
    end

    -- Access characters of a string like an array
    if tonumber(key) then
        local numKey = tonumber(key)
        if numKey >= length then
            return nil
        else
            return strsub(self, numKey + 1, numKey + 1)
        end
    end

    return internal.get(nil, stringProto, key)
end

stringMt.__lt = function(a, b)
    if b == nil then
        return false
    end
    if type(b) == "number" then
        return tonumber(a) < b
    end
    if type(b) == "boolean" then
        local numValue = b and 1 or 0
        return a < numValue
    end
    if b == jssupport.null then
        return tonumber(a) < 0
    end

    return false
end

stringMt.__le = function(a, b)
    if b == nil then
        return false
    end
    if type(b) == "number" then
        return tonumber(a) <= b
    end
    if type(b) == "boolean" then
        local numValue = b and 1 or 0
        return a <= numValue
    end
    if b == jssupport.null then
        return tonumber(a) <= 0
    end

    return false
end

-- immutable
stringMt.__newindex = function(self) end

stringMt.__add= function(a, b)
    return tostring(a) .. tostring(b)
end

stringMt.__tonumber = function(self)
    return tonumber(self) or jssupport.NaN
end

debug.setmetatable("", stringMt)

--[[
    Nil metatable
--]]

undefinedMt.__tostring = function (arg)
    return 'undefined'
end

undefinedMt.__add = function (a, b)
    if type(a) == "number" or type(b) == "number" or
        type(a) == "boolean" or type(b) == "boolean" then
        return 0/0
    end

    if type(a) == "string" or type(b) == "string" then
        return tostring(a) .. tostring(b)
    end

    return a + b
end

undefinedMt.__sub = function (a, b)
    return jssupport.NaN
end
undefinedMt.__mul = function (a, b)
    return jssupport.NaN
end
undefinedMt.__div = function (a, b)
    return jssupport.NaN
end
undefinedMt.__mod = function (a, b)
    return jssupport.NaN
end
undefinedMt.__pow = function (a, b)
    return jssupport.NaN
end

undefinedMt.__lt = function (a, b)
    return false
end
undefinedMt.__le = function (a, b)
    return false
end

undefinedMt.__tonumber = function (a, b)
    return jssupport.NaN
end

debug.setmetatable(nil, undefinedMt)

--[[
    Support functions
--]]

-- Inline creation of object: {att1: "...", att2: ...}
function coreObjects.obj(o)
    return setmetatable(o, objectMt)
end

-- Inline creation of array: [..., ...]
function coreObjects.array(arr, length)
    rawset(arr, 'length', length)
    return setmetatable(arr, arrayMt)
end

-- Inline creation of RegExp: /.../
function coreObjects.regexp(pattern, flags)
    RegExp = RegExp or require("castl.constructor.regexp")
    return coreObjects.new(RegExp, pattern, flags)
end

-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new
function coreObjects.new(f, ...)
    if type(f) ~= "function" then
        error(errorHelper.newTypeError(jssupport.typeof(f) .. " is not a function"))
    end

    local o = {}
    internal.setNewMetatable(o, f.prototype)
    local ret = f(o, ...)

    -- http://stackoverflow.com/a/3658673
    if type(ret) == "table" or type(ret) == "function" then
        return ret
    end

    return o
end

function coreObjects.arguments(...)
    local args, obj = pack(...), {}

    -- make a 0 based numbering array like
    -- and we ignore the first argument (= this)
    for i = 2, args.n do
        obj[i - 2] = args[i]
    end

    obj.length = args.n - 1

    local mt = {
        __index = function (self, key)
            return internal.get(self, objectProto, key)
        end,
        __newindex = function (self, key, value)
            return internal.put(self, key, value)
        end,
        __tostring = function(self)
            return coreObjects.objectToString(self)
        end,
        __tonumber = function()
            return jssupport.NaN
        end,
        _prototype = "Arguments"
    }

    setmetatable(obj, mt)

    return obj
end

local getPrototype = function(o)
    local mt = getmetatable(o)
    if mt then
        return mt._prototype
    end
    return nil
end

function coreObjects.instanceof(object, class)
    if type(class) ~= "function" then
        error(errorHelper.newTypeError("Expecting a function in instanceof check, but got " .. tostring(class)))
    end

    if class.prototype then
        local classPrototypeAttribute = class.prototype
        local objectPrototype = getPrototype(object)

        while objectPrototype do
            if objectPrototype == classPrototypeAttribute then
                return true
            end
            objectPrototype = getPrototype(objectPrototype)
        end
    end
    return false
end

--[[
    Iterator for objects
--]]

-- Warning: next doesn't support inherited properties
function coreObjects.next (o, previous)
    local mt = getmetatable(o)
    local isArray = mt and (mt._prototype == arrayProto or mt._prototype == "Arguments")

    -- iteration over array or string is similar
    if isArray or type(o) == "string" then
        -- start iteration at 0
        if previous == nil then
            if o[0] then
                return 0
            else
                local ret = nil
                repeat
                    ret = next(o, ret)
                until (type(ret) ~= 'number') and not (ret == 'length')
                return ret
            end
        end

        -- if previous was a number
        if type(previous) == "number" then
            if previous + 1 < o.length then
                return previous + 1
            elseif type(o) ~= "string" then
                -- try to find a non-numerical property (and different from 'length')
                local ret = nil
                repeat
                    ret = next(o, ret)
                until (type(ret) ~= 'number') and not (ret == 'length')
                return ret
            end
        else
            local ret = previous
            repeat
                ret = next(o, ret)
            until (type(ret) ~= 'number') and not (ret == 'length')
            return ret
        end

        return nil

    elseif type(o) == "table" then
        -- TODO: enumerability not handled
        return next(o, previous)
    end

    -- iteration over booleans, numbers, nil does nothing
    return nil

end


function coreObjects.props (arg)
    if type(arg) == 'function' then
        arg = coreObjects.getFunctionProxy(arg)
    end

    return coreObjects.next, arg
end

--[[
    Prototypes inherit from object (not the same as ECMAScript spec)
--]]

coreObjects.obj(functionProto)
coreObjects.obj(arrayProto)
coreObjects.obj(booleanProto)
coreObjects.obj(numberProto)
coreObjects.obj(stringProto)
coreObjects.obj(dateProto)
coreObjects.obj(regexpProto)
coreObjects.obj(errorProto)

coreObjects.obj(rangeErrorProto)
coreObjects.obj(referenceErrorProto)
coreObjects.obj(syntaxErrorProto)
coreObjects.obj(typeErrorProto)
coreObjects.obj(regexpProto)

--[[
    Export objectMt and arrayMt for JSON.parse
--]]

coreObjects.objectMt = objectMt
coreObjects.arrayMt = arrayMt


-- global this
coreObjects.this = coreObjects.obj({})

return coreObjects
