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

-- [[ CASTL NodeJS basic support submodule]] --

local nodejs = {}

local coreObject = require("castl.core_objects")
local require = require

local package = package
local find, sub, len = string.find, string.sub, string.len

_ENV = nil

nodejs.require = function(this, packagename)
    local index = find(packagename, "/[^/]*$")
    if index then
        local path = sub(packagename, 1, index)
        local file = sub(packagename, index + 1)
        if sub(file, -3) == ".js" then
            file = sub(file, 1, len(file) - 3)
        end
        package.path = package.path .. ";" .. path .. "?.lua"
        package.path = package.path .. ";" .. path .. "?.js.lua"
        return require(file)
    end

    return require(packagename)
end

return nodejs
