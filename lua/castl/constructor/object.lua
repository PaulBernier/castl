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

local coreObjects = require("castl.core_objects")
local internal = require("castl.internal")
local objectProto = require("castl.protos").objectProto
local errorHelper = require("castl.modules.error_helper")

local type, error, pairs, ipairs, tostring = type, error, pairs, ipairs, tostring
local getmetatable, rawset, rawget = getmetatable, rawset, rawget
local null, setNewMetatable, ToObject, ToString = internal.null, internal.setNewMetatable, internal.ToObject, internal.ToString

_ENV = nil

Object = function (this, obj)
    if obj == nil or obj == null then
        return coreObjects.obj({})
    end

    return ToObject(obj)
end

Object.create = function (this, prototype, props)
    local o = {}

    if prototype ~= null then
        setNewMetatable(o, prototype)
    end

    if props ~= nil then
        Object:defineProperties(o, props)
    end

    return o
end

Object.defineProperties = function (this, obj, props)
    if props ~= nil then
        for k, v in pairs(props) do
            Object:defineProperty(obj, k, v)
        end
    end
    return obj
end

Object.defineProperty = function(this, obj, prop, descriptor)
    local tobj = type(obj)

    if tobj == 'function' then
        obj = coreObjects.getFunctionProxy(obj)
    end

    if tobj ~= 'table' then
        error(errorHelper.newTypeError("Object.defineProperty called on non-object"))
    end
    if type(descriptor) ~= 'table' then
        error(errorHelper.newTypeError("Property description must be an object: " .. tostring(descriptor)))
    end
    if descriptor.value ~= nil and (descriptor.get ~= nil or descriptor.set ~= nil) then
        error(errorHelper.newTypeError("Invalid property.  A property cannot both have accessors and be writable or have a value"))
    end

    -- value
    if descriptor.value ~= nil then
        -- TODO: related to weak typing
        if type(prop) ~= "number" then
            prop = ToString(prop)
        end
        rawset(obj, prop, descriptor.value)
        return obj
    end

    prop = ToString(prop)

    -- getter
    if descriptor.get ~= nil then
        rawset(obj, "_g" .. prop, descriptor.get)
    end

    -- setter
    if descriptor.set ~= nil then
        rawset(obj, "_s" .. prop, descriptor.set)
    end

    return obj
end

-- TODO
Object.freeze = function (this, obj)
    -- not really frozen...
    return obj
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

Object.getOwnPropertyNames = function (this, obj)
    local ret, i = {}, 0

    local props = coreObjects.props(obj, false, true)
    for _, key in ipairs(props) do
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

-- TODO
Object.isExtensible = function (this, obj)
    return true
end

-- TODO
Object.isFrozen = function (this, obj)
    return false
end

-- TODO
Object.isSealed = function (this, obj)
    return false
end

Object.keys = function (this, obj)
    local tobj = type(obj)
    if tobj == "boolean" or obj == nil or tobj == "number" or tobj == "string" then
        error(errorHelper.newTypeError("Object.keys called on non-object"))
    end

    local ret, i = {}, 0

    local props = coreObjects.props(obj, false, false)
    for _, key in ipairs(props) do
        ret[i] = tostring(key)
        i = i + 1
    end

    return coreObjects.array(ret, i)
end

-- TODO
Object.preventExtensions = function (this, obj)
    return obj
end

-- TODO
Object.seal = function (this, obj)
    return obj
end

Object.prototype = objectProto
objectProto.constructor = Object

return Object
