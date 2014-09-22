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
local luajit = jit ~= nil

-- Dependencies
local null, ToPrimitiveNumber, ToNumber = internal.null, internal.ToPrimitiveNumber, internal.ToNumber
local type, tonumber, tostring, pairs, setmetatable = type, tonumber, tostring, pairs, setmetatable
local huge, abs = math.huge, math.abs
local pcall = pcall

-- Prevent modification of global environment
_ENV = nil

jssupport.void = function() end
jssupport.e = function(...) return ... end
jssupport.Infinity = huge

-- Define custom break and continue (cf try statement inside a loop)
jssupport._break = {}
jssupport._continue = {}

-- http://www.ecma-international.org/ecma-262/5.1/#sec-11.9.3
local equal
equal = function(x, y)
    local tx, ty = type(x), type(y)

    -- case 1
    if tx == ty then
        return x == y
    end
    -- case 2
    if x == null and ty == "nil" then return true end
    -- case 3
    if tx == "nil" and y == null then return true end
    -- case 4
    if tx == "number" and ty == "string" then
        return equal(x, tonumber(y))
    end
    -- case 5
    if tx == "string" and ty == "number" then
        return equal(tonumber(x), y)
    end
    -- case 6
    if tx == "boolean" then return equal(x and 1 or 0, y) end
    -- case 7
    if ty == "boolean" then return equal(x, y and 1 or 0) end
    -- case 8
    if (tx == "string" or tx == "number") and (ty == "table" and y ~= null) then
        return equal(x, ToPrimitiveNumber(y))
    end
    -- case 9
    if (tx == "table" and x ~= null) and (ty == "string" or ty == "number") then
        return equal(ToPrimitiveNumber(x), y)
    end
    -- case 10
    return false
end

jssupport.equal = equal

-- Avoid Lua coercion
function jssupport.add(x, y)
    x, y = ToPrimitiveNumber(x), ToPrimitiveNumber(y)
    local tx, ty = type(x), type(y)
    if tx == "string" or ty == "string" then
        return tostring(x) .. tostring(y)
    else
        return ToNumber(x, tx) + ToNumber(y, ty)
    end
end

if luajit then
    function jssupport.lt(x, y)
        local px, py = ToPrimitiveNumber(x), ToPrimitiveNumber(y)
        local tpx, tpy = type(px), type(py)
        if tpx == "string" and tpy == "string" then
            return px < py
        end

        return ToNumber(px, tpx) < ToNumber(py, tpy)
    end

    function jssupport.le(x, y)
        local px, py = ToPrimitiveNumber(x), ToPrimitiveNumber(y)
        local tpx, tpy = type(px), type(py)
        if tpx == "string" and tpy == "string" then
            return px <= py
        end

        return ToNumber(px, tpx) <= ToNumber(py, tpy)
    end

    function jssupport.gt(x, y)
        local px, py = ToPrimitiveNumber(x), ToPrimitiveNumber(y)
        local tpx, tpy = type(px), type(py)
        if tpx == "string" and tpy == "string" then
            return px > py
        end

        return ToNumber(px, tpx) > ToNumber(py, tpy)
    end

    function jssupport.ge(x, y)
        local px, py = ToPrimitiveNumber(x), ToPrimitiveNumber(y)
        local tpx, tpy = type(px), type(py)
        if tpx == "string" and tpy == "string" then
            return px >= py
        end

        return ToNumber(px, tpx) >= ToNumber(py, tpy)

    end
else
    function jssupport.lt(x, y)
        local status, value = pcall(function() return x < y end)
        if status then return value
        else
            local px, py = ToPrimitiveNumber(x), ToPrimitiveNumber(y)
            local tpx, tpy = type(px), type(py)
            if tpx == "string" and tpy == "string" then
                return px < py
            end

            return ToNumber(px, tpx) < ToNumber(py, tpy)
        end
    end

    function jssupport.le(x, y)
        local status, value = pcall(function() return x <= y end)
        if status then return value
        else
            local px, py = ToPrimitiveNumber(x), ToPrimitiveNumber(y)
            local tpx, tpy = type(px), type(py)
            if tpx == "string" and tpy == "string" then
                return px <= py
            end

            return ToNumber(px, tpx) <= ToNumber(py, tpy)
        end
    end

    function jssupport.gt(x, y)
        local status, value = pcall(function() return x > y end)
        if status then return value
        else
            local px, py = ToPrimitiveNumber(x), ToPrimitiveNumber(y)
            local tpx, tpy = type(px), type(py)
            if tpx == "string" and tpy == "string" then
                return px > py
            end

            return ToNumber(px, tpx) > ToNumber(py, tpy)
        end
    end

    function jssupport.ge(x, y)
        local status, value = pcall(function() return x >= y end)
        if status then return value
        else
            local px, py = ToPrimitiveNumber(x), ToPrimitiveNumber(y)
            local tpx, tpy = type(px), type(py)
            if tpx == "string" and tpy == "string" then
                return px >= py
            end

            return ToNumber(px, tpx) >= ToNumber(py, tpy)
        end
    end
end

function jssupport.inc(x)
    return ToNumber(x) + 1
end

function jssupport.dec(x)
    return ToNumber(x) - 1
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
    a, b  = ToNumber(a), ToNumber(b)
    local sign = a > 0 and 1 or -1
    return sign * (abs(a) % abs(b))
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

return jssupport
