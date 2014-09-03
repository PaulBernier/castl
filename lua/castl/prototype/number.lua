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

-- [[ CASTL Number prototype submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/prototype

local numberPrototype = {}

local tonumber, format, tostring, floor, concat, insert = tonumber, string.format, tostring, math.floor, table.concat, table.insert
local strsub = string.sub
_ENV = nil

numberPrototype.toString = function(this, radix)
    if not radix then
        return tostring(this)
    end

    -- TODO: do not handle floating point numbers
    -- http://stackoverflow.com/a/3554821
    local n = floor(this)
    if not radix or radix == 10 then return tostring(n) end
    local digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local t = {}
    local sign = ""
    if n < 0 then
        sign = "-"
        n = -n
    end
    repeat
        local d = (n % radix) + 1
        n = floor(n / radix)
        insert(t, 1, strsub(digits, d, d))
    until n == 0
    
    return sign .. concat(t, "")
end

numberPrototype.toFixed = function(this, digits)
    digits = digits or 0
    return format("%." .. tonumber(digits) .. "f", this)
end

return numberPrototype
