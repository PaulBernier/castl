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

-- [[ CASTL Number constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number

local Number

local coreObjects = require("castl.core_objects")
local internal = require("castl.internal")
local numberProto = require("castl.protos").numberProto
local jssupport = require("castl.jssupport")

local huge = math.huge
local tonumber, type, getmetatable, setmetatable = tonumber, type, getmetatable, setmetatable
local get, put, withinNew, toNumber, defaultValueNumber = internal.get, internal.put, internal.withinNew, internal.toNumber, internal.defaultValueNumber

_ENV = nil

Number = function(this, arg)
    arg = arg or 0
    -- Number constructor not called within a new
    if not withinNew(this, numberProto) then
        return tonumber(arg) or 0/0
    end

    local o = {}

    setmetatable(o, {
        __index = function (self, key)
            return get(self, numberProto, key)
        end,
        __newindex = function (self, key, value)
            return put(self, key, value)
        end,
        __tostring = function(self)
            return coreObjects.objectToString(self)
        end,
        __tonumber = function(self)
            local mt = getmetatable(self)
            return mt._primitive
        end,
        _primitive = tonumber(arg),
        __sub = function(a, b)
            return toNumber(a) - toNumber(b)
        end,
        __mul = function(a, b)
            return toNumber(a) * toNumber(b)
        end,
        __div = function(a, b)
            return toNumber(a) / toNumber(b)
        end,
        __lt = function(a, b)
            return defaultValueNumber(a) < defaultValueNumber(b)
        end,
        __le = function(a, b)
            return defaultValueNumber(a) <= defaultValueNumber(b)
        end,
        _prototype = numberProto
    })

    return o
end

Number.isFinite = function(this, arg)
    if type(arg) == 'number' then
        return arg ~= huge and arg ~= -huge and not (arg ~= arg)
    end

    return false
end

Number.isNaN = function (this, arg)
    if type(arg) == 'number' then
        return (arg ~= arg)
    end

    return false
end

Number.parseInt = function (this, str, radix)
    return jssupport.parseInt(this, str, radix)
end

Number.parseFloat = function (this, str)
    return jssupport.parseFloat(this, str)
end

-- Static properties
Number.NaN = 0/0
Number.MAX_VALUE = 1.7976931348623157e+308
Number.MIN_VALUE = 5e-324
Number.NEGATIVE_INFINITY = -jssupport.Infinity
Number.POSITIVE_INFINITY = jssupport.Infinity

Number.prototype = numberProto
numberProto.constructor = Number

return Number
