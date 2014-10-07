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

-- [[ CASTL Array constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array

local Array

local arrayProto = require("castl.protos").arrayProto
local coreObjects = require("castl.core_objects")

local getmetatable, type = getmetatable, type
local pack = table.pack or function(...) return {n = select('#',...),...} end

_ENV = nil

Array = function (this, ...)
    local args = pack(...)
    local newArray = {}

    if args.n == 1 and type(args[1]) == "number" then
        newArray.length = args[1]
    else
        newArray.length = args.n
        for i = 0, args.n do
            newArray[i] = args[i + 1]
        end
    end

    return coreObjects.array(newArray, newArray.length)
end

Array.length = 1

Array.isArray = function (this, arr)
    return (getmetatable(arr) or {})._prototype == arrayProto
end

Array.prototype = arrayProto
arrayProto.constructor = Array

return Array
