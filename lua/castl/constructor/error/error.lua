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

local errorProto = require("castl.protos").errorProto
local CallSite = require("castl.constructor.error.call_site")
local internal = require("castl.internal")
local coreObjects = require("castl.core_objects")

local new, array, instanceof = coreObjects.new, coreObjects.array, coreObjects.instanceof

local setmetatable, getmetatable, rawget, rawset = setmetatable, getmetatable, rawget, rawset
local get, put, ToNumber = internal.get, internal.put, internal.ToNumber
local getinfo = debug.getinfo
local ipairs, remove = ipairs, table.remove

_ENV = nil

Error = function(this, message)
    local o = {}
    o.message = message

    setmetatable(o, {
        __index = function (self, key)
            return get(self, errorProto, key)
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
        _prototype = errorProto}
    )

    Error:captureStackTrace(o, Error)

    return o
end

Error.captureStackTrace = function(this, error, constructorOpt)
    local frames = {}
    local frame_idx = 1

    local info_idx = constructorOpt ~= nil and 3 or 2
    while true do
        local frame

        if frame_idx <= Error.stackTraceLimit then
            frame = getinfo(info_idx)
        end
        if frame == nil then
            break
        end

        -- create a CallSite
        local cs = new(CallSite, nil, frame.fun, 0)
        getmetatable(cs).frame = frame
        frames[frame_idx] = cs
        frame_idx = frame_idx + 1
        info_idx = info_idx + 1
    end

    -- add marker
    getmetatable(error).__stack = true

    error._gstack = function(this)
        if Error.prepareStackTrace then
            -- shift to 0-based index
            local tmp = rawget(frames, 1)
            remove(frames, 1)
            rawset(frames, 0, tmp)
            return Error:prepareStackTrace(this, array(frames, frame_idx - 1))
        end

        local s = instanceof(error, Error) and error:toString() or "Error"
        for _, frame in ipairs(frames) do
            s = s .. "\n    at " .. frame:toString()
        end
        return s
    end
end

Error.stackTraceLimit = 10

Error.prototype = errorProto
errorProto.constructor = Error

return Error
