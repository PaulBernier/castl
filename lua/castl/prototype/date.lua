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

-- [[ CASTL Date prototype submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/prototype

return function(datePrototype)
    local date, time, difftime = os.date, os.time, os.difftime
    local format = string.format

    local coreObjects = require("castl.core_objects")

    _ENV = nil

    datePrototype.toString = coreObjects.func(function(this)
        return date('%a %h %d %Y %H:%M:%S GMT%z (%Z)', this._timestamp / 1000)
    end)

    datePrototype.getDate = coreObjects.func(function(this) return date('*t', this._timestamp / 1000).day end)
    datePrototype.getDay = coreObjects.func(function(this) return date('*t', this._timestamp / 1000).wday - 1 end)
    datePrototype.getFullYear = coreObjects.func(function(this) return date('*t', this._timestamp / 1000).year end)
    datePrototype.getHours = coreObjects.func(function(this) return date('*t', this._timestamp / 1000).hour end)
    datePrototype.getMilliseconds = coreObjects.func(function(this) return this._timestamp % 1000 end)
    datePrototype.getMinutes = coreObjects.func(function(this) return date('*t', this._timestamp / 1000).min end)
    datePrototype.getMonth = coreObjects.func(function(this) return date('*t', this._timestamp / 1000).month - 1 end)
    datePrototype.getSeconds = coreObjects.func(function(this) return date('*t', this._timestamp / 1000).sec end)

    datePrototype.getTime = coreObjects.func(function(this)
        return this._timestamp
    end)

    datePrototype.getTimezoneOffset = coreObjects.func(function(this)
        local now = time()
        return difftime(now, time(date("!*t", now))) / 60
    end)

    datePrototype.getUTCDate = coreObjects.func(function(this) return date('!*t', this._timestamp / 1000).day end)
    datePrototype.getUTCDay = coreObjects.func(function(this) return date('!*t', this._timestamp / 1000).wday - 1 end)
    datePrototype.getUTCFullYear = coreObjects.func(function(this) return date('!*t', this._timestamp / 1000).year end)
    datePrototype.getUTCHours = coreObjects.func(function(this) return date('!*t', this._timestamp / 1000).hour end)
    datePrototype.getUTCMilliseconds = datePrototype.getMilliseconds
    datePrototype.getUTCMinutes = coreObjects.func(function(this) return date('!*t', this._timestamp / 1000).min end)
    datePrototype.getUTCMonth = coreObjects.func(function(this) return date('!*t', this._timestamp / 1000).month - 1 end)
    datePrototype.getUTCSeconds = coreObjects.func(function(this) return date('!*t', this._timestamp / 1000).sec end)

    local setDateTime = function(this, key, value)
        local millis = this._timestamp % 1000
        local d = date('*t', this._timestamp / 1000)
        d[key] = value
        this._timestamp = (time(d) * 1000) + millis
    end

    local setDateTimeUTC = function(this, key, value)
        local millis = this._timestamp % 1000
        local d = date('!*t', this._timestamp / 1000)
        d[key] = value
        this._timestamp = (time(d) * 1000) + millis
    end

    datePrototype.setDate = coreObjects.func(function(this, dayValue) setDateTime(this, "day", dayValue) end)
    datePrototype.setFullYear = coreObjects.func(function(this, yearValue) setDateTime(this, "year", yearValue) end)
    datePrototype.setHours = coreObjects.func(function(this, hoursValue) setDateTime(this, "hour", hoursValue) end)
    datePrototype.setMinutes = coreObjects.func(function(this, minutesValue) setDateTime(this, "min", minutesValue) end)
    datePrototype.setMonth = coreObjects.func(function(this, monthValue) setDateTime(this, "month", monthValue + 1) end)
    datePrototype.setSeconds = coreObjects.func(function(this, secondsValue) setDateTime(this, "sec", secondsValue) end)

    datePrototype.setMilliseconds = coreObjects.func(function(this, millisValue)
        local d = date('*t', this._timestamp / 1000)
        this._timestamp = (time(d) * 1000)  + millisValue
    end)

    datePrototype.setTime = coreObjects.func(function(this, timeValue)
        this._timestamp = timeValue
    end)

    datePrototype.setUTCDate = coreObjects.func(function(this, dayValue) setDateTimeUTC(this, "day", dayValue) end)
    datePrototype.setUTCFullYear = coreObjects.func(function(this, yearValue) setDateTimeUTC(this, "year", yearValue) end)
    datePrototype.setUTCHours = coreObjects.func(function(this, hoursValue) setDateTimeUTC(this, "hour", hoursValue) end)
    datePrototype.setUTCMinutes = coreObjects.func(function(this, minutesValue) setDateTimeUTC(this, "min", minutesValue) end)
    datePrototype.setUTCMonth = coreObjects.func(function(this, monthValue) setDateTimeUTC(this, "month", monthValue + 1) end)
    datePrototype.setUTCSeconds = coreObjects.func(function(this, secondsValue) setDateTimeUTC(this, "sec", secondsValue) end)

    datePrototype.setUTCMilliseconds = coreObjects.func(function(this, millisValue)
        local d = date('!*t', this._timestamp / 1000)
        this._timestamp = (time(d) * 1000) + millisValue
    end)

    datePrototype.toDateString = coreObjects.func(function(this)
        return date('%a %h %d %Y', this._timestamp / 1000)
    end)

    datePrototype.toISOString = coreObjects.func(function(this)
        return date('!%Y-%m-%dT%H:%M:%S.', this._timestamp / 1000) .. format('%03dZ', this._timestamp % 1000)
    end)

    datePrototype.toJSON = datePrototype.toISOString
    datePrototype.toLocaleDateString = datePrototype.toDateString
    datePrototype.toLocaleString = datePrototype.toString

    datePrototype.toTimeString = coreObjects.func(function(this)
        return date('%H:%M:%S GMT%z (%Z)', this._timestamp / 1000)
    end)
    
    datePrototype.toLocaleTimeString = coreObjects.func(function(this)
        return date('%H:%M:%S', this._timestamp / 1000)
    end)

    datePrototype.toUTCString = coreObjects.func(function(this)
        return date('!%a %h %d %Y %H:%M:%S GMT', this._timestamp / 1000)
    end)

    datePrototype.valueOf = coreObjects.func(function(this)
        return this._timestamp
    end)
end
