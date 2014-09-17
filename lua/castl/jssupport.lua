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
local huge, abs = math.huge, math.abs

-- Prevent modification of global environment
_ENV = nil

jssupport.void = function() end
jssupport.e = function(...) return ... end
jssupport.Infinity = huge

-- Define custom break and continue (cf try statement inside a loop)
jssupport._break = {}
jssupport._continue = {}

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

return jssupport
