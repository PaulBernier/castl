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

local difftime, time, date = os.difftime, os.time, os.date
local tinsert = table.insert
local pcall, ipairs, tostring, tonumber, type, setmetatable = pcall, ipairs, tostring, tonumber, type, setmetatable
local match = string.match

local DateParser = {}

_ENV = nil

--we shall use the host OS's time conversion facilities. Dealing with all those leap seconds by hand can be such a bore.
local unix_timestamp
do
    local now = time()
    local local_UTC_offset_sec = difftime(time(date("!*t", now)), time(date("*t", now)))
    unix_timestamp = function(t, offset_sec)
        local success, improper_time = pcall(time, t)
        if not success or not improper_time then return nil, "invalid date. os.time says: " .. (improper_time or "nothing") end
        return improper_time - local_UTC_offset_sec - offset_sec
    end
end

local formats = {} -- format names
local format_func = setmetatable({}, {__mode='v'})  --format functions

---register a date format parsing function
local register_format = function(format_name, format_function)
    if type(format_name)~="string" or type(format_function)~='function' then return nil, "improper arguments, can't register format handler" end

    local found
    for i, f in ipairs(format_func) do --for ordering
        if f==format_function then
            found=true
            break
    end
    end
    if not found then
        tinsert(format_func, format_function)
    end
    formats[format_name] = format_function
    return true
end

---try to parse date string
--@param str date string
--@param date_format optional date format name, if known
--@return unix timestamp if str can be parsed; nil, error otherwise.
DateParser.parse = function(str, date_format)
    local success, res
    if date_format then
        if not formats[date_format] then return 'unknown date format: ' .. tostring(date_format) end
        success, res = pcall(formats[date_format], str)
    else
        for i, func in ipairs(format_func) do
            success, res = pcall(func, str)
            if success and res then return res end
        end
    end

    return success and res
end


do
    local tz_table = { --taken from http://www.timeanddate.com/library/abbreviations/timezones/
        A = 1,  B = 2, C = 3, D = 4,  E=5, F = 6,   G = 7,  H = 8,  I = 9,
        K = 10, L = 11, M = 12, N = -1, O = -2, P = -3, Q = -4, R = -5,
        S = -6, T = -7, U = -8, V = -9, W = -10, X = -11, Y = -12,
        Z = 0,

        EST = -5, EDT = -4, CST = -6, CDT = -5,
        MST = -7, MDT = -6, PST = -8, PDT = -7,

        GMT = 0, UT = 0, UTC = 0
    }

    local month_val = {Jan=1, Feb=2, Mar=3, Apr=4, May=5, Jun=6, Jul=7, Aug=8, Sep=9, Oct=10, Nov=11, Dec=12}

    register_format('RFC2822', function(rest)
        local year, month, day, day_of_year, week_of_year, weekday
        local hour, minute, second, second_fraction, offset_hours

        local alt_rest

        weekday, alt_rest = match(rest, "^(%w%w%w),%s+(.*)$")
        if weekday then rest=alt_rest end
        day, rest=match(rest,"^(%d%d?)%s+(.*)$")
        month, rest=match(rest,"^(%w%w%w)%s+(.*)$")
        month = month_val[month]
        year, rest = match(rest,"^(%d%d%d?%d?)%s+(.*)$")
        hour, rest = match(rest,"^(%d%d?):(.*)$")
        minute, rest = match(rest,"^(%d%d?)(.*)$")
        second, alt_rest = match(rest,"^:(%d%d)(.*)$")
        if second then rest = alt_rest end
        local tz, offset_sign, offset_h, offset_m
        tz, alt_rest = match(rest,"^%s+(%u+)(.*)$")
        if tz then
            rest = alt_rest
            offset_hours = tz_table[tz]
        else
            offset_sign, offset_h, offset_m, rest = match(rest,"^%s+([+-])(%d%d)(%d%d)%s*(.*)$")
            offset_hours = tonumber(offset_sign .. offset_h) + (tonumber(offset_m) or 0)/60
        end

        if #rest>0 or not (year and day and month and hour and minute) then
            return nil
        end

        year = tonumber(year)
        local d = {
            year = year and ((year > 100) and year or (year < 50 and (year + 2000) or (year + 1900))),
            month = month,
            day = tonumber(day),

            hour= tonumber(hour) or 0,
            min = tonumber(minute) or 0,
            sec = tonumber(second) or 0,
            isdst  = false
        }
        return unix_timestamp(d, offset_hours * 3600)
    end)
end

return DateParser
