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

-- [[ CASTL Object prototype submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/prototype

local jssupport = require("castl.jssupport")
local arrayProto = require("castl.prototype.array")
local regexpProto = require("castl.prototype.regexp")
local dateProto = require("castl.prototype.date")

local objectPrototype = {}
local _proxy
local type, rawget, require = type, rawget, require
local require, getmetatable = require, getmetatable
_ENV = nil

objectPrototype.toString = function (this)

    local mt = getmetatable(this)

    if this == nil then
        return "[object Undefined]"
    elseif this == jssupport.null then
        return "[object Null]"
    elseif type(this) == "string" then
        return "[object String]"
    elseif type(this) == "number" then
        return "[object Number]"
    elseif type(this) == "boolean" then
        return "[object Boolean]"
    elseif mt and mt._prototype == arrayProto then
        return "[object Array]"
    elseif mt and mt._prototype == regexpProto then
        return "[object RegExp]"
    elseif mt and mt._prototype == dateProto then
        return "[object Date]"
    elseif mt and mt._prototype == "Arguments" then
        return "[object Arguments]"
    elseif type(this) == "function" then
        return "[object Function]"
    end

    return '[object Object]'
end

objectPrototype.valueOf = function (this)
    return this
end

objectPrototype.hasOwnProperty = function (this, p)
    if type(this) == "string" then
        return p == "length"
    end
    if type(this) == "number" then
        return false
    end
    if type(this) == "boolean" then
        return false
    end
    if type(this) == "function" then
        _proxy = _proxy or require("castl.core_objects").getFunctionProxy
        this = _proxy(this)
    end

    return rawget(this, p) ~= nil
end

return objectPrototype
