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

local bit = {}

local bit32 = bit32

_ENV = nil

local ToUint32 = function(n)
    return n % 2^32
end

-- read bit
local function rb(n, i)
    return bit32.rshift(bit32.band(n, bit32.lshift(1,i)),i)
end

-- set bit to 1
local function sb(n, i)
    return bit32.bor(n, bit32.lshift(1,i))
end

bit.lshift = function(x, disp)
    local shiftCount = bit32.band(ToUint32(disp), 0x1F)
    local ret = bit32.lshift(x, shiftCount);

    -- Ones' complement
    if rb(ret, 31) == 1 then
        ret = -(bit32.bnot(ret) + 1)
    end

    return ret
end

bit.rshift = function(x, disp)
    local shiftCount = bit32.band(ToUint32(disp), 0x1F)
    return bit32.rshift(x, shiftCount)
end

bit.arshift = function(x, disp)
    local shiftCount = bit32.band(ToUint32(disp), 0x1F)
    local ret = bit32.rshift(x, shiftCount)

    if x < 0 then
        for i = 31, 31 - shiftCount, -1 do
            ret = sb(ret, i)
        end
        -- Ones' complement
        ret = -(bit32.bnot(ret) + 1)
    end

    return ret
end

bit.band = bit32.band
bit.bor = bit32.bor
bit.bxor = bit32.bxor
bit.bnot = bit32.bnot

return bit
