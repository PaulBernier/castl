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

local errorHelper = {}

local new
local Error, TypeError, SyntaxError, RangeError, ReferenceError, URIError, EvalError
local require = require

_ENV = nil

local loadError = function()
    new = new or require("castl.core_objects").new
    Error = Error or require("castl.constructor.error.error")
end
local loadTypeError = function()
    new = new or require("castl.core_objects").new
    TypeError = TypeError or require("castl.constructor.error.type_error")
end
local loadSyntaxError = function()
    new = new or require("castl.core_objects").new
    SyntaxError = SyntaxError or require("castl.constructor.error.syntax_error")
end
local loadRangeError = function()
    new = new or require("castl.core_objects").new
    RangeError = RangeError or require("castl.constructor.error.range_error")
end
local loadReferenceError = function()
    new = new or require("castl.core_objects").new
    ReferenceError = ReferenceError or require("castl.constructor.error.reference_error")
end
local loadEvalError = function()
    new = new or require("castl.core_objects").new
    EvalError = EvalError or require("castl.constructor.error.eval_error")
end
local loadURIError = function()
    new = new or require("castl.core_objects").new
    URIError = URIError or require("castl.constructor.error.uri_error")
end

function errorHelper.newError(message)
    loadError()
    return new(Error, message)
end
function errorHelper.newTypeError(message)
    loadTypeError()
    return new(TypeError, message)
end
function errorHelper.newSyntaxError(message)
    loadSyntaxError()
    return new(SyntaxError, message)
end
function errorHelper.newRangeError(message)
    loadRangeError()
    return new(RangeError, message)
end
function errorHelper.newReferenceError(message)
    loadReferenceError()
    return new(ReferenceError, message)
end
function errorHelper.newURIError(message)
    loadURIError()
    return new(URIError, message)
end
function errorHelper.newEvalError(message)
    loadEvalError()
    return new(EvalError, message)
end

return errorHelper
