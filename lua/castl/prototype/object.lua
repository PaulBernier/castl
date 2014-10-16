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

-- [[ CASTL Object prototype submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/prototype

return function(objectPrototype)
    local internal = require("castl.internal")
    local protos = require("castl.protos")
    local arrayProto = protos.arrayProto
    local regexpProto = protos.regexpProto
    local dateProto = protos.dateProto

    local type, rawget = type, rawget
    local getmetatable = getmetatable
    local null, getPrototype, getFunctionProxy = internal.null, internal.prototype, internal.getFunctionProxy

    _ENV = nil

    objectPrototype.toString = function (this)
        local mt = getmetatable(this)
        local tthis = type(this)
        if this == nil then
            return "[object Undefined]"
        elseif this == null then
            return "[object Null]"
        elseif tthis == "string" then
            return "[object String]"
        elseif tthis == "number" then
            return "[object Number]"
        elseif tthis == "boolean" then
            return "[object Boolean]"
        elseif mt and mt._prototype == arrayProto then
            return "[object Array]"
        elseif mt and mt._prototype == regexpProto then
            return "[object RegExp]"
        elseif mt and mt._prototype == dateProto then
            return "[object Date]"
        elseif mt and mt._arguments then
            return "[object Arguments]"
        elseif tthis == "function" then
            return "[object Function]"
        end

        return '[object Object]'
    end

    objectPrototype.toLocaleString = objectPrototype.toString

    objectPrototype.valueOf = function (this)
        return this
    end

    objectPrototype.hasOwnProperty = function (this, p)
        local tthis = type(this)
        if tthis == "string" then
            return p == "length"
        end
        if tthis == "number" then
            return false
        end
        if tthis == "boolean" then
            return false
        end
        if tthis == "function" then
            this = getFunctionProxy(this)
        end

        return rawget(this, p) ~= nil
    end

    objectPrototype.isPrototypeOf = function(this, object)
        if this ~= nil then
            local classPrototypeAttribute = this
            local objProto = getPrototype(object)

            while objProto do
                if objProto == classPrototypeAttribute then
                    return true
                end
                objProto = getPrototype(objProto)
            end
        end
        return false
    end

    -- TODO: enumerability
    objectPrototype.propertyIsEnumerable = function(this, prop)
        return this[prop] ~= nil
    end

end
