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

-- [[ CASTL Function constructor submodule]] --
-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function

local esprima, castl, runtime

local jssupport = require("castl.jssupport")
local coreObjects = require("castl.core_objects")
local functionProto = require("castl.prototype.function")

local Function

local setmetatable, error, pack, require, assert, load, tinsert, concat = setmetatable, error, table.pack, require, assert, load, table.insert, table.concat

_ENV = nil

Function = function(this, ...)
    if ... then
        local args = pack(...)
        local body = args[args.n]

        -- parse body of the function in error-tolerant mode
        esprima = esprima or require("castl.jscompile.esprima")
        local options = coreObjects.obj({tolerant = true})
        local ast = esprima:parse(body, options)

        -- get the params
        local params = {"local this"}
        for i = 1, args.n - 1 do
            tinsert(params, ",")
            tinsert(params, args[i])
        end
        tinsert(params, " = ...;\n")

        -- compile the ast
        castl = castl or require("castl.jscompile.castl")
        local castResult = castl:compileAST(ast)

        local compiledFunction
        if castResult.success then
            local luaCode = concat(params) .. castResult.compiled
            -- eval lua code
            runtime = runtime or require("castl.runtime")
            compiledFunction = assert(load(luaCode, nil, "t", runtime))
        else
            error("Function(): Failed to compile AST to Lua code")
        end

        return compiledFunction
    end

    return function () end
end

Function.prototype = functionProto
functionProto.constructor = Function

return Function
