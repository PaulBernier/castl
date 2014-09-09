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

local bitbaselib
local luajit = jit ~= nil

-- if executed by LuaJIT use its bit library as base
if luajit then
    bitbaselib = bit
else
    -- else use bit32 lib of Lua 5.2
    bitbaselib = bit32
end

local bit = {}

local toNumber = require("castl.internal").toNumber

_ENV = nil

local ToUint32 = function(n)
    return n % 2^32
end

-- read bit
local function rb(n, i)
    return bitbaselib.rshift(bitbaselib.band(n, bitbaselib.lshift(1,i)),i)
end

-- set bit to 1
local function sb(n, i)
    return bitbaselib.bor(n, bitbaselib.lshift(1,i))
end

bit.lshift = function(x, disp)
    x, disp = toNumber(x), toNumber(disp)
    local shiftCount = bitbaselib.band(ToUint32(disp), 0x1F)
    local ret = bitbaselib.lshift(x, shiftCount);

    -- Ones' complement
    if rb(ret, 31) == 1 then
        ret = -(bitbaselib.bnot(ret) + 1)
    end

    return ret
end

bit.rshift = function(x, disp)
    x, disp = toNumber(x), toNumber(disp)
    if luajit and disp == 0 then
        return ToUint32(x)
    end

    local shiftCount = bitbaselib.band(ToUint32(disp), 0x1F)
    return bitbaselib.rshift(x, shiftCount)
end

bit.arshift = function(x, disp)
    x, disp = toNumber(x), toNumber(disp)
    local shiftCount = bitbaselib.band(ToUint32(disp), 0x1F)
    local ret = bitbaselib.rshift(x, shiftCount)

    if x < 0 then
        for i = 31, 31 - shiftCount, -1 do
            ret = sb(ret, i)
        end
        -- Ones' complement
        ret = -(bitbaselib.bnot(ret) + 1)
    end

    return ret
end

bit.band = function(x, y)
    return bitbaselib.band(toNumber(x), toNumber(y))
end

bit.bor = function(x, y)
    return bitbaselib.bor(toNumber(x), toNumber(y))
end

bit.bxor = function(x, y)
    return bitbaselib.bxor(toNumber(x), toNumber(y))
end

bit.bnot = function(x)
    return bitbaselib.bnot(toNumber(x))
end

return bit
