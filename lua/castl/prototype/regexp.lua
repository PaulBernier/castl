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

-- [[ CASTL RegExp prototype submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/prototype

return function(regexpPrototype)
    local array = require("castl.core_objects").array
    local internal = require("castl.internal")
    local regexpHelper = require("castl.modules.regexphelper")

    local rawget, rawset = rawget, rawset
    local pack = table.pack or function(...) return {n = select('#',...),...} end
    local tinsert, tremove = table.insert, table.remove
    local null, ToString = internal.null, internal.ToString

    _ENV = nil

    regexpPrototype.global = false
    regexpPrototype.ignoreCase = false
    regexpPrototype.multiline = false
    regexpPrototype.source = ""
    regexpPrototype.lastIndex = 0

    regexpPrototype.exec = function(this, str)
        str = ToString(str)
        -- add a global capture to get the entire match
        -- (find don't return the entire match, only  the captures)
        local source =  "(" .. this.source .. ")"

        local cf = regexpHelper.getPCRECompilationFlag(this)
        local ret = {}

        local rex = regexpHelper.getRex()
        if this.global then
            local found = pack(rex.find(str, source, this.lastIndex + 1, cf))
            if found[1] then
                this.lastIndex = found[2]
                ret.index = found[1] - 1
                ret.input = str
                for i = 3, found.n do
                    tinsert(ret, found[i])
                end
            else
                this.lastIndex = 0
            end
        else
            local found = pack(rex.find(str, source, 1, cf))
            if found[1] then
                ret.index = found[1] - 1
                ret.input = str
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

    regexpPrototype.toString = function(this)
        local flags = ""
        if rawget(this, "global") then flags = flags .. 'g' end
        if rawget(this, "ignoreCase") then flags = flags .. 'i' end
        if rawget(this, "multiline") then flags = flags .. 'm' end

        return '/' .. this.source .. '/' .. flags
    end

    regexpPrototype.test = function(this, str)
        str = ToString(str)
        local cf = regexpHelper.getPCRECompilationFlag(this)

        local ret = false
        local rex = regexpHelper.getRex()
        if this.global then
            local _, endFound = rex.find(str, this.source, this.lastIndex + 1, cf)
            if endFound then
                this.lastIndex = endFound
                ret = true
            else
                this.lastIndex = 0
                ret = false
            end
        else
            local found = rex.find(str, this.source, 1, cf)
            ret = found and true or false
        end

        return ret
    end
end
