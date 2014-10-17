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
local errorHelper = require("castl.modules.error_helper")
local throw = require("castl.jssupport").throw
local typeof = require("castl.jssupport").typeof
local RegExp

local protos = require("castl.protos")

local objectProto = protos.objectProto
local functionProto = protos.functionProto
local arrayProto = protos.arrayProto
local booleanProto = protos.booleanProto
local numberProto = protos.numberProto
local stringProto = protos.stringProto
local dateProto = protos.dateProto
local regexpProto = protos.regexpProto
local errorProto = protos.errorProto
local rangeErrorProto = protos.rangeErrorProto
local referenceErrorProto = protos.referenceErrorProto
local syntaxErrorProto = protos.syntaxErrorProto
local typeErrorProto = protos.typeErrorProto
local uriErrorProto = protos.uriErrorProto
local evalErrorProto = protos.evalErrorProto

local coreObjects = {}

-- Dependencies
local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset
local debug = debug
local type, max, strlen, strsub, tonumber = type, math.max, string.len, string.sub, tonumber
local pack = table.pack or function(...) return {n = select('#',...),...} end
local tinsert, concat, sort = table.insert, table.concat, table.sort
local pairs, ipairs, tostring = pairs, ipairs, tostring
local require = require
local getPrototype, get, put  = internal.prototype, internal.get, internal.put
local setNewMetatable, ToNumber, getFunctionProxy = internal.setNewMetatable, internal.ToNumber, internal.getFunctionProxy

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

    local props = coreObjects.props(o, false, false)
    for _, key in ipairs(props) do
        local k = key
        local v = o[key]

        if type(k) == "number" then
            k = "'" .. tostring(k) .. "'"
        end

        if type(v) == "string" then
            v = "'" .. v .. "'"
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
    return get(self, objectProto, key)
end

objectMt.__newindex = put

objectMt.__tostring = function(self)
    return coreObjects.objectToString(self)
end

objectMt.__sub = function(a, b)
    return ToNumber(a) - ToNumber(b)
end

objectMt.__mul = function(a, b)
    return ToNumber(a) * ToNumber(b)
end

objectMt.__div = function(a, b)
    return ToNumber(a) / ToNumber(b)
end

--[[
    Function metatable
--]]

functionMt.__index = function(self, key)
    local proxy = getFunctionProxy(self)

    local value = rawget(proxy, key)
    if value ~= nil then
        return value
    end

    return get(proxy, functionProto, key)
end

functionMt.__newindex = function(self, key, value)
    local proxy = getFunctionProxy(self)
    put(proxy, key, value)
end

functionMt.__tostring = function(self)
    return "[Function]"
end

functionMt.__sub = function(a, b)
    return ToNumber(a) - ToNumber(b)
end

functionMt.__mul = function(a, b)
    return ToNumber(a) * ToNumber(b)
end

functionMt.__div = function(a, b)
    return ToNumber(a) / ToNumber(b)
end

debug.setmetatable((function () end), functionMt)

--[[
    Array metatable
--]]

arrayMt.__index = function(self, key)
    return get(self, arrayProto, key)
end

arrayMt.__newindex = function(self, key, value)
    if type(key) == 'number' then
        local length = rawget(self, 'length') or 0
        rawset(self, 'length', max(length, key + 1))
    end
    put(self, key, value)
end

arrayMt.__tostring = function(self)
    local ret = {"[ "}
    local elements = {}

    local props = coreObjects.props(self, false, false)
    for _, key in ipairs(props) do
        local k = key
        local v = self[key]

        if type(v) == "string" then
            v = "'" .. v .. "'"
        else
            v = tostring(v)
        end

        if type(k) == "number" then
            tinsert(elements, v)
        else
            tinsert(elements, k .. ": " .. v)
        end
    end
    tinsert(ret, concat(elements, ", "))
    tinsert(ret, " ]")

    return concat(ret, "")
end

arrayMt.__sub = function(a, b)
    return ToNumber(a) - ToNumber(b)
end

arrayMt.__mul = function(a, b)
    return ToNumber(a) * ToNumber(b)
end

arrayMt.__div = function(a, b)
    return ToNumber(a) / ToNumber(b)
end

--[[
    Boolean metatable
--]]

booleanMt.__index = function(self, key)
    return get(nil, booleanProto, key)
end

-- immutable
booleanMt.__newindex = function() end

booleanMt.__sub = function(a, b)
    return ToNumber(a) - ToNumber(b)
end

booleanMt.__mul = function(a, b)
    return ToNumber(a) * ToNumber(b)
end

booleanMt.__div = function(a, b)
    return ToNumber(a) / ToNumber(b)
end

debug.setmetatable(true, booleanMt)

--[[
    Number metatable
--]]

numberMt.__index = function(self, key)
    return get(nil, numberProto, key)
end

-- immutable
numberMt.__newindex = function() end

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
    local num = tonumber(key)
    if num then
        if num < length then
            return strsub(self, num + 1, num + 1)
        end
        return nil
    end

    return get(nil, stringProto, key)
end

-- immutable
stringMt.__newindex = function() end

stringMt.__sub = function(a, b)
    return ToNumber(a) - ToNumber(b)
end

stringMt.__mul = function(a, b)
    return ToNumber(a) * ToNumber(b)
end

stringMt.__div = function(a, b)
    return ToNumber(a) / ToNumber(b)
end

debug.setmetatable("", stringMt)

--[[
    Nil metatable
--]]

undefinedMt.__index = function(self, key)
    throw(errorHelper.newTypeError("Cannot read property '" .. key .. "' of undefined"))
end

undefinedMt.__newindex = function(self, key)
    throw(errorHelper.newTypeError("Cannot set property '" .. key .. "' of undefined"))
end

undefinedMt.__tostring = function ()
    return "undefined"
end

undefinedMt.__sub = function ()
    return 0/0
end
undefinedMt.__mul = function ()
    return 0/0
end
undefinedMt.__div = function ()
    return 0/0
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
        throw(errorHelper.newTypeError(typeof(f) .. " is not a function"))
    end

    local o = {}
    setNewMetatable(o, f.prototype)
    local ret = f(o, ...)

    -- http://stackoverflow.com/a/3658673
    local tr = type(ret)
    if tr == "table" or tr == "function" then
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
            return get(self, objectProto, key)
        end,
        __newindex = put,
        __tostring = function(self)
            return coreObjects.objectToString(self)
        end,
        _arguments = true,
        _prototype = objectProto
    }

    setmetatable(obj, mt)

    return obj
end

function coreObjects.instanceof(object, class)
    if type(class) ~= "function" then
        throw(errorHelper.newTypeError("Expecting a function in instanceof check, but got " .. tostring(class)))
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

function coreObjects.props (arg, inherited, enumAll)
    if type(arg) == 'function' then
        arg = getFunctionProxy(arg)
    end

    local ret = {}

    local mt = getmetatable(arg)
    local isArrayLike = (mt and (mt._prototype == arrayProto or mt._arguments or mt._prototype == stringProto));

    if isArrayLike then
        return coreObjects.propsArr(arg, enumAll)
    elseif type(arg) == 'table' then
        return coreObjects.propsObj(arg, inherited)
    elseif type(arg) == 'string' then
        for i = 0, arg.length - 1 do
            tinsert(ret, i)
        end
    end

    return ret
end

function coreObjects.propsObj(arg, inherited)
    local ret = {}
    repeat
        for i in pairs(arg) do
            tinsert(ret, i)
        end
        arg = (getmetatable(arg) or {})._prototype
    until not inherited or arg == nil
        -- Hide properties of builtin-object
        or arg == objectProto or arg == numberProto
        or arg == booleanProto or arg == stringProto
        or arg == arrayProto or arg == functionProto
        or arg == dateProto or arg == regexpProto

    -- sort keys
    sort(ret, function(a, b)
        a = tonumber(a) or a
        b = tonumber(b) or b

        local ta, tb = type(a), type(b)
        if ta == "number" and tb == "string" then
            return true
        elseif ta == "string" and tb == "number" then
            return false
        end
        return a < b
    end)

    return ret
end

function coreObjects.propsArr(arg, enumAll)
    local ret = {}

    for i in pairs(arg) do
        if enumAll or not (i == "length") then
            tinsert(ret, i)
        end
    end

    -- sort keys
    sort(ret, function(a, b)
        local ta, tb = type(a), type(b)
        if ta == "number" and tb == "string" then
            return true
        elseif ta == "string" and tb == "number" then
            return false
        end
        return a < b
    end)

    return ret
end

--[[
    Prototypes inheritance
--]]

-- Object.prototype has no _prototype
setmetatable(objectProto, {
    __index = function(self, key)
        return get(self, objectProto, key)
    end,
    __newindex = put,
    __tostring = function(self)
        return coreObjects.objectToString(self)
    end,
    __sub = function(a, b)
        return ToNumber(a) - ToNumber(b)
    end,
    __mul = function(a, b)
        return ToNumber(a) * ToNumber(b)
    end,
    __div = function(a, b)
        return ToNumber(a) / ToNumber(b)
    end
})

-- inherit from Object
coreObjects.obj(functionProto)
coreObjects.obj(arrayProto)
coreObjects.obj(booleanProto)
coreObjects.obj(numberProto)
coreObjects.obj(stringProto)
coreObjects.obj(dateProto)
coreObjects.obj(regexpProto)
coreObjects.obj(errorProto)

local err = function(o)
    setmetatable(o, {
        __index = function (self, key)
            return get(self, errorProto, key)
        end,
        __newindex = put,
        __tostring = function(self)
            return self:toString()
        end,
        __sub = function(a, b)
            return ToNumber(a) - ToNumber(b)
        end,
        __mul = function(a, b)
            return ToNumber(a) * ToNumber(b)
        end,
        __div = function(a, b)
            return ToNumber(a) / ToNumber(b)
        end,
        _prototype = errorProto})
end

-- inherit from Error
err(rangeErrorProto)
err(referenceErrorProto)
err(syntaxErrorProto)
err(typeErrorProto)
err(uriErrorProto)
err(evalErrorProto)


--[[
    Export objectMt and arrayMt for JSON.parse
--]]

coreObjects.objectMt = objectMt
coreObjects.arrayMt = arrayMt

-- global this
coreObjects.this = coreObjects.obj({})

return coreObjects
