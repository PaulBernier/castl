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

local castl, esprima, runtime
local luajit = jit ~= nil

local eval = {}
local errorHelper = require("castl.modules.error_helper")
local throw = require("castl.jssupport").throw

local debug, setmetatable, assert, load, require, type = debug, setmetatable, assert, load, require, type

_ENV = nil

-- http://stackoverflow.com/a/2835433/1120148
local locals = function(level)
    local variables = {}
    local idx = 1
    while true do
        local ln, lv = debug.getlocal(level, idx)
        if ln ~= nil then
            if lv ~= nil then
                variables[ln] = lv
            else
                variables[ln] = 0
            end
        else
            break
        end
        idx = 1 + idx
    end
    return variables
end

local upvalues = function(level)
    local variables = {}
    local idx = 1
    local func = debug.getinfo(level, "f").func
    while true do
        local ln, lv = debug.getupvalue(func, idx)
        if ln ~= nil then
            if lv ~= nil then
                variables[ln] = lv
            else
                variables[ln] = 0
            end
        else
            break
        end
        idx = 1 + idx
    end
    return variables
end

local getEvalENV = function(locals, upvalues, globals)
    return setmetatable({},{
        __index = function(self, key)
            if locals[key] ~= nil then
                return locals[key]
            elseif upvalues[key] ~= nil then
                return upvalues[key]
            else
                return globals[key]
            end
        end,
        __newindex = function(self, key, value)
            if locals[key] ~= nil then
                locals[key] = value
            elseif upvalues[key] ~= nil then
                upvalues[key] = value
            else
                globals[key] = value
            end
        end
    })
end

local evalLuaString = function(str, _G)
    local level = 4

    -- collect locals and upvalues
    local _l = locals(level)
    local _u = upvalues(level)
    local _evalENV = getEvalENV(_l, _u, _G)

    -- eval lua code
    local evaluated = assert(load(str, nil, "t", _evalENV))
    local last, beforeLast
    local catch = function()
        beforeLast = last
        local _, v = debug.getlocal(2, 1)
        last = v
    end

    -- catch the last return
    debug.sethook(catch, "r")
    evaluated()
    debug.sethook()

    -- set upvalues
    local _idx = 1
    local _func = debug.getinfo(level - 1, "f").func
    while true do
        local ln = debug.getupvalue(_func, _idx)
        if ln ~= nil then
            if ln ~= "(*temporary)" and _u[ln] ~= nil then
                debug.setupvalue(_func, _idx, _u[ln])
            end

        else
            break
        end
        _idx = 1 + _idx
    end

    -- set locals
    _idx = 1
    while true do
        local ln = debug.getlocal(level - 1, _idx)
        if ln ~= nil then
            if ln ~= "(*temporary)" and _l[ln] ~= nil then
                debug.setlocal(level - 1, _idx, _l[ln])
            end
        else
            break
        end
        _idx = 1 + _idx
    end

    return beforeLast
end

function eval.eval(this, str)
    if type(str) ~= "string" then
        return str
    end

    if luajit then
        castl = castl or require("castl.jscompile.castl_jit")
        esprima = esprima or require("castl.jscompile.esprima_jit")
    else
        castl = castl or require("castl.jscompile.castl")
        esprima = esprima or require("castl.jscompile.esprima")
    end

    -- parse and compile JS code
    local ast = esprima:parse(str)
    -- castl used in eval mode
    local castlOptions = {jit = luajit, evalMode = true}
    local castlResult = castl:compileAST(ast, castlOptions)
    local ret

    if castlResult.success then
        local luaCode = castlResult.compiled
        runtime = runtime or require("castl.runtime")
        ret = evalLuaString(luaCode, runtime)
    else
        throw(errorHelper.newEvalError("Eval(): Failed to compile AST to Lua code"))
    end

    return ret
end

return eval
