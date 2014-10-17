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

return function(numberPrototype)
    local errorHelper = require("castl.modules.error_helper")
    local throw = require("castl.jssupport").throw

    local tonumber, tostring, floor, concat, insert = tonumber, tostring, math.floor, table.concat, table.insert
    local strsub, strlen, gsub, format, getmetatable, type = string.sub, string.len, string.gsub, string.format, getmetatable, type

    _ENV = nil

    numberPrototype.valueOf = function (this)
        if type(this) == "number" then
            return this
        else
            return getmetatable(this)._primitive
        end
    end

    local valueof = numberPrototype.valueOf

    numberPrototype.toString = function(this, radix)
        local value = valueof(this)

        if not radix or radix == 10 then
            return tostring(value)
        end

        -- TODO: do not handle floating point numbers
        -- http://stackoverflow.com/a/3554821
        local n = floor(value)
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

    numberPrototype.toLocaleString = numberPrototype.toString

    numberPrototype.toFixed = function(this, digits)
        local value = valueof(this)
        digits = digits or 0
        return format("%." .. tonumber(digits) .. "f", value)
    end

    numberPrototype.toExponential = function(this, fractionDigits)
        local value = valueof(this)
        if fractionDigits == nil then
            fractionDigits = strlen(tostring(value)) - 1
            if floor(value) ~= value then
                fractionDigits = fractionDigits - 1
            end
        end
        if fractionDigits < 0 or fractionDigits > 20 then
            throw(errorHelper.newRangeError("toExponential() argument must be between 0 and 20"))
        end
        local formatted = format("%." .. fractionDigits .. "e", value)
        return (gsub(formatted, "%+0", "+"))
    end

    numberPrototype.toPrecision = function(this, precision)
        local value = valueof(this)
        if precision == nil then return tostring(value) end
        if precision < 1 or precision > 21 then
            throw(errorHelper.newRangeError("toPrecision() argument must be between 1 and 21"))
        end
        local formatted = format("%." .. precision .. "g", value)
        return (gsub(formatted, "%+0", "+"))
    end

end
