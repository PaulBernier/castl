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

local jssupport = require("castl.jssupport")
local coreObjects = require("castl.core_objects")
local bit = require("castl.modules.bit")
local others = require("castl.others")
local json = require("castl.json")
local Object = require("castl.constructor.object")
local Function = require("castl.constructor.function")
local Array = require("castl.constructor.array")
local Boolean = require("castl.constructor.boolean")
local Number = require("castl.constructor.number")
local String = require("castl.constructor.string")
local Date = require("castl.constructor.date")
local Error = require("castl.constructor.error")
local RegExp = require("castl.constructor.regexp")
local Math = require("castl.math")
local eval = require("castl.eval")

-- Exported environment
local export = {
    -- jssupport
    _eq = jssupport.equal,
    _add = jssupport.add,
    _bool = jssupport.boolean,
    _type = jssupport.typeof,
    _break = jssupport._break,
    _continue = jssupport._continue,
    _in = jssupport.inOp,
    _with = jssupport.with,
    _void = jssupport.void,
    _e = jssupport.e,
    null = jssupport.null,
    NaN = jssupport.NaN,
    Infinity = jssupport.Infinity,
    isNaN = jssupport.isNaN,
    isFinite = jssupport.isFinite,
    parseFloat = jssupport.parseFloat,
    parseInt = jssupport.parseInt,
    encodeURI = jssupport.encodeURI,
    encodeURIComponent = jssupport.encodeURIComponent,
    decodeURI = jssupport.decodeURI,
    decodeURIComponent = jssupport.decodeURIComponent,
    eval = eval.eval,

    -- core object
    _obj = coreObjects.obj,
    _arr = coreObjects.array,
    _regexp = coreObjects.regexp,
    _args = coreObjects.arguments,
    _new = coreObjects.new,
    _instanceof = coreObjects.instanceof,
    _props = coreObjects.props,
    _tonum = coreObjects.toNumber,
    this = coreObjects.this,

    -- constructors
    Object = Object,
    Function = Function,
    Array = Array,
    Boolean = Boolean,
    Number = Number,
    String = String,
    Date = Date,
    RegExp = RegExp,
    Error = Error,

    -- others
    console = others.console,
    JSON = json,
    Math = Math,
    _bit = bit,

    -- standard library export
    _tostr = tostring,
    _pcall = pcall,
    _throw = error,
    _seq = table.remove
}

if _nodejs then
    local nodejs = require("castl.nodejs")
    export.module = nodejs.module
    export.exports = nodejs.exports
    export.require = nodejs.require
end

return export
