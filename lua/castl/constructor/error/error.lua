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

-- [[ CASTL Error constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error

local Error

local jssupport = require("castl.jssupport")
local errorProto = require("castl.prototype.error.error")
local internal = require("castl.internal")

local setmetatable = setmetatable

local traceback = debug.traceback

_ENV = nil

Error = function(this, message)
    local o = {}
    o.message = message

    return setmetatable(o, {
        __index = function (self, key)
            return internal.get(self, errorProto, key)
        end,
        __newindex = function (self, key, value)
            return internal.put(self, key, value)
        end,
        __tostring = function(self)
            return traceback(self:toString(), 4)
        end,
        __tonumber = function(self)
            return jssupport.NaN
        end,
        _prototype = errorProto})
end

Error.prototype = errorProto
errorProto.constructor = Error

return Error
