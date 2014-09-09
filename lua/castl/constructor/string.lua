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
local jssupport = require("castl.jssupport")
local common = require("castl.modules.common")
local coreObjects = require("castl.core_objects")
local internal = require("castl.internal")

local tostring, type, tonumber = tostring, type, tonumber
local pack, unpack, tinsert, concat, stochar =  table.pack, table.unpack, table.insert, table.concat, string.char
local setmetatable, getmetatable = setmetatable, getmetatable

_ENV = nil

String = function(this, arg)
    if arg == nil then
        arg = ""
    else
        arg = internal.defaultValue(arg)
    end

    -- String constructor not called within a new
    if not common.withinNew(this, stringProto) then
        return arg
    end

    local o = {}

    for i = 0, arg.length - 1 do
        o[i] = arg[i]
    end

    setmetatable(o, {
        __index = function (self, key)
            return common.prototype_index(stringProto, key)
        end,
        __tostring = function(self)
            return coreObjects.objectToString(self)
        end,
        __tonumber = function(self)
            local mt = getmetatable(self)
            return tonumber(mt._primitive) or jssupport.NaN
        end,
        _primitive = arg,
        _prototype = stringProto
    })

    return o
end

local toUTF8Array = function (charcode)
    local utf8 = {}

    if charcode < 128 then
        tinsert(utf8, charcode)
    elseif charcode < 2048 then
        tinsert(utf8, bit.bor(192, bit.arshift(charcode, 6)))
        tinsert(utf8, bit.bor(128, bit.band(charcode, 63)))
    elseif (charcode < 55296) or (charcode >= 57344) then
        tinsert(utf8, bit.bor(224, bit.arshift(charcode, 12)))
        tinsert(utf8, bit.bor(128, bit.band(bit.arshift(charcode, 6), 63)))
        tinsert(utf8, bit.bor(128, bit.band(charcode, 63)))
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
