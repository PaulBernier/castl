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

return function(stringPrototype)
    local runtime
    local coreObjects = require("castl.core_objects")
    local _regexp = coreObjects.regexp
    local array = coreObjects.array
    local instanceof = coreObjects.instanceof
    local new = coreObjects.new
    local RegExp = require("castl.constructor.regexp")
    local internal = require("castl.internal")
    local regexpHelper = require("castl.modules.regexphelper")
    local common = require("castl.modules.common")

    local type, tostring, tonumber, min, rawget, rawset = type, tostring, tonumber, math.min, rawget, rawset
    local pack, tinsert, tremove, concat = table.pack, table.insert, table.remove, table.concat
    local error, require, getmetatable = error, require, getmetatable
    local sub, byte, gmatch, find, reverse = string.sub, string.byte, string.gmatch, string.find, string.reverse
    local lower, upper, match, gsub, len = string.lower, string.upper, string.match, string.gsub, string.len
    local null, defaultValueString = internal.null, internal.defaultValueString

    _ENV = nil

    stringPrototype.length = 0

    stringPrototype.valueOf = function (this)
        if type(this) == "string" then
            return this
        end
        return getmetatable(this)._primitive
    end

    local valueof = stringPrototype.valueOf

    local negativeIndex = function (index, length)
        if index < -length then
            return 0
        else
            return (index % length)
        end
    end

    stringPrototype.anchor = function(this, name)
        local value = valueof(this)
        local t = {'<a name="'}
        tinsert(t, defaultValueString(name))
        tinsert(t, '">')
        tinsert(t, value)
        tinsert(t, '</a>')
        return concat(t)
    end

    stringPrototype.charAt = function (this, i)
        local value = valueof(this)
        if type(i) == "number" then
            return sub(value, i + 1, i + 1)
        end

        return sub(value, 1, 1)
    end

    stringPrototype.charCodeAt = function (this, i)
        local value = valueof(this)
        i = i or 0
        return byte(value, tonumber(i) + 1)
    end

    stringPrototype.concat = function (this, ...)
        local args = pack(...)
        local ret = valueof(this)

        for i = 1,args.n do
            ret = ret .. args[i]
        end

        return ret
    end

    stringPrototype.indexOf = function (this, searchValue, fromIndex)
        local value = valueof(this)
        fromIndex = fromIndex or 0
        if fromIndex < 0 then
            fromIndex = 0
        end

        -- special case of empty string
        if searchValue == "" then
            if fromIndex < value.length then
                return fromIndex
            else
                return value.length
            end
        end

        if fromIndex <= 0 then
            fromIndex = 1
        elseif fromIndex > value.length then
            return -1
        end

        -- find
        local ret = find(value, tostring(searchValue), fromIndex, true)

        -- not found
        if ret == nil then
            return -1
        end

        return ret - 1
    end

    stringPrototype.lastIndexOf = function (this, searchValue, fromIndex)
        local value = valueof(this)
        fromIndex = fromIndex or value.length
        if fromIndex < 0 then
            fromIndex = 0
        elseif fromIndex > value.length then
            fromIndex = value.length
        end

        -- find in reversed string
        local ret = find(reverse(value), defaultValueString(searchValue), value.length - fromIndex + 1, true)
        if searchValue == "" then
            ret = ret - 1
        end

        -- not found
        if ret == nil then
            return -1
        end

        return value.length - ret
    end

    stringPrototype.link = function(this, url)
        local value = valueof(this)
        local t = {'<a href="'}
        tinsert(t, defaultValueString(url))
        tinsert(t, '">')
        tinsert(t, value)
        tinsert(t, '</a>')
        return concat(t)
    end

    stringPrototype.substr = function (this, start, length)
        local value = valueof(this)
        if start < 0 then
            start = negativeIndex(start, value.length)
        end

        if length ~= nil then
            return sub(value, start + 1, start + length)
        else
            return sub(value, start + 1)
        end
    end

    stringPrototype.substring = function (this, indexA, indexB)
        local value = valueof(this)
        if indexA < 0 then
            indexA = 0
        elseif indexA > value.length then
            indexA = value.length
        end

        -- if indexB is specified
        if indexB ~= nil then
            if indexB < 0 then
                indexB = 0
            elseif indexB > value.length then
                indexB = value.length
            end

            -- swap
            if indexA > indexB then
                local tmp = indexB
                indexB = indexA
                indexA = tmp
            end
        end

        if indexB ~= nil then
            return sub(value, indexA + 1, indexB)
        else
            return sub(value, indexA + 1)
        end
    end

    stringPrototype.slice = function (this, beginSlice, endSlice)
        local value = valueof(this)
        if beginSlice < 0 then
            beginSlice = negativeIndex(beginSlice, value.length)
        end

        if endSlice ~= nil then
            if endSlice < 0 then
                endSlice = negativeIndex(endSlice, value.length)
            end

            return sub(value, beginSlice + 1, endSlice)
        end

        return sub(value, beginSlice + 1)

    end

    stringPrototype.small = function(this)
        local value = valueof(this)
        local t = {'<small>'}
        tinsert(t, value)
        tinsert(t, '</small>')
        return concat(t)
    end

    stringPrototype.toLowerCase = function (this)
        return lower(valueof(this))
    end

    stringPrototype.toLocaleLowerCase = function (this)
        return lower(valueof(this))
    end

    stringPrototype.toUpperCase = function (this)
        return upper(valueof(this))
    end

    stringPrototype.toLocaleUpperCase = function (this)
        return upper(valueof(this))
    end

    stringPrototype.toString = function (this)
        local mt = getmetatable(this)
        -- Object String
        if mt and type(mt._primitive) == "string" then
            return mt._primitive
                -- primitive string
        elseif type(this) == 'string' then
            return this
        else
            return "[object Object]"
        end
    end

    stringPrototype.trim = function (this)
        local value = valueof(this)
        -- http://lua-users.org/wiki/StringTrim
        return match(value,'^()%s*$') and '' or match(value,'^%s*(.*%S)')
    end

    --[[
        Functions related to RegExp
    --]]

    stringPrototype.split = function (this, separator, limit)
        local value = valueof(this)
        -- special cases
        if separator == nil or value == "" then
            return array({[0] = value}, 1)
        elseif separator == "" then
            local ret, length = {}, value.length
            for i = 0, length - 1 do
                ret[i] = value:charAt(i)
            end
            return array(ret, length)
        end

        local ret = {}

        if type(separator) == "string" then
            -- escape magic chars as seperator is a string not a RegExp
            separator = '[^' .. common.escapeMagicChars(separator) .. ']+'
            for k in gmatch(value, separator) do
                tinsert(ret, k)
            end
        elseif instanceof(separator, RegExp) then
            local captures = regexpHelper.regExpHasCaptured(value, separator)
            local iter = regexpHelper.split(value, separator)

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

        if type(newSubStr) == "function" then
            runtime = runtime or require("castl.runtime")
            replacer = function(...)
                return defaultValueString(newSubStr(runtime, ...))
            end
        else
            replacer = defaultValueString(newSubStr)

            -- handle $ parameters
            replacer = gsub(replacer, "%$&", "$0")
            replacer = gsub(replacer, "([%$]+)(.?)",
                function(dollars, follow)
                    local length = len(dollars)
                    local ret = {"%"}
                    for i = 2, length do
                        ret[i] = (i % 2) == 0 and "$" or "%"
                    end

                    if not tonumber(sub(follow, 1, 1)) then
                        ret[length] = "$"
                    end

                    ret[length + 1] = follow

                    return concat(ret)
                end
            )
        end

        return replacer
    end

    local getReplacerString = function(newSubStr)
        local replacer = defaultValueString(newSubStr)

        -- handle $ parameters
        replacer = gsub(replacer, "%$&", "%%0")
        replacer = gsub(replacer, "([%$]+)",
            function(dollars)
                local length = len(dollars)
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
        local value = valueof(this)

        if type(match) ~= "string" and not instanceof(match, RegExp) then
            match = defaultValueString(match)
        end

        if type(match) == "string" then
            -- if flags are passed, match is converted to a regexp
            if flags ~= nil then
                match = new(RegExp, match, flags)
                -- if replacer is a function, match must be converted to a regexp
                -- to be able to use the regexp gsub
            elseif type(newSubStr) == "function" then
                match = new(RegExp, match, "")
            end
        end

        local replacer
        if type(match) == "string" then
            replacer = getReplacerString(newSubStr)
            return (gsub(value, match, replacer, 1))
        elseif instanceof(match, RegExp) then
            replacer = getReplacerRegExp(newSubStr)
            return (regexpHelper.gsub(value, match, replacer))
        else
            error("Unknown regex invocation object: " .. type(match))
        end
    end

    stringPrototype.search = function (this, regexp)
        local value = valueof(this)

        if not instanceof(regexp, RegExp) then
            regexp = _regexp(regexp)
        end

        local cf = regexpHelper.getPCRECompilationFlag(regexp)
        local rex = regexpHelper.getRex()
        local found = rex.find(value, regexp.source, 1, cf)

        return found and found - 1 or -1
    end

    stringPrototype.match = function (this, regexp)
        local value = valueof(this)

        if not instanceof(regexp, RegExp) then
            regexp = _regexp(regexp)
        end

        -- add a global capture to get the entire match
        -- (gmatch and find don't return the entire match, only  the captures)
        local source =  "(" .. regexp.source .. ")"

        local cf = regexpHelper.getPCRECompilationFlag(regexp)
        local rex = regexpHelper.getRex()
        local ret = {}

        -- global match: rex.gmatch
        if regexp.global then
            local iter = rex.gmatch(value, source, cf)

            while true do
                local match = pack(iter())
                if not match[1] then break end
                tinsert(ret, match[1])
            end
        else
            -- single match: rex.find (to get the starting index)
            local found = pack(rex.find(value, source, 1, cf))
            if found[1] then
                ret.index = found[1] - 1
                ret.input = value
                for i = 3, found.n do
                    tinsert(ret, found[i])
                end
            end
        end

        local length = #ret

        if length == 0 then
            return null
        end

        -- shift to 0-based index
        local tmp = rawget(ret, 1)
        tremove(ret, 1)
        rawset(ret, 0, tmp)

        return array(ret, length)
    end

end
