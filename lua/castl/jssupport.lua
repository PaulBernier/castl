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

-- [[ CASTL JS Support submodule]] --

local jssupport = {}

local internal = require("castl.internal")

-- Dependencies
local null, toPrimitive, toNumber = internal.null, internal.toPrimitive, internal.toNumber
local type, tonumber, tostring, pairs, setmetatable = type, tonumber, tostring, pairs, setmetatable
local huge, floor, abs = math.huge, math.floor, math.abs
local gsub, sub, match, format, sbyte, find, char = string.gsub, string.sub, string.match, string.format, string.byte, string.find, string.char

-- Prevent modification of global environment
_ENV = nil

jssupport.void = function() end
jssupport.e = function(...) return ... end
jssupport.Infinity = huge

function jssupport.isNaN(this, n)
    local tn = type(n)
    if tn == "number" then
        return n ~= n
    elseif n == nil then
        return true
    elseif n == null then
        return false
    elseif tn == "table" or tn == "function" then
        return true
    elseif tn == "string" then
        -- trim to compare with ""
        local s = match(n, '^()%s*$') and '' or match(n, '^%s*(.*%S)')
        if s == "" then return false end
        -- Warning!: tonumber() expects decimal numbers with the country-specific decimal separator instead of always the dot separator
        s = tonumber(s)
        -- LuaJIT return nan when tonumber fails
        local castfailed = s == nil or s ~= s
        if castfailed then return true else return false end
    end

    return false
end

function jssupport.isFinite(this, arg)
    arg = tonumber(arg)
    return type(arg) == 'number' and arg ~= huge and arg ~= -huge and not (arg ~= arg)
end

function jssupport.parseFloat(this, str)
    local v = tonumber(tostring(str))
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

function jssupport.parseInt(this, str, radix)
    radix = radix or 10
    local sign = 1

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

    if type(str) ~= "number" then
        str = tostring(str)

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

-- http://www.ecma-international.org/ecma-262/5.1/#sec-11.9.3
function jssupport.equal(x, y)
    x = toPrimitive(x)
    y = toPrimitive(y)
    local tx, ty = type(x), type(y)

    -- case 1
    if tx == ty then
        -- a
        if tx == nil then return true end
        -- b
        if x == null then return true end
        -- c
        if tx == "number" then
            -- testNaN
            if x ~= x or y ~= y then return false end
            if x == y then return true end
            return false
        end
        -- d
        if tx == "string" then return x == y end
        -- e
        if tx == "boolean" then return x == y end
        -- f
        return x == y
    end
    -- case 2
    if x == null and ty == "nil" then return true end
    -- case 3
    if tx == "nil" and y == null then return true end
    -- case 4
    if tx == "number" and ty == "string" then
        return jssupport.equal(x, tonumber(y))
    end
    -- case 5
    if tx == "string" and ty == "number" then
        return jssupport.equal(tonumber(x), y)
    end
    -- case 6
    if tx == "boolean" then return jssupport.equal(x and 1 or 0, y) end
    -- case 7
    if ty == "boolean" then return jssupport.equal(x, y and 1 or 0) end
    -- case 8 - 9
    -- TODO ? (comparison with objects)
    -- case 10
    return false
end

-- Avoid Lua coercion
function jssupport.add(x , y)
    local x, y = toPrimitive(x), toPrimitive(y)
    if type(x) == "string" or type(y) == "string" then
        return tostring(x) .. tostring(y)
    else
        return toNumber(x) + toNumber(y)
    end
end

-- 0, NaN and "" are true in Lua and false in JS
function jssupport.boolean(var)
    if var == 0 or var == "" or var == null or var ~= var then
        return false
    else
        return var
    end
end

function jssupport.modulo(a, b)
    local sign = a > 0 and 1 or -1
    return sign * (abs(toNumber(a)) % abs(toNumber(b)))
end

function jssupport.typeof(var)
    if var == nil then
        return "undefined"
    end
    local tvar = type(var)
    if tvar == 'table' then
        return "object"
    end
    return tvar
end

function jssupport.inOp (object, key)
    return object[key] ~= nil
end

function jssupport.with(obj, env)
    local copy = {}
    for i,j in pairs(obj) do
        copy[i] = j
    end

    -- return new environment
    return setmetatable(copy, {__index = env})
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

jssupport.encodeURI = function (this, uri)
    uri = tostring(uri)
    return encode(uri, patternEncodeURI)
end

jssupport.encodeURIComponent = function (this, uri)
    uri = tostring(uri)
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

jssupport.decodeURI = function (this, uri)
    uri = tostring(uri)
    return decode(uri, reservedURISet)
end

jssupport.decodeURIComponent = function (this, uri)
    uri = tostring(uri)
    return decode(uri, "")
end

-- Define custom break and continue (cf try statement inside a loop)
jssupport._break = {}
jssupport._continue = {}

return jssupport
