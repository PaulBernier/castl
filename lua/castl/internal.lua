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

local Boolean, Number, String, new, objectToString, obj, throw

local getmetatable, setmetatable, type, tostring, tonumber, require, rawget, rawset = getmetatable, setmetatable, type, tostring, tonumber, require, rawget, rawset
local gsub = string.gsub
local floor, ceil = math.floor, math.ceil

_ENV = nil

-- forward declaration of null
internal.null = {}
local null = internal.null

-- Functions proxy
local functionsProxyObjects = {}
setmetatable(functionsProxyObjects, {__mode = 'k'})

function internal.getFunctionProxy(fun)
    local proxy = rawget(functionsProxyObjects, fun)
    if proxy == nil then
        obj = obj or require("castl.core_objects").obj
        proxy = {prototype = obj({constructor = fun})}
        rawset(functionsProxyObjects, fun, proxy)
    end
    return proxy
end

local getFunctionProxy = internal.getFunctionProxy

function internal.isPrimitiveValue(v)
    local tv = type(v)
    return tv == "string" or tv == "number" or tv == "boolean" or v == null or v == nil
end

local isPrimitiveValue = internal.isPrimitiveValue

-- http://www.ecma-international.org/ecma-262/5.1/#sec-8.12.8
function internal.defaultValueString(o)
    if type(o.toString) == "function" then
        local value = o:toString()
        if isPrimitiveValue(value) then
            return value
        end
    end
    if type(o.valueOf) == "function" then
        local value = o:valueOf()
        if isPrimitiveValue(value) then
            return value
        end
    end

    throw = throw or require("castl.jssupport").throw
    throw(errorHelper.newTypeError("Cannot convert object to primitive value"))
end

function internal.defaultValueNumber(o)
    if type(o.valueOf) == "function" then
        local value = o:valueOf()
        if isPrimitiveValue(value) then
            return value
        end
    end
    if type(o.toString) == "function" then
        local value = o:toString()
        if isPrimitiveValue(value) then
            return value
        end
    end

    throw = throw or require("castl.jssupport").throw
    throw(errorHelper.newTypeError("Cannot convert object to primitive value"))
end

local defaultValueNumber = internal.defaultValueNumber
local defaultValueString = internal.defaultValueString

function internal.ToPrimitiveString(o)
    if isPrimitiveValue(o) then
        return o
    end
    return defaultValueString(o)
end

function internal.ToPrimitiveNumber(o)
    if isPrimitiveValue(o) then
        return o
    end
    return defaultValueNumber(o)
end

local function ToNumber(value, typeV)
    local tvalue = typeV or type(value)
    if tvalue == "number" then
        return value
    elseif tvalue == "string" then
        if gsub(value, " ", "") == "" then return 0 end
        return tonumber(value) or 0/0
    elseif tvalue == "boolean" then
        return value and 1 or 0
    elseif value == null then
        return 0
    elseif value == nil then
        return 0/0
    end

    return ToNumber(defaultValueNumber(value))
end

internal.ToNumber = ToNumber

function internal.ToString(value)
    local tv = type(value)
    if tv == "string" then
        return value
    elseif tv == "number" or tv == "boolean" then
        return tostring(value)
    elseif value == null then
        return "null"
    elseif  value == nil then
        return "undefined"
    end

    return tostring(defaultValueString(value))
end

setmetatable(internal.null,{
    __index = function(self, key)
        throw = throw or require("castl.jssupport").throw
        throw(errorHelper.newTypeError("Cannot read property '" .. key .. "' of null"))
    end,
    __newindex = function(self, key)
        throw = throw or require("castl.jssupport").throw
        throw(errorHelper.newTypeError("Cannot set property '" .. key .. "' of null"))
    end,
    __tostring = function ()
        return 'null'
    end,
    __sub = function(a, b)
        return ToNumber(a) - ToNumber(b)
    end,
    __div = function(a, b)
        return ToNumber(a) / ToNumber(b)
    end,
    __mul = function(a, b)
        return ToNumber(a) * ToNumber(b)
    end,
    __tojson = function () return "null" end
})

-- get/put

-- manually goes along the prototype chain
function internal.get(self, prototype, key)
    local getterName, getter = "_g" .. tostring(key)

    -- self == nil => case of built-in types: boolean, string and number
    -- they are immutable, so we don't have to look for a getter
    if self ~= nil then
        if type(self) == "function" then self = getFunctionProxy(self) end
        getter = rawget(self, getterName)
        if getter then
            return getter(self)
        end
    end

    local current, att = prototype
    while current do
        if type(current) == "function" then current = getFunctionProxy(current) end
        -- try to get attribute
        att = rawget(current, key)
        if att ~= nil then
            return att
        end
        --try to get getter
        getter = rawget(current, getterName)
        if getter ~= nil then
            -- call getter with the good this (self, and not current)
            return getter(self)
        end
        current = (getmetatable(current) or {})._prototype
    end

    return nil
end

function internal.put(self, key, value)
    if key == nil then return end
    -- try to find a setter in
    local setterName, current, setter = "_s" .. tostring(key), self
    while current do
        if type(current) == "function" then current = getFunctionProxy(current) end
        setter = rawget(current, setterName)
        if setter ~= nil then
            -- call setter with the good this (self, and not current)
            setter(self, value)
            return;
        end
        current = (getmetatable(current) or {})._prototype
    end

    rawset(self, key, value)
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

-- http://www.ecma-international.org/ecma-262/5.1/#sec-9.9
function internal.ToObject(v)
    if v == nil or v == null then
        throw = throw or require("castl.jssupport").throw
        throw(errorHelper.newTypeError("Cannot convert undefined or null to object"))
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

-- create a metatable for a new object (used in new statement and Object.create)
function internal.setNewMetatable(o, prototype)
    local mt = {
        __index = function (self, key)
            return get(self, prototype, key)
        end,
        __newindex = put,
        __sub = function(a, b)
            return ToNumber(a) - ToNumber(b)
        end,
        __mul = function(a, b)
            return ToNumber(a) * ToNumber(b)
        end,
        __div = function(a, b)
            return ToNumber(a) / ToNumber(b)
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

function internal.ToInteger(v)
    local number = ToNumber(v)
    return number < 0 and ceil(number) or floor(number)
end

function internal.ToUint32(v)
    local number = ToNumber(v)
    return number < 0 and ceil(number) % 0x100000000 or floor(number) % 0x100000000
end

function internal.ToUint16(v)
    local number = ToNumber(v)
    return number < 0 and ceil(number) % 0x10000 or floor(number) % 0x10000
end

return internal
