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

-- [[ CASTL Date constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean

local Date

local internal = require("castl.internal")
local dateparser = require("castl.modules.dateparser")
local dateProto = require("castl.protos").dateProto

local luajit = jit ~= nil
local date, time = os.date, os.time
local pack = table.pack or function(...) return {n = select('#',...),...} end
local type, setmetatable, require, tonumber = type, setmetatable, require, tonumber
local get, put, withinNew, ToNumber = internal.get, internal.put, internal.withinNew, internal.ToNumber

_ENV = nil

Date = function(this, ...)
    -- Date constructor not called within a new
    if not withinNew(this, dateProto) then
        return date("%a %h %d %Y %H:%M:%S GMT%z (%Z)")
    end

    local args = pack(...)
    local timestamp = 0

    if args.n == 0 then
        timestamp = Date.now()
    elseif args.n == 1 then
        local arg = args[1]
        local targ = type(arg)
        if targ == "number" then
            timestamp = arg * 1000
        elseif targ == "string" then
            timestamp = Date.parse(arg)
        end
    else
        -- special behavior for year between 0 and 100
        if args[1] >= 0 and args[1] <100 then
            args[1] = 1900 + args[1]
        end
        -- more than 1 arguments
        -- year, month, day, hour, minute, second, millisecond
        timestamp = time{year=args[1],
            month=args[2] + 1,
            day=args[3] or 1,
            hour=args[4] or 0,
            min = args[5] or 0,
            sec = args[6] or 0}

        timestamp = timestamp * 1000 + (args[7] or 0)
    end

    local o = {}
    o._timestamp = timestamp

    setmetatable(o, {
        __index = function (self, key)
            return get(self, dateProto, key)
        end,
        __newindex = put,
        __tostring = dateProto.toString,
        __sub = function(a, b)
            return ToNumber(a) - ToNumber(b)
        end,
        __mul = function(a, b)
            return ToNumber(a) * ToNumber(b)
        end,
        __div = function(a, b)
            return ToNumber(a) / ToNumber(b)
        end,
        _prototype = dateProto
    })

    return o
end

Date._timestamp = 0

if luajit then
    local ffi = require("ffi")
    -- posix systems only
    ffi.cdef[[
        typedef struct timeval {
          long tv_sec;
          long tv_usec;
        } timeval;
        int gettimeofday(struct timeval *restrict tp, void *restrict tzp);
    ]]

    local te = ffi.new("timeval[1]")

    Date.now = function(this)
        ffi.C.gettimeofday(te, nil);
        return tonumber(te[0].tv_sec * 1000 + te[0].tv_usec / 1000);
    end
else
    Date.now = function(this)
        -- TODO: write a C function to get milliseconds
        return time() * 1000
    end
end

Date.parse = function(this, str)
    -- TODO: parse RFC2822 only for now
    return dateparser.parse(str, 'RFC2822') * 1000
end

Date.UTC = function(this, year, month, day, hrs, min, sec, ms)
    local timestamp = time{year=year,
        month = month + 1,
        day = day or 1,
        hour = hrs or 0,
        min = min or 0,
        sec = sec or 0}

    timestamp = (timestamp + dateProto.getTimezoneOffset()) * 1000 + (ms or 0)

    return timestamp
end

Date.length = 7

Date.prototype = dateProto
dateProto.constructor = Date

return Date
