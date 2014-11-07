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

-- [[ CASTL others submodule]] --

local coreObjects = require("castl.core_objects")

local others = {}
local gsub = string.gsub
local print, type = print, type

_ENV = nil

others.console = coreObjects.obj({
    log = function (self, ...)
        print(...)
    end,
    info = function (self, ...)
        print(...)
    end,
    warn = function (self, ...)
        print(...)
    end,
    error = function (self, ...)
        print(...)
    end,
    dir = function(self, o)
        if type(o) == "string" then
            o = gsub(o, "\\", "\\\\")
            o = gsub(o, "\n", "\\n")
            o = gsub(o, "\r", "\\r")
            o = gsub(o, "\t", "\\t")
            o = gsub(o, "\b", "\\b")
            o = gsub(o, "\f", "\\f")
            o = "'" .. o .. "'";
        end
        print(o)
    end
})

return others
