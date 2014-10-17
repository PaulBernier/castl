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
local errorHelper = require("castl.modules.error_helper")
local throw = require("castl.jssupport").throw

local find = string.find
local setmetatable, getmetatable = setmetatable, getmetatable
local ToString, get, put, withinNew, ToNumber = internal.ToString, internal.get, internal.put, internal.withinNew, internal.ToNumber

_ENV = nil

RegExp = function(this, pattern, flags)
    local patternIsRegexp = (getmetatable(pattern) or {})._prototype == regexpProto

    if patternIsRegexp and flags ~= nil then
        throw(errorHelper.newTypeError("Cannot supply flags when constructing one RegExp from another"))
    end

    if not withinNew(this, regexpProto) and patternIsRegexp then
        return pattern
    end

    flags = flags or ""

    local o = {}

    if patternIsRegexp then
        o.source = ToString(pattern.source)
        o.global = pattern.global
        o.ignoreCase = pattern.ignoreCase
        o.multiline = pattern.multiline
    else
        o.source = ToString(pattern)
        o.global = find(flags, "g") and true
        o.ignoreCase = find(flags, "i") and true
        o.multiline = find(flags, "m") and true
    end

    setmetatable(o, {
        __index = function (self, key)
            return get(self, regexpProto, key)
        end,
        __newindex = put,
        __tostring = regexpProto.toString,
        __sub = function(a, b)
            return ToNumber(a) - ToNumber(b)
        end,
        __mul = function(a, b)
            return ToNumber(a) * ToNumber(b)
        end,
        __div = function(a, b)
            return ToNumber(a) / ToNumber(b)
        end,
        _prototype = regexpProto
    })

    return o

end

RegExp.prototype = regexpProto
regexpProto.constructor = RegExp

return RegExp
