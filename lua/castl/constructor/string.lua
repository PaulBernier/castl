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

-- [[ CASTL String constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String

local String

local stringProto = require("castl.protos").stringProto
local bit = require("castl.modules.bit")
local coreObjects = require("castl.core_objects")
local internal = require("castl.internal")

local bor, band, arshift = bit.bor, bit.band, bit.arshift
local pack = table.pack or function(...) return {n = select('#',...),...} end
local unpack, tinsert, concat, stochar =  table.unpack or unpack, table.insert, table.concat, string.char
local setmetatable = setmetatable
local ToString, withinNew, get, put, ToNumber, ToUint16 = internal.ToString, internal.withinNew, internal.get, internal.put, internal.ToNumber, internal.ToUint16

_ENV = nil

String = function(this, ...)
    local arg = pack(...).n > 0 and ToString(...) or "";

    -- String constructor not called within a new
    if not withinNew(this, stringProto) then
        return arg
    end

    local o = {length = arg.length}

    for i = 0, arg.length - 1 do
        o[i] = arg[i]
    end

    setmetatable(o, {
        __index = function (self, key)
            return get(self, stringProto, key)
        end,
        __newindex = put,
        __tostring = function(self)
            return coreObjects.objectToString(self)
        end,
        _primitive = arg,
        __sub = function(a, b)
            return ToNumber(a) - ToNumber(b)
        end,
        __mul = function(a, b)
            return ToNumber(a) * ToNumber(b)
        end,
        __div = function(a, b)
            return ToNumber(a) / ToNumber(b)
        end,
        _prototype = stringProto
    })

    return o
end

local toUTF8Array = function (charcode)
    local utf8 = {}

    if charcode < 128 then
        tinsert(utf8, charcode)
    elseif charcode < 2048 then
        tinsert(utf8, bor(192, arshift(charcode, 6)))
        tinsert(utf8, bor(128, band(charcode, 63)))
    elseif (charcode < 55296) or (charcode >= 57344) then
        tinsert(utf8, bor(224, arshift(charcode, 12)))
        tinsert(utf8, bor(128, band(arshift(charcode, 6), 63)))
        tinsert(utf8, bor(128, band(charcode, 63)))
    end

    return utf8
end

String.fromCharCode = function(this, ...)
    local args = pack(...)
    local str = {}
    for i = 1, args.n do
        local charCode = ToUint16(args[i]);
        local char = stochar(unpack(toUTF8Array(charCode)))

        tinsert(str, char)
    end

    return concat(str)
end

String.prototype = stringProto
stringProto.constructor = String

return String
