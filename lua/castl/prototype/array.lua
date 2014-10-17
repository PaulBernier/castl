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

-- [[ CASTL Array prototype submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/prototype

return function(arrayPrototype)
    local runtime
    local makeArray = require("castl.core_objects").array
    local boolean = require("castl.jssupport").boolean
    local internal = require("castl.internal")
    local errorHelper = require("castl.modules.error_helper")
    local throw = require("castl.jssupport").throw

    local rawget, rawset, require, getmetatable = rawget, rawset, require, getmetatable
    local tonumber, min, floor, type = tonumber, math.min, math.floor, type
    local pack = table.pack or function(...) return {n = select('#',...),...} end
    local remove, insert, sort = table.remove, table.insert, table.sort
    local null, ToString, ToInteger, ToNumber = internal.null, internal.ToString, internal.ToInteger, internal.ToNumber

    _ENV = nil

    arrayPrototype.length = 0

    local negativeIndex = function (index, length)
        local k = length + index
        if k < 0 then
            return 0
        end
        return k
    end

    arrayPrototype.toString = function (this)
        return arrayPrototype.join(this)
    end

    arrayPrototype.toLocaleString = arrayPrototype.toString

    arrayPrototype.push = function (this, ...)
        local args = pack(...)
        local length = this.length

        for i = 1, args.n do
            rawset(this, length, args[i])
            length = length + 1
        end

        rawset(this, "length", length)

        return length
    end

    arrayPrototype.pop = function (this)
        local length = this.length
        if length == 0 then
            return nil
        end

        local value = rawget(this, length - 1)
        rawset(this, length - 1, nil)
        rawset(this, "length", length - 1)
        return value
    end

    arrayPrototype.shift = function (this)
        local length = this.length

        if length > 0 then
            local value = rawget(this, 0)
            rawset(this, 0, remove(this, 1) or nil)
            rawset(this, 'length', length - 1)
            return value
        end

        return nil
    end

    arrayPrototype.unshift = function (this, ...)
        local args = pack(...)
        local newLength = this["length"] + args.n

        for i = args.n, 1, -1 do
            insert(this, 1, rawget(this, 0))
            rawset(this, 0, args[i])
        end

        rawset(this, 'length', newLength)

        return newLength
    end

    arrayPrototype.splice = function (this, index, howMany, ...)
        local elements = pack(...)
        local length = this.length

        if index > length then
            index = length
        elseif index < 0 then
            index = negativeIndex(index, length)
        end

        howMany = min(tonumber(howMany) or (length - index), length - index)

        -- delete elements and collect deleted elements
        local ret = {}
        for i = 1,howMany do
            ret[i - 1] = rawget(this, index)
            if index == 0 then
                rawset(this, 0, remove(this, 1) or nil)
            else
                remove(this, index)
            end
        end

        -- insert new elements
        for i = 1,elements.n do
            if index == 0 then
                insert(this, 1, rawget(this, 0))
                rawset(this, 0, elements[i])
            else
                insert(this, index, elements[i])
            end

            index = index + 1
        end

        -- new length
        rawset(this, 'length', length - howMany + elements.n)

        -- return array object
        return makeArray(ret, howMany)
    end

    arrayPrototype.reverse = function (this)
        local length = this.length

        for i = 0, floor(length / 2) - 1 do
            -- swap
            local tmp = this[i]
            this[i] = this[length - 1 - i]
            this[length - 1 - i] = tmp
        end
        return this
    end

    arrayPrototype.slice = function (this, beginSlice, endSlice)
        local length = this.length
        beginSlice = beginSlice or 0
        endSlice = endSlice or length

        if beginSlice < 0 then
            beginSlice = negativeIndex(beginSlice, length)
        end
        if endSlice < 0 then
            endSlice = negativeIndex(endSlice, length)
        elseif endSlice > length then
            endSlice = length
        end

        local ret, j = {}, 0
        for i = beginSlice, endSlice - 1 do
            ret[j] = this[i]
            j = j + 1
        end

        return makeArray(ret, j)
    end

    arrayPrototype.concat = function (this, ...)
        local ret = {}
        local length
        local args = pack(...)

        -- if this is a native Array
        if (getmetatable(this) or {})._prototype == arrayPrototype then
            for i = 1, this.length do
                ret[i] = this[i - 1]
            end
            length = this.length
        else
            ret[1] = this
            length = 1
        end

        for i = 1, args.n do
            -- test if is array
            if (getmetatable(args[i]) or {})._prototype == arrayPrototype then
                for j = 0, args[i].length -1 do
                    insert(ret, args[i][j])
                end
                length = length + args[i].length
            else
                insert(ret, args[i])
                length = length + 1
            end
        end

        -- shift to 0-based index
        local tmp = rawget(ret, 1)
        remove(ret, 1)
        rawset(ret, 0, tmp)

        -- convert to array object
        return makeArray(ret, length)
    end

    -- doesn't work if two nil follow in the array
    arrayPrototype.sort = function (this, compareFunction)
        -- shift from 0-based to 1-based index
        insert(this, 1, this[0])
        rawset(this, 0, nil)

        -- sort
        sort(this, function (a, b)
            if b == nil and a ~= nil then
                return true
            end
            if a == nil and b ~= nil then
                return false
            end

            if not compareFunction then
                return (ToString(a) < ToString(b))
            else
                local comp = compareFunction(this, a, b)
                local tcomp = type(comp)
                if tcomp == "number" then
                    return comp < 0
                elseif tcomp == "boolean" then
                    if a == b then
                        return false
                    end
                    return not comp
                end
            end
        end
        )

        --  unshift
        local tmp = rawget(this, 1)
        remove(this, 1)
        rawset(this, 0, tmp)

        return this
    end

    arrayPrototype.join = function (this, arg)
        local separator = ","
        if arg ~= nil then
            separator = ToString(arg)
        end

        local str = ""
        local bound = this.length - 1

        for i = 0, bound do
            if not (this[i] == nil or this[i] == null) then
                str = str .. ToString(this[i])
            end
            if i ~= bound then
                str = str .. separator
            end
        end

        return str
    end

    arrayPrototype.lastIndexOf = function(this, searchElement, fromIndex)
        local length = this.length
        local n = fromIndex ~= nil and ToInteger(fromIndex) or length - 1

        if n < 0 then
            n = length + n
        elseif n > length then
            n = length - 1
        end

        for i = n, 0, -1 do
            if this[i] == searchElement then
                return i
            end
        end

        return -1
    end

    arrayPrototype.indexOf = function (this, searchElement, fromIndex)
        local length = this.length
        local n = fromIndex ~= nil and ToNumber(fromIndex) or 0

        if n >= length then
            return -1
        end
        if n < 0 then
            n = negativeIndex(n, length)
        end

        for i = n, length - 1 do
            if this[i] == searchElement then
                return i
            end
        end

        return -1
    end

    local getThisArg = function(arg)
        -- if thisArg's not defined, use default this
        if arg == nil then
            runtime = runtime or require("castl.runtime")
            return runtime
        end

        return arg
    end

    arrayPrototype.map = function (this, callback, thisArg)
        local ret = {}

        thisArg = getThisArg(thisArg)

        for i = 0, this.length - 1 do
            if this[i] ~= nil then
                local v = callback(thisArg, this[i], i, this)
                insert(ret, v)
            end
        end

        -- shift to 0-based index
        local tmp = rawget(ret, 1)
        remove(ret, 1)
        rawset(ret, 0, tmp)

        -- convert to array object
        return makeArray(ret, this.length)
    end

    arrayPrototype.filter = function (this, callback, thisArg)
        local ret, length = {}, 0

        thisArg = getThisArg(thisArg)

        for i = 0, this.length - 1 do
            -- filter
            if this[i] ~= nil and boolean(callback(thisArg, this[i], i, this)) then
                insert(ret, this[i])
                length = length + 1
            end
        end

        -- shift to 0-based index
        local tmp = rawget(ret, 1)
        remove(ret, 1)
        rawset(ret, 0, tmp)

        -- convert to array object
        return makeArray(ret, length)
    end

    local empty = function(array)
        return array.length == 0 or array:every(function(_,e) return e == nil end)
    end

    arrayPrototype.reduce = function (this, callback, initialValue)
        if empty(this) and initialValue == nil then
            throw(errorHelper.newTypeError("Reduce of empty array with no initial value"))
        end

        local value = initialValue or this[0]
        local start = initialValue and 0 or 1
        local thisArg = getThisArg()
        local length = this.length
        for i = start, length - 1 do
            -- if not nil (else ignore)
            if this[i] ~= nil then
                value = callback(thisArg, value, this[i], i, this)
            end
        end

        return value
    end

    arrayPrototype.reduceRight = function (this, callback, initialValue)
        if empty(this) and initialValue == nil then
            throw(errorHelper.newTypeError("Reduce of empty array with no initial value"))
        end

        local value = initialValue or this[this.length - 1]
        local start = initialValue and this.length - 1 or this.length - 2
        local thisArg = getThisArg()
        for i = start, 0, -1 do
            -- if not nil (else ignore)
            if this[i] ~= nil then
                value = callback(thisArg, value, this[i], i, this)
            end
        end

        return value
    end

    arrayPrototype.forEach = function (this, callback, thisArg)
        thisArg = getThisArg(thisArg)

        local tthis = type(this)
        if tthis == "table" or tthis == "string" then
            local bound = this.length - 1
            for i = 0, bound do
                if this[i] ~= nil then
                    callback(thisArg, this[i], i, this)
                end
            end
        end
    end

    arrayPrototype.some = function (this, callback, thisArg)
        thisArg = getThisArg(thisArg)

        for i = 0, this.length - 1 do
            if this[i] ~= nil and boolean(callback(thisArg, this[i], i, this)) then
                return true
            end
        end

        return false
    end

    arrayPrototype.every = function (this, callback, thisArg)
        thisArg = getThisArg(thisArg)

        for i = 0, this.length - 1 do
            if not boolean(callback(thisArg, this[i], i, this)) then
                return false
            end
        end

        return true
    end

end
