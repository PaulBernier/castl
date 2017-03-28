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

-- [[ CASTL CallSite constructor submodule]] --

local CallSite

local coreObjects = require("castl.core_objects")
local callSiteProto = require("castl.protos").callSiteProto

_ENV = nil

CallSite = coreObjects.func(function(this, receiver, fun, pos, strict_mode)
    this.receiver = receiver
    this.fun = fun
    this.pos = pos
end)

CallSite.prototype = callSiteProto
callSiteProto.constructor = CallSite

return CallSite
