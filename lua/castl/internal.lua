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

local internal = {}

local errorHelper = require("castl.modules.error_helper")

local Boolean, Number, String, new, objectToString

local getmetatable, setmetatable, type, tostring, tonumber, error, require, rawget, rawset = getmetatable, setmetatable, type, tostring, tonumber, error, require, rawget, rawset
local huge = math.huge

_ENV = nil

internal.null = {}
local null = internal.null
setmetatable(internal.null,{
    __index = function(self, key)
        error(errorHelper.newTypeError("TypeError: Cannot read property '" .. key .. "' of null"))
    end,
    __newindex = function(self, key)
        error(errorHelper.newTypeError("TypeError: Cannot set property '" .. key .. "' of null"))
    end,
    __tostring = function ()
        return 'null'
    end,
    __tonumber = function()
        return 0
    end,
    __sub = function(a, b)
        a = (a == null) and 0 or tonumber(a)
        b = (b == null) and 0 or tonumber(b)
        return a - b
    end,
    __mod = function(a, b)
        a = (a == null) and 0 or tonumber(a)
        b = (b == null) and 0 or tonumber(b)
        return a % b
    end,
    __div = function(a, b)
        if a == null then
            return 0 / tonumber(b)
        end
        return huge
    end,
    __mul = function(a, b)
        a = (a == null) and 0 or tonumber(a)
        b = (b == null) and 0 or tonumber(b)
        return a * b
    end,
    __lt = function(a, b)
        local tb = type(b)
        if tb == "number" then
            return 0 < b
        end
        if tb == "string" then
            return 0 < tonumber(b)
        end
        if tb == "boolean" then
            return b
        end
        if b == null then
            return false
        end

        return false
    end,
    __le = function(a, b)
        local tb = type(b)
        if tb == "number" then
            return 0 <= b
        end
        if tb == "string" then
            return 0 <= tonumber(b)
        end
        if tb == "boolean" then
            return true
        end
        if b == null then
            return true
        end

        return false
    end,
    __tojson = function () return "null" end
})

-- get/put
function internal.get(self, prototype, key)
    -- case of built-in types: boolean, string and number
    if self == nil then return prototype[key] end
    -- check getter
    local getter = rawget(self, "_g" .. tostring(key))
    return getter and getter(self) or prototype[key]
end

function internal.put(self, key, value)
    -- check setter
    local setter = rawget(self, "_s" .. tostring(key))
    if setter then
        setter(self, value)
    else
        rawset(self, key, value)
    end
end

local get, put = internal.get, internal.put

-- prototype
function internal.prototype(o)
    local mt = getmetatable(o)
    if mt then
        return mt._prototype
    end
    return nil
end

-- test if constructor called within a new
function internal.withinNew(this, proto)
    local mt = getmetatable(this)
    return mt and mt._prototype == proto
end

function internal.toPrimitive(o)
    local mt = getmetatable(o)

    if mt._primitive then
        return mt._primitive
    end

    return o
end

local toPrimitive = internal.toPrimitive

-- http://www.ecma-international.org/ecma-262/5.1/#sec-9.9
function internal.toObject(v)
    null = null or require("castl.jssupport")
    if v == nil or v == null then
        error("ToObject: undefined or null")
    end

    local tv = type(v)
    new = new or require("castl.core_objects").new
    if tv == "boolean" then
        Boolean = Boolean or require("castl.constructor.boolean")
        return new(Boolean, v)
    elseif tv == "number" then
        Number = Number or require("castl.constructor.number")
        return new(Number, v)
    elseif tv == "string" then
        String = String or require("castl.constructor.string")
        return new(String, v)
    end

    return v
end

function internal.toNumber(value)
    local mt = getmetatable(value)
    if (mt or {}).__tonumber then
        return mt.__tonumber(value)
    end

    return tonumber(value)
end

local toNumber = internal.toNumber

-- http://www.ecma-international.org/ecma-262/5.1/#sec-8.12.8
function internal.defaultValueString(o)
    if type(o) == "table" and type(o.toString) == "function" then
        return o:toString()
    end

    return tostring(o)
end

-- Wibbly Wobbly Codey Wimey Stuff
function internal.defaultValueNumber(o)
    local to = type(o)
    if to == "table" and type(o.valueOf) == "function" then
        local value = o:valueOf()
        local tvalue = type(value)
        if tvalue ~= "table" then
            return value
        end
        return value:toString()
    elseif to == "table" and type(o.toString) == "function" then
        local value = o:toString()
        local tvalue = type(value)
        if tvalue ~= "table" then
            return value
        end
        error("[[DefaultValue(Number)")
    end

    return toNumber(o)
end

local defaultValueNumber = internal.defaultValueNumber

-- create a metatable for a new object (used in new statement and Object.create)
function internal.setNewMetatable(o, prototype)
    local mt = {
        __index = function (self, key)
            return get(self, prototype, key)
        end,
        __newindex = function (self, key, value)
            put(self, key, value)
        end,
        __tonumber = function(self)
            return tonumber(toPrimitive(self)) or 0/0
        end,
        __lt = function(a, b)
            return defaultValueNumber(a) < defaultValueNumber(b)
        end,
        __le = function(a, b)
            return defaultValueNumber(a) <= defaultValueNumber(b)
        end,
        _prototype = prototype
    }

    local protoMt = getmetatable(prototype)
    if protoMt and protoMt.__tostring then
        mt.__tostring = protoMt.__tostring
    else
        objectToString = objectToString or require("castl.core_objects").objectToString
        mt.__tostring = objectToString
    end

    setmetatable(o, mt)
end

return internal
