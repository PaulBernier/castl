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

-- [[ CASTL Boolean constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean


local objectToString = require("castl.core_objects").objectToString
local booleanProto = require("castl.protos").booleanProto
local internal = require("castl.internal")

local Boolean

local setmetatable = setmetatable
local null, get, put, withinNew, ToNumber = internal.null, internal.get, internal.put, internal.withinNew, internal.ToNumber

_ENV = nil

local booleanPrimitive = function(var)
    if var == 0 or var == "" or var == null or var ~= var then
        return false
    elseif var then
        return true
    else
        return false
    end
end

Boolean = function(this, arg)
    -- Boolean constructor not called within a new
    if not withinNew(this, booleanProto) then
        return booleanPrimitive(arg)
    end

    local o = {}

    setmetatable(o, {
        __index = function (self, key)
            return get(self, booleanProto, key)
        end,
        __newindex = put,
        __tostring = function(self)
            return objectToString(self)
        end,
        _primitive = booleanPrimitive(arg),
        __sub = function(a, b)
            return ToNumber(a) - ToNumber(b)
        end,
        __mul = function(a, b)
            return ToNumber(a) * ToNumber(b)
        end,
        __div = function(a, b)
            return ToNumber(a) / ToNumber(b)
        end,
        _prototype = booleanProto
    })

    return o
end

Boolean.prototype = booleanProto
booleanProto.constructor = Boolean

return Boolean
