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

local Boolean, Number, String, new
local jssupport = require("castl.jssupport")

local getmetatable, type, tostring, tonumber, error, require = getmetatable, type, tostring, tonumber, error, require

_ENV = nil

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
