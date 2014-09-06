local _ENV = require("castl.runtime");
(function (this, root, factory)
_e("use strict");
if _bool(((_type(define) == "function") and define.amd)) then
define(_ENV,_arr({[0]="exports"},1),factory);
elseif _bool((_type(exports) ~= "undefined")) then
factory(_ENV,exports);
else
factory(_ENV,(function () local _tmp = _obj({

}); root.esprima  = _tmp; return _tmp; end)());
end

end)(_ENV,this,(function (this, exports)
local parse,tokenize,filterTokenLocation,parseProgram,parseSourceElements,parseSourceElement,parseFunctionExpression,parseFunctionDeclaration,parseParams,parseFunctionSourceElements,parseStatement,parseDebuggerStatement,parseTryStatement,parseCatchClause,parseThrowStatement,parseSwitchStatement,parseSwitchCase,parseWithStatement,parseReturnStatement,parseBreakStatement,parseContinueStatement,parseForStatement,parseForVariableDeclaration,parseWhileStatement,parseDoWhileStatement,parseIfStatement,parseExpressionStatement,parseEmptyStatement,parseConstLetDeclaration,parseVariableStatement,parseVariableDeclarationList,parseVariableDeclaration,parseVariableIdentifier,parseBlock,parseStatementList,parseExpression,parseAssignmentExpression,parseConditionalExpression,parseBinaryExpression,binaryPrecedence,parseUnaryExpression,parsePostfixExpression,parseLeftHandSideExpression,parseLeftHandSideExpressionAllowCall,parseNewExpression,parseComputedMember,parseNonComputedMember,parseNonComputedProperty,parseArguments,parsePrimaryExpression,parseGroupExpression,parseObjectInitialiser,parseObjectProperty,parseObjectPropertyKey,parsePropertyFunction,parseArrayInitialiser,isLeftHandSide,consumeSemicolon,matchAssign,matchKeyword,match,expectKeyword,expect,throwUnexpected,throwErrorTolerant,throwError,peekLineTerminator,SourceLocation,Position,peek,lex,collectToken,advance,advanceSlash,isIdentifierName,collectRegex,scanRegExp,scanRegExpFlags,scanRegExpBody,testRegExp,scanStringLiteral,scanNumericLiteral,scanOctalLiteral,scanHexLiteral,scanPunctuator,scanIdentifier,getIdentifier,getEscapedIdentifier,scanHexEscape,skipComment,skipMultiLineComment,skipSingleLineComment,addComment,isKeyword,isRestrictedWord,isStrictModeReservedWord,isFutureReservedWord,isIdentifierPart,isIdentifierStart,isLineTerminator,isWhiteSpace,isOctalDigit,isHexDigit,isDecimalDigit,assert,extra,state,lookahead,delegate,length,lineStart,lineNumber,index,strict,source,SyntaxTreeDelegate,Regex,Messages,PropertyKind,Syntax,FnExprTokens,TokenName,Token;
assert = (function (this, condition, message)
if _bool(not _bool(condition)) then
_throw(_new(Error,(_add("ASSERT: ",message))),0)
end

end)
isDecimalDigit = (function (this, ch)
 do return ((ch >= 48) and (ch <= 57)); end
end)
isHexDigit = (function (this, ch)
 do return (("0123456789abcdefABCDEF"):indexOf(ch) >= 0); end
end)
isOctalDigit = (function (this, ch)
 do return (("01234567"):indexOf(ch) >= 0); end
end)
isWhiteSpace = (function (this, ch)
 do return ((((((ch == 32) or (ch == 9)) or (ch == 11)) or (ch == 12)) or (ch == 160)) or ((ch >= 5760) and (_arr({[0]=5760,6158,8192,8193,8194,8195,8196,8197,8198,8199,8200,8201,8202,8239,8287,12288,65279},17):indexOf(ch) >= 0))); end
end)
isLineTerminator = (function (this, ch)
 do return ((((ch == 10) or (ch == 13)) or (ch == 8232)) or (ch == 8233)); end
end)
isIdentifierStart = (function (this, ch)
 do return ((((((ch == 36) or (ch == 95)) or ((ch >= 65) and (ch <= 90))) or ((ch >= 97) and (ch <= 122))) or (ch == 92)) or ((ch >= 128) and Regex.NonAsciiIdentifierStart:test(String:fromCharCode(ch)))); end
end)
isIdentifierPart = (function (this, ch)
 do return (((((((ch == 36) or (ch == 95)) or ((ch >= 65) and (ch <= 90))) or ((ch >= 97) and (ch <= 122))) or ((ch >= 48) and (ch <= 57))) or (ch == 92)) or ((ch >= 128) and Regex.NonAsciiIdentifierPart:test(String:fromCharCode(ch)))); end
end)
isFutureReservedWord = (function (this, id)
repeat
local _into = false;
local _cases = {["class"] = true,["enum"] = true,["export"] = true,["extends"] = true,["import"] = true,["super"] = true};
if (not _cases[id]) then
_into = true;
goto _default
end
if _into or (id == "class") then

_into = true;
end
if _into or (id == "enum") then

_into = true;
end
if _into or (id == "export") then

_into = true;
end
if _into or (id == "extends") then

_into = true;
end
if _into or (id == "import") then

_into = true;
end
if _into or (id == "super") then
 do return true; end
_into = true;
end
::_default::
if _into then
 do return false; end
_into = true;
end
until true
end)
isStrictModeReservedWord = (function (this, id)
repeat
local _into = false;
local _cases = {["implements"] = true,["interface"] = true,["package"] = true,["private"] = true,["protected"] = true,["public"] = true,["static"] = true,["yield"] = true,["let"] = true};
if (not _cases[id]) then
_into = true;
goto _default
end
if _into or (id == "implements") then

_into = true;
end
if _into or (id == "interface") then

_into = true;
end
if _into or (id == "package") then

_into = true;
end
if _into or (id == "private") then

_into = true;
end
if _into or (id == "protected") then

_into = true;
end
if _into or (id == "public") then

_into = true;
end
if _into or (id == "static") then

_into = true;
end
if _into or (id == "yield") then

_into = true;
end
if _into or (id == "let") then
 do return true; end
_into = true;
end
::_default::
if _into then
 do return false; end
_into = true;
end
until true
end)
isRestrictedWord = (function (this, id)
 do return ((id == "eval") or (id == "arguments")); end
end)
isKeyword = (function (this, id)
if _bool((strict and isStrictModeReservedWord(_ENV,id))) then
 do return true; end
end

repeat
local _into = false;
local _cases = {[2] = true,[3] = true,[4] = true,[5] = true,[6] = true,[7] = true,[8] = true,[10] = true};
if (not _cases[id.length]) then
_into = true;
goto _default
end
if _into or (id.length == 2) then
 do return (((id == "if") or (id == "in")) or (id == "do")); end
_into = true;
end
if _into or (id.length == 3) then
 do return (((((id == "var") or (id == "for")) or (id == "new")) or (id == "try")) or (id == "let")); end
_into = true;
end
if _into or (id.length == 4) then
 do return ((((((id == "this") or (id == "else")) or (id == "case")) or (id == "void")) or (id == "with")) or (id == "enum")); end
_into = true;
end
if _into or (id.length == 5) then
 do return ((((((((id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) or (id == "const")) or (id == "yield")) or (id == "class")) or (id == "super")); end
_into = true;
end
if _into or (id.length == 6) then
 do return ((((((id == "return") or (id == "typeof")) or (id == "delete")) or (id == "switch")) or (id == "export")) or (id == "import")); end
_into = true;
end
if _into or (id.length == 7) then
 do return (((id == "default") or (id == "finally")) or (id == "extends")); end
_into = true;
end
if _into or (id.length == 8) then
 do return (((id == "function") or (id == "continue")) or (id == "debugger")); end
_into = true;
end
if _into or (id.length == 10) then
 do return (id == "instanceof"); end
_into = true;
end
::_default::
if _into then
 do return false; end
_into = true;
end
until true
end)
addComment = (function (this, type, value, start, _g_end, loc)
local attacher,comment;
assert(_ENV,(_type(start) == "number"),"Comment must have valid position");
if _bool((state.lastCommentStart >= start)) then
do return end
end

_e((function () local _tmp = start; state.lastCommentStart  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["type"] = type,
["value"] = value
}); comment  = _tmp; return _tmp; end)());
if _bool(extra.range) then
_e((function () local _tmp = _arr({[0]=start,_g_end},2); comment.range  = _tmp; return _tmp; end)());
end

if _bool(extra.loc) then
_e((function () local _tmp = loc; comment.loc  = _tmp; return _tmp; end)());
end

extra.comments:push(comment);
if _bool(extra.attachComment) then
extra.leadingComments:push(comment);
extra.trailingComments:push(comment);
end

end)
skipSingleLineComment = (function (this, offset)
local comment,ch,loc,start;
_e((function () local _tmp = (index - offset); start  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["start"] = _obj({
["line"] = lineNumber,
["column"] = ((index - lineStart) - offset)
})
}); loc  = _tmp; return _tmp; end)());
while _bool((index < length)) do
_e((function () local _tmp = source:charCodeAt(index); ch  = _tmp; return _tmp; end)());
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
if _bool(isLineTerminator(_ENV,ch)) then
if _bool(extra.comments) then
_e((function () local _tmp = source:slice((_add(start,offset)),(index - 1)); comment  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["line"] = lineNumber,
["column"] = ((index - lineStart) - 1)
}); loc["end"]  = _tmp; return _tmp; end)());
addComment(_ENV,"Line",comment,start,(index - 1),loc);
end

if _bool(((ch == 13) and (source:charCodeAt(index) == 10))) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
end

_e((function () local _tmp = _add(lineNumber, 1); lineNumber = _tmp; return _tmp; end)());
_e((function () local _tmp = index; lineStart  = _tmp; return _tmp; end)());
do return end
end

::_continue::
end

if _bool(extra.comments) then
_e((function () local _tmp = source:slice((_add(start,offset)),index); comment  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
}); loc["end"]  = _tmp; return _tmp; end)());
addComment(_ENV,"Line",comment,start,index,loc);
end

end)
skipMultiLineComment = (function (this)
local comment,ch,loc,start;
if _bool(extra.comments) then
_e((function () local _tmp = (index - 2); start  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["start"] = _obj({
["line"] = lineNumber,
["column"] = ((index - lineStart) - 2)
})
}); loc  = _tmp; return _tmp; end)());
end

while _bool((index < length)) do
_e((function () local _tmp = source:charCodeAt(index); ch  = _tmp; return _tmp; end)());
if _bool(isLineTerminator(_ENV,ch)) then
if _bool(((ch == 13) and (source:charCodeAt((_add(index,1))) == 10))) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
end

_e((function () local _tmp = _add(lineNumber, 1); lineNumber = _tmp; return _tmp; end)());
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = index; lineStart  = _tmp; return _tmp; end)());
if _bool((index >= length)) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

elseif _bool((ch == 42)) then
if _bool((source:charCodeAt((_add(index,1))) == 47)) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
if _bool(extra.comments) then
_e((function () local _tmp = source:slice((_add(start,2)),(index - 2)); comment  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
}); loc["end"]  = _tmp; return _tmp; end)());
addComment(_ENV,"Block",comment,start,index,loc);
end

do return end
end

_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
else
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
end

::_continue::
end

throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end)
skipComment = (function (this)
local start,ch;
_e((function () local _tmp = (index == 0); start  = _tmp; return _tmp; end)());
while _bool((index < length)) do
_e((function () local _tmp = source:charCodeAt(index); ch  = _tmp; return _tmp; end)());
if _bool(isWhiteSpace(_ENV,ch)) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
elseif _bool(isLineTerminator(_ENV,ch)) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
if _bool(((ch == 13) and (source:charCodeAt(index) == 10))) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
end

_e((function () local _tmp = _add(lineNumber, 1); lineNumber = _tmp; return _tmp; end)());
_e((function () local _tmp = index; lineStart  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; start  = _tmp; return _tmp; end)());
elseif _bool((ch == 47)) then
_e((function () local _tmp = source:charCodeAt((_add(index,1))); ch  = _tmp; return _tmp; end)());
if _bool((ch == 47)) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
skipSingleLineComment(_ENV,2);
_e((function () local _tmp = true; start  = _tmp; return _tmp; end)());
elseif _bool((ch == 42)) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
skipMultiLineComment(_ENV);
else
break;
end

elseif _bool((start and (ch == 45))) then
if _bool(((source:charCodeAt((_add(index,1))) == 45) and (source:charCodeAt((_add(index,2))) == 62))) then
_e((function () local _tmp = (_add(index,3)); index  = _tmp; return _tmp; end)());
skipSingleLineComment(_ENV,3);
else
break;
end

elseif _bool((ch == 60)) then
if _bool((source:slice((_add(index,1)),(_add(index,4))) == "!--")) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
skipSingleLineComment(_ENV,4);
else
break;
end

else
break;
end

::_continue::
end

end)
scanHexEscape = (function (this, prefix)
local code,ch,len,i;
code = 0;
_e((function () local _tmp = (_bool((prefix == "u")) and {4} or {2})[1]; len  = _tmp; return _tmp; end)());
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < len)) do
if _bool(((index < length) and isHexDigit(_ENV,source[index]))) then
_e((function () local _tmp = source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()]; ch  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add((code * 16),("0123456789abcdef"):indexOf(ch:toLowerCase()))); code  = _tmp; return _tmp; end)());
else
 do return ""; end
end

_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

 do return String:fromCharCode(code); end
end)
getEscapedIdentifier = (function (this)
local id,ch;
_e((function () local _tmp = source:charCodeAt((function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()); ch  = _tmp; return _tmp; end)());
_e((function () local _tmp = String:fromCharCode(ch); id  = _tmp; return _tmp; end)());
if _bool((ch == 92)) then
if _bool((source:charCodeAt(index) ~= 117)) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = scanHexEscape(_ENV,"u"); ch  = _tmp; return _tmp; end)());
if _bool(((not _bool(ch) or (ch == "\\")) or not _bool(isIdentifierStart(_ENV,ch:charCodeAt(0))))) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

_e((function () local _tmp = ch; id  = _tmp; return _tmp; end)());
end

while _bool((index < length)) do
_e((function () local _tmp = source:charCodeAt(index); ch  = _tmp; return _tmp; end)());
if _bool(not _bool(isIdentifierPart(_ENV,ch))) then
break;
end

_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(id,String:fromCharCode(ch))); id  = _tmp; return _tmp; end)());
if _bool((ch == 92)) then
_e((function () local _tmp = id:substr(0,(id.length - 1)); id  = _tmp; return _tmp; end)());
if _bool((source:charCodeAt(index) ~= 117)) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = scanHexEscape(_ENV,"u"); ch  = _tmp; return _tmp; end)());
if _bool(((not _bool(ch) or (ch == "\\")) or not _bool(isIdentifierPart(_ENV,ch:charCodeAt(0))))) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

_e((function () local _tmp = (_add(id,ch)); id  = _tmp; return _tmp; end)());
end

::_continue::
end

 do return id; end
end)
getIdentifier = (function (this)
local ch,start;
_e((function () local _tmp = (function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)(); start  = _tmp; return _tmp; end)());
while _bool((index < length)) do
_e((function () local _tmp = source:charCodeAt(index); ch  = _tmp; return _tmp; end)());
if _bool((ch == 92)) then
_e((function () local _tmp = start; index  = _tmp; return _tmp; end)());
 do return getEscapedIdentifier(_ENV); end
end

if _bool(isIdentifierPart(_ENV,ch)) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
else
break;
end

::_continue::
end

 do return source:slice(start,index); end
end)
scanIdentifier = (function (this)
local type,id,start;
_e((function () local _tmp = index; start  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_bool((source:charCodeAt(index) == 92)) and {getEscapedIdentifier(_ENV)} or {getIdentifier(_ENV)})[1]; id  = _tmp; return _tmp; end)());
if _bool((id.length == 1)) then
_e((function () local _tmp = Token.Identifier; type  = _tmp; return _tmp; end)());
elseif _bool(isKeyword(_ENV,id)) then
_e((function () local _tmp = Token.Keyword; type  = _tmp; return _tmp; end)());
elseif _bool((id == "null")) then
_e((function () local _tmp = Token.NullLiteral; type  = _tmp; return _tmp; end)());
elseif _bool(((id == "true") or (id == "false"))) then
_e((function () local _tmp = Token.BooleanLiteral; type  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = Token.Identifier; type  = _tmp; return _tmp; end)());
end

 do return _obj({
["type"] = type,
["value"] = id,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end)
scanPunctuator = (function (this)
local ch4,ch3,ch2,ch1,code2,code,start;
start = index;
code = source:charCodeAt(index);
ch1 = source[index];
repeat
local _into = false;
local _cases = {[46] = true,[40] = true,[41] = true,[59] = true,[44] = true,[123] = true,[125] = true,[91] = true,[93] = true,[58] = true,[63] = true,[126] = true};
if (not _cases[code]) then
_into = true;
goto _default
end
if _into or (code == 46) then

_into = true;
end
if _into or (code == 40) then

_into = true;
end
if _into or (code == 41) then

_into = true;
end
if _into or (code == 59) then

_into = true;
end
if _into or (code == 44) then

_into = true;
end
if _into or (code == 123) then

_into = true;
end
if _into or (code == 125) then

_into = true;
end
if _into or (code == 91) then

_into = true;
end
if _into or (code == 93) then

_into = true;
end
if _into or (code == 58) then

_into = true;
end
if _into or (code == 63) then

_into = true;
end
if _into or (code == 126) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
if _bool(extra.tokenize) then
if _bool((code == 40)) then
_e((function () local _tmp = extra.tokens.length; extra.openParenToken  = _tmp; return _tmp; end)());
elseif _bool((code == 123)) then
_e((function () local _tmp = extra.tokens.length; extra.openCurlyToken  = _tmp; return _tmp; end)());
end

end

 do return _obj({
["type"] = Token.Punctuator,
["value"] = String:fromCharCode(code),
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
_into = true;
end
::_default::
if _into then
_e((function () local _tmp = source:charCodeAt((_add(index,1))); code2  = _tmp; return _tmp; end)());
if _bool((code2 == 61)) then
repeat
local _into = false;
local _cases = {[43] = true,[45] = true,[47] = true,[60] = true,[62] = true,[94] = true,[124] = true,[37] = true,[38] = true,[42] = true,[33] = true,[61] = true};
if (not _cases[code]) then
_into = true;
goto _default
end
if _into or (code == 43) then

_into = true;
end
if _into or (code == 45) then

_into = true;
end
if _into or (code == 47) then

_into = true;
end
if _into or (code == 60) then

_into = true;
end
if _into or (code == 62) then

_into = true;
end
if _into or (code == 94) then

_into = true;
end
if _into or (code == 124) then

_into = true;
end
if _into or (code == 37) then

_into = true;
end
if _into or (code == 38) then

_into = true;
end
if _into or (code == 42) then
_e((function () local _tmp = (_add(index,2)); index  = _tmp; return _tmp; end)());
 do return _obj({
["type"] = Token.Punctuator,
["value"] = (_add(String:fromCharCode(code),String:fromCharCode(code2))),
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
_into = true;
end
if _into or (code == 33) then

_into = true;
end
if _into or (code == 61) then
_e((function () local _tmp = (_add(index,2)); index  = _tmp; return _tmp; end)());
if _bool((source:charCodeAt(index) == 61)) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
end

 do return _obj({
["type"] = Token.Punctuator,
["value"] = source:slice(start,index),
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
_into = true;
end
::_default::
until true
end

_into = true;
end
until true
_e((function () local _tmp = source:substr(index,4); ch4  = _tmp; return _tmp; end)());
if _bool((ch4 == ">>>=")) then
_e((function () local _tmp = (_add(index,4)); index  = _tmp; return _tmp; end)());
 do return _obj({
["type"] = Token.Punctuator,
["value"] = ch4,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end

_e((function () local _tmp = ch4:substr(0,3); ch3  = _tmp; return _tmp; end)());
if _bool((((ch3 == ">>>") or (ch3 == "<<=")) or (ch3 == ">>="))) then
_e((function () local _tmp = (_add(index,3)); index  = _tmp; return _tmp; end)());
 do return _obj({
["type"] = Token.Punctuator,
["value"] = ch3,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end

_e((function () local _tmp = ch3:substr(0,2); ch2  = _tmp; return _tmp; end)());
if _bool((((ch1 == ch2[1]) and (("+-<>&|"):indexOf(ch1) >= 0)) or (ch2 == "=>"))) then
_e((function () local _tmp = (_add(index,2)); index  = _tmp; return _tmp; end)());
 do return _obj({
["type"] = Token.Punctuator,
["value"] = ch2,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end

if _bool((("<>=!+-*%&|^/"):indexOf(ch1) >= 0)) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
 do return _obj({
["type"] = Token.Punctuator,
["value"] = ch1,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end

throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end)
scanHexLiteral = (function (this, start)
local number;
number = "";
while _bool((index < length)) do
if _bool(not _bool(isHexDigit(_ENV,source[index]))) then
break;
end

_e((function () local _tmp = (_add(number,source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()])); number  = _tmp; return _tmp; end)());
::_continue::
end

if _bool((number.length == 0)) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

if _bool(isIdentifierStart(_ENV,source:charCodeAt(index))) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

 do return _obj({
["type"] = Token.NumericLiteral,
["value"] = parseInt(_ENV,(_add("0x",number)),16),
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end)
scanOctalLiteral = (function (this, start)
local number;
number = (_add("0",source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()]));
while _bool((index < length)) do
if _bool(not _bool(isOctalDigit(_ENV,source[index]))) then
break;
end

_e((function () local _tmp = (_add(number,source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()])); number  = _tmp; return _tmp; end)());
::_continue::
end

if _bool((isIdentifierStart(_ENV,source:charCodeAt(index)) or isDecimalDigit(_ENV,source:charCodeAt(index)))) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

 do return _obj({
["type"] = Token.NumericLiteral,
["value"] = parseInt(_ENV,number,8),
["octal"] = true,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end)
scanNumericLiteral = (function (this)
local ch,start,number;
_e((function () local _tmp = source[index]; ch  = _tmp; return _tmp; end)());
assert(_ENV,(isDecimalDigit(_ENV,ch:charCodeAt(0)) or (ch == ".")),"Numeric literal must start with a decimal digit or a decimal point");
_e((function () local _tmp = index; start  = _tmp; return _tmp; end)());
_e((function () local _tmp = ""; number  = _tmp; return _tmp; end)());
if _bool((ch ~= ".")) then
_e((function () local _tmp = source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()]; number  = _tmp; return _tmp; end)());
_e((function () local _tmp = source[index]; ch  = _tmp; return _tmp; end)());
if _bool((number == "0")) then
if _bool(((ch == "x") or (ch == "X"))) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
 do return scanHexLiteral(_ENV,start); end
end

if _bool(isOctalDigit(_ENV,ch)) then
 do return scanOctalLiteral(_ENV,start); end
end

if _bool((ch and isDecimalDigit(_ENV,ch:charCodeAt(0)))) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

end

while _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) do
_e((function () local _tmp = (_add(number,source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()])); number  = _tmp; return _tmp; end)());
::_continue::
end

_e((function () local _tmp = source[index]; ch  = _tmp; return _tmp; end)());
end

if _bool((ch == ".")) then
_e((function () local _tmp = (_add(number,source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()])); number  = _tmp; return _tmp; end)());
while _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) do
_e((function () local _tmp = (_add(number,source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()])); number  = _tmp; return _tmp; end)());
::_continue::
end

_e((function () local _tmp = source[index]; ch  = _tmp; return _tmp; end)());
end

if _bool(((ch == "e") or (ch == "E"))) then
_e((function () local _tmp = (_add(number,source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()])); number  = _tmp; return _tmp; end)());
_e((function () local _tmp = source[index]; ch  = _tmp; return _tmp; end)());
if _bool(((ch == "+") or (ch == "-"))) then
_e((function () local _tmp = (_add(number,source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()])); number  = _tmp; return _tmp; end)());
end

if _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) then
while _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) do
_e((function () local _tmp = (_add(number,source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()])); number  = _tmp; return _tmp; end)());
::_continue::
end

else
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

end

if _bool(isIdentifierStart(_ENV,source:charCodeAt(index))) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

 do return _obj({
["type"] = Token.NumericLiteral,
["value"] = parseFloat(_ENV,number),
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end)
scanStringLiteral = (function (this)
local startLineStart,startLineNumber,octal,restore,unescaped,code,ch,start,quote,str;
str = "";
octal = false;
_e((function () local _tmp = lineNumber; startLineNumber  = _tmp; return _tmp; end)());
_e((function () local _tmp = lineStart; startLineStart  = _tmp; return _tmp; end)());
_e((function () local _tmp = source[index]; quote  = _tmp; return _tmp; end)());
assert(_ENV,((quote == "'") or (quote == "\"")),"String literal must starts with a quote");
_e((function () local _tmp = index; start  = _tmp; return _tmp; end)());
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
while _bool((index < length)) do
_e((function () local _tmp = source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()]; ch  = _tmp; return _tmp; end)());
if _bool((ch == quote)) then
_e((function () local _tmp = ""; quote  = _tmp; return _tmp; end)());
break;
elseif _bool((ch == "\\")) then
_e((function () local _tmp = source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()]; ch  = _tmp; return _tmp; end)());
if _bool((not _bool(ch) or not _bool(isLineTerminator(_ENV,ch:charCodeAt(0))))) then
repeat
local _into = false;
local _cases = {["u"] = true,["x"] = true,["n"] = true,["r"] = true,["t"] = true,["b"] = true,["f"] = true,["v"] = true};
if (not _cases[ch]) then
_into = true;
goto _default
end
if _into or (ch == "u") then

_into = true;
end
if _into or (ch == "x") then
_e((function () local _tmp = index; restore  = _tmp; return _tmp; end)());
_e((function () local _tmp = scanHexEscape(_ENV,ch); unescaped  = _tmp; return _tmp; end)());
if _bool(unescaped) then
_e((function () local _tmp = (_add(str,unescaped)); str  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = restore; index  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(str,ch)); str  = _tmp; return _tmp; end)());
end

break;
_into = true;
end
if _into or (ch == "n") then
_e((function () local _tmp = (_add(str,"\10")); str  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (ch == "r") then
_e((function () local _tmp = (_add(str,"\13")); str  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (ch == "t") then
_e((function () local _tmp = (_add(str,"\9")); str  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (ch == "b") then
_e((function () local _tmp = (_add(str,"\8")); str  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (ch == "f") then
_e((function () local _tmp = (_add(str,"\12")); str  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (ch == "v") then
_e((function () local _tmp = (_add(str,"\11")); str  = _tmp; return _tmp; end)());
break;
_into = true;
end
::_default::
if _into then
if _bool(isOctalDigit(_ENV,ch)) then
_e((function () local _tmp = ("01234567"):indexOf(ch); code  = _tmp; return _tmp; end)());
if _bool((code ~= 0)) then
_e((function () local _tmp = true; octal  = _tmp; return _tmp; end)());
end

if _bool(((index < length) and isOctalDigit(_ENV,source[index]))) then
_e((function () local _tmp = true; octal  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add((code * 8),("01234567"):indexOf(source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()]))); code  = _tmp; return _tmp; end)());
if _bool((((("0123"):indexOf(ch) >= 0) and (index < length)) and isOctalDigit(_ENV,source[index]))) then
_e((function () local _tmp = (_add((code * 8),("01234567"):indexOf(source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()]))); code  = _tmp; return _tmp; end)());
end

end

_e((function () local _tmp = (_add(str,String:fromCharCode(code))); str  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = (_add(str,ch)); str  = _tmp; return _tmp; end)());
end

break;
_into = true;
end
until true
else
_e((function () local _tmp = _add(lineNumber, 1); lineNumber = _tmp; return _tmp; end)());
if _bool(((ch == "\13") and (source[index] == "\10"))) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
end

_e((function () local _tmp = index; lineStart  = _tmp; return _tmp; end)());
end

elseif _bool(isLineTerminator(_ENV,ch:charCodeAt(0))) then
break;
else
_e((function () local _tmp = (_add(str,ch)); str  = _tmp; return _tmp; end)());
end

::_continue::
end

if _bool((quote ~= "")) then
throwError(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

 do return _obj({
["type"] = Token.StringLiteral,
["value"] = str,
["octal"] = octal,
["startLineNumber"] = startLineNumber,
["startLineStart"] = startLineStart,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end)
testRegExp = (function (this, pattern, flags)
local value;
local _status, _return = _pcall(function()
_e((function () local _tmp = _new(RegExp,pattern,flags); value  = _tmp; return _tmp; end)());
end);
if not _status then
local _cstatus, _creturn = _pcall(function()
local e = _return;
throwError(_ENV,_obj({

}),Messages.InvalidRegExp);
end);
if _cstatus then
else _throw(_creturn,0); end
end

 do return value; end
end)
scanRegExpBody = (function (this)
local body,terminated,classMarker,str,ch;
_e((function () local _tmp = source[index]; ch  = _tmp; return _tmp; end)());
assert(_ENV,(ch == "/"),"Regular expression literal must start with a slash");
_e((function () local _tmp = source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()]; str  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; classMarker  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; terminated  = _tmp; return _tmp; end)());
while _bool((index < length)) do
_e((function () local _tmp = source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()]; ch  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(str,ch)); str  = _tmp; return _tmp; end)());
if _bool((ch == "\\")) then
_e((function () local _tmp = source[(function () local _tmp = index; index = _add(_tmp, 1); return _tmp; end)()]; ch  = _tmp; return _tmp; end)());
if _bool(isLineTerminator(_ENV,ch:charCodeAt(0))) then
throwError(_ENV,_obj({

}),Messages.UnterminatedRegExp);
end

_e((function () local _tmp = (_add(str,ch)); str  = _tmp; return _tmp; end)());
elseif _bool(isLineTerminator(_ENV,ch:charCodeAt(0))) then
throwError(_ENV,_obj({

}),Messages.UnterminatedRegExp);
elseif _bool(classMarker) then
if _bool((ch == "]")) then
_e((function () local _tmp = false; classMarker  = _tmp; return _tmp; end)());
end

else
if _bool((ch == "/")) then
_e((function () local _tmp = true; terminated  = _tmp; return _tmp; end)());
break;
elseif _bool((ch == "[")) then
_e((function () local _tmp = true; classMarker  = _tmp; return _tmp; end)());
end

end

::_continue::
end

if _bool(not _bool(terminated)) then
throwError(_ENV,_obj({

}),Messages.UnterminatedRegExp);
end

_e((function () local _tmp = str:substr(1,(str.length - 2)); body  = _tmp; return _tmp; end)());
 do return _obj({
["value"] = body,
["literal"] = str
}); end
end)
scanRegExpFlags = (function (this)
local restore,flags,str,ch;
_e((function () local _tmp = ""; str  = _tmp; return _tmp; end)());
_e((function () local _tmp = ""; flags  = _tmp; return _tmp; end)());
while _bool((index < length)) do
_e((function () local _tmp = source[index]; ch  = _tmp; return _tmp; end)());
if _bool(not _bool(isIdentifierPart(_ENV,ch:charCodeAt(0)))) then
break;
end

_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
if _bool(((ch == "\\") and (index < length))) then
_e((function () local _tmp = source[index]; ch  = _tmp; return _tmp; end)());
if _bool((ch == "u")) then
_e((function () local _tmp = _add(index, 1); index = _tmp; return _tmp; end)());
_e((function () local _tmp = index; restore  = _tmp; return _tmp; end)());
_e((function () local _tmp = scanHexEscape(_ENV,"u"); ch  = _tmp; return _tmp; end)());
if _bool(ch) then
_e((function () local _tmp = (_add(flags,ch)); flags  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(str,"\\u")); str  = _tmp; return _tmp; end)());
while _bool((restore < index)) do
_e((function () local _tmp = (_add(str,source[restore])); str  = _tmp; return _tmp; end)());
_e((function () local _tmp = _add(restore, 1); restore = _tmp; return _tmp; end)());
end

else
_e((function () local _tmp = restore; index  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(flags,"u")); flags  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(str,"\\u")); str  = _tmp; return _tmp; end)());
end

throwErrorTolerant(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
else
_e((function () local _tmp = (_add(str,"\\")); str  = _tmp; return _tmp; end)());
throwErrorTolerant(_ENV,_obj({

}),Messages.UnexpectedToken,"ILLEGAL");
end

else
_e((function () local _tmp = (_add(flags,ch)); flags  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(str,ch)); str  = _tmp; return _tmp; end)());
end

::_continue::
end

 do return _obj({
["value"] = flags,
["literal"] = str
}); end
end)
scanRegExp = (function (this)
local value,pattern,flags,body,start;
_e((function () local _tmp = null; lookahead  = _tmp; return _tmp; end)());
skipComment(_ENV);
_e((function () local _tmp = index; start  = _tmp; return _tmp; end)());
_e((function () local _tmp = scanRegExpBody(_ENV); body  = _tmp; return _tmp; end)());
_e((function () local _tmp = scanRegExpFlags(_ENV); flags  = _tmp; return _tmp; end)());
_e((function () local _tmp = testRegExp(_ENV,body.value,flags.value); value  = _tmp; return _tmp; end)());
if _bool(extra.tokenize) then
 do return _obj({
["type"] = Token.RegularExpression,
["value"] = value,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end

 do return _obj({
["literal"] = (_add(body.literal,flags.literal)),
["value"] = value,
["start"] = start,
["end"] = index
}); end
end)
collectRegex = (function (this)
local token,regex,loc,pos;
skipComment(_ENV);
_e((function () local _tmp = index; pos  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["start"] = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
})
}); loc  = _tmp; return _tmp; end)());
_e((function () local _tmp = scanRegExp(_ENV); regex  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
}); loc["end"]  = _tmp; return _tmp; end)());
if _bool(not _bool(extra.tokenize)) then
if _bool((extra.tokens.length > 0)) then
_e((function () local _tmp = extra.tokens[(extra.tokens.length - 1)]; token  = _tmp; return _tmp; end)());
if _bool(((token.range[0] == pos) and (token.type == "Punctuator"))) then
if _bool(((token.value == "/") or (token.value == "/="))) then
extra.tokens:pop();
end

end

end

extra.tokens:push(_obj({
["type"] = "RegularExpression",
["value"] = regex.literal,
["range"] = _arr({[0]=pos,index},2),
["loc"] = loc
}));
end

 do return regex; end
end)
isIdentifierName = (function (this, token)
 do return ((((token.type == Token.Identifier) or (token.type == Token.Keyword)) or (token.type == Token.BooleanLiteral)) or (token.type == Token.NullLiteral)); end
end)
advanceSlash = (function (this)
local checkToken,prevToken;
_e((function () local _tmp = extra.tokens[(extra.tokens.length - 1)]; prevToken  = _tmp; return _tmp; end)());
if _bool(not _bool(prevToken)) then
 do return collectRegex(_ENV); end
end

if _bool((prevToken.type == "Punctuator")) then
if _bool((prevToken.value == "]")) then
 do return scanPunctuator(_ENV); end
end

if _bool((prevToken.value == ")")) then
_e((function () local _tmp = extra.tokens[(extra.openParenToken - 1)]; checkToken  = _tmp; return _tmp; end)());
if _bool(((checkToken and (checkToken.type == "Keyword")) and ((((checkToken.value == "if") or (checkToken.value == "while")) or (checkToken.value == "for")) or (checkToken.value == "with")))) then
 do return collectRegex(_ENV); end
end

 do return scanPunctuator(_ENV); end
end

if _bool((prevToken.value == "}")) then
if _bool((extra.tokens[(extra.openCurlyToken - 3)] and (extra.tokens[(extra.openCurlyToken - 3)].type == "Keyword"))) then
_e((function () local _tmp = extra.tokens[(extra.openCurlyToken - 4)]; checkToken  = _tmp; return _tmp; end)());
if _bool(not _bool(checkToken)) then
 do return scanPunctuator(_ENV); end
end

elseif _bool((extra.tokens[(extra.openCurlyToken - 4)] and (extra.tokens[(extra.openCurlyToken - 4)].type == "Keyword"))) then
_e((function () local _tmp = extra.tokens[(extra.openCurlyToken - 5)]; checkToken  = _tmp; return _tmp; end)());
if _bool(not _bool(checkToken)) then
 do return collectRegex(_ENV); end
end

else
 do return scanPunctuator(_ENV); end
end

if _bool((FnExprTokens:indexOf(checkToken.value) >= 0)) then
 do return scanPunctuator(_ENV); end
end

 do return collectRegex(_ENV); end
end

 do return collectRegex(_ENV); end
end

if _bool((prevToken.type == "Keyword")) then
 do return collectRegex(_ENV); end
end

 do return scanPunctuator(_ENV); end
end)
advance = (function (this)
local ch;
skipComment(_ENV);
if _bool((index >= length)) then
 do return _obj({
["type"] = Token.EOF,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = index,
["end"] = index
}); end
end

_e((function () local _tmp = source:charCodeAt(index); ch  = _tmp; return _tmp; end)());
if _bool(isIdentifierStart(_ENV,ch)) then
 do return scanIdentifier(_ENV); end
end

if _bool((((ch == 40) or (ch == 41)) or (ch == 59))) then
 do return scanPunctuator(_ENV); end
end

if _bool(((ch == 39) or (ch == 34))) then
 do return scanStringLiteral(_ENV); end
end

if _bool((ch == 46)) then
if _bool(isDecimalDigit(_ENV,source:charCodeAt((_add(index,1))))) then
 do return scanNumericLiteral(_ENV); end
end

 do return scanPunctuator(_ENV); end
end

if _bool(isDecimalDigit(_ENV,ch)) then
 do return scanNumericLiteral(_ENV); end
end

if _bool((extra.tokenize and (ch == 47))) then
 do return advanceSlash(_ENV); end
end

 do return scanPunctuator(_ENV); end
end)
collectToken = (function (this)
local value,range,token,loc;
skipComment(_ENV);
_e((function () local _tmp = _obj({
["start"] = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
})
}); loc  = _tmp; return _tmp; end)());
_e((function () local _tmp = advance(_ENV); token  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
}); loc["end"]  = _tmp; return _tmp; end)());
if _bool((token.type ~= Token.EOF)) then
_e((function () local _tmp = source:slice(token.start,token["end"]); value  = _tmp; return _tmp; end)());
extra.tokens:push(_obj({
["type"] = TokenName[token.type],
["value"] = value,
["range"] = _arr({[0]=token.start,token["end"]},2),
["loc"] = loc
}));
end

 do return token; end
end)
lex = (function (this)
local token;
_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
_e((function () local _tmp = token["end"]; index  = _tmp; return _tmp; end)());
_e((function () local _tmp = token.lineNumber; lineNumber  = _tmp; return _tmp; end)());
_e((function () local _tmp = token.lineStart; lineStart  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_bool((_type(extra.tokens) ~= "undefined")) and {collectToken(_ENV)} or {advance(_ENV)})[1]; lookahead  = _tmp; return _tmp; end)());
_e((function () local _tmp = token["end"]; index  = _tmp; return _tmp; end)());
_e((function () local _tmp = token.lineNumber; lineNumber  = _tmp; return _tmp; end)());
_e((function () local _tmp = token.lineStart; lineStart  = _tmp; return _tmp; end)());
 do return token; end
end)
peek = (function (this)
local start,line,pos;
_e((function () local _tmp = index; pos  = _tmp; return _tmp; end)());
_e((function () local _tmp = lineNumber; line  = _tmp; return _tmp; end)());
_e((function () local _tmp = lineStart; start  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_bool((_type(extra.tokens) ~= "undefined")) and {collectToken(_ENV)} or {advance(_ENV)})[1]; lookahead  = _tmp; return _tmp; end)());
_e((function () local _tmp = pos; index  = _tmp; return _tmp; end)());
_e((function () local _tmp = line; lineNumber  = _tmp; return _tmp; end)());
_e((function () local _tmp = start; lineStart  = _tmp; return _tmp; end)());
end)
Position = (function (this, line, column)
_e((function () local _tmp = line; this.line  = _tmp; return _tmp; end)());
_e((function () local _tmp = column; this.column  = _tmp; return _tmp; end)());
end)
SourceLocation = (function (this, startLine, startColumn, line, column)
_e((function () local _tmp = _new(Position,startLine,startColumn); this.start  = _tmp; return _tmp; end)());
_e((function () local _tmp = _new(Position,line,column); this["end"]  = _tmp; return _tmp; end)());
end)
peekLineTerminator = (function (this)
local found,start,line,pos;
_e((function () local _tmp = index; pos  = _tmp; return _tmp; end)());
_e((function () local _tmp = lineNumber; line  = _tmp; return _tmp; end)());
_e((function () local _tmp = lineStart; start  = _tmp; return _tmp; end)());
skipComment(_ENV);
_e((function () local _tmp = (lineNumber ~= line); found  = _tmp; return _tmp; end)());
_e((function () local _tmp = pos; index  = _tmp; return _tmp; end)());
_e((function () local _tmp = line; lineNumber  = _tmp; return _tmp; end)());
_e((function () local _tmp = start; lineStart  = _tmp; return _tmp; end)());
 do return found; end
end)
throwError = (function (...)
local this, token, messageFormat = ...;
local arguments = _args(...);
local msg,args,error;
args = Array.prototype.slice:call(arguments,2);
msg = messageFormat:replace(_regexp("%(\\d)","g"),(function (this, whole, index)
assert(_ENV,(index < args.length),"Message reference must be in range");
 do return args[index]; end
end));
if _bool((_type(token.lineNumber) == "number")) then
_e((function () local _tmp = _new(Error,(_add((_add((_add("Line ",token.lineNumber)),": ")),msg))); error  = _tmp; return _tmp; end)());
_e((function () local _tmp = token.start; error.index  = _tmp; return _tmp; end)());
_e((function () local _tmp = token.lineNumber; error.lineNumber  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add((token.start - lineStart),1)); error.column  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = _new(Error,(_add((_add((_add("Line ",lineNumber)),": ")),msg))); error  = _tmp; return _tmp; end)());
_e((function () local _tmp = index; error.index  = _tmp; return _tmp; end)());
_e((function () local _tmp = lineNumber; error.lineNumber  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add((index - lineStart),1)); error.column  = _tmp; return _tmp; end)());
end

_e((function () local _tmp = msg; error.description  = _tmp; return _tmp; end)());
_throw(error,0)
end)
throwErrorTolerant = (function (...)
local this = ...;
local arguments = _args(...);
local _status, _return = _pcall(function()
throwError:apply(null,arguments);
end);
if not _status then
local _cstatus, _creturn = _pcall(function()
local e = _return;
if _bool(extra.errors) then
extra.errors:push(e);
else
_throw(e,0)
end

end);
if _cstatus then
else _throw(_creturn,0); end
end

end)
throwUnexpected = (function (this, token)
if _bool((token.type == Token.EOF)) then
throwError(_ENV,token,Messages.UnexpectedEOS);
end

if _bool((token.type == Token.NumericLiteral)) then
throwError(_ENV,token,Messages.UnexpectedNumber);
end

if _bool((token.type == Token.StringLiteral)) then
throwError(_ENV,token,Messages.UnexpectedString);
end

if _bool((token.type == Token.Identifier)) then
throwError(_ENV,token,Messages.UnexpectedIdentifier);
end

if _bool((token.type == Token.Keyword)) then
if _bool(isFutureReservedWord(_ENV,token.value)) then
throwError(_ENV,token,Messages.UnexpectedReserved);
elseif _bool((strict and isStrictModeReservedWord(_ENV,token.value))) then
throwErrorTolerant(_ENV,token,Messages.StrictReservedWord);
do return end
end

throwError(_ENV,token,Messages.UnexpectedToken,token.value);
end

throwError(_ENV,token,Messages.UnexpectedToken,token.value);
end)
expect = (function (this, value)
local token;
token = lex(_ENV);
if _bool(((token.type ~= Token.Punctuator) or (token.value ~= value))) then
throwUnexpected(_ENV,token);
end

end)
expectKeyword = (function (this, keyword)
local token;
token = lex(_ENV);
if _bool(((token.type ~= Token.Keyword) or (token.value ~= keyword))) then
throwUnexpected(_ENV,token);
end

end)
match = (function (this, value)
 do return ((lookahead.type == Token.Punctuator) and (lookahead.value == value)); end
end)
matchKeyword = (function (this, keyword)
 do return ((lookahead.type == Token.Keyword) and (lookahead.value == keyword)); end
end)
matchAssign = (function (this)
local op;
if _bool((lookahead.type ~= Token.Punctuator)) then
 do return false; end
end

_e((function () local _tmp = lookahead.value; op  = _tmp; return _tmp; end)());
 do return ((((((((((((op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) or (op == ">>>=")) or (op == "&=")) or (op == "^=")) or (op == "|=")); end
end)
consumeSemicolon = (function (this)
local line;
if _bool(((source:charCodeAt(index) == 59) or match(_ENV,";"))) then
lex(_ENV);
do return end
end

_e((function () local _tmp = lineNumber; line  = _tmp; return _tmp; end)());
skipComment(_ENV);
if _bool((lineNumber ~= line)) then
do return end
end

if _bool(((lookahead.type ~= Token.EOF) and not _bool(match(_ENV,"}")))) then
throwUnexpected(_ENV,lookahead);
end

end)
isLeftHandSide = (function (this, expr)
 do return ((expr.type == Syntax.Identifier) or (expr.type == Syntax.MemberExpression)); end
end)
parseArrayInitialiser = (function (this)
local startToken,elements;
elements = _arr({},0);
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
expect(_ENV,"[");
while _bool(not _bool(match(_ENV,"]"))) do
if _bool(match(_ENV,",")) then
lex(_ENV);
elements:push(null);
else
elements:push(parseAssignmentExpression(_ENV));
if _bool(not _bool(match(_ENV,"]"))) then
expect(_ENV,",");
end

end

::_continue::
end

lex(_ENV);
 do return delegate:markEnd(delegate:createArrayExpression(elements),startToken); end
end)
parsePropertyFunction = (function (this, param, first)
local startToken,body,previousStrict;
_e((function () local _tmp = strict; previousStrict  = _tmp; return _tmp; end)());
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseFunctionSourceElements(_ENV); body  = _tmp; return _tmp; end)());
if _bool(((first and strict) and isRestrictedWord(_ENV,param[0].name))) then
throwErrorTolerant(_ENV,first,Messages.StrictParamName);
end

_e((function () local _tmp = previousStrict; strict  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createFunctionExpression(null,param,_arr({},0),body),startToken); end
end)
parseObjectPropertyKey = (function (this)
local startToken,token;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
if _bool(((token.type == Token.StringLiteral) or (token.type == Token.NumericLiteral))) then
if _bool((strict and token.octal)) then
throwErrorTolerant(_ENV,token,Messages.StrictOctalLiteral);
end

 do return delegate:markEnd(delegate:createLiteral(token),startToken); end
end

 do return delegate:markEnd(delegate:createIdentifier(token.value),startToken); end
end)
parseObjectProperty = (function (this)
local startToken,param,value,id,key,token;
_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
if _bool((token.type == Token.Identifier)) then
_e((function () local _tmp = parseObjectPropertyKey(_ENV); id  = _tmp; return _tmp; end)());
if _bool(((token.value == "get") and not _bool(match(_ENV,":")))) then
_e((function () local _tmp = parseObjectPropertyKey(_ENV); key  = _tmp; return _tmp; end)());
expect(_ENV,"(");
expect(_ENV,")");
_e((function () local _tmp = parsePropertyFunction(_ENV,_arr({},0)); value  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createProperty("get",key,value),startToken); end
end

if _bool(((token.value == "set") and not _bool(match(_ENV,":")))) then
_e((function () local _tmp = parseObjectPropertyKey(_ENV); key  = _tmp; return _tmp; end)());
expect(_ENV,"(");
_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
if _bool((token.type ~= Token.Identifier)) then
expect(_ENV,")");
throwErrorTolerant(_ENV,token,Messages.UnexpectedToken,token.value);
_e((function () local _tmp = parsePropertyFunction(_ENV,_arr({},0)); value  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = _arr({[0]=parseVariableIdentifier(_ENV)},1); param  = _tmp; return _tmp; end)());
expect(_ENV,")");
_e((function () local _tmp = parsePropertyFunction(_ENV,param,token); value  = _tmp; return _tmp; end)());
end

 do return delegate:markEnd(delegate:createProperty("set",key,value),startToken); end
end

expect(_ENV,":");
_e((function () local _tmp = parseAssignmentExpression(_ENV); value  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createProperty("init",id,value),startToken); end
end

if _bool(((token.type == Token.EOF) or (token.type == Token.Punctuator))) then
throwUnexpected(_ENV,token);
else
_e((function () local _tmp = parseObjectPropertyKey(_ENV); key  = _tmp; return _tmp; end)());
expect(_ENV,":");
_e((function () local _tmp = parseAssignmentExpression(_ENV); value  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createProperty("init",key,value),startToken); end
end

end)
parseObjectInitialiser = (function (this)
local startToken,toString,map,kind,key,name,property,properties;
properties = _arr({},0);
map = _obj({

});
toString = String;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
expect(_ENV,"{");
while _bool(not _bool(match(_ENV,"}"))) do
_e((function () local _tmp = parseObjectProperty(_ENV); property  = _tmp; return _tmp; end)());
if _bool((property.key.type == Syntax.Identifier)) then
_e((function () local _tmp = property.key.name; name  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = toString(_ENV,property.key.value); name  = _tmp; return _tmp; end)());
end

_e((function () local _tmp = (_bool((property.kind == "init")) and {PropertyKind.Data} or {(_bool((property.kind == "get")) and {PropertyKind.Get} or {PropertyKind.Set})[1]})[1]; kind  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add("$",name)); key  = _tmp; return _tmp; end)());
if _bool(Object.prototype.hasOwnProperty:call(map,key)) then
if _bool((map[key] == PropertyKind.Data)) then
if _bool((strict and (kind == PropertyKind.Data))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.StrictDuplicateProperty);
elseif _bool((kind ~= PropertyKind.Data)) then
throwErrorTolerant(_ENV,_obj({

}),Messages.AccessorDataProperty);
end

else
if _bool((kind == PropertyKind.Data)) then
throwErrorTolerant(_ENV,_obj({

}),Messages.AccessorDataProperty);
elseif _bool((_bit.band(map[key],kind))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.AccessorGetSet);
end

end

_e((function () local _tmp = (_bit.bor(map[key],kind)); map[key]  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = kind; map[key]  = _tmp; return _tmp; end)());
end

properties:push(property);
if _bool(not _bool(match(_ENV,"}"))) then
expect(_ENV,",");
end

::_continue::
end

expect(_ENV,"}");
 do return delegate:markEnd(delegate:createObjectExpression(properties),startToken); end
end)
parseGroupExpression = (function (this)
local expr;
expect(_ENV,"(");
_e((function () local _tmp = parseExpression(_ENV); expr  = _tmp; return _tmp; end)());
expect(_ENV,")");
 do return expr; end
end)
parsePrimaryExpression = (function (this)
local startToken,expr,token,type;
if _bool(match(_ENV,"(")) then
 do return parseGroupExpression(_ENV); end
end

if _bool(match(_ENV,"[")) then
 do return parseArrayInitialiser(_ENV); end
end

if _bool(match(_ENV,"{")) then
 do return parseObjectInitialiser(_ENV); end
end

_e((function () local _tmp = lookahead.type; type  = _tmp; return _tmp; end)());
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
if _bool((type == Token.Identifier)) then
_e((function () local _tmp = delegate:createIdentifier(lex(_ENV).value); expr  = _tmp; return _tmp; end)());
elseif _bool(((type == Token.StringLiteral) or (type == Token.NumericLiteral))) then
if _bool((strict and lookahead.octal)) then
throwErrorTolerant(_ENV,lookahead,Messages.StrictOctalLiteral);
end

_e((function () local _tmp = delegate:createLiteral(lex(_ENV)); expr  = _tmp; return _tmp; end)());
elseif _bool((type == Token.Keyword)) then
if _bool(matchKeyword(_ENV,"function")) then
 do return parseFunctionExpression(_ENV); end
end

if _bool(matchKeyword(_ENV,"this")) then
lex(_ENV);
_e((function () local _tmp = delegate:createThisExpression(); expr  = _tmp; return _tmp; end)());
else
throwUnexpected(_ENV,lex(_ENV));
end

elseif _bool((type == Token.BooleanLiteral)) then
_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
_e((function () local _tmp = (token.value == "true"); token.value  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createLiteral(token); expr  = _tmp; return _tmp; end)());
elseif _bool((type == Token.NullLiteral)) then
_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
_e((function () local _tmp = null; token.value  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createLiteral(token); expr  = _tmp; return _tmp; end)());
elseif _bool((match(_ENV,"/") or match(_ENV,"/="))) then
if _bool((_type(extra.tokens) ~= "undefined")) then
_e((function () local _tmp = delegate:createLiteral(collectRegex(_ENV)); expr  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = delegate:createLiteral(scanRegExp(_ENV)); expr  = _tmp; return _tmp; end)());
end

peek(_ENV);
else
throwUnexpected(_ENV,lex(_ENV));
end

 do return delegate:markEnd(expr,startToken); end
end)
parseArguments = (function (this)
local args;
args = _arr({},0);
expect(_ENV,"(");
if _bool(not _bool(match(_ENV,")"))) then
while _bool((index < length)) do
args:push(parseAssignmentExpression(_ENV));
if _bool(match(_ENV,")")) then
break;
end

expect(_ENV,",");
::_continue::
end

end

expect(_ENV,")");
 do return args; end
end)
parseNonComputedProperty = (function (this)
local startToken,token;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
if _bool(not _bool(isIdentifierName(_ENV,token))) then
throwUnexpected(_ENV,token);
end

 do return delegate:markEnd(delegate:createIdentifier(token.value),startToken); end
end)
parseNonComputedMember = (function (this)
expect(_ENV,".");
 do return parseNonComputedProperty(_ENV); end
end)
parseComputedMember = (function (this)
local expr;
expect(_ENV,"[");
_e((function () local _tmp = parseExpression(_ENV); expr  = _tmp; return _tmp; end)());
expect(_ENV,"]");
 do return expr; end
end)
parseNewExpression = (function (this)
local startToken,args,callee;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
expectKeyword(_ENV,"new");
_e((function () local _tmp = parseLeftHandSideExpression(_ENV); callee  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_bool(match(_ENV,"(")) and {parseArguments(_ENV)} or {_arr({},0)})[1]; args  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createNewExpression(callee,args),startToken); end
end)
parseLeftHandSideExpressionAllowCall = (function (this)
local startToken,property,args,expr,previousAllowIn;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = state.allowIn; previousAllowIn  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; state.allowIn  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_bool(matchKeyword(_ENV,"new")) and {parseNewExpression(_ENV)} or {parsePrimaryExpression(_ENV)})[1]; expr  = _tmp; return _tmp; end)());
_e((function () local _tmp = previousAllowIn; state.allowIn  = _tmp; return _tmp; end)());
while _bool(true) do
if _bool(match(_ENV,".")) then
_e((function () local _tmp = parseNonComputedMember(_ENV); property  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createMemberExpression(".",expr,property); expr  = _tmp; return _tmp; end)());
elseif _bool(match(_ENV,"(")) then
_e((function () local _tmp = parseArguments(_ENV); args  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createCallExpression(expr,args); expr  = _tmp; return _tmp; end)());
elseif _bool(match(_ENV,"[")) then
_e((function () local _tmp = parseComputedMember(_ENV); property  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createMemberExpression("[",expr,property); expr  = _tmp; return _tmp; end)());
else
break;
end

delegate:markEnd(expr,startToken);
end

 do return expr; end
end)
parseLeftHandSideExpression = (function (this)
local startToken,property,expr,previousAllowIn;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = state.allowIn; previousAllowIn  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_bool(matchKeyword(_ENV,"new")) and {parseNewExpression(_ENV)} or {parsePrimaryExpression(_ENV)})[1]; expr  = _tmp; return _tmp; end)());
_e((function () local _tmp = previousAllowIn; state.allowIn  = _tmp; return _tmp; end)());
while _bool((match(_ENV,".") or match(_ENV,"["))) do
if _bool(match(_ENV,"[")) then
_e((function () local _tmp = parseComputedMember(_ENV); property  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createMemberExpression("[",expr,property); expr  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = parseNonComputedMember(_ENV); property  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createMemberExpression(".",expr,property); expr  = _tmp; return _tmp; end)());
end

delegate:markEnd(expr,startToken);
::_continue::
end

 do return expr; end
end)
parsePostfixExpression = (function (this)
local startToken,token,expr;
startToken = lookahead;
_e((function () local _tmp = parseLeftHandSideExpressionAllowCall(_ENV); expr  = _tmp; return _tmp; end)());
if _bool((lookahead.type == Token.Punctuator)) then
if _bool(((match(_ENV,"++") or match(_ENV,"--")) and not _bool(peekLineTerminator(_ENV)))) then
if _bool(((strict and (expr.type == Syntax.Identifier)) and isRestrictedWord(_ENV,expr.name))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.StrictLHSPostfix);
end

if _bool(not _bool(isLeftHandSide(_ENV,expr))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.InvalidLHSInAssignment);
end

_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:markEnd(delegate:createPostfixExpression(token.value,expr),startToken); expr  = _tmp; return _tmp; end)());
end

end

 do return expr; end
end)
parseUnaryExpression = (function (this)
local startToken,expr,token;
if _bool(((lookahead.type ~= Token.Punctuator) and (lookahead.type ~= Token.Keyword))) then
_e((function () local _tmp = parsePostfixExpression(_ENV); expr  = _tmp; return _tmp; end)());
elseif _bool((match(_ENV,"++") or match(_ENV,"--"))) then
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseUnaryExpression(_ENV); expr  = _tmp; return _tmp; end)());
if _bool(((strict and (expr.type == Syntax.Identifier)) and isRestrictedWord(_ENV,expr.name))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.StrictLHSPrefix);
end

if _bool(not _bool(isLeftHandSide(_ENV,expr))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.InvalidLHSInAssignment);
end

_e((function () local _tmp = delegate:createUnaryExpression(token.value,expr); expr  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:markEnd(expr,startToken); expr  = _tmp; return _tmp; end)());
elseif _bool((((match(_ENV,"+") or match(_ENV,"-")) or match(_ENV,"~")) or match(_ENV,"!"))) then
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseUnaryExpression(_ENV); expr  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createUnaryExpression(token.value,expr); expr  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:markEnd(expr,startToken); expr  = _tmp; return _tmp; end)());
elseif _bool(((matchKeyword(_ENV,"delete") or matchKeyword(_ENV,"void")) or matchKeyword(_ENV,"typeof"))) then
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseUnaryExpression(_ENV); expr  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createUnaryExpression(token.value,expr); expr  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:markEnd(expr,startToken); expr  = _tmp; return _tmp; end)());
if _bool(((strict and (expr.operator == "delete")) and (expr.argument.type == Syntax.Identifier))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.StrictDelete);
end

else
_e((function () local _tmp = parsePostfixExpression(_ENV); expr  = _tmp; return _tmp; end)());
end

 do return expr; end
end)
binaryPrecedence = (function (this, token, allowIn)
local prec;
prec = 0;
if _bool(((token.type ~= Token.Punctuator) and (token.type ~= Token.Keyword))) then
 do return 0; end
end

repeat
local _into = false;
local _cases = {["||"] = true,["&&"] = true,["|"] = true,["^"] = true,["&"] = true,["=="] = true,["!="] = true,["==="] = true,["!=="] = true,["<"] = true,[">"] = true,["<="] = true,[">="] = true,["instanceof"] = true,["in"] = true,["<<"] = true,[">>"] = true,[">>>"] = true,["+"] = true,["-"] = true,["*"] = true,["/"] = true,["%"] = true};
if (not _cases[token.value]) then
_into = true;
goto _default
end
if _into or (token.value == "||") then
_e((function () local _tmp = 1; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (token.value == "&&") then
_e((function () local _tmp = 2; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (token.value == "|") then
_e((function () local _tmp = 3; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (token.value == "^") then
_e((function () local _tmp = 4; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (token.value == "&") then
_e((function () local _tmp = 5; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (token.value == "==") then

_into = true;
end
if _into or (token.value == "!=") then

_into = true;
end
if _into or (token.value == "===") then

_into = true;
end
if _into or (token.value == "!==") then
_e((function () local _tmp = 6; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (token.value == "<") then

_into = true;
end
if _into or (token.value == ">") then

_into = true;
end
if _into or (token.value == "<=") then

_into = true;
end
if _into or (token.value == ">=") then

_into = true;
end
if _into or (token.value == "instanceof") then
_e((function () local _tmp = 7; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (token.value == "in") then
_e((function () local _tmp = (_bool(allowIn) and {7} or {0})[1]; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (token.value == "<<") then

_into = true;
end
if _into or (token.value == ">>") then

_into = true;
end
if _into or (token.value == ">>>") then
_e((function () local _tmp = 8; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (token.value == "+") then

_into = true;
end
if _into or (token.value == "-") then
_e((function () local _tmp = 9; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (token.value == "*") then

_into = true;
end
if _into or (token.value == "/") then

_into = true;
end
if _into or (token.value == "%") then
_e((function () local _tmp = 11; prec  = _tmp; return _tmp; end)());
break;
_into = true;
end
::_default::
if _into then
break;
_into = true;
end
until true
 do return prec; end
end)
parseBinaryExpression = (function (this)
local i,left,operator,right,stack,prec,token,expr,markers,marker;
_e((function () local _tmp = lookahead; marker  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseUnaryExpression(_ENV); left  = _tmp; return _tmp; end)());
_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
_e((function () local _tmp = binaryPrecedence(_ENV,token,state.allowIn); prec  = _tmp; return _tmp; end)());
if _bool((prec == 0)) then
 do return left; end
end

_e((function () local _tmp = prec; token.prec  = _tmp; return _tmp; end)());
lex(_ENV);
_e((function () local _tmp = _arr({[0]=marker,lookahead},2); markers  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseUnaryExpression(_ENV); right  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({[0]=left,token,right},3); stack  = _tmp; return _tmp; end)());
while _bool(((function () local _tmp = binaryPrecedence(_ENV,lookahead,state.allowIn); prec  = _tmp; return _tmp; end)() > 0)) do
while _bool(((stack.length > 2) and (prec <= stack[(stack.length - 2)].prec))) do
_e((function () local _tmp = stack:pop(); right  = _tmp; return _tmp; end)());
_e((function () local _tmp = stack:pop().value; operator  = _tmp; return _tmp; end)());
_e((function () local _tmp = stack:pop(); left  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createBinaryExpression(operator,left,right); expr  = _tmp; return _tmp; end)());
markers:pop();
_e((function () local _tmp = markers[(markers.length - 1)]; marker  = _tmp; return _tmp; end)());
delegate:markEnd(expr,marker);
stack:push(expr);
::_continue::
end

_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
_e((function () local _tmp = prec; token.prec  = _tmp; return _tmp; end)());
stack:push(token);
markers:push(lookahead);
_e((function () local _tmp = parseUnaryExpression(_ENV); expr  = _tmp; return _tmp; end)());
stack:push(expr);
::_continue::
end

_e((function () local _tmp = (stack.length - 1); i  = _tmp; return _tmp; end)());
_e((function () local _tmp = stack[i]; expr  = _tmp; return _tmp; end)());
markers:pop();
while _bool((i > 1)) do
_e((function () local _tmp = delegate:createBinaryExpression(stack[(i - 1)].value,stack[(i - 2)],expr); expr  = _tmp; return _tmp; end)());
_e((function () local _tmp = (i - 2); i  = _tmp; return _tmp; end)());
_e((function () local _tmp = markers:pop(); marker  = _tmp; return _tmp; end)());
delegate:markEnd(expr,marker);
::_continue::
end

 do return expr; end
end)
parseConditionalExpression = (function (this)
local startToken,alternate,consequent,previousAllowIn,expr;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseBinaryExpression(_ENV); expr  = _tmp; return _tmp; end)());
if _bool(match(_ENV,"?")) then
lex(_ENV);
_e((function () local _tmp = state.allowIn; previousAllowIn  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; state.allowIn  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseAssignmentExpression(_ENV); consequent  = _tmp; return _tmp; end)());
_e((function () local _tmp = previousAllowIn; state.allowIn  = _tmp; return _tmp; end)());
expect(_ENV,":");
_e((function () local _tmp = parseAssignmentExpression(_ENV); alternate  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:createConditionalExpression(expr,consequent,alternate); expr  = _tmp; return _tmp; end)());
delegate:markEnd(expr,startToken);
end

 do return expr; end
end)
parseAssignmentExpression = (function (this)
local startToken,node,right,left,token;
_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = (function () local _tmp = parseConditionalExpression(_ENV); left  = _tmp; return _tmp; end)(); node  = _tmp; return _tmp; end)());
if _bool(matchAssign(_ENV)) then
if _bool(not _bool(isLeftHandSide(_ENV,left))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.InvalidLHSInAssignment);
end

if _bool(((strict and (left.type == Syntax.Identifier)) and isRestrictedWord(_ENV,left.name))) then
throwErrorTolerant(_ENV,token,Messages.StrictLHSAssignment);
end

_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseAssignmentExpression(_ENV); right  = _tmp; return _tmp; end)());
_e((function () local _tmp = delegate:markEnd(delegate:createAssignmentExpression(token.value,left,right),startToken); node  = _tmp; return _tmp; end)());
end

 do return node; end
end)
parseExpression = (function (this)
local startToken,expr;
startToken = lookahead;
_e((function () local _tmp = parseAssignmentExpression(_ENV); expr  = _tmp; return _tmp; end)());
if _bool(match(_ENV,",")) then
_e((function () local _tmp = delegate:createSequenceExpression(_arr({[0]=expr},1)); expr  = _tmp; return _tmp; end)());
while _bool((index < length)) do
if _bool(not _bool(match(_ENV,","))) then
break;
end

lex(_ENV);
expr.expressions:push(parseAssignmentExpression(_ENV));
::_continue::
end

delegate:markEnd(expr,startToken);
end

 do return expr; end
end)
parseStatementList = (function (this)
local statement,list;
list = _arr({},0);
while _bool((index < length)) do
if _bool(match(_ENV,"}")) then
break;
end

_e((function () local _tmp = parseSourceElement(_ENV); statement  = _tmp; return _tmp; end)());
if _bool((_type(statement) == "undefined")) then
break;
end

list:push(statement);
::_continue::
end

 do return list; end
end)
parseBlock = (function (this)
local startToken,block;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
expect(_ENV,"{");
_e((function () local _tmp = parseStatementList(_ENV); block  = _tmp; return _tmp; end)());
expect(_ENV,"}");
 do return delegate:markEnd(delegate:createBlockStatement(block),startToken); end
end)
parseVariableIdentifier = (function (this)
local startToken,token;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
if _bool((token.type ~= Token.Identifier)) then
throwUnexpected(_ENV,token);
end

 do return delegate:markEnd(delegate:createIdentifier(token.value),startToken); end
end)
parseVariableDeclaration = (function (this, kind)
local startToken,id,init;
init = null;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseVariableIdentifier(_ENV); id  = _tmp; return _tmp; end)());
if _bool((strict and isRestrictedWord(_ENV,id.name))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.StrictVarName);
end

if _bool((kind == "const")) then
expect(_ENV,"=");
_e((function () local _tmp = parseAssignmentExpression(_ENV); init  = _tmp; return _tmp; end)());
elseif _bool(match(_ENV,"=")) then
lex(_ENV);
_e((function () local _tmp = parseAssignmentExpression(_ENV); init  = _tmp; return _tmp; end)());
end

 do return delegate:markEnd(delegate:createVariableDeclarator(id,init),startToken); end
end)
parseVariableDeclarationList = (function (this, kind)
local list;
list = _arr({},0);
repeat
list:push(parseVariableDeclaration(_ENV,kind));
if _bool(not _bool(match(_ENV,","))) then
break;
end

lex(_ENV);
::_continue::
until not _bool((index < length))

 do return list; end
end)
parseVariableStatement = (function (this)
local declarations;
expectKeyword(_ENV,"var");
_e((function () local _tmp = parseVariableDeclarationList(_ENV); declarations  = _tmp; return _tmp; end)());
consumeSemicolon(_ENV);
 do return delegate:createVariableDeclaration(declarations,"var"); end
end)
parseConstLetDeclaration = (function (this, kind)
local startToken,declarations;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
expectKeyword(_ENV,kind);
_e((function () local _tmp = parseVariableDeclarationList(_ENV,kind); declarations  = _tmp; return _tmp; end)());
consumeSemicolon(_ENV);
 do return delegate:markEnd(delegate:createVariableDeclaration(declarations,kind),startToken); end
end)
parseEmptyStatement = (function (this)
expect(_ENV,";");
 do return delegate:createEmptyStatement(); end
end)
parseExpressionStatement = (function (this)
local expr;
expr = parseExpression(_ENV);
consumeSemicolon(_ENV);
 do return delegate:createExpressionStatement(expr); end
end)
parseIfStatement = (function (this)
local alternate,consequent,test;
expectKeyword(_ENV,"if");
expect(_ENV,"(");
_e((function () local _tmp = parseExpression(_ENV); test  = _tmp; return _tmp; end)());
expect(_ENV,")");
_e((function () local _tmp = parseStatement(_ENV); consequent  = _tmp; return _tmp; end)());
if _bool(matchKeyword(_ENV,"else")) then
lex(_ENV);
_e((function () local _tmp = parseStatement(_ENV); alternate  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = null; alternate  = _tmp; return _tmp; end)());
end

 do return delegate:createIfStatement(test,consequent,alternate); end
end)
parseDoWhileStatement = (function (this)
local oldInIteration,test,body;
expectKeyword(_ENV,"do");
_e((function () local _tmp = state.inIteration; oldInIteration  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; state.inIteration  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseStatement(_ENV); body  = _tmp; return _tmp; end)());
_e((function () local _tmp = oldInIteration; state.inIteration  = _tmp; return _tmp; end)());
expectKeyword(_ENV,"while");
expect(_ENV,"(");
_e((function () local _tmp = parseExpression(_ENV); test  = _tmp; return _tmp; end)());
expect(_ENV,")");
if _bool(match(_ENV,";")) then
lex(_ENV);
end

 do return delegate:createDoWhileStatement(body,test); end
end)
parseWhileStatement = (function (this)
local oldInIteration,body,test;
expectKeyword(_ENV,"while");
expect(_ENV,"(");
_e((function () local _tmp = parseExpression(_ENV); test  = _tmp; return _tmp; end)());
expect(_ENV,")");
_e((function () local _tmp = state.inIteration; oldInIteration  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; state.inIteration  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseStatement(_ENV); body  = _tmp; return _tmp; end)());
_e((function () local _tmp = oldInIteration; state.inIteration  = _tmp; return _tmp; end)());
 do return delegate:createWhileStatement(test,body); end
end)
parseForVariableDeclaration = (function (this)
local startToken,declarations,token;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseVariableDeclarationList(_ENV); declarations  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createVariableDeclaration(declarations,token.value),startToken); end
end)
parseForStatement = (function (this)
local oldInIteration,body,right,left,update,test,init;
_e((function () local _tmp = (function () local _tmp = (function () local _tmp = null; update  = _tmp; return _tmp; end)(); test  = _tmp; return _tmp; end)(); init  = _tmp; return _tmp; end)());
expectKeyword(_ENV,"for");
expect(_ENV,"(");
if _bool(match(_ENV,";")) then
lex(_ENV);
else
if _bool((matchKeyword(_ENV,"var") or matchKeyword(_ENV,"let"))) then
_e((function () local _tmp = false; state.allowIn  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseForVariableDeclaration(_ENV); init  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; state.allowIn  = _tmp; return _tmp; end)());
if _bool(((init.declarations.length == 1) and matchKeyword(_ENV,"in"))) then
lex(_ENV);
_e((function () local _tmp = init; left  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseExpression(_ENV); right  = _tmp; return _tmp; end)());
_e((function () local _tmp = null; init  = _tmp; return _tmp; end)());
end

else
_e((function () local _tmp = false; state.allowIn  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseExpression(_ENV); init  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; state.allowIn  = _tmp; return _tmp; end)());
if _bool(matchKeyword(_ENV,"in")) then
if _bool(not _bool(isLeftHandSide(_ENV,init))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.InvalidLHSInForIn);
end

lex(_ENV);
_e((function () local _tmp = init; left  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseExpression(_ENV); right  = _tmp; return _tmp; end)());
_e((function () local _tmp = null; init  = _tmp; return _tmp; end)());
end

end

if _bool((_type(left) == "undefined")) then
expect(_ENV,";");
end

end

if _bool((_type(left) == "undefined")) then
if _bool(not _bool(match(_ENV,";"))) then
_e((function () local _tmp = parseExpression(_ENV); test  = _tmp; return _tmp; end)());
end

expect(_ENV,";");
if _bool(not _bool(match(_ENV,")"))) then
_e((function () local _tmp = parseExpression(_ENV); update  = _tmp; return _tmp; end)());
end

end

expect(_ENV,")");
_e((function () local _tmp = state.inIteration; oldInIteration  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; state.inIteration  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseStatement(_ENV); body  = _tmp; return _tmp; end)());
_e((function () local _tmp = oldInIteration; state.inIteration  = _tmp; return _tmp; end)());
 do return (_bool((_type(left) == "undefined")) and {delegate:createForStatement(init,test,update,body)} or {delegate:createForInStatement(left,right,body)})[1]; end
end)
parseContinueStatement = (function (this)
local key,label;
label = null;
expectKeyword(_ENV,"continue");
if _bool((source:charCodeAt(index) == 59)) then
lex(_ENV);
if _bool(not _bool(state.inIteration)) then
throwError(_ENV,_obj({

}),Messages.IllegalContinue);
end

 do return delegate:createContinueStatement(null); end
end

if _bool(peekLineTerminator(_ENV)) then
if _bool(not _bool(state.inIteration)) then
throwError(_ENV,_obj({

}),Messages.IllegalContinue);
end

 do return delegate:createContinueStatement(null); end
end

if _bool((lookahead.type == Token.Identifier)) then
_e((function () local _tmp = parseVariableIdentifier(_ENV); label  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add("$",label.name)); key  = _tmp; return _tmp; end)());
if _bool(not _bool(Object.prototype.hasOwnProperty:call(state.labelSet,key))) then
throwError(_ENV,_obj({

}),Messages.UnknownLabel,label.name);
end

end

consumeSemicolon(_ENV);
if _bool(((label == null) and not _bool(state.inIteration))) then
throwError(_ENV,_obj({

}),Messages.IllegalContinue);
end

 do return delegate:createContinueStatement(label); end
end)
parseBreakStatement = (function (this)
local key,label;
label = null;
expectKeyword(_ENV,"break");
if _bool((source:charCodeAt(index) == 59)) then
lex(_ENV);
if _bool(not _bool((state.inIteration or state.inSwitch))) then
throwError(_ENV,_obj({

}),Messages.IllegalBreak);
end

 do return delegate:createBreakStatement(null); end
end

if _bool(peekLineTerminator(_ENV)) then
if _bool(not _bool((state.inIteration or state.inSwitch))) then
throwError(_ENV,_obj({

}),Messages.IllegalBreak);
end

 do return delegate:createBreakStatement(null); end
end

if _bool((lookahead.type == Token.Identifier)) then
_e((function () local _tmp = parseVariableIdentifier(_ENV); label  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add("$",label.name)); key  = _tmp; return _tmp; end)());
if _bool(not _bool(Object.prototype.hasOwnProperty:call(state.labelSet,key))) then
throwError(_ENV,_obj({

}),Messages.UnknownLabel,label.name);
end

end

consumeSemicolon(_ENV);
if _bool(((label == null) and not _bool((state.inIteration or state.inSwitch)))) then
throwError(_ENV,_obj({

}),Messages.IllegalBreak);
end

 do return delegate:createBreakStatement(label); end
end)
parseReturnStatement = (function (this)
local argument;
argument = null;
expectKeyword(_ENV,"return");
if _bool(not _bool(state.inFunctionBody)) then
throwErrorTolerant(_ENV,_obj({

}),Messages.IllegalReturn);
end

if _bool((source:charCodeAt(index) == 32)) then
if _bool(isIdentifierStart(_ENV,source:charCodeAt((_add(index,1))))) then
_e((function () local _tmp = parseExpression(_ENV); argument  = _tmp; return _tmp; end)());
consumeSemicolon(_ENV);
 do return delegate:createReturnStatement(argument); end
end

end

if _bool(peekLineTerminator(_ENV)) then
 do return delegate:createReturnStatement(null); end
end

if _bool(not _bool(match(_ENV,";"))) then
if _bool((not _bool(match(_ENV,"}")) and (lookahead.type ~= Token.EOF))) then
_e((function () local _tmp = parseExpression(_ENV); argument  = _tmp; return _tmp; end)());
end

end

consumeSemicolon(_ENV);
 do return delegate:createReturnStatement(argument); end
end)
parseWithStatement = (function (this)
local body,object;
if _bool(strict) then
skipComment(_ENV);
throwErrorTolerant(_ENV,_obj({

}),Messages.StrictModeWith);
end

expectKeyword(_ENV,"with");
expect(_ENV,"(");
_e((function () local _tmp = parseExpression(_ENV); object  = _tmp; return _tmp; end)());
expect(_ENV,")");
_e((function () local _tmp = parseStatement(_ENV); body  = _tmp; return _tmp; end)());
 do return delegate:createWithStatement(object,body); end
end)
parseSwitchCase = (function (this)
local startToken,statement,consequent,test;
consequent = _arr({},0);
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
if _bool(matchKeyword(_ENV,"default")) then
lex(_ENV);
_e((function () local _tmp = null; test  = _tmp; return _tmp; end)());
else
expectKeyword(_ENV,"case");
_e((function () local _tmp = parseExpression(_ENV); test  = _tmp; return _tmp; end)());
end

expect(_ENV,":");
while _bool((index < length)) do
if _bool(((match(_ENV,"}") or matchKeyword(_ENV,"default")) or matchKeyword(_ENV,"case"))) then
break;
end

_e((function () local _tmp = parseStatement(_ENV); statement  = _tmp; return _tmp; end)());
consequent:push(statement);
::_continue::
end

 do return delegate:markEnd(delegate:createSwitchCase(test,consequent),startToken); end
end)
parseSwitchStatement = (function (this)
local defaultFound,oldInSwitch,clause,cases,discriminant;
expectKeyword(_ENV,"switch");
expect(_ENV,"(");
_e((function () local _tmp = parseExpression(_ENV); discriminant  = _tmp; return _tmp; end)());
expect(_ENV,")");
expect(_ENV,"{");
_e((function () local _tmp = _arr({},0); cases  = _tmp; return _tmp; end)());
if _bool(match(_ENV,"}")) then
lex(_ENV);
 do return delegate:createSwitchStatement(discriminant,cases); end
end

_e((function () local _tmp = state.inSwitch; oldInSwitch  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; state.inSwitch  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; defaultFound  = _tmp; return _tmp; end)());
while _bool((index < length)) do
if _bool(match(_ENV,"}")) then
break;
end

_e((function () local _tmp = parseSwitchCase(_ENV); clause  = _tmp; return _tmp; end)());
if _bool((clause.test == null)) then
if _bool(defaultFound) then
throwError(_ENV,_obj({

}),Messages.MultipleDefaultsInSwitch);
end

_e((function () local _tmp = true; defaultFound  = _tmp; return _tmp; end)());
end

cases:push(clause);
::_continue::
end

_e((function () local _tmp = oldInSwitch; state.inSwitch  = _tmp; return _tmp; end)());
expect(_ENV,"}");
 do return delegate:createSwitchStatement(discriminant,cases); end
end)
parseThrowStatement = (function (this)
local argument;
expectKeyword(_ENV,"throw");
if _bool(peekLineTerminator(_ENV)) then
throwError(_ENV,_obj({

}),Messages.NewlineAfterThrow);
end

_e((function () local _tmp = parseExpression(_ENV); argument  = _tmp; return _tmp; end)());
consumeSemicolon(_ENV);
 do return delegate:createThrowStatement(argument); end
end)
parseCatchClause = (function (this)
local startToken,body,param;
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
expectKeyword(_ENV,"catch");
expect(_ENV,"(");
if _bool(match(_ENV,")")) then
throwUnexpected(_ENV,lookahead);
end

_e((function () local _tmp = parseVariableIdentifier(_ENV); param  = _tmp; return _tmp; end)());
if _bool((strict and isRestrictedWord(_ENV,param.name))) then
throwErrorTolerant(_ENV,_obj({

}),Messages.StrictCatchVariable);
end

expect(_ENV,")");
_e((function () local _tmp = parseBlock(_ENV); body  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createCatchClause(param,body),startToken); end
end)
parseTryStatement = (function (this)
local finalizer,handlers,block;
handlers = _arr({},0);
finalizer = null;
expectKeyword(_ENV,"try");
_e((function () local _tmp = parseBlock(_ENV); block  = _tmp; return _tmp; end)());
if _bool(matchKeyword(_ENV,"catch")) then
handlers:push(parseCatchClause(_ENV));
end

if _bool(matchKeyword(_ENV,"finally")) then
lex(_ENV);
_e((function () local _tmp = parseBlock(_ENV); finalizer  = _tmp; return _tmp; end)());
end

if _bool(((handlers.length == 0) and not _bool(finalizer))) then
throwError(_ENV,_obj({

}),Messages.NoCatchOrFinally);
end

 do return delegate:createTryStatement(block,_arr({},0),handlers,finalizer); end
end)
parseDebuggerStatement = (function (this)
expectKeyword(_ENV,"debugger");
consumeSemicolon(_ENV);
 do return delegate:createDebuggerStatement(); end
end)
parseStatement = (function (this)
local startToken,key,labeledBody,expr,type;
type = lookahead.type;
if _bool((type == Token.EOF)) then
throwUnexpected(_ENV,lookahead);
end

if _bool(((type == Token.Punctuator) and (lookahead.value == "{"))) then
 do return parseBlock(_ENV); end
end

_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
if _bool((type == Token.Punctuator)) then
repeat
local _into = false;
local _cases = {[";"] = true,["("] = true};
if (not _cases[lookahead.value]) then
_into = true;
goto _default
end
if _into or (lookahead.value == ";") then
 do return delegate:markEnd(parseEmptyStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "(") then
 do return delegate:markEnd(parseExpressionStatement(_ENV),startToken); end
_into = true;
end
::_default::
if _into then
break;
_into = true;
end
until true
end

if _bool((type == Token.Keyword)) then
repeat
local _into = false;
local _cases = {["break"] = true,["continue"] = true,["debugger"] = true,["do"] = true,["for"] = true,["function"] = true,["if"] = true,["return"] = true,["switch"] = true,["throw"] = true,["try"] = true,["var"] = true,["while"] = true,["with"] = true};
if (not _cases[lookahead.value]) then
_into = true;
goto _default
end
if _into or (lookahead.value == "break") then
 do return delegate:markEnd(parseBreakStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "continue") then
 do return delegate:markEnd(parseContinueStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "debugger") then
 do return delegate:markEnd(parseDebuggerStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "do") then
 do return delegate:markEnd(parseDoWhileStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "for") then
 do return delegate:markEnd(parseForStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "function") then
 do return delegate:markEnd(parseFunctionDeclaration(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "if") then
 do return delegate:markEnd(parseIfStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "return") then
 do return delegate:markEnd(parseReturnStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "switch") then
 do return delegate:markEnd(parseSwitchStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "throw") then
 do return delegate:markEnd(parseThrowStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "try") then
 do return delegate:markEnd(parseTryStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "var") then
 do return delegate:markEnd(parseVariableStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "while") then
 do return delegate:markEnd(parseWhileStatement(_ENV),startToken); end
_into = true;
end
if _into or (lookahead.value == "with") then
 do return delegate:markEnd(parseWithStatement(_ENV),startToken); end
_into = true;
end
::_default::
if _into then
break;
_into = true;
end
until true
end

_e((function () local _tmp = parseExpression(_ENV); expr  = _tmp; return _tmp; end)());
if _bool(((expr.type == Syntax.Identifier) and match(_ENV,":"))) then
lex(_ENV);
_e((function () local _tmp = (_add("$",expr.name)); key  = _tmp; return _tmp; end)());
if _bool(Object.prototype.hasOwnProperty:call(state.labelSet,key)) then
throwError(_ENV,_obj({

}),Messages.Redeclaration,"Label",expr.name);
end

_e((function () local _tmp = true; state.labelSet[key]  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseStatement(_ENV); labeledBody  = _tmp; return _tmp; end)());
_e((function () local _tmp = state.labelSet[key]; state.labelSet[key] = nil; return _tmp ~= nil; end)());
 do return delegate:markEnd(delegate:createLabeledStatement(expr,labeledBody),startToken); end
end

consumeSemicolon(_ENV);
 do return delegate:markEnd(delegate:createExpressionStatement(expr),startToken); end
end)
parseFunctionSourceElements = (function (this)
local startToken,oldInFunctionBody,oldInSwitch,oldInIteration,oldLabelSet,firstRestricted,directive,token,sourceElements,sourceElement;
sourceElements = _arr({},0);
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
expect(_ENV,"{");
while _bool((index < length)) do
if _bool((lookahead.type ~= Token.StringLiteral)) then
break;
end

_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseSourceElement(_ENV); sourceElement  = _tmp; return _tmp; end)());
sourceElements:push(sourceElement);
if _bool((sourceElement.expression.type ~= Syntax.Literal)) then
break;
end

_e((function () local _tmp = source:slice((_add(token.start,1)),(token["end"] - 1)); directive  = _tmp; return _tmp; end)());
if _bool((directive == "use strict")) then
_e((function () local _tmp = true; strict  = _tmp; return _tmp; end)());
if _bool(firstRestricted) then
throwErrorTolerant(_ENV,firstRestricted,Messages.StrictOctalLiteral);
end

else
if _bool((not _bool(firstRestricted) and token.octal)) then
_e((function () local _tmp = token; firstRestricted  = _tmp; return _tmp; end)());
end

end

::_continue::
end

_e((function () local _tmp = state.labelSet; oldLabelSet  = _tmp; return _tmp; end)());
_e((function () local _tmp = state.inIteration; oldInIteration  = _tmp; return _tmp; end)());
_e((function () local _tmp = state.inSwitch; oldInSwitch  = _tmp; return _tmp; end)());
_e((function () local _tmp = state.inFunctionBody; oldInFunctionBody  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({

}); state.labelSet  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; state.inIteration  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; state.inSwitch  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; state.inFunctionBody  = _tmp; return _tmp; end)());
while _bool((index < length)) do
if _bool(match(_ENV,"}")) then
break;
end

_e((function () local _tmp = parseSourceElement(_ENV); sourceElement  = _tmp; return _tmp; end)());
if _bool((_type(sourceElement) == "undefined")) then
break;
end

sourceElements:push(sourceElement);
::_continue::
end

expect(_ENV,"}");
_e((function () local _tmp = oldLabelSet; state.labelSet  = _tmp; return _tmp; end)());
_e((function () local _tmp = oldInIteration; state.inIteration  = _tmp; return _tmp; end)());
_e((function () local _tmp = oldInSwitch; state.inSwitch  = _tmp; return _tmp; end)());
_e((function () local _tmp = oldInFunctionBody; state.inFunctionBody  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createBlockStatement(sourceElements),startToken); end
end)
parseParams = (function (this, firstRestricted)
local message,key,paramSet,stricted,token,params,param;
params = _arr({},0);
expect(_ENV,"(");
if _bool(not _bool(match(_ENV,")"))) then
_e((function () local _tmp = _obj({

}); paramSet  = _tmp; return _tmp; end)());
while _bool((index < length)) do
_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseVariableIdentifier(_ENV); param  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add("$",token.value)); key  = _tmp; return _tmp; end)());
if _bool(strict) then
if _bool(isRestrictedWord(_ENV,token.value)) then
_e((function () local _tmp = token; stricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = Messages.StrictParamName; message  = _tmp; return _tmp; end)());
end

if _bool(Object.prototype.hasOwnProperty:call(paramSet,key)) then
_e((function () local _tmp = token; stricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = Messages.StrictParamDupe; message  = _tmp; return _tmp; end)());
end

elseif _bool(not _bool(firstRestricted)) then
if _bool(isRestrictedWord(_ENV,token.value)) then
_e((function () local _tmp = token; firstRestricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = Messages.StrictParamName; message  = _tmp; return _tmp; end)());
elseif _bool(isStrictModeReservedWord(_ENV,token.value)) then
_e((function () local _tmp = token; firstRestricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = Messages.StrictReservedWord; message  = _tmp; return _tmp; end)());
elseif _bool(Object.prototype.hasOwnProperty:call(paramSet,key)) then
_e((function () local _tmp = token; firstRestricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = Messages.StrictParamDupe; message  = _tmp; return _tmp; end)());
end

end

params:push(param);
_e((function () local _tmp = true; paramSet[key]  = _tmp; return _tmp; end)());
if _bool(match(_ENV,")")) then
break;
end

expect(_ENV,",");
::_continue::
end

end

expect(_ENV,")");
 do return _obj({
["params"] = params,
["stricted"] = stricted,
["firstRestricted"] = firstRestricted,
["message"] = message
}); end
end)
parseFunctionDeclaration = (function (this)
local startToken,previousStrict,message,firstRestricted,tmp,stricted,token,body,params,id;
params = _arr({},0);
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
expectKeyword(_ENV,"function");
_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseVariableIdentifier(_ENV); id  = _tmp; return _tmp; end)());
if _bool(strict) then
if _bool(isRestrictedWord(_ENV,token.value)) then
throwErrorTolerant(_ENV,token,Messages.StrictFunctionName);
end

else
if _bool(isRestrictedWord(_ENV,token.value)) then
_e((function () local _tmp = token; firstRestricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = Messages.StrictFunctionName; message  = _tmp; return _tmp; end)());
elseif _bool(isStrictModeReservedWord(_ENV,token.value)) then
_e((function () local _tmp = token; firstRestricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = Messages.StrictReservedWord; message  = _tmp; return _tmp; end)());
end

end

_e((function () local _tmp = parseParams(_ENV,firstRestricted); tmp  = _tmp; return _tmp; end)());
_e((function () local _tmp = tmp.params; params  = _tmp; return _tmp; end)());
_e((function () local _tmp = tmp.stricted; stricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = tmp.firstRestricted; firstRestricted  = _tmp; return _tmp; end)());
if _bool(tmp.message) then
_e((function () local _tmp = tmp.message; message  = _tmp; return _tmp; end)());
end

_e((function () local _tmp = strict; previousStrict  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseFunctionSourceElements(_ENV); body  = _tmp; return _tmp; end)());
if _bool((strict and firstRestricted)) then
throwError(_ENV,firstRestricted,message);
end

if _bool((strict and stricted)) then
throwErrorTolerant(_ENV,stricted,message);
end

_e((function () local _tmp = previousStrict; strict  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createFunctionDeclaration(id,params,_arr({},0),body),startToken); end
end)
parseFunctionExpression = (function (this)
local startToken,previousStrict,body,params,tmp,message,firstRestricted,stricted,id,token;
id = null;
params = _arr({},0);
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
expectKeyword(_ENV,"function");
if _bool(not _bool(match(_ENV,"("))) then
_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseVariableIdentifier(_ENV); id  = _tmp; return _tmp; end)());
if _bool(strict) then
if _bool(isRestrictedWord(_ENV,token.value)) then
throwErrorTolerant(_ENV,token,Messages.StrictFunctionName);
end

else
if _bool(isRestrictedWord(_ENV,token.value)) then
_e((function () local _tmp = token; firstRestricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = Messages.StrictFunctionName; message  = _tmp; return _tmp; end)());
elseif _bool(isStrictModeReservedWord(_ENV,token.value)) then
_e((function () local _tmp = token; firstRestricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = Messages.StrictReservedWord; message  = _tmp; return _tmp; end)());
end

end

end

_e((function () local _tmp = parseParams(_ENV,firstRestricted); tmp  = _tmp; return _tmp; end)());
_e((function () local _tmp = tmp.params; params  = _tmp; return _tmp; end)());
_e((function () local _tmp = tmp.stricted; stricted  = _tmp; return _tmp; end)());
_e((function () local _tmp = tmp.firstRestricted; firstRestricted  = _tmp; return _tmp; end)());
if _bool(tmp.message) then
_e((function () local _tmp = tmp.message; message  = _tmp; return _tmp; end)());
end

_e((function () local _tmp = strict; previousStrict  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseFunctionSourceElements(_ENV); body  = _tmp; return _tmp; end)());
if _bool((strict and firstRestricted)) then
throwError(_ENV,firstRestricted,message);
end

if _bool((strict and stricted)) then
throwErrorTolerant(_ENV,stricted,message);
end

_e((function () local _tmp = previousStrict; strict  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createFunctionExpression(id,params,_arr({},0),body),startToken); end
end)
parseSourceElement = (function (this)
if _bool((lookahead.type == Token.Keyword)) then
repeat
local _into = false;
local _cases = {["const"] = true,["let"] = true,["function"] = true};
if (not _cases[lookahead.value]) then
_into = true;
goto _default
end
if _into or (lookahead.value == "const") then

_into = true;
end
if _into or (lookahead.value == "let") then
 do return parseConstLetDeclaration(_ENV,lookahead.value); end
_into = true;
end
if _into or (lookahead.value == "function") then
 do return parseFunctionDeclaration(_ENV); end
_into = true;
end
::_default::
if _into then
 do return parseStatement(_ENV); end
_into = true;
end
until true
end

if _bool((lookahead.type ~= Token.EOF)) then
 do return parseStatement(_ENV); end
end

end)
parseSourceElements = (function (this)
local firstRestricted,directive,token,sourceElements,sourceElement;
sourceElements = _arr({},0);
while _bool((index < length)) do
_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
if _bool((token.type ~= Token.StringLiteral)) then
break;
end

_e((function () local _tmp = parseSourceElement(_ENV); sourceElement  = _tmp; return _tmp; end)());
sourceElements:push(sourceElement);
if _bool((sourceElement.expression.type ~= Syntax.Literal)) then
break;
end

_e((function () local _tmp = source:slice((_add(token.start,1)),(token["end"] - 1)); directive  = _tmp; return _tmp; end)());
if _bool((directive == "use strict")) then
_e((function () local _tmp = true; strict  = _tmp; return _tmp; end)());
if _bool(firstRestricted) then
throwErrorTolerant(_ENV,firstRestricted,Messages.StrictOctalLiteral);
end

else
if _bool((not _bool(firstRestricted) and token.octal)) then
_e((function () local _tmp = token; firstRestricted  = _tmp; return _tmp; end)());
end

end

::_continue::
end

while _bool((index < length)) do
_e((function () local _tmp = parseSourceElement(_ENV); sourceElement  = _tmp; return _tmp; end)());
if _bool((_type(sourceElement) == "undefined")) then
break;
end

sourceElements:push(sourceElement);
::_continue::
end

 do return sourceElements; end
end)
parseProgram = (function (this)
local startToken,body;
skipComment(_ENV);
peek(_ENV);
_e((function () local _tmp = lookahead; startToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; strict  = _tmp; return _tmp; end)());
_e((function () local _tmp = parseSourceElements(_ENV); body  = _tmp; return _tmp; end)());
 do return delegate:markEnd(delegate:createProgram(body),startToken); end
end)
filterTokenLocation = (function (this)
local tokens,token,entry,i;
tokens = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < extra.tokens.length)) do
_e((function () local _tmp = extra.tokens[i]; entry  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["type"] = entry.type,
["value"] = entry.value
}); token  = _tmp; return _tmp; end)());
if _bool(extra.range) then
_e((function () local _tmp = entry.range; token.range  = _tmp; return _tmp; end)());
end

if _bool(extra.loc) then
_e((function () local _tmp = entry.loc; token.loc  = _tmp; return _tmp; end)());
end

tokens:push(token);
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

_e((function () local _tmp = tokens; extra.tokens  = _tmp; return _tmp; end)());
end)
tokenize = (function (this, code, options)
local tokens,token,toString;
_e((function () local _tmp = String; toString  = _tmp; return _tmp; end)());
if _bool(((_type(code) ~= "string") and not _bool((_instanceof(code,String))))) then
_e((function () local _tmp = toString(_ENV,code); code  = _tmp; return _tmp; end)());
end

_e((function () local _tmp = SyntaxTreeDelegate; delegate  = _tmp; return _tmp; end)());
_e((function () local _tmp = code; source  = _tmp; return _tmp; end)());
_e((function () local _tmp = 0; index  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_bool((source.length > 0)) and {1} or {0})[1]; lineNumber  = _tmp; return _tmp; end)());
_e((function () local _tmp = 0; lineStart  = _tmp; return _tmp; end)());
_e((function () local _tmp = source.length; length  = _tmp; return _tmp; end)());
_e((function () local _tmp = null; lookahead  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["allowIn"] = true,
["labelSet"] = _obj({

}),
["inFunctionBody"] = false,
["inIteration"] = false,
["inSwitch"] = false,
["lastCommentStart"] = -_tonum(1)
}); state  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({

}); extra  = _tmp; return _tmp; end)());
_e((function () local _tmp = (options or _obj({

})); options  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; options.tokens  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); extra.tokens  = _tmp; return _tmp; end)());
_e((function () local _tmp = true; extra.tokenize  = _tmp; return _tmp; end)());
_e((function () local _tmp = -_tonum(1); extra.openParenToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = -_tonum(1); extra.openCurlyToken  = _tmp; return _tmp; end)());
_e((function () local _tmp = ((_type(options.range) == "boolean") and options.range); extra.range  = _tmp; return _tmp; end)());
_e((function () local _tmp = ((_type(options.loc) == "boolean") and options.loc); extra.loc  = _tmp; return _tmp; end)());
if _bool(((_type(options.comment) == "boolean") and options.comment)) then
_e((function () local _tmp = _arr({},0); extra.comments  = _tmp; return _tmp; end)());
end

if _bool(((_type(options.tolerant) == "boolean") and options.tolerant)) then
_e((function () local _tmp = _arr({},0); extra.errors  = _tmp; return _tmp; end)());
end

local _status, _return = _pcall(function()
peek(_ENV);
if _bool((lookahead.type == Token.EOF)) then
 do return extra.tokens; end
end

_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
while _bool((lookahead.type ~= Token.EOF)) do
local _status, _return = _pcall(function()
_e((function () local _tmp = lex(_ENV); token  = _tmp; return _tmp; end)());
end);
if _status then
if _return ~= nil then return _return; end
else
local _cstatus, _creturn = _pcall(function()
local lexError = _return;
_e((function () local _tmp = lookahead; token  = _tmp; return _tmp; end)());
if _bool(extra.errors) then
extra.errors:push(lexError);
do return _break; end
else
_throw(lexError,0)
end

end);
if _cstatus then
if _return == _break then break; end
else _throw(_creturn,0); end
end

::_continue::
end

filterTokenLocation(_ENV);
_e((function () local _tmp = extra.tokens; tokens  = _tmp; return _tmp; end)());
if _bool((_type(extra.comments) ~= "undefined")) then
_e((function () local _tmp = extra.comments; tokens.comments  = _tmp; return _tmp; end)());
end

if _bool((_type(extra.errors) ~= "undefined")) then
_e((function () local _tmp = extra.errors; tokens.errors  = _tmp; return _tmp; end)());
end

end);
if _status then
_e((function () local _tmp = _obj({

}); extra  = _tmp; return _tmp; end)());
else
local _cstatus, _creturn = _pcall(function()
local e = _return;
_throw(e,0)
end);
_e((function () local _tmp = _obj({

}); extra  = _tmp; return _tmp; end)());
if _cstatus then
else _throw(_creturn,0); end
end

 do return tokens; end
end)
parse = (function (this, code, options)
local toString,program;
_e((function () local _tmp = String; toString  = _tmp; return _tmp; end)());
if _bool(((_type(code) ~= "string") and not _bool((_instanceof(code,String))))) then
_e((function () local _tmp = toString(_ENV,code); code  = _tmp; return _tmp; end)());
end

_e((function () local _tmp = SyntaxTreeDelegate; delegate  = _tmp; return _tmp; end)());
_e((function () local _tmp = code; source  = _tmp; return _tmp; end)());
_e((function () local _tmp = 0; index  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_bool((source.length > 0)) and {1} or {0})[1]; lineNumber  = _tmp; return _tmp; end)());
_e((function () local _tmp = 0; lineStart  = _tmp; return _tmp; end)());
_e((function () local _tmp = source.length; length  = _tmp; return _tmp; end)());
_e((function () local _tmp = null; lookahead  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["allowIn"] = true,
["labelSet"] = _obj({

}),
["inFunctionBody"] = false,
["inIteration"] = false,
["inSwitch"] = false,
["lastCommentStart"] = -_tonum(1)
}); state  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({

}); extra  = _tmp; return _tmp; end)());
if _bool((_type(options) ~= "undefined")) then
_e((function () local _tmp = ((_type(options.range) == "boolean") and options.range); extra.range  = _tmp; return _tmp; end)());
_e((function () local _tmp = ((_type(options.loc) == "boolean") and options.loc); extra.loc  = _tmp; return _tmp; end)());
_e((function () local _tmp = ((_type(options.attachComment) == "boolean") and options.attachComment); extra.attachComment  = _tmp; return _tmp; end)());
if _bool(((extra.loc and (options.source ~= null)) and (options.source ~= undefined))) then
_e((function () local _tmp = toString(_ENV,options.source); extra.source  = _tmp; return _tmp; end)());
end

if _bool(((_type(options.tokens) == "boolean") and options.tokens)) then
_e((function () local _tmp = _arr({},0); extra.tokens  = _tmp; return _tmp; end)());
end

if _bool(((_type(options.comment) == "boolean") and options.comment)) then
_e((function () local _tmp = _arr({},0); extra.comments  = _tmp; return _tmp; end)());
end

if _bool(((_type(options.tolerant) == "boolean") and options.tolerant)) then
_e((function () local _tmp = _arr({},0); extra.errors  = _tmp; return _tmp; end)());
end

if _bool(extra.attachComment) then
_e((function () local _tmp = true; extra.range  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); extra.comments  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); extra.bottomRightStack  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); extra.trailingComments  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); extra.leadingComments  = _tmp; return _tmp; end)());
end

end

local _status, _return = _pcall(function()
_e((function () local _tmp = parseProgram(_ENV); program  = _tmp; return _tmp; end)());
if _bool((_type(extra.comments) ~= "undefined")) then
_e((function () local _tmp = extra.comments; program.comments  = _tmp; return _tmp; end)());
end

if _bool((_type(extra.tokens) ~= "undefined")) then
filterTokenLocation(_ENV);
_e((function () local _tmp = extra.tokens; program.tokens  = _tmp; return _tmp; end)());
end

if _bool((_type(extra.errors) ~= "undefined")) then
_e((function () local _tmp = extra.errors; program.errors  = _tmp; return _tmp; end)());
end

end);
if _status then
_e((function () local _tmp = _obj({

}); extra  = _tmp; return _tmp; end)());
else
local _cstatus, _creturn = _pcall(function()
local e = _return;
_throw(e,0)
end);
_e((function () local _tmp = _obj({

}); extra  = _tmp; return _tmp; end)());
if _cstatus then
else _throw(_creturn,0); end
end

 do return program; end
end)_e("use strict");
_e((function () local _tmp = _obj({
["BooleanLiteral"] = 1,
["EOF"] = 2,
["Identifier"] = 3,
["Keyword"] = 4,
["NullLiteral"] = 5,
["NumericLiteral"] = 6,
["Punctuator"] = 7,
["StringLiteral"] = 8,
["RegularExpression"] = 9
}); Token  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({

}); TokenName  = _tmp; return _tmp; end)());
_e((function () local _tmp = "Boolean"; TokenName[Token.BooleanLiteral]  = _tmp; return _tmp; end)());
_e((function () local _tmp = "<end>"; TokenName[Token.EOF]  = _tmp; return _tmp; end)());
_e((function () local _tmp = "Identifier"; TokenName[Token.Identifier]  = _tmp; return _tmp; end)());
_e((function () local _tmp = "Keyword"; TokenName[Token.Keyword]  = _tmp; return _tmp; end)());
_e((function () local _tmp = "Null"; TokenName[Token.NullLiteral]  = _tmp; return _tmp; end)());
_e((function () local _tmp = "Numeric"; TokenName[Token.NumericLiteral]  = _tmp; return _tmp; end)());
_e((function () local _tmp = "Punctuator"; TokenName[Token.Punctuator]  = _tmp; return _tmp; end)());
_e((function () local _tmp = "String"; TokenName[Token.StringLiteral]  = _tmp; return _tmp; end)());
_e((function () local _tmp = "RegularExpression"; TokenName[Token.RegularExpression]  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({[0]="(","{","[","in","typeof","instanceof","new","return","case","delete","throw","void","=","+=","-=","*=","/=","%=","<<=",">>=",">>>=","&=","|=","^=",",","+","-","*","/","%","++","--","<<",">>",">>>","&","|","^","!","~","&&","||","?",":","===","==",">=","<=","<",">","!=","!=="},52); FnExprTokens  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["AssignmentExpression"] = "AssignmentExpression",
["ArrayExpression"] = "ArrayExpression",
["BlockStatement"] = "BlockStatement",
["BinaryExpression"] = "BinaryExpression",
["BreakStatement"] = "BreakStatement",
["CallExpression"] = "CallExpression",
["CatchClause"] = "CatchClause",
["ConditionalExpression"] = "ConditionalExpression",
["ContinueStatement"] = "ContinueStatement",
["DoWhileStatement"] = "DoWhileStatement",
["DebuggerStatement"] = "DebuggerStatement",
["EmptyStatement"] = "EmptyStatement",
["ExpressionStatement"] = "ExpressionStatement",
["ForStatement"] = "ForStatement",
["ForInStatement"] = "ForInStatement",
["FunctionDeclaration"] = "FunctionDeclaration",
["FunctionExpression"] = "FunctionExpression",
["Identifier"] = "Identifier",
["IfStatement"] = "IfStatement",
["Literal"] = "Literal",
["LabeledStatement"] = "LabeledStatement",
["LogicalExpression"] = "LogicalExpression",
["MemberExpression"] = "MemberExpression",
["NewExpression"] = "NewExpression",
["ObjectExpression"] = "ObjectExpression",
["Program"] = "Program",
["Property"] = "Property",
["ReturnStatement"] = "ReturnStatement",
["SequenceExpression"] = "SequenceExpression",
["SwitchStatement"] = "SwitchStatement",
["SwitchCase"] = "SwitchCase",
["ThisExpression"] = "ThisExpression",
["ThrowStatement"] = "ThrowStatement",
["TryStatement"] = "TryStatement",
["UnaryExpression"] = "UnaryExpression",
["UpdateExpression"] = "UpdateExpression",
["VariableDeclaration"] = "VariableDeclaration",
["VariableDeclarator"] = "VariableDeclarator",
["WhileStatement"] = "WhileStatement",
["WithStatement"] = "WithStatement"
}); Syntax  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["Data"] = 1,
["Get"] = 2,
["Set"] = 4
}); PropertyKind  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["UnexpectedToken"] = "Unexpected token %0",
["UnexpectedNumber"] = "Unexpected number",
["UnexpectedString"] = "Unexpected string",
["UnexpectedIdentifier"] = "Unexpected identifier",
["UnexpectedReserved"] = "Unexpected reserved word",
["UnexpectedEOS"] = "Unexpected end of input",
["NewlineAfterThrow"] = "Illegal newline after throw",
["InvalidRegExp"] = "Invalid regular expression",
["UnterminatedRegExp"] = "Invalid regular expression: missing /",
["InvalidLHSInAssignment"] = "Invalid left-hand side in assignment",
["InvalidLHSInForIn"] = "Invalid left-hand side in for-in",
["MultipleDefaultsInSwitch"] = "More than one default clause in switch statement",
["NoCatchOrFinally"] = "Missing catch or finally after try",
["UnknownLabel"] = "Undefined label '%0'",
["Redeclaration"] = "%0 '%1' has already been declared",
["IllegalContinue"] = "Illegal continue statement",
["IllegalBreak"] = "Illegal break statement",
["IllegalReturn"] = "Illegal return statement",
["StrictModeWith"] = "Strict mode code may not include a with statement",
["StrictCatchVariable"] = "Catch variable may not be eval or arguments in strict mode",
["StrictVarName"] = "Variable name may not be eval or arguments in strict mode",
["StrictParamName"] = "Parameter name eval or arguments is not allowed in strict mode",
["StrictParamDupe"] = "Strict mode function may not have duplicate parameter names",
["StrictFunctionName"] = "Function name may not be eval or arguments in strict mode",
["StrictOctalLiteral"] = "Octal literals are not allowed in strict mode.",
["StrictDelete"] = "Delete of an unqualified identifier in strict mode.",
["StrictDuplicateProperty"] = "Duplicate data property in object literal not allowed in strict mode",
["AccessorDataProperty"] = "Object literal may not have data and accessor property with the same name",
["AccessorGetSet"] = "Object literal may not have multiple get/set accessors with the same name",
["StrictLHSAssignment"] = "Assignment to eval or arguments is not allowed in strict mode",
["StrictLHSPostfix"] = "Postfix increment/decrement may not have eval or arguments operand in strict mode",
["StrictLHSPrefix"] = "Prefix increment/decrement may not have eval or arguments operand in strict mode",
["StrictReservedWord"] = "Use of future reserved word in strict mode"
}); Messages  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["NonAsciiIdentifierStart"] = _new(RegExp,"[\194\170\194\181\194\186\195\128-\195\150\195\152-\195\182\195\184-\203\129\203\134-\203\145\203\160-\203\164\203\172\203\174\205\176-\205\180\205\182\205\183\205\186-\205\189\206\134\206\136-\206\138\206\140\206\142-\206\161\206\163-\207\181\207\183-\210\129\210\138-\212\167\212\177-\213\150\213\153\213\161-\214\135\215\144-\215\170\215\176-\215\178\216\160-\217\138\217\174\217\175\217\177-\219\147\219\149\219\165\219\166\219\174\219\175\219\186-\219\188\219\191\220\144\220\146-\220\175\221\141-\222\165\222\177\223\138-\223\170\223\180\223\181\223\186\224\160\128-\224\160\149\224\160\154\224\160\164\224\160\168\224\161\128-\224\161\152\224\162\160\224\162\162-\224\162\172\224\164\132-\224\164\185\224\164\189\224\165\144\224\165\152-\224\165\161\224\165\177-\224\165\183\224\165\185-\224\165\191\224\166\133-\224\166\140\224\166\143\224\166\144\224\166\147-\224\166\168\224\166\170-\224\166\176\224\166\178\224\166\182-\224\166\185\224\166\189\224\167\142\224\167\156\224\167\157\224\167\159-\224\167\161\224\167\176\224\167\177\224\168\133-\224\168\138\224\168\143\224\168\144\224\168\147-\224\168\168\224\168\170-\224\168\176\224\168\178\224\168\179\224\168\181\224\168\182\224\168\184\224\168\185\224\169\153-\224\169\156\224\169\158\224\169\178-\224\169\180\224\170\133-\224\170\141\224\170\143-\224\170\145\224\170\147-\224\170\168\224\170\170-\224\170\176\224\170\178\224\170\179\224\170\181-\224\170\185\224\170\189\224\171\144\224\171\160\224\171\161\224\172\133-\224\172\140\224\172\143\224\172\144\224\172\147-\224\172\168\224\172\170-\224\172\176\224\172\178\224\172\179\224\172\181-\224\172\185\224\172\189\224\173\156\224\173\157\224\173\159-\224\173\161\224\173\177\224\174\131\224\174\133-\224\174\138\224\174\142-\224\174\144\224\174\146-\224\174\149\224\174\153\224\174\154\224\174\156\224\174\158\224\174\159\224\174\163\224\174\164\224\174\168-\224\174\170\224\174\174-\224\174\185\224\175\144\224\176\133-\224\176\140\224\176\142-\224\176\144\224\176\146-\224\176\168\224\176\170-\224\176\179\224\176\181-\224\176\185\224\176\189\224\177\152\224\177\153\224\177\160\224\177\161\224\178\133-\224\178\140\224\178\142-\224\178\144\224\178\146-\224\178\168\224\178\170-\224\178\179\224\178\181-\224\178\185\224\178\189\224\179\158\224\179\160\224\179\161\224\179\177\224\179\178\224\180\133-\224\180\140\224\180\142-\224\180\144\224\180\146-\224\180\186\224\180\189\224\181\142\224\181\160\224\181\161\224\181\186-\224\181\191\224\182\133-\224\182\150\224\182\154-\224\182\177\224\182\179-\224\182\187\224\182\189\224\183\128-\224\183\134\224\184\129-\224\184\176\224\184\178\224\184\179\224\185\128-\224\185\134\224\186\129\224\186\130\224\186\132\224\186\135\224\186\136\224\186\138\224\186\141\224\186\148-\224\186\151\224\186\153-\224\186\159\224\186\161-\224\186\163\224\186\165\224\186\167\224\186\170\224\186\171\224\186\173-\224\186\176\224\186\178\224\186\179\224\186\189\224\187\128-\224\187\132\224\187\134\224\187\156-\224\187\159\224\188\128\224\189\128-\224\189\135\224\189\137-\224\189\172\224\190\136-\224\190\140\225\128\128-\225\128\170\225\128\191\225\129\144-\225\129\149\225\129\154-\225\129\157\225\129\161\225\129\165\225\129\166\225\129\174-\225\129\176\225\129\181-\225\130\129\225\130\142\225\130\160-\225\131\133\225\131\135\225\131\141\225\131\144-\225\131\186\225\131\188-\225\137\136\225\137\138-\225\137\141\225\137\144-\225\137\150\225\137\152\225\137\154-\225\137\157\225\137\160-\225\138\136\225\138\138-\225\138\141\225\138\144-\225\138\176\225\138\178-\225\138\181\225\138\184-\225\138\190\225\139\128\225\139\130-\225\139\133\225\139\136-\225\139\150\225\139\152-\225\140\144\225\140\146-\225\140\149\225\140\152-\225\141\154\225\142\128-\225\142\143\225\142\160-\225\143\180\225\144\129-\225\153\172\225\153\175-\225\153\191\225\154\129-\225\154\154\225\154\160-\225\155\170\225\155\174-\225\155\176\225\156\128-\225\156\140\225\156\142-\225\156\145\225\156\160-\225\156\177\225\157\128-\225\157\145\225\157\160-\225\157\172\225\157\174-\225\157\176\225\158\128-\225\158\179\225\159\151\225\159\156\225\160\160-\225\161\183\225\162\128-\225\162\168\225\162\170\225\162\176-\225\163\181\225\164\128-\225\164\156\225\165\144-\225\165\173\225\165\176-\225\165\180\225\166\128-\225\166\171\225\167\129-\225\167\135\225\168\128-\225\168\150\225\168\160-\225\169\148\225\170\167\225\172\133-\225\172\179\225\173\133-\225\173\139\225\174\131-\225\174\160\225\174\174\225\174\175\225\174\186-\225\175\165\225\176\128-\225\176\163\225\177\141-\225\177\143\225\177\154-\225\177\189\225\179\169-\225\179\172\225\179\174-\225\179\177\225\179\181\225\179\182\225\180\128-\225\182\191\225\184\128-\225\188\149\225\188\152-\225\188\157\225\188\160-\225\189\133\225\189\136-\225\189\141\225\189\144-\225\189\151\225\189\153\225\189\155\225\189\157\225\189\159-\225\189\189\225\190\128-\225\190\180\225\190\182-\225\190\188\225\190\190\225\191\130-\225\191\132\225\191\134-\225\191\140\225\191\144-\225\191\147\225\191\150-\225\191\155\225\191\160-\225\191\172\225\191\178-\225\191\180\225\191\182-\225\191\188\226\129\177\226\129\191\226\130\144-\226\130\156\226\132\130\226\132\135\226\132\138-\226\132\147\226\132\149\226\132\153-\226\132\157\226\132\164\226\132\166\226\132\168\226\132\170-\226\132\173\226\132\175-\226\132\185\226\132\188-\226\132\191\226\133\133-\226\133\137\226\133\142\226\133\160-\226\134\136\226\176\128-\226\176\174\226\176\176-\226\177\158\226\177\160-\226\179\164\226\179\171-\226\179\174\226\179\178\226\179\179\226\180\128-\226\180\165\226\180\167\226\180\173\226\180\176-\226\181\167\226\181\175\226\182\128-\226\182\150\226\182\160-\226\182\166\226\182\168-\226\182\174\226\182\176-\226\182\182\226\182\184-\226\182\190\226\183\128-\226\183\134\226\183\136-\226\183\142\226\183\144-\226\183\150\226\183\152-\226\183\158\226\184\175\227\128\133-\227\128\135\227\128\161-\227\128\169\227\128\177-\227\128\181\227\128\184-\227\128\188\227\129\129-\227\130\150\227\130\157-\227\130\159\227\130\161-\227\131\186\227\131\188-\227\131\191\227\132\133-\227\132\173\227\132\177-\227\134\142\227\134\160-\227\134\186\227\135\176-\227\135\191\227\144\128-\228\182\181\228\184\128-\233\191\140\234\128\128-\234\146\140\234\147\144-\234\147\189\234\148\128-\234\152\140\234\152\144-\234\152\159\234\152\170\234\152\171\234\153\128-\234\153\174\234\153\191-\234\154\151\234\154\160-\234\155\175\234\156\151-\234\156\159\234\156\162-\234\158\136\234\158\139-\234\158\142\234\158\144-\234\158\147\234\158\160-\234\158\170\234\159\184-\234\160\129\234\160\131-\234\160\133\234\160\135-\234\160\138\234\160\140-\234\160\162\234\161\128-\234\161\179\234\162\130-\234\162\179\234\163\178-\234\163\183\234\163\187\234\164\138-\234\164\165\234\164\176-\234\165\134\234\165\160-\234\165\188\234\166\132-\234\166\178\234\167\143\234\168\128-\234\168\168\234\169\128-\234\169\130\234\169\132-\234\169\139\234\169\160-\234\169\182\234\169\186\234\170\128-\234\170\175\234\170\177\234\170\181\234\170\182\234\170\185-\234\170\189\234\171\128\234\171\130\234\171\155-\234\171\157\234\171\160-\234\171\170\234\171\178-\234\171\180\234\172\129-\234\172\134\234\172\137-\234\172\142\234\172\145-\234\172\150\234\172\160-\234\172\166\234\172\168-\234\172\174\234\175\128-\234\175\162\234\176\128-\237\158\163\237\158\176-\237\159\134\237\159\139-\237\159\187\239\164\128-\239\169\173\239\169\176-\239\171\153\239\172\128-\239\172\134\239\172\147-\239\172\151\239\172\157\239\172\159-\239\172\168\239\172\170-\239\172\182\239\172\184-\239\172\188\239\172\190\239\173\128\239\173\129\239\173\131\239\173\132\239\173\134-\239\174\177\239\175\147-\239\180\189\239\181\144-\239\182\143\239\182\146-\239\183\135\239\183\176-\239\183\187\239\185\176-\239\185\180\239\185\182-\239\187\188\239\188\161-\239\188\186\239\189\129-\239\189\154\239\189\166-\239\190\190\239\191\130-\239\191\135\239\191\138-\239\191\143\239\191\146-\239\191\151\239\191\154-\239\191\156]"),
["NonAsciiIdentifierPart"] = _new(RegExp,"[\194\170\194\181\194\186\195\128-\195\150\195\152-\195\182\195\184-\203\129\203\134-\203\145\203\160-\203\164\203\172\203\174\204\128-\205\180\205\182\205\183\205\186-\205\189\206\134\206\136-\206\138\206\140\206\142-\206\161\206\163-\207\181\207\183-\210\129\210\131-\210\135\210\138-\212\167\212\177-\213\150\213\153\213\161-\214\135\214\145-\214\189\214\191\215\129\215\130\215\132\215\133\215\135\215\144-\215\170\215\176-\215\178\216\144-\216\154\216\160-\217\169\217\174-\219\147\219\149-\219\156\219\159-\219\168\219\170-\219\188\219\191\220\144-\221\138\221\141-\222\177\223\128-\223\181\223\186\224\160\128-\224\160\173\224\161\128-\224\161\155\224\162\160\224\162\162-\224\162\172\224\163\164-\224\163\190\224\164\128-\224\165\163\224\165\166-\224\165\175\224\165\177-\224\165\183\224\165\185-\224\165\191\224\166\129-\224\166\131\224\166\133-\224\166\140\224\166\143\224\166\144\224\166\147-\224\166\168\224\166\170-\224\166\176\224\166\178\224\166\182-\224\166\185\224\166\188-\224\167\132\224\167\135\224\167\136\224\167\139-\224\167\142\224\167\151\224\167\156\224\167\157\224\167\159-\224\167\163\224\167\166-\224\167\177\224\168\129-\224\168\131\224\168\133-\224\168\138\224\168\143\224\168\144\224\168\147-\224\168\168\224\168\170-\224\168\176\224\168\178\224\168\179\224\168\181\224\168\182\224\168\184\224\168\185\224\168\188\224\168\190-\224\169\130\224\169\135\224\169\136\224\169\139-\224\169\141\224\169\145\224\169\153-\224\169\156\224\169\158\224\169\166-\224\169\181\224\170\129-\224\170\131\224\170\133-\224\170\141\224\170\143-\224\170\145\224\170\147-\224\170\168\224\170\170-\224\170\176\224\170\178\224\170\179\224\170\181-\224\170\185\224\170\188-\224\171\133\224\171\135-\224\171\137\224\171\139-\224\171\141\224\171\144\224\171\160-\224\171\163\224\171\166-\224\171\175\224\172\129-\224\172\131\224\172\133-\224\172\140\224\172\143\224\172\144\224\172\147-\224\172\168\224\172\170-\224\172\176\224\172\178\224\172\179\224\172\181-\224\172\185\224\172\188-\224\173\132\224\173\135\224\173\136\224\173\139-\224\173\141\224\173\150\224\173\151\224\173\156\224\173\157\224\173\159-\224\173\163\224\173\166-\224\173\175\224\173\177\224\174\130\224\174\131\224\174\133-\224\174\138\224\174\142-\224\174\144\224\174\146-\224\174\149\224\174\153\224\174\154\224\174\156\224\174\158\224\174\159\224\174\163\224\174\164\224\174\168-\224\174\170\224\174\174-\224\174\185\224\174\190-\224\175\130\224\175\134-\224\175\136\224\175\138-\224\175\141\224\175\144\224\175\151\224\175\166-\224\175\175\224\176\129-\224\176\131\224\176\133-\224\176\140\224\176\142-\224\176\144\224\176\146-\224\176\168\224\176\170-\224\176\179\224\176\181-\224\176\185\224\176\189-\224\177\132\224\177\134-\224\177\136\224\177\138-\224\177\141\224\177\149\224\177\150\224\177\152\224\177\153\224\177\160-\224\177\163\224\177\166-\224\177\175\224\178\130\224\178\131\224\178\133-\224\178\140\224\178\142-\224\178\144\224\178\146-\224\178\168\224\178\170-\224\178\179\224\178\181-\224\178\185\224\178\188-\224\179\132\224\179\134-\224\179\136\224\179\138-\224\179\141\224\179\149\224\179\150\224\179\158\224\179\160-\224\179\163\224\179\166-\224\179\175\224\179\177\224\179\178\224\180\130\224\180\131\224\180\133-\224\180\140\224\180\142-\224\180\144\224\180\146-\224\180\186\224\180\189-\224\181\132\224\181\134-\224\181\136\224\181\138-\224\181\142\224\181\151\224\181\160-\224\181\163\224\181\166-\224\181\175\224\181\186-\224\181\191\224\182\130\224\182\131\224\182\133-\224\182\150\224\182\154-\224\182\177\224\182\179-\224\182\187\224\182\189\224\183\128-\224\183\134\224\183\138\224\183\143-\224\183\148\224\183\150\224\183\152-\224\183\159\224\183\178\224\183\179\224\184\129-\224\184\186\224\185\128-\224\185\142\224\185\144-\224\185\153\224\186\129\224\186\130\224\186\132\224\186\135\224\186\136\224\186\138\224\186\141\224\186\148-\224\186\151\224\186\153-\224\186\159\224\186\161-\224\186\163\224\186\165\224\186\167\224\186\170\224\186\171\224\186\173-\224\186\185\224\186\187-\224\186\189\224\187\128-\224\187\132\224\187\134\224\187\136-\224\187\141\224\187\144-\224\187\153\224\187\156-\224\187\159\224\188\128\224\188\152\224\188\153\224\188\160-\224\188\169\224\188\181\224\188\183\224\188\185\224\188\190-\224\189\135\224\189\137-\224\189\172\224\189\177-\224\190\132\224\190\134-\224\190\151\224\190\153-\224\190\188\224\191\134\225\128\128-\225\129\137\225\129\144-\225\130\157\225\130\160-\225\131\133\225\131\135\225\131\141\225\131\144-\225\131\186\225\131\188-\225\137\136\225\137\138-\225\137\141\225\137\144-\225\137\150\225\137\152\225\137\154-\225\137\157\225\137\160-\225\138\136\225\138\138-\225\138\141\225\138\144-\225\138\176\225\138\178-\225\138\181\225\138\184-\225\138\190\225\139\128\225\139\130-\225\139\133\225\139\136-\225\139\150\225\139\152-\225\140\144\225\140\146-\225\140\149\225\140\152-\225\141\154\225\141\157-\225\141\159\225\142\128-\225\142\143\225\142\160-\225\143\180\225\144\129-\225\153\172\225\153\175-\225\153\191\225\154\129-\225\154\154\225\154\160-\225\155\170\225\155\174-\225\155\176\225\156\128-\225\156\140\225\156\142-\225\156\148\225\156\160-\225\156\180\225\157\128-\225\157\147\225\157\160-\225\157\172\225\157\174-\225\157\176\225\157\178\225\157\179\225\158\128-\225\159\147\225\159\151\225\159\156\225\159\157\225\159\160-\225\159\169\225\160\139-\225\160\141\225\160\144-\225\160\153\225\160\160-\225\161\183\225\162\128-\225\162\170\225\162\176-\225\163\181\225\164\128-\225\164\156\225\164\160-\225\164\171\225\164\176-\225\164\187\225\165\134-\225\165\173\225\165\176-\225\165\180\225\166\128-\225\166\171\225\166\176-\225\167\137\225\167\144-\225\167\153\225\168\128-\225\168\155\225\168\160-\225\169\158\225\169\160-\225\169\188\225\169\191-\225\170\137\225\170\144-\225\170\153\225\170\167\225\172\128-\225\173\139\225\173\144-\225\173\153\225\173\171-\225\173\179\225\174\128-\225\175\179\225\176\128-\225\176\183\225\177\128-\225\177\137\225\177\141-\225\177\189\225\179\144-\225\179\146\225\179\148-\225\179\182\225\180\128-\225\183\166\225\183\188-\225\188\149\225\188\152-\225\188\157\225\188\160-\225\189\133\225\189\136-\225\189\141\225\189\144-\225\189\151\225\189\153\225\189\155\225\189\157\225\189\159-\225\189\189\225\190\128-\225\190\180\225\190\182-\225\190\188\225\190\190\225\191\130-\225\191\132\225\191\134-\225\191\140\225\191\144-\225\191\147\225\191\150-\225\191\155\225\191\160-\225\191\172\225\191\178-\225\191\180\225\191\182-\225\191\188\226\128\140\226\128\141\226\128\191\226\129\128\226\129\148\226\129\177\226\129\191\226\130\144-\226\130\156\226\131\144-\226\131\156\226\131\161\226\131\165-\226\131\176\226\132\130\226\132\135\226\132\138-\226\132\147\226\132\149\226\132\153-\226\132\157\226\132\164\226\132\166\226\132\168\226\132\170-\226\132\173\226\132\175-\226\132\185\226\132\188-\226\132\191\226\133\133-\226\133\137\226\133\142\226\133\160-\226\134\136\226\176\128-\226\176\174\226\176\176-\226\177\158\226\177\160-\226\179\164\226\179\171-\226\179\179\226\180\128-\226\180\165\226\180\167\226\180\173\226\180\176-\226\181\167\226\181\175\226\181\191-\226\182\150\226\182\160-\226\182\166\226\182\168-\226\182\174\226\182\176-\226\182\182\226\182\184-\226\182\190\226\183\128-\226\183\134\226\183\136-\226\183\142\226\183\144-\226\183\150\226\183\152-\226\183\158\226\183\160-\226\183\191\226\184\175\227\128\133-\227\128\135\227\128\161-\227\128\175\227\128\177-\227\128\181\227\128\184-\227\128\188\227\129\129-\227\130\150\227\130\153\227\130\154\227\130\157-\227\130\159\227\130\161-\227\131\186\227\131\188-\227\131\191\227\132\133-\227\132\173\227\132\177-\227\134\142\227\134\160-\227\134\186\227\135\176-\227\135\191\227\144\128-\228\182\181\228\184\128-\233\191\140\234\128\128-\234\146\140\234\147\144-\234\147\189\234\148\128-\234\152\140\234\152\144-\234\152\171\234\153\128-\234\153\175\234\153\180-\234\153\189\234\153\191-\234\154\151\234\154\159-\234\155\177\234\156\151-\234\156\159\234\156\162-\234\158\136\234\158\139-\234\158\142\234\158\144-\234\158\147\234\158\160-\234\158\170\234\159\184-\234\160\167\234\161\128-\234\161\179\234\162\128-\234\163\132\234\163\144-\234\163\153\234\163\160-\234\163\183\234\163\187\234\164\128-\234\164\173\234\164\176-\234\165\147\234\165\160-\234\165\188\234\166\128-\234\167\128\234\167\143-\234\167\153\234\168\128-\234\168\182\234\169\128-\234\169\141\234\169\144-\234\169\153\234\169\160-\234\169\182\234\169\186\234\169\187\234\170\128-\234\171\130\234\171\155-\234\171\157\234\171\160-\234\171\175\234\171\178-\234\171\182\234\172\129-\234\172\134\234\172\137-\234\172\142\234\172\145-\234\172\150\234\172\160-\234\172\166\234\172\168-\234\172\174\234\175\128-\234\175\170\234\175\172\234\175\173\234\175\176-\234\175\185\234\176\128-\237\158\163\237\158\176-\237\159\134\237\159\139-\237\159\187\239\164\128-\239\169\173\239\169\176-\239\171\153\239\172\128-\239\172\134\239\172\147-\239\172\151\239\172\157-\239\172\168\239\172\170-\239\172\182\239\172\184-\239\172\188\239\172\190\239\173\128\239\173\129\239\173\131\239\173\132\239\173\134-\239\174\177\239\175\147-\239\180\189\239\181\144-\239\182\143\239\182\146-\239\183\135\239\183\176-\239\183\187\239\184\128-\239\184\143\239\184\160-\239\184\166\239\184\179\239\184\180\239\185\141-\239\185\143\239\185\176-\239\185\180\239\185\182-\239\187\188\239\188\144-\239\188\153\239\188\161-\239\188\186\239\188\191\239\189\129-\239\189\154\239\189\166-\239\190\190\239\191\130-\239\191\135\239\191\138-\239\191\143\239\191\146-\239\191\151\239\191\154-\239\191\156]")
}); Regex  = _tmp; return _tmp; end)());
_e((function () local _tmp = _obj({
["name"] = "SyntaxTree",
["processComment"] = (function (this, node)
local trailingComments,lastChild;
if _bool((node.type == Syntax.Program)) then
if _bool((node.body.length > 0)) then
do return end
end

end

if _bool((extra.trailingComments.length > 0)) then
if _bool((extra.trailingComments[0].range[0] >= node.range[1])) then
_e((function () local _tmp = extra.trailingComments; trailingComments  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); extra.trailingComments  = _tmp; return _tmp; end)());
else
_e((function () local _tmp = 0; extra.trailingComments.length  = _tmp; return _tmp; end)());
end

else
if _bool((((extra.bottomRightStack.length > 0) and extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments) and (extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments[0].range[0] >= node.range[1]))) then
_e((function () local _tmp = extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments; trailingComments  = _tmp; return _tmp; end)());
_e((function () local _tmp = extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments; extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments = nil; return _tmp ~= nil; end)());
end

end

while _bool(((extra.bottomRightStack.length > 0) and (extra.bottomRightStack[(extra.bottomRightStack.length - 1)].range[0] >= node.range[0]))) do
_e((function () local _tmp = extra.bottomRightStack:pop(); lastChild  = _tmp; return _tmp; end)());
::_continue::
end

if _bool(lastChild) then
if _bool((lastChild.leadingComments and (lastChild.leadingComments[(lastChild.leadingComments.length - 1)].range[1] <= node.range[0]))) then
_e((function () local _tmp = lastChild.leadingComments; node.leadingComments  = _tmp; return _tmp; end)());
_e((function () local _tmp = lastChild.leadingComments; lastChild.leadingComments = nil; return _tmp ~= nil; end)());
end

elseif _bool(((extra.leadingComments.length > 0) and (extra.leadingComments[(extra.leadingComments.length - 1)].range[1] <= node.range[0]))) then
_e((function () local _tmp = extra.leadingComments; node.leadingComments  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); extra.leadingComments  = _tmp; return _tmp; end)());
end

if _bool(trailingComments) then
_e((function () local _tmp = trailingComments; node.trailingComments  = _tmp; return _tmp; end)());
end

extra.bottomRightStack:push(node);
end),
["markEnd"] = (function (this, node, startToken)
if _bool(extra.range) then
_e((function () local _tmp = _arr({[0]=startToken.start,index},2); node.range  = _tmp; return _tmp; end)());
end

if _bool(extra.loc) then
_e((function () local _tmp = _new(SourceLocation,(_bool((startToken.startLineNumber == undefined)) and {startToken.lineNumber} or {startToken.startLineNumber})[1],(startToken.start - (_bool((startToken.startLineStart == undefined)) and {startToken.lineStart} or {startToken.startLineStart})[1]),lineNumber,(index - lineStart)); node.loc  = _tmp; return _tmp; end)());
this:postProcess(node);
end

if _bool(extra.attachComment) then
this:processComment(node);
end

 do return node; end
end),
["postProcess"] = (function (this, node)
if _bool(extra.source) then
_e((function () local _tmp = extra.source; node.loc.source  = _tmp; return _tmp; end)());
end

 do return node; end
end),
["createArrayExpression"] = (function (this, elements)
 do return _obj({
["type"] = Syntax.ArrayExpression,
["elements"] = elements
}); end
end),
["createAssignmentExpression"] = (function (this, operator, left, right)
 do return _obj({
["type"] = Syntax.AssignmentExpression,
["operator"] = operator,
["left"] = left,
["right"] = right
}); end
end),
["createBinaryExpression"] = (function (this, operator, left, right)
local type;
type = (_bool(((operator == "||") or (operator == "&&"))) and {Syntax.LogicalExpression} or {Syntax.BinaryExpression})[1];
 do return _obj({
["type"] = type,
["operator"] = operator,
["left"] = left,
["right"] = right
}); end
end),
["createBlockStatement"] = (function (this, body)
 do return _obj({
["type"] = Syntax.BlockStatement,
["body"] = body
}); end
end),
["createBreakStatement"] = (function (this, label)
 do return _obj({
["type"] = Syntax.BreakStatement,
["label"] = label
}); end
end),
["createCallExpression"] = (function (this, callee, args)
 do return _obj({
["type"] = Syntax.CallExpression,
["callee"] = callee,
["arguments"] = args
}); end
end),
["createCatchClause"] = (function (this, param, body)
 do return _obj({
["type"] = Syntax.CatchClause,
["param"] = param,
["body"] = body
}); end
end),
["createConditionalExpression"] = (function (this, test, consequent, alternate)
 do return _obj({
["type"] = Syntax.ConditionalExpression,
["test"] = test,
["consequent"] = consequent,
["alternate"] = alternate
}); end
end),
["createContinueStatement"] = (function (this, label)
 do return _obj({
["type"] = Syntax.ContinueStatement,
["label"] = label
}); end
end),
["createDebuggerStatement"] = (function (this)
 do return _obj({
["type"] = Syntax.DebuggerStatement
}); end
end),
["createDoWhileStatement"] = (function (this, body, test)
 do return _obj({
["type"] = Syntax.DoWhileStatement,
["body"] = body,
["test"] = test
}); end
end),
["createEmptyStatement"] = (function (this)
 do return _obj({
["type"] = Syntax.EmptyStatement
}); end
end),
["createExpressionStatement"] = (function (this, expression)
 do return _obj({
["type"] = Syntax.ExpressionStatement,
["expression"] = expression
}); end
end),
["createForStatement"] = (function (this, init, test, update, body)
 do return _obj({
["type"] = Syntax.ForStatement,
["init"] = init,
["test"] = test,
["update"] = update,
["body"] = body
}); end
end),
["createForInStatement"] = (function (this, left, right, body)
 do return _obj({
["type"] = Syntax.ForInStatement,
["left"] = left,
["right"] = right,
["body"] = body,
["each"] = false
}); end
end),
["createFunctionDeclaration"] = (function (this, id, params, defaults, body)
 do return _obj({
["type"] = Syntax.FunctionDeclaration,
["id"] = id,
["params"] = params,
["defaults"] = defaults,
["body"] = body,
["rest"] = null,
["generator"] = false,
["expression"] = false
}); end
end),
["createFunctionExpression"] = (function (this, id, params, defaults, body)
 do return _obj({
["type"] = Syntax.FunctionExpression,
["id"] = id,
["params"] = params,
["defaults"] = defaults,
["body"] = body,
["rest"] = null,
["generator"] = false,
["expression"] = false
}); end
end),
["createIdentifier"] = (function (this, name)
 do return _obj({
["type"] = Syntax.Identifier,
["name"] = name
}); end
end),
["createIfStatement"] = (function (this, test, consequent, alternate)
 do return _obj({
["type"] = Syntax.IfStatement,
["test"] = test,
["consequent"] = consequent,
["alternate"] = alternate
}); end
end),
["createLabeledStatement"] = (function (this, label, body)
 do return _obj({
["type"] = Syntax.LabeledStatement,
["label"] = label,
["body"] = body
}); end
end),
["createLiteral"] = (function (this, token)
 do return _obj({
["type"] = Syntax.Literal,
["value"] = token.value,
["raw"] = source:slice(token.start,token["end"])
}); end
end),
["createMemberExpression"] = (function (this, accessor, object, property)
 do return _obj({
["type"] = Syntax.MemberExpression,
["computed"] = (accessor == "["),
["object"] = object,
["property"] = property
}); end
end),
["createNewExpression"] = (function (this, callee, args)
 do return _obj({
["type"] = Syntax.NewExpression,
["callee"] = callee,
["arguments"] = args
}); end
end),
["createObjectExpression"] = (function (this, properties)
 do return _obj({
["type"] = Syntax.ObjectExpression,
["properties"] = properties
}); end
end),
["createPostfixExpression"] = (function (this, operator, argument)
 do return _obj({
["type"] = Syntax.UpdateExpression,
["operator"] = operator,
["argument"] = argument,
["prefix"] = false
}); end
end),
["createProgram"] = (function (this, body)
 do return _obj({
["type"] = Syntax.Program,
["body"] = body
}); end
end),
["createProperty"] = (function (this, kind, key, value)
 do return _obj({
["type"] = Syntax.Property,
["key"] = key,
["value"] = value,
["kind"] = kind
}); end
end),
["createReturnStatement"] = (function (this, argument)
 do return _obj({
["type"] = Syntax.ReturnStatement,
["argument"] = argument
}); end
end),
["createSequenceExpression"] = (function (this, expressions)
 do return _obj({
["type"] = Syntax.SequenceExpression,
["expressions"] = expressions
}); end
end),
["createSwitchCase"] = (function (this, test, consequent)
 do return _obj({
["type"] = Syntax.SwitchCase,
["test"] = test,
["consequent"] = consequent
}); end
end),
["createSwitchStatement"] = (function (this, discriminant, cases)
 do return _obj({
["type"] = Syntax.SwitchStatement,
["discriminant"] = discriminant,
["cases"] = cases
}); end
end),
["createThisExpression"] = (function (this)
 do return _obj({
["type"] = Syntax.ThisExpression
}); end
end),
["createThrowStatement"] = (function (this, argument)
 do return _obj({
["type"] = Syntax.ThrowStatement,
["argument"] = argument
}); end
end),
["createTryStatement"] = (function (this, block, guardedHandlers, handlers, finalizer)
 do return _obj({
["type"] = Syntax.TryStatement,
["block"] = block,
["guardedHandlers"] = guardedHandlers,
["handlers"] = handlers,
["finalizer"] = finalizer
}); end
end),
["createUnaryExpression"] = (function (this, operator, argument)
if _bool(((operator == "++") or (operator == "--"))) then
 do return _obj({
["type"] = Syntax.UpdateExpression,
["operator"] = operator,
["argument"] = argument,
["prefix"] = true
}); end
end

 do return _obj({
["type"] = Syntax.UnaryExpression,
["operator"] = operator,
["argument"] = argument,
["prefix"] = true
}); end
end),
["createVariableDeclaration"] = (function (this, declarations, kind)
 do return _obj({
["type"] = Syntax.VariableDeclaration,
["declarations"] = declarations,
["kind"] = kind
}); end
end),
["createVariableDeclarator"] = (function (this, id, init)
 do return _obj({
["type"] = Syntax.VariableDeclarator,
["id"] = id,
["init"] = init
}); end
end),
["createWhileStatement"] = (function (this, test, body)
 do return _obj({
["type"] = Syntax.WhileStatement,
["test"] = test,
["body"] = body
}); end
end),
["createWithStatement"] = (function (this, object, body)
 do return _obj({
["type"] = Syntax.WithStatement,
["object"] = object,
["body"] = body
}); end
end)
}); SyntaxTreeDelegate  = _tmp; return _tmp; end)());
_e((function () local _tmp = "1.2.2"; exports.version  = _tmp; return _tmp; end)());
_e((function () local _tmp = tokenize; exports.tokenize  = _tmp; return _tmp; end)());
_e((function () local _tmp = parse; exports.parse  = _tmp; return _tmp; end)());
_e((function () local _tmp = (function (this)
local types,name;
types = _obj({

});
if _bool((_type(Object.create) == "function")) then
_e((function () local _tmp = Object:create(null); types  = _tmp; return _tmp; end)());
end

for name in _props(Syntax) do
name = _tostr(name);
if _bool(Syntax:hasOwnProperty(name)) then
_e((function () local _tmp = Syntax[name]; types[name]  = _tmp; return _tmp; end)());
end
::_continue::
end

if _bool((_type(Object.freeze) == "function")) then
Object:freeze(types);
end

 do return types; end
end)(_ENV); exports.Syntax  = _tmp; return _tmp; end)());
end));

return this.esprima
