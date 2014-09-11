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

-- [[ CASTL Math object submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/abs

local Math = {}

local internal = require("castl.internal")
local coreObjects = require("castl.core_objects")

local math, tonumber, time = math, tonumber, os.time
local null = internal.null

_ENV = nil

-- init random
math.randomseed(time())

-- constants
Math.E = math.exp(1)
Math.LN2 = math.log(2)
Math.LN10 = math.log(10)
Math.LOG2E = 1 / math.log(2)
Math.LOG10E = 1 / math.log(10)
Math.PI = math.pi
Math.SQRT1_2 = 1 / math.sqrt(2)
Math.SQRT2 = math.sqrt(2)

-- functions

local san = function(x)
    return ((x == null) and 0 or tonumber(x)) or 0/0
end

Math.abs = function(this, x) return math.abs(san(x)) end
Math.acos = function(this,x) return math.acos(san(x)) end
Math.asin = function(this,x) return math.asin(san(x)) end
Math.atan = function(this,x) return math.atan(san(x)) end
Math.atan2 = function(this,x,y) return math.atan2(san(x),san(y)) end
Math.ceil = function(this,x) return math.ceil(san(x)) end
Math.cos = function(this,x) return math.cos(san(x)) end
Math.exp = function(this,x) return math.exp(san(x)) end
Math.floor = function(this,x) return math.floor(san(x)) end
Math.log = function(this,x) return math.log(san(x)) end
Math.max = function(this,x,y) return math.max(san(x), san(y)) end
Math.min = function(this,x,y) return math.min(san(x), san(y)) end
Math.pow = function(this,x,y) return (san(x) ^ san(y)) end
Math.random = function(this) return math.random() end
Math.round = function(this, x) return math.floor(san(x) + 0.5) end
Math.sin = function(this,x) return math.sin(san(x)) end
Math.sqrt = function(this,x) return math.sqrt(san(x)) end
Math.tan = function(this,x) return math.tan(san(x)) end

return coreObjects.obj(Math)
