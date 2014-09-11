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

-- [[ CASTL RangeError constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RangeError

local RangeError

local rangeErrorProto = require("castl.prototype.error.range_error")
local internal = require("castl.internal")

local setmetatable = setmetatable
local get, put = internal.get, internal.put
local traceback = debug.traceback

_ENV = nil

RangeError = function(this, message)
    local o = {}
    o.message = message

    return setmetatable(o, {
        __index = function (self, key)
            return get(self, rangeErrorProto, key)
        end,
        __newindex = function (self, key, value)
            return put(self, key, value)
        end,
        __tostring = function(self)
            return traceback(self:toString(), 4)
        end,
        __tonumber = function(self)
            return 0/0
        end,
        _prototype = rangeErrorProto})
end

RangeError.prototype = rangeErrorProto
rangeErrorProto.constructor = RangeError

return RangeError
