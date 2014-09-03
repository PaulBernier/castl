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

local stringProto = require("castl.prototype.string")
local bit = require("castl.modules.bit")

local tostring, type, tonumber = tostring, type, tonumber
local pack, unpack, tinsert, concat, stochar =  table.pack, table.unpack, table.insert, table.concat, string.char

_ENV = nil

String = function(this, arg)
    if type(arg) == 'table' and type(arg.toString) == 'function' then
        return arg:toString()
    end
    return tostring(arg)
end

local toUTF8Array = function (charcode)
    local utf8 = {}

    if charcode < 128 then
        tinsert(utf8, charcode);
    elseif charcode < 2048 then
        tinsert(utf8, bit.bor(192, bit.arshift(charcode, 6)))
        tinsert(utf8, bit.bor(128, bit.band(charcode, 63)));
    elseif (charcode < 55296) or (charcode >= 57344) then
        tinsert(utf8, bit.bor(224, bit.arshift(charcode, 12)))
        tinsert(utf8, bit.bor(128, bit.band(bit.arshift(charcode, 6), 63)))
        tinsert(utf8, bit.bor(128, bit.band(charcode, 63)));
    end

    return utf8
end

String.fromCharCode = function(this, ...)
    local args = pack(...)
    local str = {}
    for i = 1, args.n do
        local charCode = tonumber(args[i]);
        local char = stochar(unpack(toUTF8Array(charCode)))

        tinsert(str, char)
    end

    return concat(str)
end



String.prototype = stringProto
stringProto.constructor = String

return String
