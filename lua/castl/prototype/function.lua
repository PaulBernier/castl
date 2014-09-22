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

-- [[ CASTL Function prototype submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/prototype

return function(functionPrototype)
    local pack = table.pack or function(...) return {n = select('#',...),...} end
    local unpack = table.unpack or unpack

    _ENV = nil

    functionPrototype.call = function(this, thisArg, ...)
        return this(thisArg, ...)
    end

    functionPrototype.bind = function(this, thisArg, ...)
        local argsToPrepend = pack(...)

        return function(_, ...)
            local argset, j = {}, 1
            local argsToAppend = pack(...)

            for i = 1, argsToPrepend.n do
                argset[j] = argsToPrepend[i]
                j = j + 1
            end

            for i = 1, argsToAppend.n do
                argset[j] = argsToAppend[i]
                j = j + 1
            end

            return this(thisArg, unpack(argset, 1, argsToPrepend.n + argsToAppend.n))
        end
    end

    functionPrototype.apply = function(this, thisArg, argsArray)
        local args, length = {}, 0

        if argsArray ~= nil then
            length = argsArray.length
            for i = 0, length - 1 do
                args[i+1] = argsArray[i]
            end
        end

        return this(thisArg, unpack(args, 1, length))
    end

    functionPrototype.toString = function(this)
        return "function (){}"
    end

end
