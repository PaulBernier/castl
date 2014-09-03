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

-- [[ CASTL non-core objects submodule]] --

local coreObjects = require("castl.core_objects")
local jssupport = require("castl.jssupport")
local json = require("castl.modules.dkjson")
local others = {}

local error = error
local print = print
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
    end
})

others.JSON = {}

others.JSON.parse = function(this, text)
    local obj, pos, err = json.decode(text, 1, jssupport.null, coreObjects.objectMt, coreObjects.arrayMt)
    if err then
        error("JSON.parse error: " .. err)
    end

    return obj
end

others.JSON.stringify = function(this, value)
    if not value then return nil end
    return json.encode(value)
end

return others
