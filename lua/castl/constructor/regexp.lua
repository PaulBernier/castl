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

local regexpProto = require("castl.prototype.regexp")
local internal = require("castl.internal")
local common = require("castl.modules.common")
local jssupport = require("castl.jssupport")

local find = string.find
local setmetatable = setmetatable

_ENV = nil

RegExp = function(this, pattern, flags)
    flags = flags or ""

    local o = {}

    o.source = internal.defaultValue(pattern)
    o.global = find(flags, "g") and true
    o.ignoreCase = find(flags, "i") and true
    o.multiline = find(flags, "m") and true

    setmetatable(o, {
        __index = function (self, key)
            return common.prototype_index(regexpProto, key)
        end,
        __tostring = regexpProto.toString,
        __tonumber = function() return jssupport.NaN end,
        _prototype = regexpProto
    })

    return o

end

RegExp.prototype = regexpProto
regexpProto.constructor = RegExp

return RegExp
