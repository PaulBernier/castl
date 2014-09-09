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

-- [[ CASTL Object constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object

local Object

local common = require("castl.modules.common")
local jssupport = require("castl.jssupport")
local coreObjects = require("castl.core_objects")
local objectProto = require("castl.prototype.object")
local errorHelper = require("castl.modules.error_helper")

local type, error, pairs, tostring = type, error, pairs, tostring
local setmetatable, getmetatable, rawset, rawget = setmetatable, getmetatable, rawset, rawget
local tinsert = table.insert
_ENV = nil

Object = function (this, obj)
    if obj == nil or obj == jssupport.null then
        return coreObjects.obj({})
    end

    return coreObjects.toObject(obj)
end

Object.create = function (this, prototype, props)
    local o = {}

    if prototype ~= jssupport.null then
        local mt = {}
        -- Inheritance
        mt.__index = function (self, key)
            return common.prototype_index(prototype, key)
        end
        mt._prototype = prototype
        setmetatable(o, mt)
    end

    if props then
        Object:defineProperties(o, props)
    end

    return o
end

Object.defineProperty = function(this, obj, prop, descriptor)
    if type(obj) == 'function' then
        obj = coreObjects.getFunctionProxy(obj)
    end

    if type(obj) ~= 'table' then
        error(errorHelper.newTypeError("Object.defineProperty called on non-object"))
    end
    if type(descriptor) ~= 'table' then
        error(errorHelper.newTypeError("Property description must be an object: " .. tostring(descriptor)))
    end

    if descriptor.value ~= nil then
        rawset(obj, prop, descriptor.value)
    end

    return obj
end

Object.defineProperties = function (this, obj, props)
    if props then
        for k, v in pairs(props) do
            Object:defineProperty(obj, k, v)
        end
    end
    return obj
end

Object.freeze = function (this, obj)
    -- not really frozen...
    return obj
end

Object.keys = function (this, obj)
    local t = type(obj)
    if t == "boolean" or obj == nil or t == "number" or t == "string" then
        error(errorHelper.newTypeError("Object.keys called on non-object"))
    end

    local ret, i = {}, 0

    for key in coreObjects.props(obj) do
        ret[i] = tostring(key)
        i = i + 1
    end

    return coreObjects.array(ret, i)
end

Object.getOwnPropertyDescriptor = function (this, obj, prop)
    local mt = getmetatable(obj)

    if mt then
        return coreObjects.obj({
            value = rawget(obj, prop),
            writable = true,
            configurable = true,
            enumerable = true
        })
    end

    return nil
end

-- Object.getOwnPropertyNames and Object.keys
-- are equivalent as enumerability is not handled for now
Object.getOwnPropertyNames = function (this, obj)
    local ret, i = {}, 0

    for key in coreObjects.props(obj) do
        ret[i] = tostring(key)
        i = i + 1
    end

    return coreObjects.array(ret, i)
end

Object.getPrototypeOf = function (this, obj)
    local mt = getmetatable(obj)
    if mt then
        return mt._prototype
    end

    return nil
end

Object.prototype = objectProto
objectProto.constructor = Object

return Object
