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

-- [[ CASTL String prototype submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/prototype

local stringPrototype = {}

local jssupport = require("castl.jssupport")
local regexpHelper = require("castl.modules.regexphelper")
local common = require("castl.modules.common")

local RegExp, instanceof, array, _regexp, new
local type, tostring, tonumber, min, max, rawget, rawset = type, tostring, tonumber, math.min, math.max, rawget, rawset
local pack, tinsert, tremove, concat = table.pack, table.insert, table.remove, table.concat
local string, error, require, gmatch, pairs = string, error, require, string.gmatch, pairs

_ENV = nil

local negativeIndex = function (index, length)
    if index < -length then
        return 0
    else
        return (index % length)
    end
end

stringPrototype.charCodeAt = function (this, i)
    i = i or 0
    return string.byte(this, tonumber(i) + 1)
end

stringPrototype.charAt = function (this, i)
    if type(i) == "number" then
        return string.sub(this, i + 1, i + 1)
    end

    return string.sub(this, 1, 1)
end

stringPrototype.substr = function (this, start, length)
    if start < 0 then
        start = negativeIndex(start, this.length)
    end

    if length ~= nil then
        return string.sub(this, start + 1, start + length)
    else
        return string.sub(this, start + 1)
    end
end

stringPrototype.substring = function (this, indexA, indexB)
    if indexA < 0 then
        indexA = 0
    elseif indexA > this.length then
        indexA = this.length
    end

    -- if indexB is specified
    if indexB ~= nil then
        if indexB < 0 then
            indexB = 0
        elseif indexB > this.length then
            indexB = this.length
        end

        -- swap
        if indexA > indexB then
            local tmp = indexB
            indexB = indexA
            indexA = tmp
        end
    end

    if indexB ~= nil then
        return string.sub(this, indexA + 1, indexB)
    else
        return string.sub(this, indexA + 1)
    end
end

stringPrototype.slice = function (this, beginSlice, endSlice)
    if beginSlice < 0 then
        beginSlice = negativeIndex(beginSlice, this.length)
    end

    if endSlice ~= nil then
        if endSlice < 0 then
            endSlice = negativeIndex(endSlice, this.length)
        end

        return string.sub(this, beginSlice + 1, endSlice)
    end

    return string.sub(this, beginSlice + 1)

end

stringPrototype.toLowerCase = function (this)
    return string.lower(this)
end

stringPrototype.toLocaleLowerCase = function (this)
    return string.lower(this)
end

stringPrototype.toUpperCase = function (this)
    return string.upper(this)
end

stringPrototype.toLocaleUpperCase = function (this)
    return string.upper(this)
end

stringPrototype.indexOf = function (this, searchValue, fromIndex)

    fromIndex = fromIndex or 0
    if fromIndex < 0 then
        fromIndex = 0
    end

    -- special case of empty string
    if searchValue == "" then
        if fromIndex < this.length then
            return fromIndex
        else
            return this.length
        end
    end

    if fromIndex <= 0 then
        fromIndex = 1
    elseif fromIndex > this.length then
        return -1
    end

    -- find
    local ret = string.find(this, tostring(searchValue), fromIndex, true)

    -- not found
    if ret == nil then
        return -1
    end

    return ret - 1
end

stringPrototype.lastIndexOf = function (this, searchValue, fromIndex)
    fromIndex = fromIndex or this.length
    if fromIndex < 0 then
        fromIndex = 0
    elseif fromIndex > this.length then
        fromIndex = this.length
    end

    -- find in reversed string
    local ret = string.find(string.reverse(this), tostring(searchValue), this.length - fromIndex + 1, true)
    if searchValue == "" then
        ret = ret - 1
    end

    -- not found
    if ret == nil then
        return -1
    end

    return this.length - ret

end

stringPrototype.toString = function (this)
    if type(this) == 'string' then
        return this
    else
        return "[object Object]"
    end
end

stringPrototype.trim = function (this)
    -- http://lua-users.org/wiki/StringTrim
    return string.match(this,'^()%s*$') and '' or string.match(this,'^%s*(.*%S)')
end

stringPrototype.concat = function (this, ...)
    local args = pack(...)
    local ret = this

    for i = 1,args.n do
        ret = ret .. args[i]
    end

    return ret
end

--[[
    Functions related to RegExp
--]]

stringPrototype.split = function (this, separator, limit)
    array = array or require("castl.core_objects").array
    -- special cases
    if not separator or this == "" then
        return array({[0] = this}, 1)
    elseif separator == "" then
        local ret, length = {}, this.length
        for i = 0, length - 1 do
            ret[i] = this:charAt(i)
        end
        return array(ret, length)
    end

    RegExp = RegExp or require("castl.constructor.regexp")
    instanceof = instanceof or require("castl.core_objects").instanceof

    local ret = {}

    if type(separator) == "string" then
        -- escape magic chars as seperator is a string not a RegExp
        separator = '[^' .. common.escapeMagicChars(separator) .. ']+'
        for k in gmatch(this, separator) do
            tinsert(ret, k)
        end
    elseif instanceof(separator, RegExp) then
        local captures = regexpHelper.regExpHasCaptured(this, separator)
        local iter = regexpHelper.split(this, separator)

        while true do
            local match = pack(iter())
            if not match[1] then break end
            -- insert section
            tinsert(ret, match[1])

            if captures then
                -- insert captures
                for i = 2, match.n do
                    tinsert(ret, match[i])
                end
            end
        end
    end

    -- Limit number of results
    local length = #ret
    limit = tonumber(limit)
    if limit and limit >= 0 then
        limit = min(limit, length)
    else
        limit = length
    end

    for i = length, limit + 1, -1 do
        tremove(ret, i)
    end

    -- shift to 0-based index
    local tmp = rawget(ret, 1)
    tremove(ret, 1)
    rawset(ret, 0, tmp)

    return array(ret, limit)
end

local getReplacerRegExp = function(newSubStr)
    local replacer = ""
    if type(newSubStr) == "string" then
        -- handle $ parameters
        replacer = string.gsub(newSubStr, "%$&", "$0")
        replacer = string.gsub(replacer, "([%$]+)(.?)",
            function(dollars, follow)
                local length = string.len(dollars)
                local ret = {"%"}
                for i = 2, length do
                    ret[i] = (i % 2) == 0 and "$" or "%"
                end

                if not tonumber(string.sub(follow, 1, 1)) then
                    ret[length] = "$"
                end

                ret[length + 1] = follow

                return concat(ret)
            end
        )
    elseif type(newSubStr) == "function" then
        replacer = function(...)
            -- call with an empty this
            return newSubStr({}, ...)
        end
    end

    return replacer
end

local getReplacerString = function(newSubStr)
    -- handle $ parameters
    local replacer = string.gsub(newSubStr, "%$&", "%%0")
    replacer = string.gsub(replacer, "([%$]+)",
        function(dollars)
            local length = string.len(dollars)
            local ret = {"$"}
            for i = 2, length do
                ret[i] = (i % 2) == 1 and "$" or ""
            end

            return concat(ret)
        end
    )

    return replacer
end

stringPrototype.replace = function (this, match, newSubStr, flags)
    RegExp = RegExp or require("castl.constructor.regexp")
    instanceof = instanceof or require("castl.core_objects").instanceof

    -- if flags are passed, match is converted to a regexp
    if type(match) == "string" and flags then
        new = new or require("castl.core_objects").new
        match = new(RegExp, match, flags)
    end

    -- if replacer is a function, match must be converted to a regexp
    -- to be able to use the regexp gsub
    if type(match) == "string" and type(newSubStr) == "function" then
        new = new or require("castl.core_objects").new
        match = new(RegExp, match, "")
    end

    local replacer
    if type(match) == "string" then
        replacer = getReplacerString(newSubStr)
        return (string.gsub(this, match, replacer, 1))
    elseif instanceof(match, RegExp) then
        replacer = getReplacerRegExp(newSubStr)
        return (regexpHelper.gsub(this, match, replacer))
    else
        error("Unknown regex invocation object: " .. type(match))
    end
end

stringPrototype.search = function (this, regexp)
    RegExp = RegExp or require("castl.constructor.regexp")
    instanceof = instanceof or require("castl.core_objects").instanceof
    _regexp = _regexp or require("castl.core_objects").regexp

    -- TODO: how to convert other types to RegExp?
    if type(regexp) == "string" then
        regexp = _regexp(regexp, "")
    end

    local cf = regexpHelper.getPCRECompilationFlag(regexp)
    local rex = regexpHelper.getRex()
    local found = rex.find(this, regexp.source, 1, cf)

    return found and found - 1 or -1
end

stringPrototype.match = function (this, regexp)
    RegExp = RegExp or require("castl.constructor.regexp")
    instanceof = instanceof or require("castl.core_objects").instanceof
    _regexp = _regexp or require("castl.core_objects").regexp
    array = array or require("castl.core_objects").array

    -- TODO: how to convert other types to RegExp?
    if type(regexp) == "string" then
        regexp = _regexp(regexp, "")
    end

    -- add a global capture to get the entire match
    -- (gmatch and find don't return the entire match, only  the captures)
    local source =  "(" .. regexp.source .. ")"

    local cf = regexpHelper.getPCRECompilationFlag(regexp)
    local rex = regexpHelper.getRex()
    local ret = {}

    -- global match: rex.gmatch
    if regexp.global then
        local iter = rex.gmatch(this, source, cf)

        while true do
            local match = pack(iter())
            if not match[1] then break end
            tinsert(ret, match[1])
        end
    else
        -- single match: rex.find (to get the starting index)
        local found = pack(rex.find(this, source, 1, cf))
        if found[1] then
            ret.index = found[1] - 1
            ret.input = this
            for i = 3, found.n do
                tinsert(ret, found[i])
            end
        end
    end

    local length = #ret

    if length == 0 then
        return jssupport.null
    end

    -- shift to 0-based index
    local tmp = rawget(ret, 1)
    tremove(ret, 1)
    rawset(ret, 0, tmp)

    return array(ret, length)
end

return stringPrototype
