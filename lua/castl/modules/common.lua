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

-- [[ CASTL useful shared code submodule]] --
-- No 'require' dependency

local common = {}

local pairs, getmetatable = pairs, getmetatable
local gsub = string.gsub

_ENV = nil

local magicChars = {
    ["%"] = "%%%%" ,
    ["("] = "%%(" ,
    [")"] = "%%)" ,
    ["."] = "%%." ,
    ["+"] = "%%+" ,
    ["-"] = "%%-" ,
    ["*"] = "%%*" ,
    ["?"] = "%%?" ,
    ["["] = "%%[" ,
    ["]"] = "%%]" ,
    ["$"] = "%%$"}

common.escapeMagicChars = function(str)
    for c,r in pairs(magicChars) do
        str = gsub(str, "%" .. c, r)
    end
    return str
end

-- Handle proper access to __proto__ field of an object
common.prototype_index = function(prototype, key)
    if key == "__proto__" then
        return prototype
    end

    return prototype[key]
end

common.withinNew = function(this, proto)
    local mt = getmetatable(this)
    return mt and mt._prototype == proto
end

return common
