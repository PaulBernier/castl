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


local coreObjects = require("castl.core_objects")
local internal = require("castl.internal")
local jssupport = require("castl.jssupport")
local booleanProto = require("castl.prototype.boolean")

local Boolean

local setmetatable, getmetatable = setmetatable, getmetatable

_ENV = nil

Boolean = function(this, arg)
    -- Boolean constructor not called within a new
    if not internal.withinNew(this, booleanProto) then
        return jssupport.boolean(arg)
    end

    local o = {}

    setmetatable(o, {
        __index = function (self, key)
            return internal.get(self, booleanProto, key)
        end,
        __newindex = function (self, key, value)
            return internal.put(self, key, value)
        end,
        __tostring = function(self)
            return coreObjects.objectToString(self)
        end,
        __tonumber = function(self)
            local mt = getmetatable(self)
            return mt._primitive and 1 or 0
        end,
        _primitive = jssupport.boolean(arg),
        _prototype = booleanProto
    })

    return o
end

Boolean.prototype = booleanProto
booleanProto.constructor = Boolean

return Boolean
