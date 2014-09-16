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

-- [[ CASTL RegExp constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp

local RegExp

local regexpProto = require("castl.protos").regexpProto
local internal = require("castl.internal")

local find = string.find
local setmetatable = setmetatable
local defaultValueString, get, put, defaultValueNumber = internal.defaultValueString, internal.get, internal.put, internal.defaultValueNumber

_ENV = nil

RegExp = function(this, pattern, flags)
    flags = flags or ""

    local o = {}

    o.source = defaultValueString(pattern)
    o.global = find(flags, "g") and true
    o.ignoreCase = find(flags, "i") and true
    o.multiline = find(flags, "m") and true

    setmetatable(o, {
        __index = function (self, key)
            return get(self, regexpProto, key)
        end,
        __newindex = function (self, key, value)
            return put(self, key, value)
        end,
        __tostring = regexpProto.toString,
        __tonumber = function() return 0/0 end,
        __lt = function(a, b)
            return defaultValueNumber(a) < defaultValueNumber(b)
        end,
        __le = function(a, b)
            return defaultValueNumber(a) <= defaultValueNumber(b)
        end,
        _prototype = regexpProto
    })

    return o

end

RegExp.prototype = regexpProto
regexpProto.constructor = RegExp

return RegExp
