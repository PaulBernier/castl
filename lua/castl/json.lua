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
local internal = require("castl.internal")
local json = require("castl.modules.dkjson")
local errorHelper = require("castl.modules.error_helper")
local throw = require("castl.jssupport").throw

local null, ToString = internal.null, internal.ToString

local JSON = {}

_ENV = nil

JSON.parse = function(this, text)
    text = ToString(text)
    local obj, pos, err = json.decode(text, 1, null, coreObjects.objectMt, coreObjects.arrayMt)
    if err then
        throw(errorHelper.newSyntaxError(err))
    end

    return obj
end

JSON.stringify = function(this, value)
    if value == nil then return nil end
    return json.encode(value)
end

return JSON
