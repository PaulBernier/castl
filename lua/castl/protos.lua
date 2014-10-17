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

local protos = {}

-- forward declaration
protos.arrayProto = {}
protos.booleanProto = {}
protos.dateProto = {}
protos.functionProto = {}
protos.numberProto = {}
protos.objectProto = {}
protos.regexpProto = {}
protos.stringProto = {}

protos.errorProto = {}
protos.rangeErrorProto = {}
protos.referenceErrorProto = {}
protos.syntaxErrorProto = {}
protos.typeErrorProto = {}
protos.evalErrorProto = {}
protos.uriErrorProto = {}
protos.callSiteProto = {}

-- load definition
protos.loadPrototypesDefinition = function()
    require("castl.prototype.array")(protos.arrayProto)
    require("castl.prototype.boolean")(protos.booleanProto)
    require("castl.prototype.date")(protos.dateProto)
    require("castl.prototype.function")(protos.functionProto)
    require("castl.prototype.number")(protos.numberProto)
    require("castl.prototype.object")(protos.objectProto)
    require("castl.prototype.regexp")(protos.regexpProto)
    require("castl.prototype.string")(protos.stringProto)

    require("castl.prototype.error.error")(protos.errorProto)
    require("castl.prototype.error.range_error")(protos.rangeErrorProto)
    require("castl.prototype.error.reference_error")(protos.referenceErrorProto)
    require("castl.prototype.error.syntax_error")(protos.syntaxErrorProto)
    require("castl.prototype.error.type_error")(protos.typeErrorProto)
    require("castl.prototype.error.eval_error")(protos.evalErrorProto)
    require("castl.prototype.error.uri_error")(protos.uriErrorProto)
    require("castl.prototype.error.call_site")(protos.callSiteProto)
end

return protos
