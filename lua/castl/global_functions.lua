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

local globalFunctions = {}

local internal = require("castl.internal")

-- Dependencies
local null, ToNumber, ToString = internal.null, internal.ToNumber, internal.ToString
local type, tonumber = type, tonumber
local huge, floor, abs, ceil = math.huge, math.floor, math.abs, math.ceil
local gsub, sub, match, format, sbyte, find, char = string.gsub, string.sub, string.match, string.format, string.byte, string.find, string.char

_ENV = nil

function globalFunctions.isNaN(this, n)
    local tonum = ToNumber(n)
    return tonum ~= tonum
end

function globalFunctions.isFinite(this, arg)
    arg = ToNumber(arg)
    return arg ~= huge and arg ~= -huge and not (arg ~= arg)
end

function globalFunctions.parseFloat(this, str)
    local v = tonumber(ToString(str))
    if v == nil then
        return 0/0
    else
        return v
    end
end

-- http://www.ecma-international.org/ecma-262/5.1/#sec-15.1.2.2
local radixDigit = {
    [2] = "[^01]",
    [3] = "[^012]",
    [4] = "[^0123]",
    [5] = "[^01234]",
    [6] = "[^012345]",
    [7] = "[^0123456]",
    [8] = "[^01234567]",
    [9] = "[^012345678]",
    [10] = "[^0123456789]",
    [11] = "[^0123456789aA]",
    [12] = "[^0123456789aAbB]",
    [13] = "[^0123456789aAbBcC]",
    [14] = "[^0123456789aAbBcCdD]",
    [15] = "[^0123456789aAbBcCdDeE]",
    [16] = "[^0123456789aAbBcCdDeEfF]",
    [17] = "[^0123456789aAbBcCdDeEfFgG]",
    [18] = "[^0123456789aAbBcCdDeEfFgGhH]",
    [19] = "[^0123456789aAbBcCdDeEfFgGhHiI]",
    [20] = "[^0123456789aAbBcCdDeEfFgGhHiIjJ]",
    [21] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkK]",
    [22] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlL]",
    [23] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmM]",
    [24] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnN]",
    [25] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoO]",
    [26] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpP]",
    [27] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQ]",
    [28] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrR]",
    [29] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsS]",
    [30] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStT]",
    [31] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuU]",
    [32] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvV]",
    [33] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwW]",
    [34] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxX]",
    [35] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyY]",
    [36] = "[^0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ]"
}

function globalFunctions.parseInt(this, str, radix)
    radix = radix or 10
    local tstr = type(str)

    -- shortcut: parseInt used as a cast to int
    if tstr == "number" and radix == 10 then
        return str < 0 and ceil(str) or floor(str)
    end

    -- radix check
    radix = tonumber(radix)
    if radix ~= 0 then
        -- radix bounds
        if radix < 2 or radix > 36 then
            return 0/0
        end
    else
        -- if radix == 0 then radix is treated as 10
        radix = 10
    end

    local sign = 1
    if tstr ~= "number" then
        str = ToString(str)

        -- trim
        str = match(str,'^()%s*$') and '' or match(str,'^%s*(.*%S)')

        if str ~= "" then
            if sub(str, 1, 1) == "-" then
                sign = -1
            end
            str = gsub(str, "^[%+%-]", "")
        end

        if radix == 16 then
            -- strip hexa prefix 0x if it exists
            str = gsub(str, "^0[xX]", "")
        end

        -- If str contains any character that is not a radix digit,
        -- then str becomes the substring of str consisting of all characters before the first such character
        local firstUnallowedCharOffset = (find(str, radixDigit[radix]))
        if firstUnallowedCharOffset then
            str = sub(str, 1, firstUnallowedCharOffset - 1)
        end
    else
        -- str is a number
        sign = (str > 0) and 1 or -1
        str = floor(abs(str))
    end

    local v = tonumber(str, radix)
    if v then
        return sign * v
    end

    return 0/0
end

-- URI
-- http://www.ecma-international.org/ecma-262/5.1/#sec-15.1.3

local uriReserved = ";/%?:@&=%+%$,"
local uriMark = "%-_%.!~*'%(%)"
local uriUnescaped = "%a%d" .. uriMark
local score = "#"

-- Encoding

local patternEncodeURI = "[^" .. uriReserved .. uriUnescaped .. score  .. "]"
local patternEncodeURIComponent = "[^" .. uriUnescaped .. "]"

local encode = function(str, unescapedSet)
    return (gsub(str, unescapedSet,
        function(c)
            return format("%%%02X", sbyte(c))
        end
    ))
end

globalFunctions.encodeURI = function (this, uri)
    uri = ToString(uri)
    return encode(uri, patternEncodeURI)
end

globalFunctions.encodeURIComponent = function (this, uri)
    uri = ToString(uri)
    return encode(uri, patternEncodeURIComponent)
end

-- Decoding

local decode = function(str, reservedSet)
    return (gsub(str, "%%(%x%x)",
        function(h)
            local char = char(tonumber(h, 16))
            if find(reservedSet, char, 1, true) then
                return "%" .. h
            end
            return char
        end
    ))
end

local reservedURISet = ";/?:@&=+$,#"

globalFunctions.decodeURI = function (this, uri)
    uri = ToString(uri)
    return decode(uri, reservedURISet)
end

globalFunctions.decodeURIComponent = function (this, uri)
    uri = ToString(uri)
    return decode(uri, "")
end

return globalFunctions
