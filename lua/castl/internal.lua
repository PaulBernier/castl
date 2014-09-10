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

local Boolean, Number, String, new, objectToString, jssupport

local getmetatable, setmetatable, type, tostring, tonumber, error, require, rawget, rawset = getmetatable, setmetatable, type, tostring, tonumber, error, require, rawget, rawset

_ENV = nil

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

-- prototype
function internal.prototype(o)
    local mt = getmetatable(o)
    if mt then
        return mt._prototype
    end
    return nil
end

-- test if constructor called within a new
internal.withinNew = function(this, proto)
    local mt = getmetatable(this)
    return mt and mt._prototype == proto
end

-- create a metatable for a new object (used in new statement and Object.create)
function internal.setNewMetatable(o, prototype)
    local mt = {
        __index = function (self, key)
            return internal.get(self, prototype, key)
        end,
        __newindex = function (self, key, value)
            internal.put(self, key, value)
        end,
        __tonumber = function(self)
            jssupport = jssupport or require("castl.jssupport")
            return tonumber(internal.toPrimitive(self)) or jssupport.NaN
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

-- ToPrimitive, ToObject, toString, toNumber

function internal.toPrimitive(o)
    local mt = getmetatable(o)

    if mt._primitive then
        return mt._primitive
    end

    return o
end

-- http://www.ecma-international.org/ecma-262/5.1/#sec-9.9
function internal.toObject(v)
    jssupport = jssupport or require("castl.jssupport")
    if v == nil or v == jssupport.null then
        error("ToObject: undefined or null")
    end

    new = new or require("castl.core_objects").new
    if type(v) == "boolean" then
        Boolean = Boolean or require("castl.constructor.boolean")
        return new(Boolean, v)
    elseif type(v) == "number" then
        Number = Number or require("castl.constructor.number")
        return new(Number, v)
    elseif type(v) == "string" then
        String = String or require("castl.constructor.string")
        return new(String, v)
    end

    return v
end

-- http://www.ecma-international.org/ecma-262/5.1/#sec-8.12.8
function internal.defaultValue(o)
    if type(o) == "table" and type(o.toString) == "function" then
        return o:toString()
    else
        return tostring(o)
    end
end

function internal.toNumber(value)
    local mt = getmetatable(value)
    if (mt or {}).__tonumber then
        return mt.__tonumber(value)
    end

    return tonumber(value)
end

return internal
