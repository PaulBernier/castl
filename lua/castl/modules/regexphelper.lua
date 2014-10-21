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

local regexHelper = {}

local rex
local require, type = require, type
local regexEngineName = "rex_pcre"

_ENV = nil

regexHelper.getRex = function()
    return rex or require(regexEngineName)
end

regexHelper.getPCRECompilationFlag = function(regexp)
    if regexp.ignoreCase and regexp.multiline then
        return "im"
    elseif regexp.ignoreCase then
        return "i"
    elseif regexp.multiline then
        return "m"
    end

    return nil
end

regexHelper.split = function(subject, regexp)
    rex = rex or require(regexEngineName)

    -- compilation flags
    local cf = regexHelper.getPCRECompilationFlag(regexp)

    return rex.split(subject, regexp.source, cf)
end

-- TODO: it's a hack. maybe I missed something but it's the only way
-- I found to know if second returned argument of rex.split is a capture or only the separator pattern itself
-- http://rrthomas.github.io/lrexlib/manual.html#split
regexHelper.regExpHasCaptures = function(subject, regexp)
    rex = rex or require(regexEngineName)
    local _,_,capture = rex.find(subject, regexp.source)
    return capture
end

regexHelper.gsub = function(subject, regexp, replacer)
    rex = rex or require(regexEngineName)

    -- compilation flags
    local cf = regexHelper.getPCRECompilationFlag(regexp)
    local n = not regexp.global and 1 or nil

    local match = regexp.source

    -- add a global capture to get the entire match
    -- passed to the function
    if type(replacer) == "function" then
        match = "(" .. match .. ")"
    end

    return rex.gsub(subject, match, replacer, n, cf)
end

return regexHelper
