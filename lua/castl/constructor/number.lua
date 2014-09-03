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

local numberProto = require("castl.prototype.number")
local jssupport = require("castl.jssupport")

local huge = math.huge
local tonumber, type = tonumber, type
_ENV = nil

Number = function(this, arg)
    return tonumber(arg)
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

Number.NaN = 0/0

Number.prototype = numberProto
numberProto.constructor = Number

return Number
