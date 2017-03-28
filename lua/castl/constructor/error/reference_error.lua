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

-- [[ CASTL ReferenceError constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ReferenceError

local ReferenceError

local coreObjects = require("castl.core_objects")
local Error = require("castl.constructor.error.error")
local referenceErrorProto = require("castl.protos").referenceErrorProto
local internal = require("castl.internal")

local setmetatable = setmetatable
local get, put, ToNumber = internal.get, internal.put, internal.ToNumber

_ENV = nil

ReferenceError = coreObjects.func(function(this, message)
    local o = {}
    o.message = message

    setmetatable(o, {
        __index = function (self, key)
            return get(self, referenceErrorProto, key)
        end,
        __newindex = put,
        __tostring = function(self)
            return self:toString()
        end,
        __sub = function(a, b)
            return ToNumber(a) - ToNumber(b)
        end,
        __mul = function(a, b)
            return ToNumber(a) * ToNumber(b)
        end,
        __div = function(a, b)
            return ToNumber(a) / ToNumber(b)
        end,
        _prototype = referenceErrorProto})

    Error:captureStackTrace(o, ReferenceError)

    return o
end)

ReferenceError.prototype = referenceErrorProto
referenceErrorProto.constructor = ReferenceError

return ReferenceError
