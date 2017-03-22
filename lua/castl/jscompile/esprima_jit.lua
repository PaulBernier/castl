local _ENV = require("castl.runtime");
return setfenv(function(...)
(function (this, root, factory)
if _bool(((function() local _lev=(_type(define) == "function"); if _bool(_lev) then return define.amd; else return _lev; end end)())) then
define(_ENV,_arr({[0]="exports"},1),factory);
elseif (_type(exports) ~= "undefined") then
factory(_ENV,exports);
else
factory(_ENV,(function() root.esprima = _obj({}); return root.esprima end)());
end

end)(_ENV,this,(function (this, exports)
local parse,tokenize,filterTokenLocation,parseProgram,parseScriptBody,parseImportDeclaration,parseImportNamespaceSpecifier,parseImportDefaultSpecifier,parseNamedImports,parseImportSpecifier,parseExportDeclaration,parseExportAllDeclaration,parseExportDefaultDeclaration,parseExportNamedDeclaration,parseExportSpecifier,parseModuleSpecifier,parseClassExpression,parseClassDeclaration,parseClassBody,parseFunctionExpression,parseFunctionDeclaration,parseParams,parseParam,validateParam,parseFunctionSourceElements,parseStatement,parseDebuggerStatement,parseTryStatement,parseCatchClause,parseThrowStatement,parseSwitchStatement,parseSwitchCase,parseWithStatement,parseReturnStatement,parseBreakStatement,parseContinueStatement,parseForStatement,parseWhileStatement,parseDoWhileStatement,parseIfStatement,parseExpressionStatement,parseEmptyStatement,parseRestElement,parseLexicalDeclaration,isLexicalDeclaration,resetTokenizerState,tokenizerState,parseBindingList,parseLexicalBinding,parseVariableStatement,parseVariableDeclarationList,parseVariableDeclaration,parseVariableIdentifier,parseBlock,parseStatementList,parseStatementListItem,parseExpression,parseAssignmentExpression,parseYieldExpression,parseArrowFunctionExpression,reinterpretAsCoverFormalsList,checkPatternParam,parseConciseBody,parseConditionalExpression,parseBinaryExpression,binaryPrecedence,parseUnaryExpression,parsePostfixExpression,parseLeftHandSideExpression,parseLeftHandSideExpressionAllowCall,parseNewExpression,parseComputedMember,parseNonComputedMember,parseNonComputedProperty,parseArguments,parsePrimaryExpression,parseGroupExpression,parseTemplateLiteral,parseTemplateElement,reinterpretExpressionAsPattern,parseObjectInitializer,parseObjectProperty,tryParseMethodDefinition,lookaheadPropertyName,parseObjectPropertyKey,parsePropertyMethodFunction,parsePropertyFunction,parseArrayInitializer,parsePatternWithDefault,parsePattern,parseObjectPattern,parsePropertyPattern,parseArrayPattern,inheritCoverGrammar,isolateCoverGrammar,consumeSemicolon,matchAssign,matchContextualKeyword,matchKeyword,match,expectKeyword,expectCommaSeparator,expect,tolerateUnexpectedToken,throwUnexpectedToken,unexpectedTokenError,tolerateError,throwError,createError,constructError,recordError,WrappingNode,Node,WrappingSourceLocation,SourceLocation,Position,peek,lex,collectToken,advance,advanceSlash,isIdentifierName,collectRegex,scanRegExp,scanRegExpFlags,scanRegExpBody,testRegExp,scanTemplate,scanStringLiteral,scanNumericLiteral,isImplicitOctalLiteral,scanOctalLiteral,scanBinaryLiteral,scanHexLiteral,scanPunctuator,scanIdentifier,getIdentifier,getComplexIdentifier,codePointAt,scanUnicodeCodePointEscape,scanHexEscape,skipComment,skipMultiLineComment,skipSingleLineComment,addComment,isKeyword,isRestrictedWord,isStrictModeReservedWord,isFutureReservedWord,isIdentifierPart,isIdentifierStart,fromCodePoint,isLineTerminator,isWhiteSpace,octalToDecimal,isOctalDigit,isHexDigit,isDecimalDigit,assert,firstCoverInitializedNameError,isAssignmentTarget,isBindingElement,extra,state,lookahead,length,scanning,startLineStart,startLineNumber,startIndex,lastLineStart,lastLineNumber,lastIndex,hasLineTerminator,lineStart,lineNumber,index,strict,source,Regex,Messages,PlaceHolders,Syntax,FnExprTokens,TokenName,Token;
assert = (function (this, condition, message)
if not _bool(condition) then
_throw(_new(Error,(_addStr1("ASSERT: ",message))),0)
end

end);
isDecimalDigit = (function (this, ch)
do return ((function() local _lev=(_ge(ch,48)); if _bool(_lev) then return (_le(ch,57)); else return _lev; end end)()); end
end);
isHexDigit = (function (this, ch)
do return (_ge(("0123456789abcdefABCDEF"):indexOf(ch),0)); end
end);
isOctalDigit = (function (this, ch)
do return (_ge(("01234567"):indexOf(ch),0)); end
end);
octalToDecimal = (function (this, ch)
local code,octal;
octal = (ch ~= "0");
code = ("01234567"):indexOf(ch);
if _bool(((function() local _lev=(_lt(index,length)); if _bool(_lev) then return isOctalDigit(_ENV,source[index]); else return _lev; end end)())) then
octal = true;
code = (_addNum1((code * 8),("01234567"):indexOf(source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()])));
if _bool(((function() local _lev=((function() local _lev=(_ge(("0123"):indexOf(ch),0)); if _bool(_lev) then return (_lt(index,length)); else return _lev; end end)()); if _bool(_lev) then return isOctalDigit(_ENV,source[index]); else return _lev; end end)())) then
code = (_addNum1((code * 8),("01234567"):indexOf(source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()])));
end

end

do return _obj({
["code"] = code,
["octal"] = octal
}); end
end);
isWhiteSpace = (function (this, ch)
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(ch == 32); return _bool(_lev) and _lev or (ch == 9) end)()); return _bool(_lev) and _lev or (ch == 11) end)()); return _bool(_lev) and _lev or (ch == 12) end)()); return _bool(_lev) and _lev or (ch == 160) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,5760)); if _bool(_lev) then return (_ge(_arr({[0]=5760,6158,8192,8193,8194,8195,8196,8197,8198,8199,8200,8201,8202,8239,8287,12288,65279},17):indexOf(ch),0)); else return _lev; end end)()) end)()); end
end);
isLineTerminator = (function (this, ch)
do return ((function() local _lev=((function() local _lev=((function() local _lev=(ch == 10); return _bool(_lev) and _lev or (ch == 13) end)()); return _bool(_lev) and _lev or (ch == 8232) end)()); return _bool(_lev) and _lev or (ch == 8233) end)()); end
end);
fromCodePoint = (function (this, cp)
do return (function() if (_lt(cp,65536)) then return String:fromCharCode(cp); else return (_add(String:fromCharCode((55296 + (_arshift((cp - 65536),10)))),String:fromCharCode((56320 + (_band((cp - 65536),1023)))))); end end)(); end
end);
isIdentifierStart = (function (this, ch)
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(ch == 36); return _bool(_lev) and _lev or (ch == 95) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,65)); if _bool(_lev) then return (_le(ch,90)); else return _lev; end end)()) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,97)); if _bool(_lev) then return (_le(ch,122)); else return _lev; end end)()) end)()); return _bool(_lev) and _lev or (ch == 92) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,128)); if _bool(_lev) then return Regex.NonAsciiIdentifierStart:test(fromCodePoint(_ENV,ch)); else return _lev; end end)()) end)()); end
end);
isIdentifierPart = (function (this, ch)
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(ch == 36); return _bool(_lev) and _lev or (ch == 95) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,65)); if _bool(_lev) then return (_le(ch,90)); else return _lev; end end)()) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,97)); if _bool(_lev) then return (_le(ch,122)); else return _lev; end end)()) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,48)); if _bool(_lev) then return (_le(ch,57)); else return _lev; end end)()) end)()); return _bool(_lev) and _lev or (ch == 92) end)()); return _bool(_lev) and _lev or ((function() local _lev=(_ge(ch,128)); if _bool(_lev) then return Regex.NonAsciiIdentifierPart:test(fromCodePoint(_ENV,ch)); else return _lev; end end)()) end)()); end
end);
isFutureReservedWord = (function (this, id)
repeat
local _into = false;
local _cases = {["enum"] = true,["export"] = true,["import"] = true,["super"] = true};
local _v = id;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "enum") then

_into = true;
end
if _into or (_v == "export") then

_into = true;
end
if _into or (_v == "import") then

_into = true;
end
if _into or (_v == "super") then
do return true; end
_into = true;
end
::_default::
if _into then
do return false; end
_into = true;
end
until true
end);
isStrictModeReservedWord = (function (this, id)
repeat
local _into = false;
local _cases = {["implements"] = true,["interface"] = true,["package"] = true,["private"] = true,["protected"] = true,["public"] = true,["static"] = true,["yield"] = true,["let"] = true};
local _v = id;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "implements") then

_into = true;
end
if _into or (_v == "interface") then

_into = true;
end
if _into or (_v == "package") then

_into = true;
end
if _into or (_v == "private") then

_into = true;
end
if _into or (_v == "protected") then

_into = true;
end
if _into or (_v == "public") then

_into = true;
end
if _into or (_v == "static") then

_into = true;
end
if _into or (_v == "yield") then

_into = true;
end
if _into or (_v == "let") then
do return true; end
_into = true;
end
::_default::
if _into then
do return false; end
_into = true;
end
until true
end);
isRestrictedWord = (function (this, id)
do return ((function() local _lev=(id == "eval"); return _bool(_lev) and _lev or (id == "arguments") end)()); end
end);
isKeyword = (function (this, id)
repeat
local _into = false;
local _cases = {[2] = true,[3] = true,[4] = true,[5] = true,[6] = true,[7] = true,[8] = true,[10] = true};
local _v = id.length;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == 2) then
do return ((function() local _lev=((function() local _lev=(id == "if"); return _bool(_lev) and _lev or (id == "in") end)()); return _bool(_lev) and _lev or (id == "do") end)()); end
_into = true;
end
if _into or (_v == 3) then
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(id == "var"); return _bool(_lev) and _lev or (id == "for") end)()); return _bool(_lev) and _lev or (id == "new") end)()); return _bool(_lev) and _lev or (id == "try") end)()); return _bool(_lev) and _lev or (id == "let") end)()); end
_into = true;
end
if _into or (_v == 4) then
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(id == "this"); return _bool(_lev) and _lev or (id == "else") end)()); return _bool(_lev) and _lev or (id == "case") end)()); return _bool(_lev) and _lev or (id == "void") end)()); return _bool(_lev) and _lev or (id == "with") end)()); return _bool(_lev) and _lev or (id == "enum") end)()); end
_into = true;
end
if _into or (_v == 5) then
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(id == "while"); return _bool(_lev) and _lev or (id == "break") end)()); return _bool(_lev) and _lev or (id == "catch") end)()); return _bool(_lev) and _lev or (id == "throw") end)()); return _bool(_lev) and _lev or (id == "const") end)()); return _bool(_lev) and _lev or (id == "yield") end)()); return _bool(_lev) and _lev or (id == "class") end)()); return _bool(_lev) and _lev or (id == "super") end)()); end
_into = true;
end
if _into or (_v == 6) then
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(id == "return"); return _bool(_lev) and _lev or (id == "typeof") end)()); return _bool(_lev) and _lev or (id == "delete") end)()); return _bool(_lev) and _lev or (id == "switch") end)()); return _bool(_lev) and _lev or (id == "export") end)()); return _bool(_lev) and _lev or (id == "import") end)()); end
_into = true;
end
if _into or (_v == 7) then
do return ((function() local _lev=((function() local _lev=(id == "default"); return _bool(_lev) and _lev or (id == "finally") end)()); return _bool(_lev) and _lev or (id == "extends") end)()); end
_into = true;
end
if _into or (_v == 8) then
do return ((function() local _lev=((function() local _lev=(id == "function"); return _bool(_lev) and _lev or (id == "continue") end)()); return _bool(_lev) and _lev or (id == "debugger") end)()); end
_into = true;
end
if _into or (_v == 10) then
do return (id == "instanceof"); end
_into = true;
end
::_default::
if _into then
do return false; end
_into = true;
end
until true
end);
addComment = (function (this, type, value, start, _g_end, loc)
local comment;
assert(_ENV,(_type(start) == "number"),"Comment must have valid position");
state.lastCommentStart = start;
comment = _obj({
["type"] = type,
["value"] = value
});
if _bool(extra.range) then
comment.range = _arr({[0]=start,_g_end},2);
end

if _bool(extra.loc) then
comment.loc = loc;
end

extra.comments:push(comment);
if _bool(extra.attachComment) then
extra.leadingComments:push(comment);
extra.trailingComments:push(comment);
end

if _bool(extra.tokenize) then
comment.type = (_addStr2(comment.type,"Comment"));
if _bool(extra.delegate) then
comment = extra:delegate(comment);
end

extra.tokens:push(comment);
end

end);
skipSingleLineComment = (function (this, offset)
local comment,ch,loc,start;
start = (index - offset);
loc = _obj({
["start"] = _obj({
["line"] = lineNumber,
["column"] = ((index - lineStart) - offset)
})
});
while (_lt(index,length)) do
ch = source:charCodeAt(index);
index = _inc(index);
if _bool(isLineTerminator(_ENV,ch)) then
hasLineTerminator = true;
if _bool(extra.comments) then
comment = source:slice((_add(start,offset)),(index - 1));
loc["end"] = _obj({
["line"] = lineNumber,
["column"] = ((index - lineStart) - 1)
});
addComment(_ENV,"Line",comment,start,(index - 1),loc);
end

if ((function() local _lev=(ch == 13); if _bool(_lev) then return (source:charCodeAt(index) == 10); else return _lev; end end)()) then
index = _inc(index);
end

lineNumber = _inc(lineNumber);
lineStart = index;
do return end
end

::_continue::
end

if _bool(extra.comments) then
comment = source:slice((_add(start,offset)),index);
loc["end"] = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
});
addComment(_ENV,"Line",comment,start,index,loc);
end

end);
skipMultiLineComment = (function (this)
local comment,ch,loc,start;
if _bool(extra.comments) then
start = (index - 2);
loc = _obj({
["start"] = _obj({
["line"] = lineNumber,
["column"] = ((index - lineStart) - 2)
})
});
end

while (_lt(index,length)) do
ch = source:charCodeAt(index);
if _bool(isLineTerminator(_ENV,ch)) then
if ((function() local _lev=(ch == 13); if _bool(_lev) then return (source:charCodeAt((_addNum2(index,1))) == 10); else return _lev; end end)()) then
index = _inc(index);
end

hasLineTerminator = true;
lineNumber = _inc(lineNumber);
index = _inc(index);
lineStart = index;
elseif (ch == 42) then
if (source:charCodeAt((_addNum2(index,1))) == 47) then
index = _inc(index);
index = _inc(index);
if _bool(extra.comments) then
comment = source:slice((_addNum2(start,2)),(index - 2));
loc["end"] = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
});
addComment(_ENV,"Block",comment,start,index,loc);
end

do return end
end

index = _inc(index);
else
index = _inc(index);
end

::_continue::
end

if _bool(extra.comments) then
loc["end"] = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
});
comment = source:slice((_addNum2(start,2)),index);
addComment(_ENV,"Block",comment,start,index,loc);
end

tolerateUnexpectedToken(_ENV);
end);
skipComment = (function (this)
local start,ch;
hasLineTerminator = false;
start = (index == 0);
while (_lt(index,length)) do
ch = source:charCodeAt(index);
if _bool(isWhiteSpace(_ENV,ch)) then
index = _inc(index);
elseif _bool(isLineTerminator(_ENV,ch)) then
hasLineTerminator = true;
index = _inc(index);
if ((function() local _lev=(ch == 13); if _bool(_lev) then return (source:charCodeAt(index) == 10); else return _lev; end end)()) then
index = _inc(index);
end

lineNumber = _inc(lineNumber);
lineStart = index;
start = true;
elseif (ch == 47) then
ch = source:charCodeAt((_addNum2(index,1)));
if (ch == 47) then
index = _inc(index);
index = _inc(index);
skipSingleLineComment(_ENV,2);
start = true;
elseif (ch == 42) then
index = _inc(index);
index = _inc(index);
skipMultiLineComment(_ENV);
else
do break end;
end

elseif _bool(((function() if _bool(start) then return (ch == 45); else return start; end end)())) then
if ((function() local _lev=(source:charCodeAt((_addNum2(index,1))) == 45); if _bool(_lev) then return (source:charCodeAt((_addNum2(index,2))) == 62); else return _lev; end end)()) then
index = (_addNum2(index,3));
skipSingleLineComment(_ENV,3);
else
do break end;
end

elseif (ch == 60) then
if (source:slice((_addNum2(index,1)),(_addNum2(index,4))) == "!--") then
index = _inc(index);
index = _inc(index);
index = _inc(index);
index = _inc(index);
skipSingleLineComment(_ENV,4);
else
do break end;
end

else
do break end;
end

::_continue::
end

end);
scanHexEscape = (function (this, prefix)
local code,ch,len,i;
code = 0;
len = (function() if (prefix == "u") then return 4; else return 2; end end)();
i = 0;
while (i<len) do
if _bool(((function() local _lev=(_lt(index,length)); if _bool(_lev) then return isHexDigit(_ENV,source[index]); else return _lev; end end)())) then
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
code = (_addNum1((code * 16),("0123456789abcdef"):indexOf(ch:toLowerCase())));
else
do return ""; end
end

i = i + 1;
end

do return String:fromCharCode(code); end
end);
scanUnicodeCodePointEscape = (function (this)
local code,ch;
ch = source[index];
code = 0;
if (ch == "}") then
throwUnexpectedToken(_ENV);
end

while (_lt(index,length)) do
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
if not _bool(isHexDigit(_ENV,ch)) then
do break end;
end

code = (_addNum1((code * 16),("0123456789abcdef"):indexOf(ch:toLowerCase())));
::_continue::
end

if ((function() local _lev=(_gt(code,1114111)); return _bool(_lev) and _lev or (ch ~= "}") end)()) then
throwUnexpectedToken(_ENV);
end

do return fromCodePoint(_ENV,code); end
end);
codePointAt = (function (this, i)
local second,first,cp;
cp = source:charCodeAt(i);
if ((function() local _lev=(_ge(cp,55296)); if _bool(_lev) then return (_le(cp,56319)); else return _lev; end end)()) then
second = source:charCodeAt((_addNum2(i,1)));
if ((function() local _lev=(_ge(second,56320)); if _bool(_lev) then return (_le(second,57343)); else return _lev; end end)()) then
first = cp;
cp = (((_addNum1(((first - 55296) * 1024),second)) - 56320) + 65536);
end

end

do return cp; end
end);
getComplexIdentifier = (function (this)
local id,ch,cp;
cp = codePointAt(_ENV,index);
id = fromCodePoint(_ENV,cp);
index = (_add(index,id.length));
if (cp == 92) then
if (source:charCodeAt(index) ~= 117) then
throwUnexpectedToken(_ENV);
end

index = _inc(index);
if (source[index] == "{") then
index = _inc(index);
ch = scanUnicodeCodePointEscape(_ENV);
else
ch = scanHexEscape(_ENV,"u");
cp = ch:charCodeAt(0);
if ((function() local _lev=((function() local _lev=not _bool(ch); return _bool(_lev) and _lev or (ch == "\\") end)()); return _bool(_lev) and _lev or not _bool(isIdentifierStart(_ENV,cp)) end)()) then
throwUnexpectedToken(_ENV);
end

end

id = ch;
end

while (_lt(index,length)) do
cp = codePointAt(_ENV,index);
if not _bool(isIdentifierPart(_ENV,cp)) then
do break end;
end

ch = fromCodePoint(_ENV,cp);
id = (_add(id,ch));
index = (_add(index,ch.length));
if (cp == 92) then
id = id:substr(0,(id.length - 1));
if (source:charCodeAt(index) ~= 117) then
throwUnexpectedToken(_ENV);
end

index = _inc(index);
if (source[index] == "{") then
index = _inc(index);
ch = scanUnicodeCodePointEscape(_ENV);
else
ch = scanHexEscape(_ENV,"u");
cp = ch:charCodeAt(0);
if ((function() local _lev=((function() local _lev=not _bool(ch); return _bool(_lev) and _lev or (ch == "\\") end)()); return _bool(_lev) and _lev or not _bool(isIdentifierPart(_ENV,cp)) end)()) then
throwUnexpectedToken(_ENV);
end

end

id = (_add(id,ch));
end

::_continue::
end

do return id; end
end);
getIdentifier = (function (this)
local ch,start;
start = (function () local _tmp = index; index = _inc(_tmp); return _tmp; end)();
while (_lt(index,length)) do
ch = source:charCodeAt(index);
if (ch == 92) then
index = start;
do return getComplexIdentifier(_ENV); end
elseif ((function() local _lev=(_ge(ch,55296)); if _bool(_lev) then return (_lt(ch,57343)); else return _lev; end end)()) then
index = start;
do return getComplexIdentifier(_ENV); end
end

if _bool(isIdentifierPart(_ENV,ch)) then
index = _inc(index);
else
do break end;
end

::_continue::
end

do return source:slice(start,index); end
end);
scanIdentifier = (function (this)
local type,id,start;
start = index;
id = (function() if (source:charCodeAt(index) == 92) then return getComplexIdentifier(_ENV); else return getIdentifier(_ENV); end end)();
if (id.length == 1) then
type = Token.Identifier;
elseif _bool(isKeyword(_ENV,id)) then
type = Token.Keyword;
elseif (id == "null") then
type = Token.NullLiteral;
elseif ((function() local _lev=(id == "true"); return _bool(_lev) and _lev or (id == "false") end)()) then
type = Token.BooleanLiteral;
else
type = Token.Identifier;
end

do return _obj({
["type"] = type,
["value"] = id,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end);
scanPunctuator = (function (this)
local str,token;
token = _obj({
["type"] = Token.Punctuator,
["value"] = "",
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = index,
["end"] = index
});
str = source[index];
repeat
local _into = false;
local _cases = {["("] = true,["{"] = true,["."] = true,["}"] = true,[")"] = true,[";"] = true,[","] = true,["["] = true,["]"] = true,[":"] = true,["?"] = true,["~"] = true};
local _v = str;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "(") then
if _bool(extra.tokenize) then
extra.openParenToken = extra.tokenValues.length;
end

index = _inc(index);
do break end;
_into = true;
end
if _into or (_v == "{") then
if _bool(extra.tokenize) then
extra.openCurlyToken = extra.tokenValues.length;
end

state.curlyStack:push("{");
index = _inc(index);
do break end;
_into = true;
end
if _into or (_v == ".") then
index = _inc(index);
if ((function() local _lev=(source[index] == "."); if _bool(_lev) then return (source[(_addNum2(index,1))] == "."); else return _lev; end end)()) then
index = (_addNum2(index,2));
str = "...";
end

do break end;
_into = true;
end
if _into or (_v == "}") then
index = _inc(index);
state.curlyStack:pop();
do break end;
_into = true;
end
if _into or (_v == ")") then

_into = true;
end
if _into or (_v == ";") then

_into = true;
end
if _into or (_v == ",") then

_into = true;
end
if _into or (_v == "[") then

_into = true;
end
if _into or (_v == "]") then

_into = true;
end
if _into or (_v == ":") then

_into = true;
end
if _into or (_v == "?") then

_into = true;
end
if _into or (_v == "~") then
index = _inc(index);
do break end;
_into = true;
end
::_default::
if _into then
str = source:substr(index,4);
if (str == ">>>=") then
index = (_addNum2(index,4));
else
str = str:substr(0,3);
if ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(str == "==="); return _bool(_lev) and _lev or (str == "!==") end)()); return _bool(_lev) and _lev or (str == ">>>") end)()); return _bool(_lev) and _lev or (str == "<<=") end)()); return _bool(_lev) and _lev or (str == ">>=") end)()) then
index = (_addNum2(index,3));
else
str = str:substr(0,2);
if ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(str == "&&"); return _bool(_lev) and _lev or (str == "||") end)()); return _bool(_lev) and _lev or (str == "==") end)()); return _bool(_lev) and _lev or (str == "!=") end)()); return _bool(_lev) and _lev or (str == "+=") end)()); return _bool(_lev) and _lev or (str == "-=") end)()); return _bool(_lev) and _lev or (str == "*=") end)()); return _bool(_lev) and _lev or (str == "/=") end)()); return _bool(_lev) and _lev or (str == "++") end)()); return _bool(_lev) and _lev or (str == "--") end)()); return _bool(_lev) and _lev or (str == "<<") end)()); return _bool(_lev) and _lev or (str == ">>") end)()); return _bool(_lev) and _lev or (str == "&=") end)()); return _bool(_lev) and _lev or (str == "|=") end)()); return _bool(_lev) and _lev or (str == "^=") end)()); return _bool(_lev) and _lev or (str == "%=") end)()); return _bool(_lev) and _lev or (str == "<=") end)()); return _bool(_lev) and _lev or (str == ">=") end)()); return _bool(_lev) and _lev or (str == "=>") end)()) then
index = (_addNum2(index,2));
else
str = source[index];
if (_ge(("<>=!+-*%&|^/"):indexOf(str),0)) then
index = _inc(index);
end

end

end

end

_into = true;
end
until true
if (index == token.start) then
throwUnexpectedToken(_ENV);
end

token["end"] = index;
token.value = str;
do return token; end
end);
scanHexLiteral = (function (this, start)
local number;
number = "";
while (_lt(index,length)) do
if not _bool(isHexDigit(_ENV,source[index])) then
do break end;
end

number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

if (number.length == 0) then
throwUnexpectedToken(_ENV);
end

if _bool(isIdentifierStart(_ENV,source:charCodeAt(index))) then
throwUnexpectedToken(_ENV);
end

do return _obj({
["type"] = Token.NumericLiteral,
["value"] = parseInt(_ENV,(_addStr1("0x",number)),16),
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end);
scanBinaryLiteral = (function (this, start)
local number,ch;
number = "";
while (_lt(index,length)) do
ch = source[index];
if ((function() local _lev=(ch ~= "0"); if _bool(_lev) then return (ch ~= "1"); else return _lev; end end)()) then
do break end;
end

number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

if (number.length == 0) then
throwUnexpectedToken(_ENV);
end

if (_lt(index,length)) then
ch = source:charCodeAt(index);
if _bool(((function() local _lev=isIdentifierStart(_ENV,ch); return _bool(_lev) and _lev or isDecimalDigit(_ENV,ch) end)())) then
throwUnexpectedToken(_ENV);
end

end

do return _obj({
["type"] = Token.NumericLiteral,
["value"] = parseInt(_ENV,number,2),
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end);
scanOctalLiteral = (function (this, prefix, start)
local octal,number;
if _bool(isOctalDigit(_ENV,prefix)) then
octal = true;
number = (_addStr1("0",source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
else
octal = false;
index = _inc(index);
number = "";
end

while (_lt(index,length)) do
if not _bool(isOctalDigit(_ENV,source[index])) then
do break end;
end

number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

if ((function() local _lev=not _bool(octal); if _bool(_lev) then return (number.length == 0); else return _lev; end end)()) then
throwUnexpectedToken(_ENV);
end

if _bool(((function() local _lev=isIdentifierStart(_ENV,source:charCodeAt(index)); return _bool(_lev) and _lev or isDecimalDigit(_ENV,source:charCodeAt(index)) end)())) then
throwUnexpectedToken(_ENV);
end

do return _obj({
["type"] = Token.NumericLiteral,
["value"] = parseInt(_ENV,number,8),
["octal"] = octal,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end);
isImplicitOctalLiteral = (function (this)
local ch,i;
i = (_addNum2(index,1));
while (_lt(i,length)) do
ch = source[i];
if ((function() local _lev=(ch == "8"); return _bool(_lev) and _lev or (ch == "9") end)()) then
do return false; end
end

if not _bool(isOctalDigit(_ENV,ch)) then
do return true; end
end

i = _inc(i);
end

do return true; end
end);
scanNumericLiteral = (function (this)
local ch,start,number;
ch = source[index];
assert(_ENV,((function() local _lev=isDecimalDigit(_ENV,ch:charCodeAt(0)); return _bool(_lev) and _lev or (ch == ".") end)()),"Numeric literal must start with a decimal digit or a decimal point");
start = index;
number = "";
if (ch ~= ".") then
number = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
ch = source[index];
if (number == "0") then
if ((function() local _lev=(ch == "x"); return _bool(_lev) and _lev or (ch == "X") end)()) then
index = _inc(index);
do return scanHexLiteral(_ENV,start); end
end

if ((function() local _lev=(ch == "b"); return _bool(_lev) and _lev or (ch == "B") end)()) then
index = _inc(index);
do return scanBinaryLiteral(_ENV,start); end
end

if ((function() local _lev=(ch == "o"); return _bool(_lev) and _lev or (ch == "O") end)()) then
do return scanOctalLiteral(_ENV,ch,start); end
end

if _bool(isOctalDigit(_ENV,ch)) then
if _bool(isImplicitOctalLiteral(_ENV)) then
do return scanOctalLiteral(_ENV,ch,start); end
end

end

end

while _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) do
number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

ch = source[index];
end

if (ch == ".") then
number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
while _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) do
number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

ch = source[index];
end

if ((function() local _lev=(ch == "e"); return _bool(_lev) and _lev or (ch == "E") end)()) then
number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
ch = source[index];
if ((function() local _lev=(ch == "+"); return _bool(_lev) and _lev or (ch == "-") end)()) then
number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
end

if _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) then
while _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) do
number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

else
throwUnexpectedToken(_ENV);
end

end

if _bool(isIdentifierStart(_ENV,source:charCodeAt(index))) then
throwUnexpectedToken(_ENV);
end

do return _obj({
["type"] = Token.NumericLiteral,
["value"] = parseFloat(_ENV,number),
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end);
scanStringLiteral = (function (this)
local octal,octToDec,unescaped,ch,start,quote,str;
str = "";
octal = false;
quote = source[index];
assert(_ENV,((function() local _lev=(quote == "'"); return _bool(_lev) and _lev or (quote == "\"") end)()),"String literal must starts with a quote");
start = index;
index = _inc(index);
while (_lt(index,length)) do
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
if (ch == quote) then
quote = "";
do break end;
elseif (ch == "\\") then
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
if ((function() local _lev=not _bool(ch); return _bool(_lev) and _lev or not _bool(isLineTerminator(_ENV,ch:charCodeAt(0))) end)()) then
repeat
local _into = false;
local _cases = {["u"] = true,["x"] = true,["n"] = true,["r"] = true,["t"] = true,["b"] = true,["f"] = true,["v"] = true,["8"] = true,["9"] = true};
local _v = ch;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "u") then

_into = true;
end
if _into or (_v == "x") then
if (source[index] == "{") then
index = _inc(index);
str = (_add(str,scanUnicodeCodePointEscape(_ENV)));
else
unescaped = scanHexEscape(_ENV,ch);
if not _bool(unescaped) then
_throw(throwUnexpectedToken(_ENV),0)
end

str = (_add(str,unescaped));
end

do break end;
_into = true;
end
if _into or (_v == "n") then
str = (_addStr2(str,"\010"));
do break end;
_into = true;
end
if _into or (_v == "r") then
str = (_addStr2(str,"\013"));
do break end;
_into = true;
end
if _into or (_v == "t") then
str = (_addStr2(str,"\009"));
do break end;
_into = true;
end
if _into or (_v == "b") then
str = (_addStr2(str,"\008"));
do break end;
_into = true;
end
if _into or (_v == "f") then
str = (_addStr2(str,"\012"));
do break end;
_into = true;
end
if _into or (_v == "v") then
str = (_addStr2(str,"\011"));
do break end;
_into = true;
end
if _into or (_v == "8") then

_into = true;
end
if _into or (_v == "9") then
str = (_add(str,ch));
tolerateUnexpectedToken(_ENV);
do break end;
_into = true;
end
::_default::
if _into then
if _bool(isOctalDigit(_ENV,ch)) then
octToDec = octalToDecimal(_ENV,ch);
octal = ((function() local _lev=octToDec.octal; return _bool(_lev) and _lev or octal end)());
str = (_add(str,String:fromCharCode(octToDec.code)));
else
str = (_add(str,ch));
end

do break end;
_into = true;
end
until true
else
lineNumber = _inc(lineNumber);
if ((function() local _lev=(ch == "\013"); if _bool(_lev) then return (source[index] == "\010"); else return _lev; end end)()) then
index = _inc(index);
end

lineStart = index;
end

elseif _bool(isLineTerminator(_ENV,ch:charCodeAt(0))) then
do break end;
else
str = (_add(str,ch));
end

::_continue::
end

if (quote ~= "") then
index = start;
throwUnexpectedToken(_ENV);
end

do return _obj({
["type"] = Token.StringLiteral,
["value"] = str,
["octal"] = octal,
["lineNumber"] = startLineNumber,
["lineStart"] = startLineStart,
["start"] = start,
["end"] = index
}); end
end);
scanTemplate = (function (this)
local unescaped,restore,tail,head,terminated,rawOffset,start,ch,cooked;
cooked = "";
terminated = false;
tail = false;
start = index;
head = (source[index] == "`");
rawOffset = 2;
index = _inc(index);
while (_lt(index,length)) do
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
if (ch == "`") then
rawOffset = 1;
tail = true;
terminated = true;
do break end;
elseif (ch == "$") then
if (source[index] == "{") then
state.curlyStack:push("${");
index = _inc(index);
terminated = true;
do break end;
end

cooked = (_add(cooked,ch));
elseif (ch == "\\") then
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
if not _bool(isLineTerminator(_ENV,ch:charCodeAt(0))) then
repeat
local _into = false;
local _cases = {["n"] = true,["r"] = true,["t"] = true,["u"] = true,["x"] = true,["b"] = true,["f"] = true,["v"] = true};
local _v = ch;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "n") then
cooked = (_addStr2(cooked,"\010"));
do break end;
_into = true;
end
if _into or (_v == "r") then
cooked = (_addStr2(cooked,"\013"));
do break end;
_into = true;
end
if _into or (_v == "t") then
cooked = (_addStr2(cooked,"\009"));
do break end;
_into = true;
end
if _into or (_v == "u") then

_into = true;
end
if _into or (_v == "x") then
if (source[index] == "{") then
index = _inc(index);
cooked = (_add(cooked,scanUnicodeCodePointEscape(_ENV)));
else
restore = index;
unescaped = scanHexEscape(_ENV,ch);
if _bool(unescaped) then
cooked = (_add(cooked,unescaped));
else
index = restore;
cooked = (_add(cooked,ch));
end

end

do break end;
_into = true;
end
if _into or (_v == "b") then
cooked = (_addStr2(cooked,"\008"));
do break end;
_into = true;
end
if _into or (_v == "f") then
cooked = (_addStr2(cooked,"\012"));
do break end;
_into = true;
end
if _into or (_v == "v") then
cooked = (_addStr2(cooked,"\011"));
do break end;
_into = true;
end
::_default::
if _into then
if (ch == "0") then
if _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) then
throwError(_ENV,Messages.TemplateOctalLiteral);
end

cooked = (_addStr2(cooked,"\000"));
elseif _bool(isOctalDigit(_ENV,ch)) then
throwError(_ENV,Messages.TemplateOctalLiteral);
else
cooked = (_add(cooked,ch));
end

do break end;
_into = true;
end
until true
else
lineNumber = _inc(lineNumber);
if ((function() local _lev=(ch == "\013"); if _bool(_lev) then return (source[index] == "\010"); else return _lev; end end)()) then
index = _inc(index);
end

lineStart = index;
end

elseif _bool(isLineTerminator(_ENV,ch:charCodeAt(0))) then
lineNumber = _inc(lineNumber);
if ((function() local _lev=(ch == "\013"); if _bool(_lev) then return (source[index] == "\010"); else return _lev; end end)()) then
index = _inc(index);
end

lineStart = index;
cooked = (_addStr2(cooked,"\010"));
else
cooked = (_add(cooked,ch));
end

::_continue::
end

if not _bool(terminated) then
throwUnexpectedToken(_ENV);
end

if not _bool(head) then
state.curlyStack:pop();
end

do return _obj({
["type"] = Token.Template,
["value"] = _obj({
["cooked"] = cooked,
["raw"] = source:slice((_addNum2(start,1)),(index - rawOffset))
}),
["head"] = head,
["tail"] = tail,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end);
testRegExp = (function (this, pattern, flags)
local tmp,astralSubstitute;
astralSubstitute = "\239\191\191";
tmp = pattern;
if (_ge(flags:indexOf("u"),0)) then
tmp = tmp:replace(_regexp("\\\\u\\{([0-9a-fA-F]+)\\}|\\\\u([a-fA-F0-9]{4})","g"),(function (this, S0, S1, S2)
local codePoint;
codePoint = parseInt(_ENV,(_bool(S1) and S1 or S2),16);
if (_gt(codePoint,1114111)) then
throwUnexpectedToken(_ENV,null,Messages.InvalidRegExp);
end

if (_le(codePoint,65535)) then
do return String:fromCharCode(codePoint); end
end

do return astralSubstitute; end
end)):replace(_regexp("[\240\144\128\128-\244\143\176\128][\240\144\128\128-\244\143\176\128]","g"),astralSubstitute);
end

local _status, _return = _pcall(function()
RegExp(_ENV,tmp);
end);
if not _status then
local _cstatus, _creturn = _pcall(function()
local e = _return;
throwUnexpectedToken(_ENV,null,Messages.InvalidRegExp);
end);
if _cstatus then
else _throw(_creturn,0); end
end

local _status, _return = _pcall(function()
do return _new(RegExp,pattern,flags); end
end);
if _status then
if _return ~= nil then return _return; end
else
local _cstatus, _creturn = _pcall(function()
local exception = _return;
do return null; end
end);
if _cstatus then
if _creturn ~= nil then return _creturn; end
else _throw(_creturn,0); end
end

end);
scanRegExpBody = (function (this)
local body,terminated,classMarker,str,ch;
ch = source[index];
assert(_ENV,(ch == "/"),"Regular expression literal must start with a slash");
str = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
classMarker = false;
terminated = false;
while (_lt(index,length)) do
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
str = (_add(str,ch));
if (ch == "\\") then
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
if _bool(isLineTerminator(_ENV,ch:charCodeAt(0))) then
throwUnexpectedToken(_ENV,null,Messages.UnterminatedRegExp);
end

str = (_add(str,ch));
elseif _bool(isLineTerminator(_ENV,ch:charCodeAt(0))) then
throwUnexpectedToken(_ENV,null,Messages.UnterminatedRegExp);
elseif _bool(classMarker) then
if (ch == "]") then
classMarker = false;
end

else
if (ch == "/") then
terminated = true;
do break end;
elseif (ch == "[") then
classMarker = true;
end

end

::_continue::
end

if not _bool(terminated) then
throwUnexpectedToken(_ENV,null,Messages.UnterminatedRegExp);
end

body = str:substr(1,(str.length - 2));
do return _obj({
["value"] = body,
["literal"] = str
}); end
end);
scanRegExpFlags = (function (this)
local restore,flags,str,ch;
str = "";
flags = "";
while (_lt(index,length)) do
ch = source[index];
if not _bool(isIdentifierPart(_ENV,ch:charCodeAt(0))) then
do break end;
end

index = _inc(index);
if ((function() local _lev=(ch == "\\"); if _bool(_lev) then return (_lt(index,length)); else return _lev; end end)()) then
ch = source[index];
if (ch == "u") then
index = _inc(index);
restore = index;
ch = scanHexEscape(_ENV,"u");
if _bool(ch) then
flags = (_add(flags,ch));
str = (_addStr2(str,"\\u"));
while (_lt(restore,index)) do
str = (_add(str,source[restore]));
restore = _inc(restore);
end

else
index = restore;
flags = (_addStr2(flags,"u"));
str = (_addStr2(str,"\\u"));
end

tolerateUnexpectedToken(_ENV);
else
str = (_addStr2(str,"\\"));
tolerateUnexpectedToken(_ENV);
end

else
flags = (_add(flags,ch));
str = (_add(str,ch));
end

::_continue::
end

do return _obj({
["value"] = flags,
["literal"] = str
}); end
end);
scanRegExp = (function (this)
local value,flags,body,start;
scanning = true;
lookahead = null;
skipComment(_ENV);
start = index;
body = scanRegExpBody(_ENV);
flags = scanRegExpFlags(_ENV);
value = testRegExp(_ENV,body.value,flags.value);
scanning = false;
if _bool(extra.tokenize) then
do return _obj({
["type"] = Token.RegularExpression,
["value"] = value,
["regex"] = _obj({
["pattern"] = body.value,
["flags"] = flags.value
}),
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end

do return _obj({
["literal"] = (_add(body.literal,flags.literal)),
["value"] = value,
["regex"] = _obj({
["pattern"] = body.value,
["flags"] = flags.value
}),
["start"] = start,
["end"] = index
}); end
end);
collectRegex = (function (this)
local token,regex,loc,pos;
skipComment(_ENV);
pos = index;
loc = _obj({
["start"] = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
})
});
regex = scanRegExp(_ENV);
loc["end"] = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
});
if not _bool(extra.tokenize) then
if (_gt(extra.tokens.length,0)) then
token = extra.tokens[(extra.tokens.length - 1)];
if ((function() local _lev=(token.range[0] == pos); if _bool(_lev) then return (token.type == "Punctuator"); else return _lev; end end)()) then
if ((function() local _lev=(token.value == "/"); return _bool(_lev) and _lev or (token.value == "/=") end)()) then
extra.tokens:pop();
end

end

end

extra.tokens:push(_obj({
["type"] = "RegularExpression",
["value"] = regex.literal,
["regex"] = regex.regex,
["range"] = _arr({[0]=pos,index},2),
["loc"] = loc
}));
end

do return regex; end
end);
isIdentifierName = (function (this, token)
do return ((function() local _lev=((function() local _lev=((function() local _lev=(token.type == Token.Identifier); return _bool(_lev) and _lev or (token.type == Token.Keyword) end)()); return _bool(_lev) and _lev or (token.type == Token.BooleanLiteral) end)()); return _bool(_lev) and _lev or (token.type == Token.NullLiteral) end)()); end
end);
advanceSlash = (function (this)
local testKeyword,check,previous,regex;
testKeyword = (function (this, value)
do return ((function() local _lev=((function() local _lev=((function() if _bool(value) then return (_gt(value.length,1)); else return value; end end)()); if _bool(_lev) then return (_ge(value[0],"a")); else return _lev; end end)()); if _bool(_lev) then return (_le(value[0],"z")); else return _lev; end end)()); end
end);previous = extra.tokenValues[(extra.tokenValues.length - 1)];
regex = (previous ~= null);
repeat
local _into = false;
local _cases = {["this"] = true,["]"] = true,[")"] = true,["}"] = true};
local _v = previous;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "this") then

_into = true;
end
if _into or (_v == "]") then
regex = false;
do break end;
_into = true;
end
if _into or (_v == ")") then
check = extra.tokenValues[(extra.openParenToken - 1)];
regex = ((function() local _lev=((function() local _lev=((function() local _lev=(check == "if"); return _bool(_lev) and _lev or (check == "while") end)()); return _bool(_lev) and _lev or (check == "for") end)()); return _bool(_lev) and _lev or (check == "with") end)());
do break end;
_into = true;
end
if _into or (_v == "}") then
regex = false;
if _bool(testKeyword(_ENV,extra.tokenValues[(extra.openCurlyToken - 3)])) then
check = extra.tokenValues[(extra.openCurlyToken - 4)];
regex = (function() if _bool(check) then return (_lt(FnExprTokens:indexOf(check),0)); else return false; end end)();
elseif _bool(testKeyword(_ENV,extra.tokenValues[(extra.openCurlyToken - 4)])) then
check = extra.tokenValues[(extra.openCurlyToken - 5)];
regex = (function() if _bool(check) then return (_lt(FnExprTokens:indexOf(check),0)); else return true; end end)();
end

_into = true;
end
::_default::
until true
do return (function() if _bool(regex) then return collectRegex(_ENV); else return scanPunctuator(_ENV); end end)(); end
end);
advance = (function (this)
local token,cp;
if (_ge(index,length)) then
do return _obj({
["type"] = Token.EOF,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = index,
["end"] = index
}); end
end

cp = source:charCodeAt(index);
if _bool(isIdentifierStart(_ENV,cp)) then
token = scanIdentifier(_ENV);
if _bool(((function() if _bool(strict) then return isStrictModeReservedWord(_ENV,token.value); else return strict; end end)())) then
token.type = Token.Keyword;
end

do return token; end
end

if ((function() local _lev=((function() local _lev=(cp == 40); return _bool(_lev) and _lev or (cp == 41) end)()); return _bool(_lev) and _lev or (cp == 59) end)()) then
do return scanPunctuator(_ENV); end
end

if ((function() local _lev=(cp == 39); return _bool(_lev) and _lev or (cp == 34) end)()) then
do return scanStringLiteral(_ENV); end
end

if (cp == 46) then
if _bool(isDecimalDigit(_ENV,source:charCodeAt((_addNum2(index,1))))) then
do return scanNumericLiteral(_ENV); end
end

do return scanPunctuator(_ENV); end
end

if _bool(isDecimalDigit(_ENV,cp)) then
do return scanNumericLiteral(_ENV); end
end

if _bool(((function() local _lev=extra.tokenize; if _bool(_lev) then return (cp == 47); else return _lev; end end)())) then
do return advanceSlash(_ENV); end
end

if ((function() local _lev=(cp == 96); return _bool(_lev) and _lev or ((function() local _lev=(cp == 125); if _bool(_lev) then return (state.curlyStack[(state.curlyStack.length - 1)] == "${"); else return _lev; end end)()) end)()) then
do return scanTemplate(_ENV); end
end

if ((function() local _lev=(_ge(cp,55296)); if _bool(_lev) then return (_lt(cp,57343)); else return _lev; end end)()) then
cp = codePointAt(_ENV,index);
if _bool(isIdentifierStart(_ENV,cp)) then
do return scanIdentifier(_ENV); end
end

end

do return scanPunctuator(_ENV); end
end);
collectToken = (function (this)
local entry,value,token,loc;
loc = _obj({
["start"] = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
})
});
token = advance(_ENV);
loc["end"] = _obj({
["line"] = lineNumber,
["column"] = (index - lineStart)
});
if (token.type ~= Token.EOF) then
value = source:slice(token.start,token["end"]);
entry = _obj({
["type"] = TokenName[token.type],
["value"] = value,
["range"] = _arr({[0]=token.start,token["end"]},2),
["loc"] = loc
});
if _bool(token.regex) then
entry.regex = _obj({
["pattern"] = token.regex.pattern,
["flags"] = token.regex.flags
});
end

if _bool(extra.tokenValues) then
extra.tokenValues:push((function() if ((function() local _lev=(entry.type == "Punctuator"); return _bool(_lev) and _lev or (entry.type == "Keyword") end)()) then return entry.value; else return null; end end)());
end

if _bool(extra.tokenize) then
if not _bool(extra.range) then
(function () local _r = false; local _g, _s = entry["_g" .. "range"], entry["_s" .. "range"]; entry["_g" .. "range"], entry["_s" .. "range"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = entry.range; entry.range = nil; return _r or _v ~= nil; end)();
end

if not _bool(extra.loc) then
(function () local _r = false; local _g, _s = entry["_g" .. "loc"], entry["_s" .. "loc"]; entry["_g" .. "loc"], entry["_s" .. "loc"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = entry.loc; entry.loc = nil; return _r or _v ~= nil; end)();
end

if _bool(extra.delegate) then
entry = extra:delegate(entry);
end

end

extra.tokens:push(entry);
end

do return token; end
end);
lex = (function (this)
local token;
scanning = true;
lastIndex = index;
lastLineNumber = lineNumber;
lastLineStart = lineStart;
skipComment(_ENV);
token = lookahead;
startIndex = index;
startLineNumber = lineNumber;
startLineStart = lineStart;
lookahead = (function() if (_type(extra.tokens) ~= "undefined") then return collectToken(_ENV); else return advance(_ENV); end end)();
scanning = false;
do return token; end
end);
peek = (function (this)
scanning = true;
skipComment(_ENV);
lastIndex = index;
lastLineNumber = lineNumber;
lastLineStart = lineStart;
startIndex = index;
startLineNumber = lineNumber;
startLineStart = lineStart;
lookahead = (function() if (_type(extra.tokens) ~= "undefined") then return collectToken(_ENV); else return advance(_ENV); end end)();
scanning = false;
end);
Position = (function (this)
this.line = startLineNumber;
this.column = (startIndex - startLineStart);
end);
SourceLocation = (function (this)
this.start = _new(Position);
this["end"] = null;
end);
WrappingSourceLocation = (function (this, startToken)
this.start = _obj({
["line"] = startToken.lineNumber,
["column"] = (startToken.start - startToken.lineStart)
});
this["end"] = null;
end);
Node = (function (this)
if _bool(extra.range) then
this.range = _arr({[0]=startIndex,0},2);
end

if _bool(extra.loc) then
this.loc = _new(SourceLocation);
end

end);
WrappingNode = (function (this, startToken)
if _bool(extra.range) then
this.range = _arr({[0]=startToken.start,0},2);
end

if _bool(extra.loc) then
this.loc = _new(WrappingSourceLocation,startToken);
end

end);
recordError = (function (this, error)
local existing,e;
e = 0;
while (e<extra.errors.length) do
existing = extra.errors[e];
if ((function() local _lev=(existing.index == error.index); if _bool(_lev) then return (existing.message == error.message); else return _lev; end end)()) then
do return end
end

e = e + 1;
end

extra.errors:push(error);
end);
constructError = (function (this, msg, column)
local error;
error = _new(Error,msg);
local _status, _return = _pcall(function()
_throw(error,0)
end);
if _status then
do return error; end
else
local _cstatus, _creturn = _pcall(function()
local base = _return;
if _bool(((function() local _lev=Object.create; if _bool(_lev) then return Object.defineProperty; else return _lev; end end)())) then
error = Object:create(base);
Object:defineProperty(error,"column",_obj({
["value"] = column
}));
end

end);
do return error; end
if _cstatus then
else _throw(_creturn,0); end
end

end);
createError = (function (this, line, pos, description)
local error,column,msg;
msg = (_addStr1(((_addStr1("Line ",line)) .. ": "),description));
column = ((pos - (function() if _bool(scanning) then return lineStart; else return lastLineStart; end end)()) + 1);
error = constructError(_ENV,msg,column);
error.lineNumber = line;
error.description = description;
error.index = pos;
do return error; end
end);
throwError = (function (...)
local this, messageFormat = ...;
local arguments = _args(...);
local msg,args;
args = Array.prototype.slice:call(arguments,1);
msg = messageFormat:replace(_regexp("%(\\d)","g"),(function (this, whole, idx)
assert(_ENV,(_lt(idx,args.length)),"Message reference must be in range");
do return args[idx]; end
end));
_throw(createError(_ENV,lastLineNumber,lastIndex,msg),0)
end);
tolerateError = (function (...)
local this, messageFormat = ...;
local arguments = _args(...);
local error,msg,args;
args = Array.prototype.slice:call(arguments,1);
msg = messageFormat:replace(_regexp("%(\\d)","g"),(function (this, whole, idx)
assert(_ENV,(_lt(idx,args.length)),"Message reference must be in range");
do return args[idx]; end
end));
error = createError(_ENV,lineNumber,lastIndex,msg);
if _bool(extra.errors) then
recordError(_ENV,error);
else
_throw(error,0)
end

end);
unexpectedTokenError = (function (this, token, message)
local msg,value;
msg = (_bool(message) and message or Messages.UnexpectedToken);
if _bool(token) then
if not _bool(message) then
msg = (function() if (token.type == Token.EOF) then return Messages.UnexpectedEOS; else return (function() if (token.type == Token.Identifier) then return Messages.UnexpectedIdentifier; else return (function() if (token.type == Token.NumericLiteral) then return Messages.UnexpectedNumber; else return (function() if (token.type == Token.StringLiteral) then return Messages.UnexpectedString; else return (function() if (token.type == Token.Template) then return Messages.UnexpectedTemplate; else return Messages.UnexpectedToken; end end)(); end end)(); end end)(); end end)(); end end)();
if (token.type == Token.Keyword) then
if _bool(isFutureReservedWord(_ENV,token.value)) then
msg = Messages.UnexpectedReserved;
elseif _bool(((function() if _bool(strict) then return isStrictModeReservedWord(_ENV,token.value); else return strict; end end)())) then
msg = Messages.StrictReservedWord;
end

end

end

value = (function() if (token.type == Token.Template) then return token.value.raw; else return token.value; end end)();
else
value = "ILLEGAL";
end

msg = msg:replace("%0",value);
do return (function() if _bool(((function() if _bool(token) then return (_type(token.lineNumber) == "number"); else return token; end end)())) then return createError(_ENV,token.lineNumber,token.start,msg); else return createError(_ENV,(function() if _bool(scanning) then return lineNumber; else return lastLineNumber; end end)(),(function() if _bool(scanning) then return index; else return lastIndex; end end)(),msg); end end)(); end
end);
throwUnexpectedToken = (function (this, token, message)
_throw(unexpectedTokenError(_ENV,token,message),0)
end);
tolerateUnexpectedToken = (function (this, token, message)
local error;
error = unexpectedTokenError(_ENV,token,message);
if _bool(extra.errors) then
recordError(_ENV,error);
else
_throw(error,0)
end

end);
expect = (function (this, value)
local token;
token = lex(_ENV);
if ((function() local _lev=(token.type ~= Token.Punctuator); return _bool(_lev) and _lev or (token.value ~= value) end)()) then
throwUnexpectedToken(_ENV,token);
end

end);
expectCommaSeparator = (function (this)
local token;
if _bool(extra.errors) then
token = lookahead;
if ((function() local _lev=(token.type == Token.Punctuator); if _bool(_lev) then return (token.value == ","); else return _lev; end end)()) then
lex(_ENV);
elseif ((function() local _lev=(token.type == Token.Punctuator); if _bool(_lev) then return (token.value == ";"); else return _lev; end end)()) then
lex(_ENV);
tolerateUnexpectedToken(_ENV,token);
else
tolerateUnexpectedToken(_ENV,token,Messages.UnexpectedToken);
end

else
expect(_ENV,",");
end

end);
expectKeyword = (function (this, keyword)
local token;
token = lex(_ENV);
if ((function() local _lev=(token.type ~= Token.Keyword); return _bool(_lev) and _lev or (token.value ~= keyword) end)()) then
throwUnexpectedToken(_ENV,token);
end

end);
match = (function (this, value)
do return ((function() local _lev=(lookahead.type == Token.Punctuator); if _bool(_lev) then return (lookahead.value == value); else return _lev; end end)()); end
end);
matchKeyword = (function (this, keyword)
do return ((function() local _lev=(lookahead.type == Token.Keyword); if _bool(_lev) then return (lookahead.value == keyword); else return _lev; end end)()); end
end);
matchContextualKeyword = (function (this, keyword)
do return ((function() local _lev=(lookahead.type == Token.Identifier); if _bool(_lev) then return (lookahead.value == keyword); else return _lev; end end)()); end
end);
matchAssign = (function (this)
local op;
if (lookahead.type ~= Token.Punctuator) then
do return false; end
end

op = lookahead.value;
do return ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(op == "="); return _bool(_lev) and _lev or (op == "*=") end)()); return _bool(_lev) and _lev or (op == "/=") end)()); return _bool(_lev) and _lev or (op == "%=") end)()); return _bool(_lev) and _lev or (op == "+=") end)()); return _bool(_lev) and _lev or (op == "-=") end)()); return _bool(_lev) and _lev or (op == "<<=") end)()); return _bool(_lev) and _lev or (op == ">>=") end)()); return _bool(_lev) and _lev or (op == ">>>=") end)()); return _bool(_lev) and _lev or (op == "&=") end)()); return _bool(_lev) and _lev or (op == "^=") end)()); return _bool(_lev) and _lev or (op == "|=") end)()); end
end);
consumeSemicolon = (function (this)
if _bool(((function() local _lev=(source:charCodeAt(startIndex) == 59); return _bool(_lev) and _lev or match(_ENV,";") end)())) then
lex(_ENV);
do return end
end

if _bool(hasLineTerminator) then
do return end
end

lastIndex = startIndex;
lastLineNumber = startLineNumber;
lastLineStart = startLineStart;
if ((function() local _lev=(lookahead.type ~= Token.EOF); if _bool(_lev) then return not _bool(match(_ENV,"}")); else return _lev; end end)()) then
throwUnexpectedToken(_ENV,lookahead);
end

end);
isolateCoverGrammar = (function (this, parser)
local result,oldFirstCoverInitializedNameError,oldIsAssignmentTarget,oldIsBindingElement;
oldIsBindingElement = isBindingElement;
oldIsAssignmentTarget = isAssignmentTarget;
oldFirstCoverInitializedNameError = firstCoverInitializedNameError;
isBindingElement = true;
isAssignmentTarget = true;
firstCoverInitializedNameError = null;
result = parser(_ENV);
if (firstCoverInitializedNameError ~= null) then
throwUnexpectedToken(_ENV,firstCoverInitializedNameError);
end

isBindingElement = oldIsBindingElement;
isAssignmentTarget = oldIsAssignmentTarget;
firstCoverInitializedNameError = oldFirstCoverInitializedNameError;
do return result; end
end);
inheritCoverGrammar = (function (this, parser)
local result,oldFirstCoverInitializedNameError,oldIsAssignmentTarget,oldIsBindingElement;
oldIsBindingElement = isBindingElement;
oldIsAssignmentTarget = isAssignmentTarget;
oldFirstCoverInitializedNameError = firstCoverInitializedNameError;
isBindingElement = true;
isAssignmentTarget = true;
firstCoverInitializedNameError = null;
result = parser(_ENV);
isBindingElement = ((function() if _bool(isBindingElement) then return oldIsBindingElement; else return isBindingElement; end end)());
isAssignmentTarget = ((function() if _bool(isAssignmentTarget) then return oldIsAssignmentTarget; else return isAssignmentTarget; end end)());
firstCoverInitializedNameError = (_bool(oldFirstCoverInitializedNameError) and oldFirstCoverInitializedNameError or firstCoverInitializedNameError);
do return result; end
end);
parseArrayPattern = (function (this, params, kind)
local restNode,rest,elements,node;
node = _new(Node);
elements = _arr({},0);
expect(_ENV,"[");
while not _bool(match(_ENV,"]")) do
if _bool(match(_ENV,",")) then
lex(_ENV);
elements:push(null);
else
if _bool(match(_ENV,"...")) then
restNode = _new(Node);
lex(_ENV);
params:push(lookahead);
rest = parseVariableIdentifier(_ENV,kind);
elements:push(restNode:finishRestElement(rest));
do break end;
else
elements:push(parsePatternWithDefault(_ENV,params,kind));
end

if not _bool(match(_ENV,"]")) then
expect(_ENV,",");
end

end

::_continue::
end

expect(_ENV,"]");
do return node:finishArrayPattern(elements); end
end);
parsePropertyPattern = (function (this, params, kind)
local init,computed,keyToken,key,node;
node = _new(Node);
computed = match(_ENV,"[");
if (lookahead.type == Token.Identifier) then
keyToken = lookahead;
key = parseVariableIdentifier(_ENV);
if _bool(match(_ENV,"=")) then
params:push(keyToken);
lex(_ENV);
init = parseAssignmentExpression(_ENV);
do return node:finishProperty("init",key,false,_new(WrappingNode,keyToken):finishAssignmentPattern(key,init),false,true); end
elseif not _bool(match(_ENV,":")) then
params:push(keyToken);
do return node:finishProperty("init",key,false,key,false,true); end
end

else
key = parseObjectPropertyKey(_ENV);
end

expect(_ENV,":");
init = parsePatternWithDefault(_ENV,params,kind);
do return node:finishProperty("init",key,computed,init,false,false); end
end);
parseObjectPattern = (function (this, params, kind)
local properties,node;
node = _new(Node);
properties = _arr({},0);
expect(_ENV,"{");
while not _bool(match(_ENV,"}")) do
properties:push(parsePropertyPattern(_ENV,params,kind));
if not _bool(match(_ENV,"}")) then
expect(_ENV,",");
end

::_continue::
end

lex(_ENV);
do return node:finishObjectPattern(properties); end
end);
parsePattern = (function (this, params, kind)
if _bool(match(_ENV,"[")) then
do return parseArrayPattern(_ENV,params,kind); end
elseif _bool(match(_ENV,"{")) then
do return parseObjectPattern(_ENV,params,kind); end
elseif _bool(matchKeyword(_ENV,"let")) then
if ((function() local _lev=(kind == "const"); return _bool(_lev) and _lev or (kind == "let") end)()) then
tolerateUnexpectedToken(_ENV,lookahead,Messages.UnexpectedToken);
end

end

params:push(lookahead);
do return parseVariableIdentifier(_ENV,kind); end
end);
parsePatternWithDefault = (function (this, params, kind)
local right,previousAllowYield,pattern,startToken;
startToken = lookahead;
pattern = parsePattern(_ENV,params,kind);
if _bool(match(_ENV,"=")) then
lex(_ENV);
previousAllowYield = state.allowYield;
state.allowYield = true;
right = isolateCoverGrammar(_ENV,parseAssignmentExpression);
state.allowYield = previousAllowYield;
pattern = _new(WrappingNode,startToken):finishAssignmentPattern(pattern,right);
end

do return pattern; end
end);
parseArrayInitializer = (function (this)
local restSpread,node,elements;
elements = _arr({},0);
node = _new(Node);
expect(_ENV,"[");
while not _bool(match(_ENV,"]")) do
if _bool(match(_ENV,",")) then
lex(_ENV);
elements:push(null);
elseif _bool(match(_ENV,"...")) then
restSpread = _new(Node);
lex(_ENV);
restSpread:finishSpreadElement(inheritCoverGrammar(_ENV,parseAssignmentExpression));
if not _bool(match(_ENV,"]")) then
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
expect(_ENV,",");
end

elements:push(restSpread);
else
elements:push(inheritCoverGrammar(_ENV,parseAssignmentExpression));
if not _bool(match(_ENV,"]")) then
expect(_ENV,",");
end

end

::_continue::
end

lex(_ENV);
do return node:finishArrayExpression(elements); end
end);
parsePropertyFunction = (function (this, node, paramInfo, isGenerator)
local body,previousStrict;
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
previousStrict = strict;
body = isolateCoverGrammar(_ENV,parseFunctionSourceElements);
if _bool(((function() if _bool(strict) then return paramInfo.firstRestricted; else return strict; end end)())) then
tolerateUnexpectedToken(_ENV,paramInfo.firstRestricted,paramInfo.message);
end

if _bool(((function() if _bool(strict) then return paramInfo.stricted; else return strict; end end)())) then
tolerateUnexpectedToken(_ENV,paramInfo.stricted,paramInfo.message);
end

strict = previousStrict;
do return node:finishFunctionExpression(null,paramInfo.params,paramInfo.defaults,body,isGenerator); end
end);
parsePropertyMethodFunction = (function (this)
local previousAllowYield,node,method,params;
node = _new(Node);
previousAllowYield = state.allowYield;
state.allowYield = false;
params = parseParams(_ENV);
state.allowYield = previousAllowYield;
state.allowYield = false;
method = parsePropertyFunction(_ENV,node,params,false);
state.allowYield = previousAllowYield;
do return method; end
end);
parseObjectPropertyKey = (function (this)
local expr,node,token;
node = _new(Node);
token = lex(_ENV);
repeat
local _into = false;
local _cases = {[Token.StringLiteral] = true,[Token.NumericLiteral] = true,[Token.Identifier] = true,[Token.BooleanLiteral] = true,[Token.NullLiteral] = true,[Token.Keyword] = true,[Token.Punctuator] = true};
local _v = token.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == Token.StringLiteral) then

_into = true;
end
if _into or (_v == Token.NumericLiteral) then
if _bool(((function() if _bool(strict) then return token.octal; else return strict; end end)())) then
tolerateUnexpectedToken(_ENV,token,Messages.StrictOctalLiteral);
end

do return node:finishLiteral(token); end
_into = true;
end
if _into or (_v == Token.Identifier) then

_into = true;
end
if _into or (_v == Token.BooleanLiteral) then

_into = true;
end
if _into or (_v == Token.NullLiteral) then

_into = true;
end
if _into or (_v == Token.Keyword) then
do return node:finishIdentifier(token.value); end
_into = true;
end
if _into or (_v == Token.Punctuator) then
if (token.value == "[") then
expr = isolateCoverGrammar(_ENV,parseAssignmentExpression);
expect(_ENV,"]");
do return expr; end
end

do break end;
_into = true;
end
::_default::
until true
throwUnexpectedToken(_ENV,token);
end);
lookaheadPropertyName = (function (this)
repeat
local _into = false;
local _cases = {[Token.Identifier] = true,[Token.StringLiteral] = true,[Token.BooleanLiteral] = true,[Token.NullLiteral] = true,[Token.NumericLiteral] = true,[Token.Keyword] = true,[Token.Punctuator] = true};
local _v = lookahead.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == Token.Identifier) then

_into = true;
end
if _into or (_v == Token.StringLiteral) then

_into = true;
end
if _into or (_v == Token.BooleanLiteral) then

_into = true;
end
if _into or (_v == Token.NullLiteral) then

_into = true;
end
if _into or (_v == Token.NumericLiteral) then

_into = true;
end
if _into or (_v == Token.Keyword) then
do return true; end
_into = true;
end
if _into or (_v == Token.Punctuator) then
do return (lookahead.value == "["); end
_into = true;
end
::_default::
until true
do return false; end
end);
tryParseMethodDefinition = (function (this, token, key, computed, node)
local previousAllowYield,params,methodNode,options,value;
previousAllowYield = state.allowYield;
if (token.type == Token.Identifier) then
if _bool(((function() local _lev=(token.value == "get"); if _bool(_lev) then return lookaheadPropertyName(_ENV); else return _lev; end end)())) then
computed = match(_ENV,"[");
key = parseObjectPropertyKey(_ENV);
methodNode = _new(Node);
expect(_ENV,"(");
expect(_ENV,")");
state.allowYield = false;
value = parsePropertyFunction(_ENV,methodNode,_obj({
["params"] = _arr({},0),
["defaults"] = _arr({},0),
["stricted"] = null,
["firstRestricted"] = null,
["message"] = null
}),false);
state.allowYield = previousAllowYield;
do return node:finishProperty("get",key,computed,value,false,false); end
elseif _bool(((function() local _lev=(token.value == "set"); if _bool(_lev) then return lookaheadPropertyName(_ENV); else return _lev; end end)())) then
computed = match(_ENV,"[");
key = parseObjectPropertyKey(_ENV);
methodNode = _new(Node);
expect(_ENV,"(");
options = _obj({
["params"] = _arr({},0),
["defaultCount"] = 0,
["defaults"] = _arr({},0),
["firstRestricted"] = null,
["paramSet"] = _obj({})
});
if _bool(match(_ENV,")")) then
tolerateUnexpectedToken(_ENV,lookahead);
else
state.allowYield = false;
parseParam(_ENV,options);
state.allowYield = previousAllowYield;
if (options.defaultCount == 0) then
options.defaults = _arr({},0);
end

end

expect(_ENV,")");
state.allowYield = false;
value = parsePropertyFunction(_ENV,methodNode,options,false);
state.allowYield = previousAllowYield;
do return node:finishProperty("set",key,computed,value,false,false); end
end

elseif _bool(((function() local _lev=((function() local _lev=(token.type == Token.Punctuator); if _bool(_lev) then return (token.value == "*"); else return _lev; end end)()); if _bool(_lev) then return lookaheadPropertyName(_ENV); else return _lev; end end)())) then
computed = match(_ENV,"[");
key = parseObjectPropertyKey(_ENV);
methodNode = _new(Node);
state.allowYield = true;
params = parseParams(_ENV);
state.allowYield = previousAllowYield;
state.allowYield = false;
value = parsePropertyFunction(_ENV,methodNode,params,true);
state.allowYield = previousAllowYield;
do return node:finishProperty("init",key,computed,value,true,false); end
end

if _bool(((function() if _bool(key) then return match(_ENV,"("); else return key; end end)())) then
value = parsePropertyMethodFunction(_ENV);
do return node:finishProperty("init",key,computed,value,true,false); end
end

do return null; end
end);
parseObjectProperty = (function (this, hasProto)
local value,proto,maybeMethod,key,computed,node,token;
token = lookahead;
node = _new(Node);
computed = match(_ENV,"[");
if _bool(match(_ENV,"*")) then
lex(_ENV);
else
key = parseObjectPropertyKey(_ENV);
end

maybeMethod = tryParseMethodDefinition(_ENV,token,key,computed,node);
if _bool(maybeMethod) then
do return maybeMethod; end
end

if not _bool(key) then
throwUnexpectedToken(_ENV,lookahead);
end

if not _bool(computed) then
proto = ((function() local _lev=((function() local _lev=(key.type == Syntax.Identifier); if _bool(_lev) then return (key.name == "__proto__"); else return _lev; end end)()); return _bool(_lev) and _lev or ((function() local _lev=(key.type == Syntax.Literal); if _bool(_lev) then return (key.value == "__proto__"); else return _lev; end end)()) end)());
if _bool(((function() local _lev=hasProto.value; if _bool(_lev) then return proto; else return _lev; end end)())) then
tolerateError(_ENV,Messages.DuplicateProtoProperty);
end

hasProto.value = (_bor(hasProto.value,proto));
end

if _bool(match(_ENV,":")) then
lex(_ENV);
value = inheritCoverGrammar(_ENV,parseAssignmentExpression);
do return node:finishProperty("init",key,computed,value,false,false); end
end

if (token.type == Token.Identifier) then
if _bool(match(_ENV,"=")) then
firstCoverInitializedNameError = lookahead;
lex(_ENV);
value = isolateCoverGrammar(_ENV,parseAssignmentExpression);
do return node:finishProperty("init",key,computed,_new(WrappingNode,token):finishAssignmentPattern(key,value),false,true); end
end

do return node:finishProperty("init",key,computed,key,false,true); end
end

throwUnexpectedToken(_ENV,lookahead);
end);
parseObjectInitializer = (function (this)
local node,hasProto,properties;
properties = _arr({},0);
hasProto = _obj({
["value"] = false
});
node = _new(Node);
expect(_ENV,"{");
while not _bool(match(_ENV,"}")) do
properties:push(parseObjectProperty(_ENV,hasProto));
if not _bool(match(_ENV,"}")) then
expectCommaSeparator(_ENV);
end

::_continue::
end

expect(_ENV,"}");
do return node:finishObjectExpression(properties); end
end);
reinterpretExpressionAsPattern = (function (this, expr)
local i;
repeat
local _into = false;
local _cases = {[Syntax.Identifier] = true,[Syntax.MemberExpression] = true,[Syntax.RestElement] = true,[Syntax.AssignmentPattern] = true,[Syntax.SpreadElement] = true,[Syntax.ArrayExpression] = true,[Syntax.ObjectExpression] = true,[Syntax.AssignmentExpression] = true};
local _v = expr.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == Syntax.Identifier) then

_into = true;
end
if _into or (_v == Syntax.MemberExpression) then

_into = true;
end
if _into or (_v == Syntax.RestElement) then

_into = true;
end
if _into or (_v == Syntax.AssignmentPattern) then
do break end;
_into = true;
end
if _into or (_v == Syntax.SpreadElement) then
expr.type = Syntax.RestElement;
reinterpretExpressionAsPattern(_ENV,expr.argument);
do break end;
_into = true;
end
if _into or (_v == Syntax.ArrayExpression) then
expr.type = Syntax.ArrayPattern;
i = 0;
while (i<expr.elements.length) do
if (expr.elements[i] ~= null) then
reinterpretExpressionAsPattern(_ENV,expr.elements[i]);
end

i = i + 1;
end

do break end;
_into = true;
end
if _into or (_v == Syntax.ObjectExpression) then
expr.type = Syntax.ObjectPattern;
i = 0;
while (i<expr.properties.length) do
reinterpretExpressionAsPattern(_ENV,expr.properties[i].value);
i = i + 1;
end

do break end;
_into = true;
end
if _into or (_v == Syntax.AssignmentExpression) then
expr.type = Syntax.AssignmentPattern;
reinterpretExpressionAsPattern(_ENV,expr.left);
do break end;
_into = true;
end
::_default::
if _into then
do break end;
_into = true;
end
until true
end);
parseTemplateElement = (function (this, option)
local token,node;
if _bool(((function() local _lev=(lookahead.type ~= Token.Template); return _bool(_lev) and _lev or ((function() local _lev=option.head; if _bool(_lev) then return not _bool(lookahead.head); else return _lev; end end)()) end)())) then
throwUnexpectedToken(_ENV);
end

node = _new(Node);
token = lex(_ENV);
do return node:finishTemplateElement(_obj({
["raw"] = token.value.raw,
["cooked"] = token.value.cooked
}),token.tail); end
end);
parseTemplateLiteral = (function (this)
local node,expressions,quasis,quasi;
node = _new(Node);
quasi = parseTemplateElement(_ENV,_obj({
["head"] = true
}));
quasis = _arr({[0]=quasi},1);
expressions = _arr({},0);
while not _bool(quasi.tail) do
expressions:push(parseExpression(_ENV));
quasi = parseTemplateElement(_ENV,_obj({
["head"] = false
}));
quasis:push(quasi);
::_continue::
end

do return node:finishTemplateLiteral(quasis,expressions); end
end);
parseGroupExpression = (function (this)
local params,i,startToken,expressions,expr;
params = _arr({},0);
expect(_ENV,"(");
if _bool(match(_ENV,")")) then
lex(_ENV);
if not _bool(match(_ENV,"=>")) then
expect(_ENV,"=>");
end

do return _obj({
["type"] = PlaceHolders.ArrowParameterPlaceHolder,
["params"] = _arr({},0),
["rawParams"] = _arr({},0)
}); end
end

startToken = lookahead;
if _bool(match(_ENV,"...")) then
expr = parseRestElement(_ENV,params);
expect(_ENV,")");
if not _bool(match(_ENV,"=>")) then
expect(_ENV,"=>");
end

do return _obj({
["type"] = PlaceHolders.ArrowParameterPlaceHolder,
["params"] = _arr({[0]=expr},1)
}); end
end

isBindingElement = true;
expr = inheritCoverGrammar(_ENV,parseAssignmentExpression);
if _bool(match(_ENV,",")) then
isAssignmentTarget = false;
expressions = _arr({[0]=expr},1);
while (_lt(startIndex,length)) do
if not _bool(match(_ENV,",")) then
do break end;
end

lex(_ENV);
if _bool(match(_ENV,"...")) then
if not _bool(isBindingElement) then
throwUnexpectedToken(_ENV,lookahead);
end

expressions:push(parseRestElement(_ENV,params));
expect(_ENV,")");
if not _bool(match(_ENV,"=>")) then
expect(_ENV,"=>");
end

isBindingElement = false;
i = 0;
while (i<expressions.length) do
reinterpretExpressionAsPattern(_ENV,expressions[i]);
i = i + 1;
end

do return _obj({
["type"] = PlaceHolders.ArrowParameterPlaceHolder,
["params"] = expressions
}); end
end

expressions:push(inheritCoverGrammar(_ENV,parseAssignmentExpression));
::_continue::
end

expr = _new(WrappingNode,startToken):finishSequenceExpression(expressions);
end

expect(_ENV,")");
if _bool(match(_ENV,"=>")) then
if ((function() local _lev=(expr.type == Syntax.Identifier); if _bool(_lev) then return (expr.name == "yield"); else return _lev; end end)()) then
do return _obj({
["type"] = PlaceHolders.ArrowParameterPlaceHolder,
["params"] = _arr({[0]=expr},1)
}); end
end

if not _bool(isBindingElement) then
throwUnexpectedToken(_ENV,lookahead);
end

if (expr.type == Syntax.SequenceExpression) then
i = 0;
while (i<expr.expressions.length) do
reinterpretExpressionAsPattern(_ENV,expr.expressions[i]);
i = i + 1;
end

else
reinterpretExpressionAsPattern(_ENV,expr);
end

expr = _obj({
["type"] = PlaceHolders.ArrowParameterPlaceHolder,
["params"] = (function() if (expr.type == Syntax.SequenceExpression) then return expr.expressions; else return _arr({[0]=expr},1); end end)()
});
end

isBindingElement = false;
do return expr; end
end);
parsePrimaryExpression = (function (this)
local node,expr,token,type;
if _bool(match(_ENV,"(")) then
isBindingElement = false;
do return inheritCoverGrammar(_ENV,parseGroupExpression); end
end

if _bool(match(_ENV,"[")) then
do return inheritCoverGrammar(_ENV,parseArrayInitializer); end
end

if _bool(match(_ENV,"{")) then
do return inheritCoverGrammar(_ENV,parseObjectInitializer); end
end

type = lookahead.type;
node = _new(Node);
if (type == Token.Identifier) then
if ((function() local _lev=(state.sourceType == "module"); if _bool(_lev) then return (lookahead.value == "await"); else return _lev; end end)()) then
tolerateUnexpectedToken(_ENV,lookahead);
end

expr = node:finishIdentifier(lex(_ENV).value);
elseif ((function() local _lev=(type == Token.StringLiteral); return _bool(_lev) and _lev or (type == Token.NumericLiteral) end)()) then
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
if _bool(((function() if _bool(strict) then return lookahead.octal; else return strict; end end)())) then
tolerateUnexpectedToken(_ENV,lookahead,Messages.StrictOctalLiteral);
end

expr = node:finishLiteral(lex(_ENV));
elseif (type == Token.Keyword) then
if _bool(((function() local _lev=((function() local _lev=not _bool(strict); if _bool(_lev) then return state.allowYield; else return _lev; end end)()); if _bool(_lev) then return matchKeyword(_ENV,"yield"); else return _lev; end end)())) then
do return parseNonComputedProperty(_ENV); end
end

if _bool(((function() local _lev=not _bool(strict); if _bool(_lev) then return matchKeyword(_ENV,"let"); else return _lev; end end)())) then
do return node:finishIdentifier(lex(_ENV).value); end
end

isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
if _bool(matchKeyword(_ENV,"function")) then
do return parseFunctionExpression(_ENV); end
end

if _bool(matchKeyword(_ENV,"this")) then
lex(_ENV);
do return node:finishThisExpression(); end
end

if _bool(matchKeyword(_ENV,"class")) then
do return parseClassExpression(_ENV); end
end

throwUnexpectedToken(_ENV,lex(_ENV));
elseif (type == Token.BooleanLiteral) then
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
token = lex(_ENV);
token.value = (token.value == "true");
expr = node:finishLiteral(token);
elseif (type == Token.NullLiteral) then
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
token = lex(_ENV);
token.value = null;
expr = node:finishLiteral(token);
elseif _bool(((function() local _lev=match(_ENV,"/"); return _bool(_lev) and _lev or match(_ENV,"/=") end)())) then
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
index = startIndex;
if (_type(extra.tokens) ~= "undefined") then
token = collectRegex(_ENV);
else
token = scanRegExp(_ENV);
end

lex(_ENV);
expr = node:finishLiteral(token);
elseif (type == Token.Template) then
expr = parseTemplateLiteral(_ENV);
else
throwUnexpectedToken(_ENV,lex(_ENV));
end

do return expr; end
end);
parseArguments = (function (this)
local expr,args;
args = _arr({},0);
expect(_ENV,"(");
if not _bool(match(_ENV,")")) then
while (_lt(startIndex,length)) do
if _bool(match(_ENV,"...")) then
expr = _new(Node);
lex(_ENV);
expr:finishSpreadElement(isolateCoverGrammar(_ENV,parseAssignmentExpression));
else
expr = isolateCoverGrammar(_ENV,parseAssignmentExpression);
end

args:push(expr);
if _bool(match(_ENV,")")) then
do break end;
end

expectCommaSeparator(_ENV);
::_continue::
end

end

expect(_ENV,")");
do return args; end
end);
parseNonComputedProperty = (function (this)
local node,token;
node = _new(Node);
token = lex(_ENV);
if not _bool(isIdentifierName(_ENV,token)) then
throwUnexpectedToken(_ENV,token);
end

do return node:finishIdentifier(token.value); end
end);
parseNonComputedMember = (function (this)
expect(_ENV,".");
do return parseNonComputedProperty(_ENV); end
end);
parseComputedMember = (function (this)
local expr;
expect(_ENV,"[");
expr = isolateCoverGrammar(_ENV,parseExpression);
expect(_ENV,"]");
do return expr; end
end);
parseNewExpression = (function (this)
local node,args,callee;
node = _new(Node);
expectKeyword(_ENV,"new");
if _bool(match(_ENV,".")) then
lex(_ENV);
if ((function() local _lev=(lookahead.type == Token.Identifier); if _bool(_lev) then return (lookahead.value == "target"); else return _lev; end end)()) then
if _bool(state.inFunctionBody) then
lex(_ENV);
do return node:finishMetaProperty("new","target"); end
end

end

throwUnexpectedToken(_ENV,lookahead);
end

callee = isolateCoverGrammar(_ENV,parseLeftHandSideExpression);
args = (function() if _bool(match(_ENV,"(")) then return parseArguments(_ENV); else return _arr({},0); end end)();
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
do return node:finishNewExpression(callee,args); end
end);
parseLeftHandSideExpressionAllowCall = (function (this)
local previousAllowIn,startToken,property,args,expr,quasi;
previousAllowIn = state.allowIn;
startToken = lookahead;
state.allowIn = true;
if _bool(((function() local _lev=matchKeyword(_ENV,"super"); if _bool(_lev) then return state.inFunctionBody; else return _lev; end end)())) then
expr = _new(Node);
lex(_ENV);
expr = expr:finishSuper();
if ((function() local _lev=((function() local _lev=not _bool(match(_ENV,"(")); if _bool(_lev) then return not _bool(match(_ENV,".")); else return _lev; end end)()); if _bool(_lev) then return not _bool(match(_ENV,"[")); else return _lev; end end)()) then
throwUnexpectedToken(_ENV,lookahead);
end

else
expr = inheritCoverGrammar(_ENV,(function() if _bool(matchKeyword(_ENV,"new")) then return parseNewExpression; else return parsePrimaryExpression; end end)());
end

while true do
if _bool(match(_ENV,".")) then
isBindingElement = false;
isAssignmentTarget = true;
property = parseNonComputedMember(_ENV);
expr = _new(WrappingNode,startToken):finishMemberExpression(".",expr,property);
elseif _bool(match(_ENV,"(")) then
isBindingElement = false;
isAssignmentTarget = false;
args = parseArguments(_ENV);
expr = _new(WrappingNode,startToken):finishCallExpression(expr,args);
elseif _bool(match(_ENV,"[")) then
isBindingElement = false;
isAssignmentTarget = true;
property = parseComputedMember(_ENV);
expr = _new(WrappingNode,startToken):finishMemberExpression("[",expr,property);
elseif _bool(((function() local _lev=(lookahead.type == Token.Template); if _bool(_lev) then return lookahead.head; else return _lev; end end)())) then
quasi = parseTemplateLiteral(_ENV);
expr = _new(WrappingNode,startToken):finishTaggedTemplateExpression(expr,quasi);
else
do break end;
end

end

state.allowIn = previousAllowIn;
do return expr; end
end);
parseLeftHandSideExpression = (function (this)
local startToken,property,expr,quasi;
assert(_ENV,state.allowIn,"callee of new expression always allow in keyword.");
startToken = lookahead;
if _bool(((function() local _lev=matchKeyword(_ENV,"super"); if _bool(_lev) then return state.inFunctionBody; else return _lev; end end)())) then
expr = _new(Node);
lex(_ENV);
expr = expr:finishSuper();
if ((function() local _lev=not _bool(match(_ENV,"[")); if _bool(_lev) then return not _bool(match(_ENV,".")); else return _lev; end end)()) then
throwUnexpectedToken(_ENV,lookahead);
end

else
expr = inheritCoverGrammar(_ENV,(function() if _bool(matchKeyword(_ENV,"new")) then return parseNewExpression; else return parsePrimaryExpression; end end)());
end

while true do
if _bool(match(_ENV,"[")) then
isBindingElement = false;
isAssignmentTarget = true;
property = parseComputedMember(_ENV);
expr = _new(WrappingNode,startToken):finishMemberExpression("[",expr,property);
elseif _bool(match(_ENV,".")) then
isBindingElement = false;
isAssignmentTarget = true;
property = parseNonComputedMember(_ENV);
expr = _new(WrappingNode,startToken):finishMemberExpression(".",expr,property);
elseif _bool(((function() local _lev=(lookahead.type == Token.Template); if _bool(_lev) then return lookahead.head; else return _lev; end end)())) then
quasi = parseTemplateLiteral(_ENV);
expr = _new(WrappingNode,startToken):finishTaggedTemplateExpression(expr,quasi);
else
do break end;
end

end

do return expr; end
end);
parsePostfixExpression = (function (this)
local startToken,token,expr;
startToken = lookahead;
expr = inheritCoverGrammar(_ENV,parseLeftHandSideExpressionAllowCall);
if ((function() local _lev=not _bool(hasLineTerminator); if _bool(_lev) then return (lookahead.type == Token.Punctuator); else return _lev; end end)()) then
if _bool(((function() local _lev=match(_ENV,"++"); return _bool(_lev) and _lev or match(_ENV,"--") end)())) then
if _bool(((function() local _lev=((function() if _bool(strict) then return (expr.type == Syntax.Identifier); else return strict; end end)()); if _bool(_lev) then return isRestrictedWord(_ENV,expr.name); else return _lev; end end)())) then
tolerateError(_ENV,Messages.StrictLHSPostfix);
end

if not _bool(isAssignmentTarget) then
tolerateError(_ENV,Messages.InvalidLHSInAssignment);
end

isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
token = lex(_ENV);
expr = _new(WrappingNode,startToken):finishPostfixExpression(token.value,expr);
end

end

do return expr; end
end);
parseUnaryExpression = (function (this)
local startToken,expr,token;
if ((function() local _lev=(lookahead.type ~= Token.Punctuator); if _bool(_lev) then return (lookahead.type ~= Token.Keyword); else return _lev; end end)()) then
expr = parsePostfixExpression(_ENV);
elseif _bool(((function() local _lev=match(_ENV,"++"); return _bool(_lev) and _lev or match(_ENV,"--") end)())) then
startToken = lookahead;
token = lex(_ENV);
expr = inheritCoverGrammar(_ENV,parseUnaryExpression);
if _bool(((function() local _lev=((function() if _bool(strict) then return (expr.type == Syntax.Identifier); else return strict; end end)()); if _bool(_lev) then return isRestrictedWord(_ENV,expr.name); else return _lev; end end)())) then
tolerateError(_ENV,Messages.StrictLHSPrefix);
end

if not _bool(isAssignmentTarget) then
tolerateError(_ENV,Messages.InvalidLHSInAssignment);
end

expr = _new(WrappingNode,startToken):finishUnaryExpression(token.value,expr);
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
elseif _bool(((function() local _lev=((function() local _lev=((function() local _lev=match(_ENV,"+"); return _bool(_lev) and _lev or match(_ENV,"-") end)()); return _bool(_lev) and _lev or match(_ENV,"~") end)()); return _bool(_lev) and _lev or match(_ENV,"!") end)())) then
startToken = lookahead;
token = lex(_ENV);
expr = inheritCoverGrammar(_ENV,parseUnaryExpression);
expr = _new(WrappingNode,startToken):finishUnaryExpression(token.value,expr);
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
elseif _bool(((function() local _lev=((function() local _lev=matchKeyword(_ENV,"delete"); return _bool(_lev) and _lev or matchKeyword(_ENV,"void") end)()); return _bool(_lev) and _lev or matchKeyword(_ENV,"typeof") end)())) then
startToken = lookahead;
token = lex(_ENV);
expr = inheritCoverGrammar(_ENV,parseUnaryExpression);
expr = _new(WrappingNode,startToken):finishUnaryExpression(token.value,expr);
if _bool(((function() local _lev=((function() if _bool(strict) then return (expr.operator == "delete"); else return strict; end end)()); if _bool(_lev) then return (expr.argument.type == Syntax.Identifier); else return _lev; end end)())) then
tolerateError(_ENV,Messages.StrictDelete);
end

isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
else
expr = parsePostfixExpression(_ENV);
end

do return expr; end
end);
binaryPrecedence = (function (this, token, allowIn)
local prec;
prec = 0;
if ((function() local _lev=(token.type ~= Token.Punctuator); if _bool(_lev) then return (token.type ~= Token.Keyword); else return _lev; end end)()) then
do return 0; end
end

repeat
local _into = false;
local _cases = {["||"] = true,["&&"] = true,["|"] = true,["^"] = true,["&"] = true,["=="] = true,["!="] = true,["==="] = true,["!=="] = true,["<"] = true,[">"] = true,["<="] = true,[">="] = true,["instanceof"] = true,["in"] = true,["<<"] = true,[">>"] = true,[">>>"] = true,["+"] = true,["-"] = true,["*"] = true,["/"] = true,["%"] = true};
local _v = token.value;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "||") then
prec = 1;
do break end;
_into = true;
end
if _into or (_v == "&&") then
prec = 2;
do break end;
_into = true;
end
if _into or (_v == "|") then
prec = 3;
do break end;
_into = true;
end
if _into or (_v == "^") then
prec = 4;
do break end;
_into = true;
end
if _into or (_v == "&") then
prec = 5;
do break end;
_into = true;
end
if _into or (_v == "==") then

_into = true;
end
if _into or (_v == "!=") then

_into = true;
end
if _into or (_v == "===") then

_into = true;
end
if _into or (_v == "!==") then
prec = 6;
do break end;
_into = true;
end
if _into or (_v == "<") then

_into = true;
end
if _into or (_v == ">") then

_into = true;
end
if _into or (_v == "<=") then

_into = true;
end
if _into or (_v == ">=") then

_into = true;
end
if _into or (_v == "instanceof") then
prec = 7;
do break end;
_into = true;
end
if _into or (_v == "in") then
prec = (function() if _bool(allowIn) then return 7; else return 0; end end)();
do break end;
_into = true;
end
if _into or (_v == "<<") then

_into = true;
end
if _into or (_v == ">>") then

_into = true;
end
if _into or (_v == ">>>") then
prec = 8;
do break end;
_into = true;
end
if _into or (_v == "+") then

_into = true;
end
if _into or (_v == "-") then
prec = 9;
do break end;
_into = true;
end
if _into or (_v == "*") then

_into = true;
end
if _into or (_v == "/") then

_into = true;
end
if _into or (_v == "%") then
prec = 11;
do break end;
_into = true;
end
::_default::
if _into then
do break end;
_into = true;
end
until true
do return prec; end
end);
parseBinaryExpression = (function (this)
local i,left,operator,right,stack,prec,token,expr,markers,marker;
marker = lookahead;
left = inheritCoverGrammar(_ENV,parseUnaryExpression);
token = lookahead;
prec = binaryPrecedence(_ENV,token,state.allowIn);
if (prec == 0) then
do return left; end
end

isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
token.prec = prec;
lex(_ENV);
markers = _arr({[0]=marker,lookahead},2);
right = isolateCoverGrammar(_ENV,parseUnaryExpression);
stack = _arr({[0]=left,token,right},3);
while (_gt((function() prec = binaryPrecedence(_ENV,lookahead,state.allowIn); return prec end)(),0)) do
while ((function() local _lev=(_gt(stack.length,2)); if _bool(_lev) then return (_le(prec,stack[(stack.length - 2)].prec)); else return _lev; end end)()) do
right = stack:pop();
operator = stack:pop().value;
left = stack:pop();
markers:pop();
expr = _new(WrappingNode,markers[(markers.length - 1)]):finishBinaryExpression(operator,left,right);
stack:push(expr);
::_continue::
end

token = lex(_ENV);
token.prec = prec;
stack:push(token);
markers:push(lookahead);
expr = isolateCoverGrammar(_ENV,parseUnaryExpression);
stack:push(expr);
::_continue::
end

i = (stack.length - 1);
expr = stack[i];
markers:pop();
while (_gt(i,1)) do
expr = _new(WrappingNode,markers:pop()):finishBinaryExpression(stack[(i - 1)].value,stack[(i - 2)],expr);
i = (i - 2);
::_continue::
end

do return expr; end
end);
parseConditionalExpression = (function (this)
local startToken,alternate,consequent,previousAllowIn,expr;
startToken = lookahead;
expr = inheritCoverGrammar(_ENV,parseBinaryExpression);
if _bool(match(_ENV,"?")) then
lex(_ENV);
previousAllowIn = state.allowIn;
state.allowIn = true;
consequent = isolateCoverGrammar(_ENV,parseAssignmentExpression);
state.allowIn = previousAllowIn;
expect(_ENV,":");
alternate = isolateCoverGrammar(_ENV,parseAssignmentExpression);
expr = _new(WrappingNode,startToken):finishConditionalExpression(expr,consequent,alternate);
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
end

do return expr; end
end);
parseConciseBody = (function (this)
if _bool(match(_ENV,"{")) then
do return parseFunctionSourceElements(_ENV); end
end

do return isolateCoverGrammar(_ENV,parseAssignmentExpression); end
end);
checkPatternParam = (function (this, options, param)
local i;
repeat
local _into = false;
local _cases = {[Syntax.Identifier] = true,[Syntax.RestElement] = true,[Syntax.AssignmentPattern] = true,[Syntax.ArrayPattern] = true,[Syntax.YieldExpression] = true};
local _v = param.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == Syntax.Identifier) then
validateParam(_ENV,options,param,param.name);
do break end;
_into = true;
end
if _into or (_v == Syntax.RestElement) then
checkPatternParam(_ENV,options,param.argument);
do break end;
_into = true;
end
if _into or (_v == Syntax.AssignmentPattern) then
checkPatternParam(_ENV,options,param.left);
do break end;
_into = true;
end
if _into or (_v == Syntax.ArrayPattern) then
i = 0;
while (i<param.elements.length) do
if (param.elements[i] ~= null) then
checkPatternParam(_ENV,options,param.elements[i]);
end

i = i + 1;
end

do break end;
_into = true;
end
if _into or (_v == Syntax.YieldExpression) then
do break end;
_into = true;
end
::_default::
if _into then
assert(_ENV,(param.type == Syntax.ObjectPattern),"Invalid type");
i = 0;
while (i<param.properties.length) do
checkPatternParam(_ENV,options,param.properties[i].value);
i = i + 1;
end

do break end;
_into = true;
end
until true
end);
reinterpretAsCoverFormalsList = (function (this, expr)
local token,options,defaultCount,defaults,params,param,len,i;
defaults = _arr({},0);
defaultCount = 0;
params = _arr({[0]=expr},1);
repeat
local _into = false;
local _cases = {[Syntax.Identifier] = true,[PlaceHolders.ArrowParameterPlaceHolder] = true};
local _v = expr.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == Syntax.Identifier) then
do break end;
_into = true;
end
if _into or (_v == PlaceHolders.ArrowParameterPlaceHolder) then
params = expr.params;
do break end;
_into = true;
end
::_default::
if _into then
do return null; end
_into = true;
end
until true
options = _obj({
["paramSet"] = _obj({})
});
_seq({(function() i = 0; return i end)(),(function() len = params.length; return len end)()});
while (_lt(i,len)) do
param = params[i];
repeat
local _into = false;
local _cases = {[Syntax.AssignmentPattern] = true};
local _v = param.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == Syntax.AssignmentPattern) then
params[i] = param.left;
if (param.right.type == Syntax.YieldExpression) then
if _bool(param.right.argument) then
throwUnexpectedToken(_ENV,lookahead);
end

param.right.type = Syntax.Identifier;
param.right.name = "yield";
(function () local _r = false; local _g, _s = param.right["_g" .. "argument"], param.right["_s" .. "argument"]; param.right["_g" .. "argument"], param.right["_s" .. "argument"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = param.right.argument; param.right.argument = nil; return _r or _v ~= nil; end)();
(function () local _r = false; local _g, _s = param.right["_g" .. "delegate"], param.right["_s" .. "delegate"]; param.right["_g" .. "delegate"], param.right["_s" .. "delegate"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = param.right.delegate; param.right.delegate = nil; return _r or _v ~= nil; end)();
end

defaults:push(param.right);
defaultCount = _inc(defaultCount);
checkPatternParam(_ENV,options,param.left);
do break end;
_into = true;
end
::_default::
if _into then
checkPatternParam(_ENV,options,param);
params[i] = param;
defaults:push(null);
do break end;
_into = true;
end
until true
i = (_addNum2(i,1));
end

if _bool((_bool(strict) and strict or not _bool(state.allowYield))) then
_seq({(function() i = 0; return i end)(),(function() len = params.length; return len end)()});
while (_lt(i,len)) do
param = params[i];
if (param.type == Syntax.YieldExpression) then
throwUnexpectedToken(_ENV,lookahead);
end

i = (_addNum2(i,1));
end

end

if (options.message == Messages.StrictParamDupe) then
token = (function() if _bool(strict) then return options.stricted; else return options.firstRestricted; end end)();
throwUnexpectedToken(_ENV,token,options.message);
end

if (defaultCount == 0) then
defaults = _arr({},0);
end

do return _obj({
["params"] = params,
["defaults"] = defaults,
["stricted"] = options.stricted,
["firstRestricted"] = options.firstRestricted,
["message"] = options.message
}); end
end);
parseArrowFunctionExpression = (function (this, options, node)
local body,previousAllowYield,previousStrict;
if _bool(hasLineTerminator) then
tolerateUnexpectedToken(_ENV,lookahead);
end

expect(_ENV,"=>");
previousStrict = strict;
previousAllowYield = state.allowYield;
state.allowYield = true;
body = parseConciseBody(_ENV);
if _bool(((function() if _bool(strict) then return options.firstRestricted; else return strict; end end)())) then
throwUnexpectedToken(_ENV,options.firstRestricted,options.message);
end

if _bool(((function() if _bool(strict) then return options.stricted; else return strict; end end)())) then
tolerateUnexpectedToken(_ENV,options.stricted,options.message);
end

strict = previousStrict;
state.allowYield = previousAllowYield;
do return node:finishArrowFunctionExpression(options.params,options.defaults,body,(body.type ~= Syntax.BlockStatement)); end
end);
parseYieldExpression = (function (this)
local previousAllowYield,delegate,expr,argument;
argument = null;
expr = _new(Node);
delegate = false;
expectKeyword(_ENV,"yield");
if not _bool(hasLineTerminator) then
previousAllowYield = state.allowYield;
state.allowYield = false;
delegate = match(_ENV,"*");
if _bool(delegate) then
lex(_ENV);
argument = parseAssignmentExpression(_ENV);
else
if ((function() local _lev=((function() local _lev=((function() local _lev=not _bool(match(_ENV,";")); if _bool(_lev) then return not _bool(match(_ENV,"}")); else return _lev; end end)()); if _bool(_lev) then return not _bool(match(_ENV,")")); else return _lev; end end)()); if _bool(_lev) then return (lookahead.type ~= Token.EOF); else return _lev; end end)()) then
argument = parseAssignmentExpression(_ENV);
end

end

state.allowYield = previousAllowYield;
end

do return expr:finishYieldExpression(argument,delegate); end
end);
parseAssignmentExpression = (function (this)
local startToken,list,right,expr,token;
startToken = lookahead;
token = lookahead;
if _bool(((function() local _lev=not _bool(state.allowYield); if _bool(_lev) then return matchKeyword(_ENV,"yield"); else return _lev; end end)())) then
do return parseYieldExpression(_ENV); end
end

expr = parseConditionalExpression(_ENV);
if _bool(((function() local _lev=(expr.type == PlaceHolders.ArrowParameterPlaceHolder); return _bool(_lev) and _lev or match(_ENV,"=>") end)())) then
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
list = reinterpretAsCoverFormalsList(_ENV,expr);
if _bool(list) then
firstCoverInitializedNameError = null;
do return parseArrowFunctionExpression(_ENV,list,_new(WrappingNode,startToken)); end
end

do return expr; end
end

if _bool(matchAssign(_ENV)) then
if not _bool(isAssignmentTarget) then
tolerateError(_ENV,Messages.InvalidLHSInAssignment);
end

if _bool(((function() if _bool(strict) then return (expr.type == Syntax.Identifier); else return strict; end end)())) then
if _bool(isRestrictedWord(_ENV,expr.name)) then
tolerateUnexpectedToken(_ENV,token,Messages.StrictLHSAssignment);
end

if _bool(isStrictModeReservedWord(_ENV,expr.name)) then
tolerateUnexpectedToken(_ENV,token,Messages.StrictReservedWord);
end

end

if not _bool(match(_ENV,"=")) then
isAssignmentTarget = (function() isBindingElement = false; return isBindingElement end)();
else
reinterpretExpressionAsPattern(_ENV,expr);
end

token = lex(_ENV);
right = isolateCoverGrammar(_ENV,parseAssignmentExpression);
expr = _new(WrappingNode,startToken):finishAssignmentExpression(token.value,expr,right);
firstCoverInitializedNameError = null;
end

do return expr; end
end);
parseExpression = (function (this)
local expressions,startToken,expr;
startToken = lookahead;
expr = isolateCoverGrammar(_ENV,parseAssignmentExpression);
if _bool(match(_ENV,",")) then
expressions = _arr({[0]=expr},1);
while (_lt(startIndex,length)) do
if not _bool(match(_ENV,",")) then
do break end;
end

lex(_ENV);
expressions:push(isolateCoverGrammar(_ENV,parseAssignmentExpression));
::_continue::
end

expr = _new(WrappingNode,startToken):finishSequenceExpression(expressions);
end

do return expr; end
end);
parseStatementListItem = (function (this)
if (lookahead.type == Token.Keyword) then
repeat
local _into = false;
local _cases = {["export"] = true,["import"] = true,["const"] = true,["function"] = true,["class"] = true};
local _v = lookahead.value;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "export") then
if (state.sourceType ~= "module") then
tolerateUnexpectedToken(_ENV,lookahead,Messages.IllegalExportDeclaration);
end

do return parseExportDeclaration(_ENV); end
_into = true;
end
if _into or (_v == "import") then
if (state.sourceType ~= "module") then
tolerateUnexpectedToken(_ENV,lookahead,Messages.IllegalImportDeclaration);
end

do return parseImportDeclaration(_ENV); end
_into = true;
end
if _into or (_v == "const") then
do return parseLexicalDeclaration(_ENV,_obj({
["inFor"] = false
})); end
_into = true;
end
if _into or (_v == "function") then
do return parseFunctionDeclaration(_ENV,_new(Node)); end
_into = true;
end
if _into or (_v == "class") then
do return parseClassDeclaration(_ENV); end
_into = true;
end
::_default::
until true
end

if _bool(((function() local _lev=matchKeyword(_ENV,"let"); if _bool(_lev) then return isLexicalDeclaration(_ENV); else return _lev; end end)())) then
do return parseLexicalDeclaration(_ENV,_obj({
["inFor"] = false
})); end
end

do return parseStatement(_ENV); end
end);
parseStatementList = (function (this)
local list;
list = _arr({},0);
while (_lt(startIndex,length)) do
if _bool(match(_ENV,"}")) then
do break end;
end

list:push(parseStatementListItem(_ENV));
::_continue::
end

do return list; end
end);
parseBlock = (function (this)
local node,block;
node = _new(Node);
expect(_ENV,"{");
block = parseStatementList(_ENV);
expect(_ENV,"}");
do return node:finishBlockStatement(block); end
end);
parseVariableIdentifier = (function (this, kind)
local node,token;
node = _new(Node);
token = lex(_ENV);
if ((function() local _lev=(token.type == Token.Keyword); if _bool(_lev) then return (token.value == "yield"); else return _lev; end end)()) then
if _bool(strict) then
tolerateUnexpectedToken(_ENV,token,Messages.StrictReservedWord);
end

if not _bool(state.allowYield) then
throwUnexpectedToken(_ENV,token);
end

elseif (token.type ~= Token.Identifier) then
if _bool(((function() local _lev=((function() if _bool(strict) then return (token.type == Token.Keyword); else return strict; end end)()); if _bool(_lev) then return isStrictModeReservedWord(_ENV,token.value); else return _lev; end end)())) then
tolerateUnexpectedToken(_ENV,token,Messages.StrictReservedWord);
else
if _bool(((function() local _lev=(_bool(strict) and strict or (token.value ~= "let")); return _bool(_lev) and _lev or (kind ~= "var") end)())) then
throwUnexpectedToken(_ENV,token);
end

end

elseif ((function() local _lev=((function() local _lev=(state.sourceType == "module"); if _bool(_lev) then return (token.type == Token.Identifier); else return _lev; end end)()); if _bool(_lev) then return (token.value == "await"); else return _lev; end end)()) then
tolerateUnexpectedToken(_ENV,token);
end

do return node:finishIdentifier(token.value); end
end);
parseVariableDeclaration = (function (this, options)
local params,node,id,init;
init = null;
node = _new(Node);
params = _arr({},0);
id = parsePattern(_ENV,params,"var");
if _bool(((function() if _bool(strict) then return isRestrictedWord(_ENV,id.name); else return strict; end end)())) then
tolerateError(_ENV,Messages.StrictVarName);
end

if _bool(match(_ENV,"=")) then
lex(_ENV);
init = isolateCoverGrammar(_ENV,parseAssignmentExpression);
elseif ((function() local _lev=(id.type ~= Syntax.Identifier); if _bool(_lev) then return not _bool(options.inFor); else return _lev; end end)()) then
expect(_ENV,"=");
end

do return node:finishVariableDeclarator(id,init); end
end);
parseVariableDeclarationList = (function (this, options)
local list,opt;
opt = _obj({
["inFor"] = options.inFor
});
list = _arr({[0]=parseVariableDeclaration(_ENV,opt)},1);
while _bool(match(_ENV,",")) do
lex(_ENV);
list:push(parseVariableDeclaration(_ENV,opt));
::_continue::
end

do return list; end
end);
parseVariableStatement = (function (this, node)
local declarations;
expectKeyword(_ENV,"var");
declarations = parseVariableDeclarationList(_ENV,_obj({
["inFor"] = false
}));
consumeSemicolon(_ENV);
do return node:finishVariableDeclaration(declarations); end
end);
parseLexicalBinding = (function (this, kind, options)
local params,node,id,init;
init = null;
node = _new(Node);
params = _arr({},0);
id = parsePattern(_ENV,params,kind);
if _bool(((function() local _lev=((function() if _bool(strict) then return (id.type == Syntax.Identifier); else return strict; end end)()); if _bool(_lev) then return isRestrictedWord(_ENV,id.name); else return _lev; end end)())) then
tolerateError(_ENV,Messages.StrictVarName);
end

if (kind == "const") then
if ((function() local _lev=not _bool(matchKeyword(_ENV,"in")); if _bool(_lev) then return not _bool(matchContextualKeyword(_ENV,"of")); else return _lev; end end)()) then
expect(_ENV,"=");
init = isolateCoverGrammar(_ENV,parseAssignmentExpression);
end

elseif _bool(((function() local _lev=((function() local _lev=not _bool(options.inFor); if _bool(_lev) then return (id.type ~= Syntax.Identifier); else return _lev; end end)()); return _bool(_lev) and _lev or match(_ENV,"=") end)())) then
expect(_ENV,"=");
init = isolateCoverGrammar(_ENV,parseAssignmentExpression);
end

do return node:finishVariableDeclarator(id,init); end
end);
parseBindingList = (function (this, kind, options)
local list;
list = _arr({[0]=parseLexicalBinding(_ENV,kind,options)},1);
while _bool(match(_ENV,",")) do
lex(_ENV);
list:push(parseLexicalBinding(_ENV,kind,options));
::_continue::
end

do return list; end
end);
tokenizerState = (function (this)
do return _obj({
["index"] = index,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["hasLineTerminator"] = hasLineTerminator,
["lastIndex"] = lastIndex,
["lastLineNumber"] = lastLineNumber,
["lastLineStart"] = lastLineStart,
["startIndex"] = startIndex,
["startLineNumber"] = startLineNumber,
["startLineStart"] = startLineStart,
["lookahead"] = lookahead,
["tokenCount"] = (function() if _bool(extra.tokens) then return extra.tokens.length; else return 0; end end)()
}); end
end);
resetTokenizerState = (function (this, ts)
index = ts.index;
lineNumber = ts.lineNumber;
lineStart = ts.lineStart;
hasLineTerminator = ts.hasLineTerminator;
lastIndex = ts.lastIndex;
lastLineNumber = ts.lastLineNumber;
lastLineStart = ts.lastLineStart;
startIndex = ts.startIndex;
startLineNumber = ts.startLineNumber;
startLineStart = ts.startLineStart;
lookahead = ts.lookahead;
if _bool(extra.tokens) then
extra.tokens:splice(ts.tokenCount,extra.tokens.length);
end

end);
isLexicalDeclaration = (function (this)
local ts,lexical;
ts = tokenizerState(_ENV);
lex(_ENV);
lexical = ((function() local _lev=((function() local _lev=((function() local _lev=((function() local _lev=(lookahead.type == Token.Identifier); return _bool(_lev) and _lev or match(_ENV,"[") end)()); return _bool(_lev) and _lev or match(_ENV,"{") end)()); return _bool(_lev) and _lev or matchKeyword(_ENV,"let") end)()); return _bool(_lev) and _lev or matchKeyword(_ENV,"yield") end)());
resetTokenizerState(_ENV,ts);
do return lexical; end
end);
parseLexicalDeclaration = (function (this, options)
local node,declarations,kind;
node = _new(Node);
kind = lex(_ENV).value;
assert(_ENV,((function() local _lev=(kind == "let"); return _bool(_lev) and _lev or (kind == "const") end)()),"Lexical declaration must be either let or const");
declarations = parseBindingList(_ENV,kind,options);
consumeSemicolon(_ENV);
do return node:finishLexicalDeclaration(declarations,kind); end
end);
parseRestElement = (function (this, params)
local node,param;
node = _new(Node);
lex(_ENV);
if _bool(match(_ENV,"{")) then
throwError(_ENV,Messages.ObjectPatternAsRestParameter);
end

params:push(lookahead);
param = parseVariableIdentifier(_ENV);
if _bool(match(_ENV,"=")) then
throwError(_ENV,Messages.DefaultRestParameter);
end

if not _bool(match(_ENV,")")) then
throwError(_ENV,Messages.ParameterAfterRestParameter);
end

do return node:finishRestElement(param); end
end);
parseEmptyStatement = (function (this, node)
expect(_ENV,";");
do return node:finishEmptyStatement(); end
end);
parseExpressionStatement = (function (this, node)
local expr;
expr = parseExpression(_ENV);
consumeSemicolon(_ENV);
do return node:finishExpressionStatement(expr); end
end);
parseIfStatement = (function (this, node)
local alternate,consequent,test;
expectKeyword(_ENV,"if");
expect(_ENV,"(");
test = parseExpression(_ENV);
expect(_ENV,")");
consequent = parseStatement(_ENV);
if _bool(matchKeyword(_ENV,"else")) then
lex(_ENV);
alternate = parseStatement(_ENV);
else
alternate = null;
end

do return node:finishIfStatement(test,consequent,alternate); end
end);
parseDoWhileStatement = (function (this, node)
local oldInIteration,test,body;
expectKeyword(_ENV,"do");
oldInIteration = state.inIteration;
state.inIteration = true;
body = parseStatement(_ENV);
state.inIteration = oldInIteration;
expectKeyword(_ENV,"while");
expect(_ENV,"(");
test = parseExpression(_ENV);
expect(_ENV,")");
if _bool(match(_ENV,";")) then
lex(_ENV);
end

do return node:finishDoWhileStatement(body,test); end
end);
parseWhileStatement = (function (this, node)
local oldInIteration,body,test;
expectKeyword(_ENV,"while");
expect(_ENV,"(");
test = parseExpression(_ENV);
expect(_ENV,")");
oldInIteration = state.inIteration;
state.inIteration = true;
body = parseStatement(_ENV);
state.inIteration = oldInIteration;
do return node:finishWhileStatement(test,body); end
end);
parseForStatement = (function (this, node)
local previousAllowIn,oldInIteration,body,declarations,kind,right,left,update,test,initStartToken,initSeq,forIn,init;
previousAllowIn = state.allowIn;
init = (function() test = (function() update = null; return update end)(); return test end)();
forIn = true;
expectKeyword(_ENV,"for");
expect(_ENV,"(");
if _bool(match(_ENV,";")) then
lex(_ENV);
else
if _bool(matchKeyword(_ENV,"var")) then
init = _new(Node);
lex(_ENV);
state.allowIn = false;
declarations = parseVariableDeclarationList(_ENV,_obj({
["inFor"] = true
}));
state.allowIn = previousAllowIn;
if _bool(((function() local _lev=(declarations.length == 1); if _bool(_lev) then return matchKeyword(_ENV,"in"); else return _lev; end end)())) then
init = init:finishVariableDeclaration(declarations);
lex(_ENV);
left = init;
right = parseExpression(_ENV);
init = null;
elseif _bool(((function() local _lev=((function() local _lev=(declarations.length == 1); if _bool(_lev) then return (declarations[0].init == null); else return _lev; end end)()); if _bool(_lev) then return matchContextualKeyword(_ENV,"of"); else return _lev; end end)())) then
init = init:finishVariableDeclaration(declarations);
lex(_ENV);
left = init;
right = parseAssignmentExpression(_ENV);
init = null;
forIn = false;
else
init = init:finishVariableDeclaration(declarations);
expect(_ENV,";");
end

elseif _bool(((function() local _lev=matchKeyword(_ENV,"const"); return _bool(_lev) and _lev or matchKeyword(_ENV,"let") end)())) then
init = _new(Node);
kind = lex(_ENV).value;
if ((function() local _lev=not _bool(strict); if _bool(_lev) then return (lookahead.value == "in"); else return _lev; end end)()) then
init = init:finishIdentifier(kind);
lex(_ENV);
left = init;
right = parseExpression(_ENV);
init = null;
else
state.allowIn = false;
declarations = parseBindingList(_ENV,kind,_obj({
["inFor"] = true
}));
state.allowIn = previousAllowIn;
if _bool(((function() local _lev=((function() local _lev=(declarations.length == 1); if _bool(_lev) then return (declarations[0].init == null); else return _lev; end end)()); if _bool(_lev) then return matchKeyword(_ENV,"in"); else return _lev; end end)())) then
init = init:finishLexicalDeclaration(declarations,kind);
lex(_ENV);
left = init;
right = parseExpression(_ENV);
init = null;
elseif _bool(((function() local _lev=((function() local _lev=(declarations.length == 1); if _bool(_lev) then return (declarations[0].init == null); else return _lev; end end)()); if _bool(_lev) then return matchContextualKeyword(_ENV,"of"); else return _lev; end end)())) then
init = init:finishLexicalDeclaration(declarations,kind);
lex(_ENV);
left = init;
right = parseAssignmentExpression(_ENV);
init = null;
forIn = false;
else
consumeSemicolon(_ENV);
init = init:finishLexicalDeclaration(declarations,kind);
end

end

else
initStartToken = lookahead;
state.allowIn = false;
init = inheritCoverGrammar(_ENV,parseAssignmentExpression);
state.allowIn = previousAllowIn;
if _bool(matchKeyword(_ENV,"in")) then
if not _bool(isAssignmentTarget) then
tolerateError(_ENV,Messages.InvalidLHSInForIn);
end

lex(_ENV);
reinterpretExpressionAsPattern(_ENV,init);
left = init;
right = parseExpression(_ENV);
init = null;
elseif _bool(matchContextualKeyword(_ENV,"of")) then
if not _bool(isAssignmentTarget) then
tolerateError(_ENV,Messages.InvalidLHSInForLoop);
end

lex(_ENV);
reinterpretExpressionAsPattern(_ENV,init);
left = init;
right = parseAssignmentExpression(_ENV);
init = null;
forIn = false;
else
if _bool(match(_ENV,",")) then
initSeq = _arr({[0]=init},1);
while _bool(match(_ENV,",")) do
lex(_ENV);
initSeq:push(isolateCoverGrammar(_ENV,parseAssignmentExpression));
::_continue::
end

init = _new(WrappingNode,initStartToken):finishSequenceExpression(initSeq);
end

expect(_ENV,";");
end

end

end

if (_type(left) == "undefined") then
if not _bool(match(_ENV,";")) then
test = parseExpression(_ENV);
end

expect(_ENV,";");
if not _bool(match(_ENV,")")) then
update = parseExpression(_ENV);
end

end

expect(_ENV,")");
oldInIteration = state.inIteration;
state.inIteration = true;
body = isolateCoverGrammar(_ENV,parseStatement);
state.inIteration = oldInIteration;
do return (function() if (_type(left) == "undefined") then return node:finishForStatement(init,test,update,body); else return (function() if _bool(forIn) then return node:finishForInStatement(left,right,body); else return node:finishForOfStatement(left,right,body); end end)(); end end)(); end
end);
parseContinueStatement = (function (this, node)
local key,label;
label = null;
expectKeyword(_ENV,"continue");
if (source:charCodeAt(startIndex) == 59) then
lex(_ENV);
if not _bool(state.inIteration) then
throwError(_ENV,Messages.IllegalContinue);
end

do return node:finishContinueStatement(null); end
end

if _bool(hasLineTerminator) then
if not _bool(state.inIteration) then
throwError(_ENV,Messages.IllegalContinue);
end

do return node:finishContinueStatement(null); end
end

if (lookahead.type == Token.Identifier) then
label = parseVariableIdentifier(_ENV);
key = (_addStr1("$",label.name));
if not _bool(Object.prototype.hasOwnProperty:call(state.labelSet,key)) then
throwError(_ENV,Messages.UnknownLabel,label.name);
end

end

consumeSemicolon(_ENV);
if ((function() local _lev=(label == null); if _bool(_lev) then return not _bool(state.inIteration); else return _lev; end end)()) then
throwError(_ENV,Messages.IllegalContinue);
end

do return node:finishContinueStatement(label); end
end);
parseBreakStatement = (function (this, node)
local key,label;
label = null;
expectKeyword(_ENV,"break");
if (source:charCodeAt(lastIndex) == 59) then
lex(_ENV);
if not _bool(((function() local _lev=state.inIteration; return _bool(_lev) and _lev or state.inSwitch end)())) then
throwError(_ENV,Messages.IllegalBreak);
end

do return node:finishBreakStatement(null); end
end

if _bool(hasLineTerminator) then
if not _bool(((function() local _lev=state.inIteration; return _bool(_lev) and _lev or state.inSwitch end)())) then
throwError(_ENV,Messages.IllegalBreak);
end

elseif (lookahead.type == Token.Identifier) then
label = parseVariableIdentifier(_ENV);
key = (_addStr1("$",label.name));
if not _bool(Object.prototype.hasOwnProperty:call(state.labelSet,key)) then
throwError(_ENV,Messages.UnknownLabel,label.name);
end

end

consumeSemicolon(_ENV);
if ((function() local _lev=(label == null); if _bool(_lev) then return not _bool(((function() local _lev=state.inIteration; return _bool(_lev) and _lev or state.inSwitch end)())); else return _lev; end end)()) then
throwError(_ENV,Messages.IllegalBreak);
end

do return node:finishBreakStatement(label); end
end);
parseReturnStatement = (function (this, node)
local argument;
argument = null;
expectKeyword(_ENV,"return");
if not _bool(state.inFunctionBody) then
tolerateError(_ENV,Messages.IllegalReturn);
end

if (source:charCodeAt(lastIndex) == 32) then
if _bool(isIdentifierStart(_ENV,source:charCodeAt((_addNum2(lastIndex,1))))) then
argument = parseExpression(_ENV);
consumeSemicolon(_ENV);
do return node:finishReturnStatement(argument); end
end

end

if _bool(hasLineTerminator) then
do return node:finishReturnStatement(null); end
end

if not _bool(match(_ENV,";")) then
if ((function() local _lev=not _bool(match(_ENV,"}")); if _bool(_lev) then return (lookahead.type ~= Token.EOF); else return _lev; end end)()) then
argument = parseExpression(_ENV);
end

end

consumeSemicolon(_ENV);
do return node:finishReturnStatement(argument); end
end);
parseWithStatement = (function (this, node)
local body,object;
if _bool(strict) then
tolerateError(_ENV,Messages.StrictModeWith);
end

expectKeyword(_ENV,"with");
expect(_ENV,"(");
object = parseExpression(_ENV);
expect(_ENV,")");
body = parseStatement(_ENV);
do return node:finishWithStatement(object,body); end
end);
parseSwitchCase = (function (this)
local node,statement,consequent,test;
consequent = _arr({},0);
node = _new(Node);
if _bool(matchKeyword(_ENV,"default")) then
lex(_ENV);
test = null;
else
expectKeyword(_ENV,"case");
test = parseExpression(_ENV);
end

expect(_ENV,":");
while (_lt(startIndex,length)) do
if _bool(((function() local _lev=((function() local _lev=match(_ENV,"}"); return _bool(_lev) and _lev or matchKeyword(_ENV,"default") end)()); return _bool(_lev) and _lev or matchKeyword(_ENV,"case") end)())) then
do break end;
end

statement = parseStatementListItem(_ENV);
consequent:push(statement);
::_continue::
end

do return node:finishSwitchCase(test,consequent); end
end);
parseSwitchStatement = (function (this, node)
local defaultFound,oldInSwitch,clause,cases,discriminant;
expectKeyword(_ENV,"switch");
expect(_ENV,"(");
discriminant = parseExpression(_ENV);
expect(_ENV,")");
expect(_ENV,"{");
cases = _arr({},0);
if _bool(match(_ENV,"}")) then
lex(_ENV);
do return node:finishSwitchStatement(discriminant,cases); end
end

oldInSwitch = state.inSwitch;
state.inSwitch = true;
defaultFound = false;
while (_lt(startIndex,length)) do
if _bool(match(_ENV,"}")) then
do break end;
end

clause = parseSwitchCase(_ENV);
if (clause.test == null) then
if _bool(defaultFound) then
throwError(_ENV,Messages.MultipleDefaultsInSwitch);
end

defaultFound = true;
end

cases:push(clause);
::_continue::
end

state.inSwitch = oldInSwitch;
expect(_ENV,"}");
do return node:finishSwitchStatement(discriminant,cases); end
end);
parseThrowStatement = (function (this, node)
local argument;
expectKeyword(_ENV,"throw");
if _bool(hasLineTerminator) then
throwError(_ENV,Messages.NewlineAfterThrow);
end

argument = parseExpression(_ENV);
consumeSemicolon(_ENV);
do return node:finishThrowStatement(argument); end
end);
parseCatchClause = (function (this)
local node,body,i,key,paramMap,params,param;
params = _arr({},0);
paramMap = _obj({});
node = _new(Node);
expectKeyword(_ENV,"catch");
expect(_ENV,"(");
if _bool(match(_ENV,")")) then
throwUnexpectedToken(_ENV,lookahead);
end

param = parsePattern(_ENV,params);
i = 0;
while (i<params.length) do
key = (_addStr1("$",params[i].value));
if _bool(Object.prototype.hasOwnProperty:call(paramMap,key)) then
tolerateError(_ENV,Messages.DuplicateBinding,params[i].value);
end

paramMap[key] = true;
i = i + 1;
end

if _bool(((function() if _bool(strict) then return isRestrictedWord(_ENV,param.name); else return strict; end end)())) then
tolerateError(_ENV,Messages.StrictCatchVariable);
end

expect(_ENV,")");
body = parseBlock(_ENV);
do return node:finishCatchClause(param,body); end
end);
parseTryStatement = (function (this, node)
local finalizer,handler,block;
handler = null;
finalizer = null;
expectKeyword(_ENV,"try");
block = parseBlock(_ENV);
if _bool(matchKeyword(_ENV,"catch")) then
handler = parseCatchClause(_ENV);
end

if _bool(matchKeyword(_ENV,"finally")) then
lex(_ENV);
finalizer = parseBlock(_ENV);
end

if ((function() local _lev=not _bool(handler); if _bool(_lev) then return not _bool(finalizer); else return _lev; end end)()) then
throwError(_ENV,Messages.NoCatchOrFinally);
end

do return node:finishTryStatement(block,handler,finalizer); end
end);
parseDebuggerStatement = (function (this, node)
expectKeyword(_ENV,"debugger");
consumeSemicolon(_ENV);
do return node:finishDebuggerStatement(); end
end);
parseStatement = (function (this)
local node,key,labeledBody,expr,type;
type = lookahead.type;
if (type == Token.EOF) then
throwUnexpectedToken(_ENV,lookahead);
end

if ((function() local _lev=(type == Token.Punctuator); if _bool(_lev) then return (lookahead.value == "{"); else return _lev; end end)()) then
do return parseBlock(_ENV); end
end

isAssignmentTarget = (function() isBindingElement = true; return isBindingElement end)();
node = _new(Node);
if (type == Token.Punctuator) then
repeat
local _into = false;
local _cases = {[";"] = true,["("] = true};
local _v = lookahead.value;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == ";") then
do return parseEmptyStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "(") then
do return parseExpressionStatement(_ENV,node); end
_into = true;
end
::_default::
if _into then
do break end;
_into = true;
end
until true
elseif (type == Token.Keyword) then
repeat
local _into = false;
local _cases = {["break"] = true,["continue"] = true,["debugger"] = true,["do"] = true,["for"] = true,["function"] = true,["if"] = true,["return"] = true,["switch"] = true,["throw"] = true,["try"] = true,["var"] = true,["while"] = true,["with"] = true};
local _v = lookahead.value;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "break") then
do return parseBreakStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "continue") then
do return parseContinueStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "debugger") then
do return parseDebuggerStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "do") then
do return parseDoWhileStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "for") then
do return parseForStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "function") then
do return parseFunctionDeclaration(_ENV,node); end
_into = true;
end
if _into or (_v == "if") then
do return parseIfStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "return") then
do return parseReturnStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "switch") then
do return parseSwitchStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "throw") then
do return parseThrowStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "try") then
do return parseTryStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "var") then
do return parseVariableStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "while") then
do return parseWhileStatement(_ENV,node); end
_into = true;
end
if _into or (_v == "with") then
do return parseWithStatement(_ENV,node); end
_into = true;
end
::_default::
if _into then
do break end;
_into = true;
end
until true
end

expr = parseExpression(_ENV);
if _bool(((function() local _lev=(expr.type == Syntax.Identifier); if _bool(_lev) then return match(_ENV,":"); else return _lev; end end)())) then
lex(_ENV);
key = (_addStr1("$",expr.name));
if _bool(Object.prototype.hasOwnProperty:call(state.labelSet,key)) then
throwError(_ENV,Messages.Redeclaration,"Label",expr.name);
end

state.labelSet[key] = true;
labeledBody = parseStatement(_ENV);
(function () local _r = false; local _g, _s = state.labelSet["_g" .. key], state.labelSet["_s" .. key]; state.labelSet["_g" .. key], state.labelSet["_s" .. key] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = state.labelSet[key]; state.labelSet[key] = nil; return _r or _v ~= nil; end)();
do return node:finishLabeledStatement(expr,labeledBody); end
end

consumeSemicolon(_ENV);
do return node:finishExpressionStatement(expr); end
end);
parseFunctionSourceElements = (function (this)
local node,oldInFunctionBody,oldInSwitch,oldInIteration,oldLabelSet,firstRestricted,directive,token,body,statement;
body = _arr({},0);
node = _new(Node);
expect(_ENV,"{");
while (_lt(startIndex,length)) do
if (lookahead.type ~= Token.StringLiteral) then
do break end;
end

token = lookahead;
statement = parseStatementListItem(_ENV);
body:push(statement);
if (statement.expression.type ~= Syntax.Literal) then
do break end;
end

directive = source:slice((_addNum2(token.start,1)),(token["end"] - 1));
if (directive == "use strict") then
strict = true;
if _bool(firstRestricted) then
tolerateUnexpectedToken(_ENV,firstRestricted,Messages.StrictOctalLiteral);
end

else
if _bool(((function() local _lev=not _bool(firstRestricted); if _bool(_lev) then return token.octal; else return _lev; end end)())) then
firstRestricted = token;
end

end

::_continue::
end

oldLabelSet = state.labelSet;
oldInIteration = state.inIteration;
oldInSwitch = state.inSwitch;
oldInFunctionBody = state.inFunctionBody;
state.labelSet = _obj({});
state.inIteration = false;
state.inSwitch = false;
state.inFunctionBody = true;
while (_lt(startIndex,length)) do
if _bool(match(_ENV,"}")) then
do break end;
end

body:push(parseStatementListItem(_ENV));
::_continue::
end

expect(_ENV,"}");
state.labelSet = oldLabelSet;
state.inIteration = oldInIteration;
state.inSwitch = oldInSwitch;
state.inFunctionBody = oldInFunctionBody;
do return node:finishBlockStatement(body); end
end);
validateParam = (function (this, options, param, name)
local key;
key = (_addStr1("$",name));
if _bool(strict) then
if _bool(isRestrictedWord(_ENV,name)) then
options.stricted = param;
options.message = Messages.StrictParamName;
end

if _bool(Object.prototype.hasOwnProperty:call(options.paramSet,key)) then
options.stricted = param;
options.message = Messages.StrictParamDupe;
end

elseif not _bool(options.firstRestricted) then
if _bool(isRestrictedWord(_ENV,name)) then
options.firstRestricted = param;
options.message = Messages.StrictParamName;
elseif _bool(isStrictModeReservedWord(_ENV,name)) then
options.firstRestricted = param;
options.message = Messages.StrictReservedWord;
elseif _bool(Object.prototype.hasOwnProperty:call(options.paramSet,key)) then
options.stricted = param;
options.message = Messages.StrictParamDupe;
end

end

options.paramSet[key] = true;
end);
parseParam = (function (this, options)
local def,i,params,param,token;
params = _arr({},0);
token = lookahead;
if (token.value == "...") then
param = parseRestElement(_ENV,params);
validateParam(_ENV,options,param.argument,param.argument.name);
options.params:push(param);
options.defaults:push(null);
do return false; end
end

param = parsePatternWithDefault(_ENV,params);
i = 0;
while (i<params.length) do
validateParam(_ENV,options,params[i],params[i].value);
i = i + 1;
end

if (param.type == Syntax.AssignmentPattern) then
def = param.right;
param = param.left;
options.defaultCount = _inc(options.defaultCount);
end

options.params:push(param);
options.defaults:push(def);
do return not _bool(match(_ENV,")")); end
end);
parseParams = (function (this, firstRestricted)
local options;
options = _obj({
["params"] = _arr({},0),
["defaultCount"] = 0,
["defaults"] = _arr({},0),
["firstRestricted"] = firstRestricted
});
expect(_ENV,"(");
if not _bool(match(_ENV,")")) then
options.paramSet = _obj({});
while (_lt(startIndex,length)) do
if not _bool(parseParam(_ENV,options)) then
do break end;
end

expect(_ENV,",");
::_continue::
end

end

expect(_ENV,")");
if (options.defaultCount == 0) then
options.defaults = _arr({},0);
end

do return _obj({
["params"] = options.params,
["defaults"] = options.defaults,
["stricted"] = options.stricted,
["firstRestricted"] = options.firstRestricted,
["message"] = options.message
}); end
end);
parseFunctionDeclaration = (function (this, node, identifierIsOptional)
local previousAllowYield,isGenerator,previousStrict,message,firstRestricted,tmp,stricted,token,body,defaults,params,id;
id = null;
params = _arr({},0);
defaults = _arr({},0);
previousAllowYield = state.allowYield;
expectKeyword(_ENV,"function");
isGenerator = match(_ENV,"*");
if _bool(isGenerator) then
lex(_ENV);
end

if ((function() local _lev=not _bool(identifierIsOptional); return _bool(_lev) and _lev or not _bool(match(_ENV,"(")) end)()) then
token = lookahead;
id = parseVariableIdentifier(_ENV);
if _bool(strict) then
if _bool(isRestrictedWord(_ENV,token.value)) then
tolerateUnexpectedToken(_ENV,token,Messages.StrictFunctionName);
end

else
if _bool(isRestrictedWord(_ENV,token.value)) then
firstRestricted = token;
message = Messages.StrictFunctionName;
elseif _bool(isStrictModeReservedWord(_ENV,token.value)) then
firstRestricted = token;
message = Messages.StrictReservedWord;
end

end

end

state.allowYield = not _bool(isGenerator);
tmp = parseParams(_ENV,firstRestricted);
params = tmp.params;
defaults = tmp.defaults;
stricted = tmp.stricted;
firstRestricted = tmp.firstRestricted;
if _bool(tmp.message) then
message = tmp.message;
end

previousStrict = strict;
body = parseFunctionSourceElements(_ENV);
if _bool(((function() if _bool(strict) then return firstRestricted; else return strict; end end)())) then
throwUnexpectedToken(_ENV,firstRestricted,message);
end

if _bool(((function() if _bool(strict) then return stricted; else return strict; end end)())) then
tolerateUnexpectedToken(_ENV,stricted,message);
end

strict = previousStrict;
state.allowYield = previousAllowYield;
do return node:finishFunctionDeclaration(id,params,defaults,body,isGenerator); end
end);
parseFunctionExpression = (function (this)
local previousAllowYield,isGenerator,node,previousStrict,body,defaults,params,tmp,message,firstRestricted,stricted,id,token;
id = null;
params = _arr({},0);
defaults = _arr({},0);
node = _new(Node);
previousAllowYield = state.allowYield;
expectKeyword(_ENV,"function");
isGenerator = match(_ENV,"*");
if _bool(isGenerator) then
lex(_ENV);
end

state.allowYield = not _bool(isGenerator);
if not _bool(match(_ENV,"(")) then
token = lookahead;
id = (function() if _bool(((function() local _lev=((function() local _lev=not _bool(strict); if _bool(_lev) then return not _bool(isGenerator); else return _lev; end end)()); if _bool(_lev) then return matchKeyword(_ENV,"yield"); else return _lev; end end)())) then return parseNonComputedProperty(_ENV); else return parseVariableIdentifier(_ENV); end end)();
if _bool(strict) then
if _bool(isRestrictedWord(_ENV,token.value)) then
tolerateUnexpectedToken(_ENV,token,Messages.StrictFunctionName);
end

else
if _bool(isRestrictedWord(_ENV,token.value)) then
firstRestricted = token;
message = Messages.StrictFunctionName;
elseif _bool(isStrictModeReservedWord(_ENV,token.value)) then
firstRestricted = token;
message = Messages.StrictReservedWord;
end

end

end

tmp = parseParams(_ENV,firstRestricted);
params = tmp.params;
defaults = tmp.defaults;
stricted = tmp.stricted;
firstRestricted = tmp.firstRestricted;
if _bool(tmp.message) then
message = tmp.message;
end

previousStrict = strict;
body = parseFunctionSourceElements(_ENV);
if _bool(((function() if _bool(strict) then return firstRestricted; else return strict; end end)())) then
throwUnexpectedToken(_ENV,firstRestricted,message);
end

if _bool(((function() if _bool(strict) then return stricted; else return strict; end end)())) then
tolerateUnexpectedToken(_ENV,stricted,message);
end

strict = previousStrict;
state.allowYield = previousAllowYield;
do return node:finishFunctionExpression(id,params,defaults,body,isGenerator); end
end);
parseClassBody = (function (this)
local key,computed,method,body,hasConstructor,isStatic,token,classBody;
hasConstructor = false;
classBody = _new(Node);
expect(_ENV,"{");
body = _arr({},0);
while not _bool(match(_ENV,"}")) do
if _bool(match(_ENV,";")) then
lex(_ENV);
else
method = _new(Node);
token = lookahead;
isStatic = false;
computed = match(_ENV,"[");
if _bool(match(_ENV,"*")) then
lex(_ENV);
else
key = parseObjectPropertyKey(_ENV);
if _bool(((function() local _lev=(key.name == "static"); if _bool(_lev) then return ((function() local _lev=lookaheadPropertyName(_ENV); return _bool(_lev) and _lev or match(_ENV,"*") end)()); else return _lev; end end)())) then
token = lookahead;
isStatic = true;
computed = match(_ENV,"[");
if _bool(match(_ENV,"*")) then
lex(_ENV);
else
key = parseObjectPropertyKey(_ENV);
end

end

end

method = tryParseMethodDefinition(_ENV,token,key,computed,method);
if _bool(method) then
method["static"] = isStatic;
if (method.kind == "init") then
method.kind = "method";
end

if not _bool(isStatic) then
if ((function() local _lev=not _bool(method.computed); if _bool(_lev) then return (((function() local _lev=method.key.name; return _bool(_lev) and _lev or method.key.value:toString() end)()) == "constructor"); else return _lev; end end)()) then
if _bool(((function() local _lev=((function() local _lev=(method.kind ~= "method"); return _bool(_lev) and _lev or not _bool(method.method) end)()); return _bool(_lev) and _lev or method.value.generator end)())) then
throwUnexpectedToken(_ENV,token,Messages.ConstructorSpecialMethod);
end

if _bool(hasConstructor) then
throwUnexpectedToken(_ENV,token,Messages.DuplicateConstructor);
else
hasConstructor = true;
end

method.kind = "constructor";
end

else
if ((function() local _lev=not _bool(method.computed); if _bool(_lev) then return (((function() local _lev=method.key.name; return _bool(_lev) and _lev or method.key.value:toString() end)()) == "prototype"); else return _lev; end end)()) then
throwUnexpectedToken(_ENV,token,Messages.StaticPrototype);
end

end

method.type = Syntax.MethodDefinition;
(function () local _r = false; local _g, _s = method["_g" .. "method"], method["_s" .. "method"]; method["_g" .. "method"], method["_s" .. "method"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = method.method; method.method = nil; return _r or _v ~= nil; end)();
(function () local _r = false; local _g, _s = method["_g" .. "shorthand"], method["_s" .. "shorthand"]; method["_g" .. "shorthand"], method["_s" .. "shorthand"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = method.shorthand; method.shorthand = nil; return _r or _v ~= nil; end)();
body:push(method);
else
throwUnexpectedToken(_ENV,lookahead);
end

end

::_continue::
end

lex(_ENV);
do return classBody:finishClassBody(body); end
end);
parseClassDeclaration = (function (this, identifierIsOptional)
local previousStrict,classBody,classNode,superClass,id;
id = null;
superClass = null;
classNode = _new(Node);
previousStrict = strict;
strict = true;
expectKeyword(_ENV,"class");
if ((function() local _lev=not _bool(identifierIsOptional); return _bool(_lev) and _lev or (lookahead.type == Token.Identifier) end)()) then
id = parseVariableIdentifier(_ENV);
end

if _bool(matchKeyword(_ENV,"extends")) then
lex(_ENV);
superClass = isolateCoverGrammar(_ENV,parseLeftHandSideExpressionAllowCall);
end

classBody = parseClassBody(_ENV);
strict = previousStrict;
do return classNode:finishClassDeclaration(id,superClass,classBody); end
end);
parseClassExpression = (function (this)
local previousStrict,classBody,classNode,superClass,id;
id = null;
superClass = null;
classNode = _new(Node);
previousStrict = strict;
strict = true;
expectKeyword(_ENV,"class");
if (lookahead.type == Token.Identifier) then
id = parseVariableIdentifier(_ENV);
end

if _bool(matchKeyword(_ENV,"extends")) then
lex(_ENV);
superClass = isolateCoverGrammar(_ENV,parseLeftHandSideExpressionAllowCall);
end

classBody = parseClassBody(_ENV);
strict = previousStrict;
do return classNode:finishClassExpression(id,superClass,classBody); end
end);
parseModuleSpecifier = (function (this)
local node;
node = _new(Node);
if (lookahead.type ~= Token.StringLiteral) then
throwError(_ENV,Messages.InvalidModuleSpecifier);
end

do return node:finishLiteral(lex(_ENV)); end
end);
parseExportSpecifier = (function (this)
local def,node,_g_local,exported;
node = _new(Node);
if _bool(matchKeyword(_ENV,"default")) then
def = _new(Node);
lex(_ENV);
_g_local = def:finishIdentifier("default");
else
_g_local = parseVariableIdentifier(_ENV);
end

if _bool(matchContextualKeyword(_ENV,"as")) then
lex(_ENV);
exported = parseNonComputedProperty(_ENV);
end

do return node:finishExportSpecifier(_g_local,exported); end
end);
parseExportNamedDeclaration = (function (this, node)
local specifiers,src,isExportFromIdentifier,declaration;
declaration = null;
src = null;
specifiers = _arr({},0);
if (lookahead.type == Token.Keyword) then
repeat
local _into = false;
local _cases = {["let"] = true,["const"] = true,["var"] = true,["class"] = true,["function"] = true};
local _v = lookahead.value;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "let") then

_into = true;
end
if _into or (_v == "const") then
declaration = parseLexicalDeclaration(_ENV,_obj({
["inFor"] = false
}));
do return node:finishExportNamedDeclaration(declaration,specifiers,null); end
_into = true;
end
if _into or (_v == "var") then

_into = true;
end
if _into or (_v == "class") then

_into = true;
end
if _into or (_v == "function") then
declaration = parseStatementListItem(_ENV);
do return node:finishExportNamedDeclaration(declaration,specifiers,null); end
_into = true;
end
::_default::
until true
end

expect(_ENV,"{");
while not _bool(match(_ENV,"}")) do
isExportFromIdentifier = (_bool(isExportFromIdentifier) and isExportFromIdentifier or matchKeyword(_ENV,"default"));
specifiers:push(parseExportSpecifier(_ENV));
if not _bool(match(_ENV,"}")) then
expect(_ENV,",");
if _bool(match(_ENV,"}")) then
do break end;
end

end

::_continue::
end

expect(_ENV,"}");
if _bool(matchContextualKeyword(_ENV,"from")) then
lex(_ENV);
src = parseModuleSpecifier(_ENV);
consumeSemicolon(_ENV);
elseif _bool(isExportFromIdentifier) then
throwError(_ENV,(function() if _bool(lookahead.value) then return Messages.UnexpectedToken; else return Messages.MissingFromClause; end end)(),lookahead.value);
else
consumeSemicolon(_ENV);
end

do return node:finishExportNamedDeclaration(declaration,specifiers,src); end
end);
parseExportDefaultDeclaration = (function (this, node)
local expression,declaration;
declaration = null;
expression = null;
expectKeyword(_ENV,"default");
if _bool(matchKeyword(_ENV,"function")) then
declaration = parseFunctionDeclaration(_ENV,_new(Node),true);
do return node:finishExportDefaultDeclaration(declaration); end
end

if _bool(matchKeyword(_ENV,"class")) then
declaration = parseClassDeclaration(_ENV,true);
do return node:finishExportDefaultDeclaration(declaration); end
end

if _bool(matchContextualKeyword(_ENV,"from")) then
throwError(_ENV,Messages.UnexpectedToken,lookahead.value);
end

if _bool(match(_ENV,"{")) then
expression = parseObjectInitializer(_ENV);
elseif _bool(match(_ENV,"[")) then
expression = parseArrayInitializer(_ENV);
else
expression = parseAssignmentExpression(_ENV);
end

consumeSemicolon(_ENV);
do return node:finishExportDefaultDeclaration(expression); end
end);
parseExportAllDeclaration = (function (this, node)
local src;
expect(_ENV,"*");
if not _bool(matchContextualKeyword(_ENV,"from")) then
throwError(_ENV,(function() if _bool(lookahead.value) then return Messages.UnexpectedToken; else return Messages.MissingFromClause; end end)(),lookahead.value);
end

lex(_ENV);
src = parseModuleSpecifier(_ENV);
consumeSemicolon(_ENV);
do return node:finishExportAllDeclaration(src); end
end);
parseExportDeclaration = (function (this)
local node;
node = _new(Node);
if _bool(state.inFunctionBody) then
throwError(_ENV,Messages.IllegalExportDeclaration);
end

expectKeyword(_ENV,"export");
if _bool(matchKeyword(_ENV,"default")) then
do return parseExportDefaultDeclaration(_ENV,node); end
end

if _bool(match(_ENV,"*")) then
do return parseExportAllDeclaration(_ENV,node); end
end

do return parseExportNamedDeclaration(_ENV,node); end
end);
parseImportSpecifier = (function (this)
local node,imported,_g_local;
node = _new(Node);
imported = parseNonComputedProperty(_ENV);
if _bool(matchContextualKeyword(_ENV,"as")) then
lex(_ENV);
_g_local = parseVariableIdentifier(_ENV);
end

do return node:finishImportSpecifier(_g_local,imported); end
end);
parseNamedImports = (function (this)
local specifiers;
specifiers = _arr({},0);
expect(_ENV,"{");
while not _bool(match(_ENV,"}")) do
specifiers:push(parseImportSpecifier(_ENV));
if not _bool(match(_ENV,"}")) then
expect(_ENV,",");
if _bool(match(_ENV,"}")) then
do break end;
end

end

::_continue::
end

expect(_ENV,"}");
do return specifiers; end
end);
parseImportDefaultSpecifier = (function (this)
local node,_g_local;
node = _new(Node);
_g_local = parseNonComputedProperty(_ENV);
do return node:finishImportDefaultSpecifier(_g_local); end
end);
parseImportNamespaceSpecifier = (function (this)
local node,_g_local;
node = _new(Node);
expect(_ENV,"*");
if not _bool(matchContextualKeyword(_ENV,"as")) then
throwError(_ENV,Messages.NoAsAfterImportNamespace);
end

lex(_ENV);
_g_local = parseNonComputedProperty(_ENV);
do return node:finishImportNamespaceSpecifier(_g_local); end
end);
parseImportDeclaration = (function (this)
local node,src,specifiers;
specifiers = _arr({},0);
node = _new(Node);
if _bool(state.inFunctionBody) then
throwError(_ENV,Messages.IllegalImportDeclaration);
end

expectKeyword(_ENV,"import");
if (lookahead.type == Token.StringLiteral) then
src = parseModuleSpecifier(_ENV);
else
if _bool(match(_ENV,"{")) then
specifiers = specifiers:concat(parseNamedImports(_ENV));
elseif _bool(match(_ENV,"*")) then
specifiers:push(parseImportNamespaceSpecifier(_ENV));
elseif _bool(((function() local _lev=isIdentifierName(_ENV,lookahead); if _bool(_lev) then return not _bool(matchKeyword(_ENV,"default")); else return _lev; end end)())) then
specifiers:push(parseImportDefaultSpecifier(_ENV));
if _bool(match(_ENV,",")) then
lex(_ENV);
if _bool(match(_ENV,"*")) then
specifiers:push(parseImportNamespaceSpecifier(_ENV));
elseif _bool(match(_ENV,"{")) then
specifiers = specifiers:concat(parseNamedImports(_ENV));
else
throwUnexpectedToken(_ENV,lookahead);
end

end

else
throwUnexpectedToken(_ENV,lex(_ENV));
end

if not _bool(matchContextualKeyword(_ENV,"from")) then
throwError(_ENV,(function() if _bool(lookahead.value) then return Messages.UnexpectedToken; else return Messages.MissingFromClause; end end)(),lookahead.value);
end

lex(_ENV);
src = parseModuleSpecifier(_ENV);
end

consumeSemicolon(_ENV);
do return node:finishImportDeclaration(specifiers,src); end
end);
parseScriptBody = (function (this)
local firstRestricted,directive,token,body,statement;
body = _arr({},0);
while (_lt(startIndex,length)) do
token = lookahead;
if (token.type ~= Token.StringLiteral) then
do break end;
end

statement = parseStatementListItem(_ENV);
body:push(statement);
if (statement.expression.type ~= Syntax.Literal) then
do break end;
end

directive = source:slice((_addNum2(token.start,1)),(token["end"] - 1));
if (directive == "use strict") then
strict = true;
if _bool(firstRestricted) then
tolerateUnexpectedToken(_ENV,firstRestricted,Messages.StrictOctalLiteral);
end

else
if _bool(((function() local _lev=not _bool(firstRestricted); if _bool(_lev) then return token.octal; else return _lev; end end)())) then
firstRestricted = token;
end

end

::_continue::
end

while (_lt(startIndex,length)) do
statement = parseStatementListItem(_ENV);
if (_type(statement) == "undefined") then
do break end;
end

body:push(statement);
::_continue::
end

do return body; end
end);
parseProgram = (function (this)
local node,body;
peek(_ENV);
node = _new(Node);
body = parseScriptBody(_ENV);
do return node:finishProgram(body,state.sourceType); end
end);
filterTokenLocation = (function (this)
local tokens,token,entry,i;
tokens = _arr({},0);
i = 0;
while (i<extra.tokens.length) do
entry = extra.tokens[i];
token = _obj({
["type"] = entry.type,
["value"] = entry.value
});
if _bool(entry.regex) then
token.regex = _obj({
["pattern"] = entry.regex.pattern,
["flags"] = entry.regex.flags
});
end

if _bool(extra.range) then
token.range = entry.range;
end

if _bool(extra.loc) then
token.loc = entry.loc;
end

tokens:push(token);
i = i + 1;
end

extra.tokens = tokens;
end);
tokenize = (function (this, code, options, delegate)
local tokens,toString;
toString = String;
if ((function() local _lev=(_type(code) ~= "string"); if _bool(_lev) then return not (_instanceof(code,String)); else return _lev; end end)()) then
code = toString(_ENV,code);
end

source = code;
index = 0;
lineNumber = (function() if (_gt(source.length,0)) then return 1; else return 0; end end)();
lineStart = 0;
startIndex = index;
startLineNumber = lineNumber;
startLineStart = lineStart;
length = source.length;
lookahead = null;
state = _obj({
["allowIn"] = true,
["allowYield"] = true,
["labelSet"] = _obj({}),
["inFunctionBody"] = false,
["inIteration"] = false,
["inSwitch"] = false,
["lastCommentStart"] = -1,
["curlyStack"] = _arr({},0)
});
extra = _obj({});
options = (_bool(options) and options or _obj({}));
options.tokens = true;
extra.tokens = _arr({},0);
extra.tokenValues = _arr({},0);
extra.tokenize = true;
extra.delegate = delegate;
extra.openParenToken = -1;
extra.openCurlyToken = -1;
extra.range = ((function() local _lev=(_type(options.range) == "boolean"); if _bool(_lev) then return options.range; else return _lev; end end)());
extra.loc = ((function() local _lev=(_type(options.loc) == "boolean"); if _bool(_lev) then return options.loc; else return _lev; end end)());
if _bool(((function() local _lev=(_type(options.comment) == "boolean"); if _bool(_lev) then return options.comment; else return _lev; end end)())) then
extra.comments = _arr({},0);
end

if _bool(((function() local _lev=(_type(options.tolerant) == "boolean"); if _bool(_lev) then return options.tolerant; else return _lev; end end)())) then
extra.errors = _arr({},0);
end

local _status, _return = _pcall(function()
peek(_ENV);
if (lookahead.type == Token.EOF) then
do return extra.tokens; end
end

lex(_ENV);
while (lookahead.type ~= Token.EOF) do
local _status, _return = _pcall(function()
lex(_ENV);
end);
if not _status then
local _cstatus, _creturn = _pcall(function()
local lexError = _return;
if _bool(extra.errors) then
recordError(_ENV,lexError);
do return _break; end
else
_throw(lexError,0)
end

end);
if _cstatus then
if _creturn == _break then break; end
else _throw(_creturn,0); end
end

::_continue::
end

tokens = extra.tokens;
if (_type(extra.errors) ~= "undefined") then
tokens.errors = extra.errors;
end

end);
if _status then
extra = _obj({});
if _return ~= nil then return _return; end
else
local _cstatus, _creturn = _pcall(function()
local e = _return;
_throw(e,0)
end);
extra = _obj({});
if _cstatus then
else _throw(_creturn,0); end
end

do return tokens; end
end);
parse = (function (this, code, options)
local toString,program;
toString = String;
if ((function() local _lev=(_type(code) ~= "string"); if _bool(_lev) then return not (_instanceof(code,String)); else return _lev; end end)()) then
code = toString(_ENV,code);
end

source = code;
index = 0;
lineNumber = (function() if (_gt(source.length,0)) then return 1; else return 0; end end)();
lineStart = 0;
startIndex = index;
startLineNumber = lineNumber;
startLineStart = lineStart;
length = source.length;
lookahead = null;
state = _obj({
["allowIn"] = true,
["allowYield"] = true,
["labelSet"] = _obj({}),
["inFunctionBody"] = false,
["inIteration"] = false,
["inSwitch"] = false,
["lastCommentStart"] = -1,
["curlyStack"] = _arr({},0),
["sourceType"] = "script"
});
strict = false;
extra = _obj({});
if (_type(options) ~= "undefined") then
extra.range = ((function() local _lev=(_type(options.range) == "boolean"); if _bool(_lev) then return options.range; else return _lev; end end)());
extra.loc = ((function() local _lev=(_type(options.loc) == "boolean"); if _bool(_lev) then return options.loc; else return _lev; end end)());
extra.attachComment = ((function() local _lev=(_type(options.attachComment) == "boolean"); if _bool(_lev) then return options.attachComment; else return _lev; end end)());
if _bool(((function() local _lev=((function() local _lev=extra.loc; if _bool(_lev) then return (options.source ~= null); else return _lev; end end)()); if _bool(_lev) then return (options.source ~= undefined); else return _lev; end end)())) then
extra.source = toString(_ENV,options.source);
end

if _bool(((function() local _lev=(_type(options.tokens) == "boolean"); if _bool(_lev) then return options.tokens; else return _lev; end end)())) then
extra.tokens = _arr({},0);
end

if _bool(((function() local _lev=(_type(options.comment) == "boolean"); if _bool(_lev) then return options.comment; else return _lev; end end)())) then
extra.comments = _arr({},0);
end

if _bool(((function() local _lev=(_type(options.tolerant) == "boolean"); if _bool(_lev) then return options.tolerant; else return _lev; end end)())) then
extra.errors = _arr({},0);
end

if _bool(extra.attachComment) then
extra.range = true;
extra.comments = _arr({},0);
extra.bottomRightStack = _arr({},0);
extra.trailingComments = _arr({},0);
extra.leadingComments = _arr({},0);
end

if (options.sourceType == "module") then
state.sourceType = options.sourceType;
strict = true;
end

end

local _status, _return = _pcall(function()
program = parseProgram(_ENV);
if (_type(extra.comments) ~= "undefined") then
program.comments = extra.comments;
end

if (_type(extra.tokens) ~= "undefined") then
filterTokenLocation(_ENV);
program.tokens = extra.tokens;
end

if (_type(extra.errors) ~= "undefined") then
program.errors = extra.errors;
end

end);
if _status then
extra = _obj({});
else
local _cstatus, _creturn = _pcall(function()
local e = _return;
_throw(e,0)
end);
extra = _obj({});
if _cstatus then
else _throw(_creturn,0); end
end

do return program; end
end);Token = _obj({
["BooleanLiteral"] = 1,
["EOF"] = 2,
["Identifier"] = 3,
["Keyword"] = 4,
["NullLiteral"] = 5,
["NumericLiteral"] = 6,
["Punctuator"] = 7,
["StringLiteral"] = 8,
["RegularExpression"] = 9,
["Template"] = 10
});
TokenName = _obj({});
TokenName[Token.BooleanLiteral] = "Boolean";
TokenName[Token.EOF] = "<end>";
TokenName[Token.Identifier] = "Identifier";
TokenName[Token.Keyword] = "Keyword";
TokenName[Token.NullLiteral] = "Null";
TokenName[Token.NumericLiteral] = "Numeric";
TokenName[Token.Punctuator] = "Punctuator";
TokenName[Token.StringLiteral] = "String";
TokenName[Token.RegularExpression] = "RegularExpression";
TokenName[Token.Template] = "Template";
FnExprTokens = _arr({[0]="(","{","[","in","typeof","instanceof","new","return","case","delete","throw","void","=","+=","-=","*=","/=","%=","<<=",">>=",">>>=","&=","|=","^=",",","+","-","*","/","%","++","--","<<",">>",">>>","&","|","^","!","~","&&","||","?",":","===","==",">=","<=","<",">","!=","!=="},52);
Syntax = _obj({
["AssignmentExpression"] = "AssignmentExpression",
["AssignmentPattern"] = "AssignmentPattern",
["ArrayExpression"] = "ArrayExpression",
["ArrayPattern"] = "ArrayPattern",
["ArrowFunctionExpression"] = "ArrowFunctionExpression",
["BlockStatement"] = "BlockStatement",
["BinaryExpression"] = "BinaryExpression",
["BreakStatement"] = "BreakStatement",
["CallExpression"] = "CallExpression",
["CatchClause"] = "CatchClause",
["ClassBody"] = "ClassBody",
["ClassDeclaration"] = "ClassDeclaration",
["ClassExpression"] = "ClassExpression",
["ConditionalExpression"] = "ConditionalExpression",
["ContinueStatement"] = "ContinueStatement",
["DoWhileStatement"] = "DoWhileStatement",
["DebuggerStatement"] = "DebuggerStatement",
["EmptyStatement"] = "EmptyStatement",
["ExportAllDeclaration"] = "ExportAllDeclaration",
["ExportDefaultDeclaration"] = "ExportDefaultDeclaration",
["ExportNamedDeclaration"] = "ExportNamedDeclaration",
["ExportSpecifier"] = "ExportSpecifier",
["ExpressionStatement"] = "ExpressionStatement",
["ForStatement"] = "ForStatement",
["ForOfStatement"] = "ForOfStatement",
["ForInStatement"] = "ForInStatement",
["FunctionDeclaration"] = "FunctionDeclaration",
["FunctionExpression"] = "FunctionExpression",
["Identifier"] = "Identifier",
["IfStatement"] = "IfStatement",
["ImportDeclaration"] = "ImportDeclaration",
["ImportDefaultSpecifier"] = "ImportDefaultSpecifier",
["ImportNamespaceSpecifier"] = "ImportNamespaceSpecifier",
["ImportSpecifier"] = "ImportSpecifier",
["Literal"] = "Literal",
["LabeledStatement"] = "LabeledStatement",
["LogicalExpression"] = "LogicalExpression",
["MemberExpression"] = "MemberExpression",
["MetaProperty"] = "MetaProperty",
["MethodDefinition"] = "MethodDefinition",
["NewExpression"] = "NewExpression",
["ObjectExpression"] = "ObjectExpression",
["ObjectPattern"] = "ObjectPattern",
["Program"] = "Program",
["Property"] = "Property",
["RestElement"] = "RestElement",
["ReturnStatement"] = "ReturnStatement",
["SequenceExpression"] = "SequenceExpression",
["SpreadElement"] = "SpreadElement",
["Super"] = "Super",
["SwitchCase"] = "SwitchCase",
["SwitchStatement"] = "SwitchStatement",
["TaggedTemplateExpression"] = "TaggedTemplateExpression",
["TemplateElement"] = "TemplateElement",
["TemplateLiteral"] = "TemplateLiteral",
["ThisExpression"] = "ThisExpression",
["ThrowStatement"] = "ThrowStatement",
["TryStatement"] = "TryStatement",
["UnaryExpression"] = "UnaryExpression",
["UpdateExpression"] = "UpdateExpression",
["VariableDeclaration"] = "VariableDeclaration",
["VariableDeclarator"] = "VariableDeclarator",
["WhileStatement"] = "WhileStatement",
["WithStatement"] = "WithStatement",
["YieldExpression"] = "YieldExpression"
});
PlaceHolders = _obj({
["ArrowParameterPlaceHolder"] = "ArrowParameterPlaceHolder"
});
Messages = _obj({
["UnexpectedToken"] = "Unexpected token %0",
["UnexpectedNumber"] = "Unexpected number",
["UnexpectedString"] = "Unexpected string",
["UnexpectedIdentifier"] = "Unexpected identifier",
["UnexpectedReserved"] = "Unexpected reserved word",
["UnexpectedTemplate"] = "Unexpected quasi %0",
["UnexpectedEOS"] = "Unexpected end of input",
["NewlineAfterThrow"] = "Illegal newline after throw",
["InvalidRegExp"] = "Invalid regular expression",
["UnterminatedRegExp"] = "Invalid regular expression: missing /",
["InvalidLHSInAssignment"] = "Invalid left-hand side in assignment",
["InvalidLHSInForIn"] = "Invalid left-hand side in for-in",
["InvalidLHSInForLoop"] = "Invalid left-hand side in for-loop",
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
["StrictLHSAssignment"] = "Assignment to eval or arguments is not allowed in strict mode",
["StrictLHSPostfix"] = "Postfix increment/decrement may not have eval or arguments operand in strict mode",
["StrictLHSPrefix"] = "Prefix increment/decrement may not have eval or arguments operand in strict mode",
["StrictReservedWord"] = "Use of future reserved word in strict mode",
["TemplateOctalLiteral"] = "Octal literals are not allowed in template strings.",
["ParameterAfterRestParameter"] = "Rest parameter must be last formal parameter",
["DefaultRestParameter"] = "Unexpected token =",
["ObjectPatternAsRestParameter"] = "Unexpected token {",
["DuplicateProtoProperty"] = "Duplicate __proto__ fields are not allowed in object literals",
["ConstructorSpecialMethod"] = "Class constructor may not be an accessor",
["DuplicateConstructor"] = "A class may only have one constructor",
["StaticPrototype"] = "Classes may not have static property named prototype",
["MissingFromClause"] = "Unexpected token",
["NoAsAfterImportNamespace"] = "Unexpected token",
["InvalidModuleSpecifier"] = "Unexpected token",
["IllegalImportDeclaration"] = "Unexpected token",
["IllegalExportDeclaration"] = "Unexpected token",
["DuplicateBinding"] = "Duplicate binding %0"
});
Regex = _obj({
["NonAsciiIdentifierStart"] = _regexp("[\\xAA\\xB5\\xBA\\xC0-\\xD6\\xD8-\\xF6\\xF8-\203\129\203\134-\203\145\203\160-\203\164\203\172\203\174\205\176-\205\180\205\182\205\183\205\186-\205\189\205\191\206\134\206\136-\206\138\206\140\206\142-\206\161\206\163-\207\181\207\183-\210\129\210\138-\212\175\212\177-\213\150\213\153\213\161-\214\135\215\144-\215\170\215\176-\215\178\216\160-\217\138\217\174\217\175\217\177-\219\147\219\149\219\165\219\166\219\174\219\175\219\186-\219\188\219\191\220\144\220\146-\220\175\221\141-\222\165\222\177\223\138-\223\170\223\180\223\181\223\186\224\160\128-\224\160\149\224\160\154\224\160\164\224\160\168\224\161\128-\224\161\152\224\162\160-\224\162\178\224\164\132-\224\164\185\224\164\189\224\165\144\224\165\152-\224\165\161\224\165\177-\224\166\128\224\166\133-\224\166\140\224\166\143\224\166\144\224\166\147-\224\166\168\224\166\170-\224\166\176\224\166\178\224\166\182-\224\166\185\224\166\189\224\167\142\224\167\156\224\167\157\224\167\159-\224\167\161\224\167\176\224\167\177\224\168\133-\224\168\138\224\168\143\224\168\144\224\168\147-\224\168\168\224\168\170-\224\168\176\224\168\178\224\168\179\224\168\181\224\168\182\224\168\184\224\168\185\224\169\153-\224\169\156\224\169\158\224\169\178-\224\169\180\224\170\133-\224\170\141\224\170\143-\224\170\145\224\170\147-\224\170\168\224\170\170-\224\170\176\224\170\178\224\170\179\224\170\181-\224\170\185\224\170\189\224\171\144\224\171\160\224\171\161\224\172\133-\224\172\140\224\172\143\224\172\144\224\172\147-\224\172\168\224\172\170-\224\172\176\224\172\178\224\172\179\224\172\181-\224\172\185\224\172\189\224\173\156\224\173\157\224\173\159-\224\173\161\224\173\177\224\174\131\224\174\133-\224\174\138\224\174\142-\224\174\144\224\174\146-\224\174\149\224\174\153\224\174\154\224\174\156\224\174\158\224\174\159\224\174\163\224\174\164\224\174\168-\224\174\170\224\174\174-\224\174\185\224\175\144\224\176\133-\224\176\140\224\176\142-\224\176\144\224\176\146-\224\176\168\224\176\170-\224\176\185\224\176\189\224\177\152\224\177\153\224\177\160\224\177\161\224\178\133-\224\178\140\224\178\142-\224\178\144\224\178\146-\224\178\168\224\178\170-\224\178\179\224\178\181-\224\178\185\224\178\189\224\179\158\224\179\160\224\179\161\224\179\177\224\179\178\224\180\133-\224\180\140\224\180\142-\224\180\144\224\180\146-\224\180\186\224\180\189\224\181\142\224\181\160\224\181\161\224\181\186-\224\181\191\224\182\133-\224\182\150\224\182\154-\224\182\177\224\182\179-\224\182\187\224\182\189\224\183\128-\224\183\134\224\184\129-\224\184\176\224\184\178\224\184\179\224\185\128-\224\185\134\224\186\129\224\186\130\224\186\132\224\186\135\224\186\136\224\186\138\224\186\141\224\186\148-\224\186\151\224\186\153-\224\186\159\224\186\161-\224\186\163\224\186\165\224\186\167\224\186\170\224\186\171\224\186\173-\224\186\176\224\186\178\224\186\179\224\186\189\224\187\128-\224\187\132\224\187\134\224\187\156-\224\187\159\224\188\128\224\189\128-\224\189\135\224\189\137-\224\189\172\224\190\136-\224\190\140\225\128\128-\225\128\170\225\128\191\225\129\144-\225\129\149\225\129\154-\225\129\157\225\129\161\225\129\165\225\129\166\225\129\174-\225\129\176\225\129\181-\225\130\129\225\130\142\225\130\160-\225\131\133\225\131\135\225\131\141\225\131\144-\225\131\186\225\131\188-\225\137\136\225\137\138-\225\137\141\225\137\144-\225\137\150\225\137\152\225\137\154-\225\137\157\225\137\160-\225\138\136\225\138\138-\225\138\141\225\138\144-\225\138\176\225\138\178-\225\138\181\225\138\184-\225\138\190\225\139\128\225\139\130-\225\139\133\225\139\136-\225\139\150\225\139\152-\225\140\144\225\140\146-\225\140\149\225\140\152-\225\141\154\225\142\128-\225\142\143\225\142\160-\225\143\180\225\144\129-\225\153\172\225\153\175-\225\153\191\225\154\129-\225\154\154\225\154\160-\225\155\170\225\155\174-\225\155\184\225\156\128-\225\156\140\225\156\142-\225\156\145\225\156\160-\225\156\177\225\157\128-\225\157\145\225\157\160-\225\157\172\225\157\174-\225\157\176\225\158\128-\225\158\179\225\159\151\225\159\156\225\160\160-\225\161\183\225\162\128-\225\162\168\225\162\170\225\162\176-\225\163\181\225\164\128-\225\164\158\225\165\144-\225\165\173\225\165\176-\225\165\180\225\166\128-\225\166\171\225\167\129-\225\167\135\225\168\128-\225\168\150\225\168\160-\225\169\148\225\170\167\225\172\133-\225\172\179\225\173\133-\225\173\139\225\174\131-\225\174\160\225\174\174\225\174\175\225\174\186-\225\175\165\225\176\128-\225\176\163\225\177\141-\225\177\143\225\177\154-\225\177\189\225\179\169-\225\179\172\225\179\174-\225\179\177\225\179\181\225\179\182\225\180\128-\225\182\191\225\184\128-\225\188\149\225\188\152-\225\188\157\225\188\160-\225\189\133\225\189\136-\225\189\141\225\189\144-\225\189\151\225\189\153\225\189\155\225\189\157\225\189\159-\225\189\189\225\190\128-\225\190\180\225\190\182-\225\190\188\225\190\190\225\191\130-\225\191\132\225\191\134-\225\191\140\225\191\144-\225\191\147\225\191\150-\225\191\155\225\191\160-\225\191\172\225\191\178-\225\191\180\225\191\182-\225\191\188\226\129\177\226\129\191\226\130\144-\226\130\156\226\132\130\226\132\135\226\132\138-\226\132\147\226\132\149\226\132\152-\226\132\157\226\132\164\226\132\166\226\132\168\226\132\170-\226\132\185\226\132\188-\226\132\191\226\133\133-\226\133\137\226\133\142\226\133\160-\226\134\136\226\176\128-\226\176\174\226\176\176-\226\177\158\226\177\160-\226\179\164\226\179\171-\226\179\174\226\179\178\226\179\179\226\180\128-\226\180\165\226\180\167\226\180\173\226\180\176-\226\181\167\226\181\175\226\182\128-\226\182\150\226\182\160-\226\182\166\226\182\168-\226\182\174\226\182\176-\226\182\182\226\182\184-\226\182\190\226\183\128-\226\183\134\226\183\136-\226\183\142\226\183\144-\226\183\150\226\183\152-\226\183\158\227\128\133-\227\128\135\227\128\161-\227\128\169\227\128\177-\227\128\181\227\128\184-\227\128\188\227\129\129-\227\130\150\227\130\155-\227\130\159\227\130\161-\227\131\186\227\131\188-\227\131\191\227\132\133-\227\132\173\227\132\177-\227\134\142\227\134\160-\227\134\186\227\135\176-\227\135\191\227\144\128-\228\182\181\228\184\128-\233\191\140\234\128\128-\234\146\140\234\147\144-\234\147\189\234\148\128-\234\152\140\234\152\144-\234\152\159\234\152\170\234\152\171\234\153\128-\234\153\174\234\153\191-\234\154\157\234\154\160-\234\155\175\234\156\151-\234\156\159\234\156\162-\234\158\136\234\158\139-\234\158\142\234\158\144-\234\158\173\234\158\176\234\158\177\234\159\183-\234\160\129\234\160\131-\234\160\133\234\160\135-\234\160\138\234\160\140-\234\160\162\234\161\128-\234\161\179\234\162\130-\234\162\179\234\163\178-\234\163\183\234\163\187\234\164\138-\234\164\165\234\164\176-\234\165\134\234\165\160-\234\165\188\234\166\132-\234\166\178\234\167\143\234\167\160-\234\167\164\234\167\166-\234\167\175\234\167\186-\234\167\190\234\168\128-\234\168\168\234\169\128-\234\169\130\234\169\132-\234\169\139\234\169\160-\234\169\182\234\169\186\234\169\190-\234\170\175\234\170\177\234\170\181\234\170\182\234\170\185-\234\170\189\234\171\128\234\171\130\234\171\155-\234\171\157\234\171\160-\234\171\170\234\171\178-\234\171\180\234\172\129-\234\172\134\234\172\137-\234\172\142\234\172\145-\234\172\150\234\172\160-\234\172\166\234\172\168-\234\172\174\234\172\176-\234\173\154\234\173\156-\234\173\159\234\173\164\234\173\165\234\175\128-\234\175\162\234\176\128-\237\158\163\237\158\176-\237\159\134\237\159\139-\237\159\187\239\164\128-\239\169\173\239\169\176-\239\171\153\239\172\128-\239\172\134\239\172\147-\239\172\151\239\172\157\239\172\159-\239\172\168\239\172\170-\239\172\182\239\172\184-\239\172\188\239\172\190\239\173\128\239\173\129\239\173\131\239\173\132\239\173\134-\239\174\177\239\175\147-\239\180\189\239\181\144-\239\182\143\239\182\146-\239\183\135\239\183\176-\239\183\187\239\185\176-\239\185\180\239\185\182-\239\187\188\239\188\161-\239\188\186\239\189\129-\239\189\154\239\189\166-\239\190\190\239\191\130-\239\191\135\239\191\138-\239\191\143\239\191\146-\239\191\151\239\191\154-\239\191\156]|\240\144\128\128[\240\144\128\128-\240\146\176\128\240\147\144\128-\240\153\160\128\240\154\128\128-\240\158\160\128\240\159\128\128\240\159\144\128\240\159\176\128-\240\163\144\128\240\164\128\128-\240\167\144\128\240\176\128\128-\241\142\160\128\241\160\128\128-\241\173\128\128\242\176\128\128-\242\183\128\128\242\184\128\128-\243\132\128\128\243\144\128\128-\243\151\176\128\243\156\128\128-\243\162\160\128\243\164\128\128-\243\173\144\128\243\176\128\128-\243\183\144\128\243\184\128\128-\244\128\176\128\244\130\128\128-\244\131\176\128\244\132\144\128-\244\133\144\128]|\240\144\144\128[\240\144\128\128-\240\183\144\128\241\144\128\128-\241\153\176\128\241\156\128\128-\241\168\176\128\242\144\128\128-\243\157\160\128\243\160\128\128-\243\165\144\128\243\168\128\128-\243\169\176\128]|\240\144\160\128[\240\144\128\128-\240\145\144\128\240\146\128\128\240\146\160\128-\240\157\144\128\240\157\176\128\240\158\128\128\240\159\128\128\240\159\176\128-\240\165\144\128\240\168\128\128-\240\173\160\128\240\176\128\128-\240\183\160\128\241\144\128\128-\241\149\144\128\241\152\128\128-\241\158\144\128\241\176\128\128-\241\189\176\128\241\191\160\128\241\191\176\128\242\144\128\128\242\148\128\128-\242\148\176\128\242\149\144\128-\242\149\176\128\242\150\144\128-\242\156\176\128\242\168\128\128-\242\175\128\128\242\176\128\128-\242\183\128\128\243\128\128\128-\243\129\176\128\243\130\144\128-\243\137\128\128\243\144\128\128-\243\157\144\128\243\160\128\128-\243\165\144\128\243\168\128\128-\243\172\160\128\243\176\128\128-\243\180\144\128]|\240\144\176\128[\240\144\128\128-\240\162\128\128]|\240\145\128\128[\240\144\176\128-\240\157\176\128\240\176\176\128-\240\187\176\128\241\132\128\128-\241\138\128\128\241\144\176\128-\241\153\160\128\241\164\128\128-\241\172\160\128\241\173\160\128\241\176\176\128-\241\188\160\128\242\128\144\128-\242\129\128\128\242\134\160\128\242\144\128\128-\242\148\144\128\242\148\176\128-\242\154\176\128\242\188\128\128-\243\135\160\128\243\145\144\128-\243\147\128\128\243\147\176\128\243\148\128\128\243\148\176\128-\243\154\128\128\243\154\160\128-\243\156\128\128\243\156\160\128\243\156\176\128\243\157\144\128-\243\158\144\128\243\159\144\128\243\167\144\128-\243\168\144\128]|\240\145\144\128[\240\176\128\128-\240\187\176\128\241\129\128\128\241\129\144\128\241\129\176\128\241\176\128\128-\241\187\160\128\242\144\128\128-\242\155\176\128\242\161\128\128\242\176\128\128-\242\186\160\128]|\240\145\160\128[\240\184\128\128-\241\135\176\128\241\143\176\128\243\128\128\128-\243\142\128\128]|\240\146\128\128[\240\144\128\128-\243\182\128\128]|\240\146\144\128[\240\144\128\128-\240\171\160\128]|[\240\147\128\128\240\160\128\128-\240\170\128\128\240\170\160\128-\240\171\128\128][\240\144\128\128-\244\143\176\128]|\240\147\144\128[\240\144\128\128-\240\155\160\128]|\240\150\160\128[\240\144\128\128-\242\158\128\128\242\160\128\128-\242\167\160\128\243\132\128\128-\243\139\144\128\243\144\128\128-\243\155\176\128\243\160\128\128-\243\160\176\128\243\168\176\128-\243\173\176\128\243\175\144\128-\243\179\176\128]|\240\150\176\128[\243\144\128\128-\243\161\128\128\243\164\128\128\243\180\176\128-\243\183\176\128]|\240\155\128\128[\240\144\128\128\240\144\144\128]|\240\155\176\128[\240\144\128\128-\240\170\160\128\240\172\128\128-\240\175\128\128\240\176\128\128-\240\178\128\128\240\180\128\128-\240\182\144\128]|\240\157\144\128[\240\144\128\128-\240\165\128\128\240\165\160\128-\240\183\128\128\240\183\160\128\240\183\176\128\240\184\160\128\240\185\144\128\240\185\160\128\240\186\144\128-\240\187\128\128\240\187\160\128-\240\190\144\128\240\190\176\128\240\191\144\128-\241\128\176\128\241\129\144\128-\241\145\144\128\241\145\176\128-\241\146\160\128\241\147\144\128-\241\149\128\128\241\149\160\128-\241\151\128\128\241\151\160\128-\241\158\144\128\241\158\176\128-\241\159\160\128\241\160\128\128-\241\161\128\128\241\161\160\128\241\162\160\128-\241\164\128\128\241\164\160\128-\242\185\144\128\242\186\128\128-\243\128\128\128\243\128\160\128-\243\134\160\128\243\135\128\128-\243\142\160\128\243\143\128\128-\243\149\128\128\243\149\160\128-\243\157\128\128\243\157\160\128-\243\163\160\128\243\164\128\128-\243\171\160\128\243\172\128\128-\243\178\128\128\243\178\160\128-\243\186\128\128\243\186\160\128-\244\128\160\128\244\129\128\128-\244\130\176\128]|\240\158\160\128[\240\144\128\128-\241\129\128\128]|\240\158\176\128[\242\144\128\128-\242\144\176\128\242\145\144\128-\242\151\176\128\242\152\144\128\242\152\160\128\242\153\128\128\242\153\176\128\242\154\144\128-\242\156\160\128\242\157\128\128-\242\157\176\128\242\158\144\128\242\158\176\128\242\160\160\128\242\161\176\128\242\162\144\128\242\162\176\128\242\163\144\128-\242\163\176\128\242\164\144\128\242\164\160\128\242\165\128\128\242\165\176\128\242\166\144\128\242\166\176\128\242\167\144\128\242\167\176\128\242\168\144\128\242\168\160\128\242\169\128\128\242\169\176\128-\242\170\160\128\242\171\128\128-\242\172\160\128\242\173\128\128-\242\173\176\128\242\174\144\128-\242\175\128\128\242\175\160\128\242\176\128\128-\242\178\144\128\242\178\176\128-\242\182\176\128\242\184\144\128-\242\184\176\128\242\185\144\128-\242\186\144\128\242\186\176\128-\242\190\176\128]|\240\170\144\128[\240\144\128\128-\243\133\160\128\243\144\128\128-\244\143\176\128]|\240\171\144\128[\240\144\128\128-\243\157\128\128\243\160\128\128-\244\143\176\128]|\240\171\160\128[\240\144\128\128-\240\151\144\128]|\240\175\160\128[\240\144\128\128-\242\151\144\128]",""),
["NonAsciiIdentifierPart"] = _regexp("[\\xAA\\xB5\\xB7\\xBA\\xC0-\\xD6\\xD8-\\xF6\\xF8-\203\129\203\134-\203\145\203\160-\203\164\203\172\203\174\204\128-\205\180\205\182\205\183\205\186-\205\189\205\191\206\134-\206\138\206\140\206\142-\206\161\206\163-\207\181\207\183-\210\129\210\131-\210\135\210\138-\212\175\212\177-\213\150\213\153\213\161-\214\135\214\145-\214\189\214\191\215\129\215\130\215\132\215\133\215\135\215\144-\215\170\215\176-\215\178\216\144-\216\154\216\160-\217\169\217\174-\219\147\219\149-\219\156\219\159-\219\168\219\170-\219\188\219\191\220\144-\221\138\221\141-\222\177\223\128-\223\181\223\186\224\160\128-\224\160\173\224\161\128-\224\161\155\224\162\160-\224\162\178\224\163\164-\224\165\163\224\165\166-\224\165\175\224\165\177-\224\166\131\224\166\133-\224\166\140\224\166\143\224\166\144\224\166\147-\224\166\168\224\166\170-\224\166\176\224\166\178\224\166\182-\224\166\185\224\166\188-\224\167\132\224\167\135\224\167\136\224\167\139-\224\167\142\224\167\151\224\167\156\224\167\157\224\167\159-\224\167\163\224\167\166-\224\167\177\224\168\129-\224\168\131\224\168\133-\224\168\138\224\168\143\224\168\144\224\168\147-\224\168\168\224\168\170-\224\168\176\224\168\178\224\168\179\224\168\181\224\168\182\224\168\184\224\168\185\224\168\188\224\168\190-\224\169\130\224\169\135\224\169\136\224\169\139-\224\169\141\224\169\145\224\169\153-\224\169\156\224\169\158\224\169\166-\224\169\181\224\170\129-\224\170\131\224\170\133-\224\170\141\224\170\143-\224\170\145\224\170\147-\224\170\168\224\170\170-\224\170\176\224\170\178\224\170\179\224\170\181-\224\170\185\224\170\188-\224\171\133\224\171\135-\224\171\137\224\171\139-\224\171\141\224\171\144\224\171\160-\224\171\163\224\171\166-\224\171\175\224\172\129-\224\172\131\224\172\133-\224\172\140\224\172\143\224\172\144\224\172\147-\224\172\168\224\172\170-\224\172\176\224\172\178\224\172\179\224\172\181-\224\172\185\224\172\188-\224\173\132\224\173\135\224\173\136\224\173\139-\224\173\141\224\173\150\224\173\151\224\173\156\224\173\157\224\173\159-\224\173\163\224\173\166-\224\173\175\224\173\177\224\174\130\224\174\131\224\174\133-\224\174\138\224\174\142-\224\174\144\224\174\146-\224\174\149\224\174\153\224\174\154\224\174\156\224\174\158\224\174\159\224\174\163\224\174\164\224\174\168-\224\174\170\224\174\174-\224\174\185\224\174\190-\224\175\130\224\175\134-\224\175\136\224\175\138-\224\175\141\224\175\144\224\175\151\224\175\166-\224\175\175\224\176\128-\224\176\131\224\176\133-\224\176\140\224\176\142-\224\176\144\224\176\146-\224\176\168\224\176\170-\224\176\185\224\176\189-\224\177\132\224\177\134-\224\177\136\224\177\138-\224\177\141\224\177\149\224\177\150\224\177\152\224\177\153\224\177\160-\224\177\163\224\177\166-\224\177\175\224\178\129-\224\178\131\224\178\133-\224\178\140\224\178\142-\224\178\144\224\178\146-\224\178\168\224\178\170-\224\178\179\224\178\181-\224\178\185\224\178\188-\224\179\132\224\179\134-\224\179\136\224\179\138-\224\179\141\224\179\149\224\179\150\224\179\158\224\179\160-\224\179\163\224\179\166-\224\179\175\224\179\177\224\179\178\224\180\129-\224\180\131\224\180\133-\224\180\140\224\180\142-\224\180\144\224\180\146-\224\180\186\224\180\189-\224\181\132\224\181\134-\224\181\136\224\181\138-\224\181\142\224\181\151\224\181\160-\224\181\163\224\181\166-\224\181\175\224\181\186-\224\181\191\224\182\130\224\182\131\224\182\133-\224\182\150\224\182\154-\224\182\177\224\182\179-\224\182\187\224\182\189\224\183\128-\224\183\134\224\183\138\224\183\143-\224\183\148\224\183\150\224\183\152-\224\183\159\224\183\166-\224\183\175\224\183\178\224\183\179\224\184\129-\224\184\186\224\185\128-\224\185\142\224\185\144-\224\185\153\224\186\129\224\186\130\224\186\132\224\186\135\224\186\136\224\186\138\224\186\141\224\186\148-\224\186\151\224\186\153-\224\186\159\224\186\161-\224\186\163\224\186\165\224\186\167\224\186\170\224\186\171\224\186\173-\224\186\185\224\186\187-\224\186\189\224\187\128-\224\187\132\224\187\134\224\187\136-\224\187\141\224\187\144-\224\187\153\224\187\156-\224\187\159\224\188\128\224\188\152\224\188\153\224\188\160-\224\188\169\224\188\181\224\188\183\224\188\185\224\188\190-\224\189\135\224\189\137-\224\189\172\224\189\177-\224\190\132\224\190\134-\224\190\151\224\190\153-\224\190\188\224\191\134\225\128\128-\225\129\137\225\129\144-\225\130\157\225\130\160-\225\131\133\225\131\135\225\131\141\225\131\144-\225\131\186\225\131\188-\225\137\136\225\137\138-\225\137\141\225\137\144-\225\137\150\225\137\152\225\137\154-\225\137\157\225\137\160-\225\138\136\225\138\138-\225\138\141\225\138\144-\225\138\176\225\138\178-\225\138\181\225\138\184-\225\138\190\225\139\128\225\139\130-\225\139\133\225\139\136-\225\139\150\225\139\152-\225\140\144\225\140\146-\225\140\149\225\140\152-\225\141\154\225\141\157-\225\141\159\225\141\169-\225\141\177\225\142\128-\225\142\143\225\142\160-\225\143\180\225\144\129-\225\153\172\225\153\175-\225\153\191\225\154\129-\225\154\154\225\154\160-\225\155\170\225\155\174-\225\155\184\225\156\128-\225\156\140\225\156\142-\225\156\148\225\156\160-\225\156\180\225\157\128-\225\157\147\225\157\160-\225\157\172\225\157\174-\225\157\176\225\157\178\225\157\179\225\158\128-\225\159\147\225\159\151\225\159\156\225\159\157\225\159\160-\225\159\169\225\160\139-\225\160\141\225\160\144-\225\160\153\225\160\160-\225\161\183\225\162\128-\225\162\170\225\162\176-\225\163\181\225\164\128-\225\164\158\225\164\160-\225\164\171\225\164\176-\225\164\187\225\165\134-\225\165\173\225\165\176-\225\165\180\225\166\128-\225\166\171\225\166\176-\225\167\137\225\167\144-\225\167\154\225\168\128-\225\168\155\225\168\160-\225\169\158\225\169\160-\225\169\188\225\169\191-\225\170\137\225\170\144-\225\170\153\225\170\167\225\170\176-\225\170\189\225\172\128-\225\173\139\225\173\144-\225\173\153\225\173\171-\225\173\179\225\174\128-\225\175\179\225\176\128-\225\176\183\225\177\128-\225\177\137\225\177\141-\225\177\189\225\179\144-\225\179\146\225\179\148-\225\179\182\225\179\184\225\179\185\225\180\128-\225\183\181\225\183\188-\225\188\149\225\188\152-\225\188\157\225\188\160-\225\189\133\225\189\136-\225\189\141\225\189\144-\225\189\151\225\189\153\225\189\155\225\189\157\225\189\159-\225\189\189\225\190\128-\225\190\180\225\190\182-\225\190\188\225\190\190\225\191\130-\225\191\132\225\191\134-\225\191\140\225\191\144-\225\191\147\225\191\150-\225\191\155\225\191\160-\225\191\172\225\191\178-\225\191\180\225\191\182-\225\191\188\226\128\140\226\128\141\226\128\191\226\129\128\226\129\148\226\129\177\226\129\191\226\130\144-\226\130\156\226\131\144-\226\131\156\226\131\161\226\131\165-\226\131\176\226\132\130\226\132\135\226\132\138-\226\132\147\226\132\149\226\132\152-\226\132\157\226\132\164\226\132\166\226\132\168\226\132\170-\226\132\185\226\132\188-\226\132\191\226\133\133-\226\133\137\226\133\142\226\133\160-\226\134\136\226\176\128-\226\176\174\226\176\176-\226\177\158\226\177\160-\226\179\164\226\179\171-\226\179\179\226\180\128-\226\180\165\226\180\167\226\180\173\226\180\176-\226\181\167\226\181\175\226\181\191-\226\182\150\226\182\160-\226\182\166\226\182\168-\226\182\174\226\182\176-\226\182\182\226\182\184-\226\182\190\226\183\128-\226\183\134\226\183\136-\226\183\142\226\183\144-\226\183\150\226\183\152-\226\183\158\226\183\160-\226\183\191\227\128\133-\227\128\135\227\128\161-\227\128\175\227\128\177-\227\128\181\227\128\184-\227\128\188\227\129\129-\227\130\150\227\130\153-\227\130\159\227\130\161-\227\131\186\227\131\188-\227\131\191\227\132\133-\227\132\173\227\132\177-\227\134\142\227\134\160-\227\134\186\227\135\176-\227\135\191\227\144\128-\228\182\181\228\184\128-\233\191\140\234\128\128-\234\146\140\234\147\144-\234\147\189\234\148\128-\234\152\140\234\152\144-\234\152\171\234\153\128-\234\153\175\234\153\180-\234\153\189\234\153\191-\234\154\157\234\154\159-\234\155\177\234\156\151-\234\156\159\234\156\162-\234\158\136\234\158\139-\234\158\142\234\158\144-\234\158\173\234\158\176\234\158\177\234\159\183-\234\160\167\234\161\128-\234\161\179\234\162\128-\234\163\132\234\163\144-\234\163\153\234\163\160-\234\163\183\234\163\187\234\164\128-\234\164\173\234\164\176-\234\165\147\234\165\160-\234\165\188\234\166\128-\234\167\128\234\167\143-\234\167\153\234\167\160-\234\167\190\234\168\128-\234\168\182\234\169\128-\234\169\141\234\169\144-\234\169\153\234\169\160-\234\169\182\234\169\186-\234\171\130\234\171\155-\234\171\157\234\171\160-\234\171\175\234\171\178-\234\171\182\234\172\129-\234\172\134\234\172\137-\234\172\142\234\172\145-\234\172\150\234\172\160-\234\172\166\234\172\168-\234\172\174\234\172\176-\234\173\154\234\173\156-\234\173\159\234\173\164\234\173\165\234\175\128-\234\175\170\234\175\172\234\175\173\234\175\176-\234\175\185\234\176\128-\237\158\163\237\158\176-\237\159\134\237\159\139-\237\159\187\239\164\128-\239\169\173\239\169\176-\239\171\153\239\172\128-\239\172\134\239\172\147-\239\172\151\239\172\157-\239\172\168\239\172\170-\239\172\182\239\172\184-\239\172\188\239\172\190\239\173\128\239\173\129\239\173\131\239\173\132\239\173\134-\239\174\177\239\175\147-\239\180\189\239\181\144-\239\182\143\239\182\146-\239\183\135\239\183\176-\239\183\187\239\184\128-\239\184\143\239\184\160-\239\184\173\239\184\179\239\184\180\239\185\141-\239\185\143\239\185\176-\239\185\180\239\185\182-\239\187\188\239\188\144-\239\188\153\239\188\161-\239\188\186\239\188\191\239\189\129-\239\189\154\239\189\166-\239\190\190\239\191\130-\239\191\135\239\191\138-\239\191\143\239\191\146-\239\191\151\239\191\154-\239\191\156]|\240\144\128\128[\240\144\128\128-\240\146\176\128\240\147\144\128-\240\153\160\128\240\154\128\128-\240\158\160\128\240\159\128\128\240\159\144\128\240\159\176\128-\240\163\144\128\240\164\128\128-\240\167\144\128\240\176\128\128-\241\142\160\128\241\160\128\128-\241\173\128\128\242\143\144\128\242\176\128\128-\242\183\128\128\242\184\128\128-\243\132\128\128\243\136\128\128\243\144\128\128-\243\151\176\128\243\156\128\128-\243\162\160\128\243\164\128\128-\243\174\160\128\243\176\128\128-\243\183\144\128\243\184\128\128-\244\128\176\128\244\130\128\128-\244\131\176\128\244\132\144\128-\244\133\144\128]|\240\144\144\128[\240\144\128\128-\240\183\144\128\240\184\128\128-\240\186\144\128\241\144\128\128-\241\153\176\128\241\156\128\128-\241\168\176\128\242\144\128\128-\243\157\160\128\243\160\128\128-\243\165\144\128\243\168\128\128-\243\169\176\128]|\240\144\160\128[\240\144\128\128-\240\145\144\128\240\146\128\128\240\146\160\128-\240\157\144\128\240\157\176\128\240\158\128\128\240\159\128\128\240\159\176\128-\240\165\144\128\240\168\128\128-\240\173\160\128\240\176\128\128-\240\183\160\128\241\144\128\128-\241\149\144\128\241\152\128\128-\241\158\144\128\241\176\128\128-\241\189\176\128\241\191\160\128\241\191\176\128\242\144\128\128-\242\144\176\128\242\145\144\128\242\145\160\128\242\147\128\128-\242\148\176\128\242\149\144\128-\242\149\176\128\242\150\144\128-\242\156\176\128\242\158\128\128-\242\158\160\128\242\159\176\128\242\168\128\128-\242\175\128\128\242\176\128\128-\242\183\128\128\243\128\128\128-\243\129\176\128\243\130\144\128-\243\137\160\128\243\144\128\128-\243\157\144\128\243\160\128\128-\243\165\144\128\243\168\128\128-\243\172\160\128\243\176\128\128-\243\180\144\128]|\240\144\176\128[\240\144\128\128-\240\162\128\128]|\240\145\128\128[\240\144\128\128-\240\161\160\128\240\169\160\128-\240\171\176\128\240\175\176\128-\240\190\160\128\241\132\128\128-\241\138\128\128\241\140\128\128-\241\142\144\128\241\144\128\128-\241\157\128\128\241\157\160\128-\241\159\176\128\241\164\128\128-\241\172\176\128\241\173\160\128\241\176\128\128-\242\129\128\128\242\132\128\128-\242\134\160\128\242\144\128\128-\242\148\144\128\242\148\176\128-\242\157\176\128\242\188\128\128-\243\138\160\128\243\140\128\128-\243\142\144\128\243\144\144\128-\243\144\176\128\243\145\144\128-\243\147\128\128\243\147\176\128\243\148\128\128\243\148\176\128-\243\154\128\128\243\154\160\128-\243\156\128\128\243\156\160\128\243\156\176\128\243\157\144\128-\243\158\144\128\243\159\128\128-\243\161\128\128\243\161\176\128\243\162\128\128\243\162\176\128-\243\163\144\128\243\165\176\128\243\167\144\128-\243\168\176\128\243\169\160\128-\243\171\128\128\243\172\128\128-\243\173\128\128]|\240\145\144\128[\240\176\128\128-\241\129\144\128\241\129\176\128\241\132\128\128-\241\134\144\128\241\176\128\128-\241\189\144\128\241\190\128\128-\242\128\128\128\242\144\128\128-\242\160\128\128\242\161\128\128\242\164\128\128-\242\166\144\128\242\176\128\128-\242\189\176\128\243\128\128\128-\243\130\144\128]|\240\145\160\128[\240\184\128\128-\241\138\144\128\241\143\176\128\243\128\128\128-\243\142\128\128]|\240\146\128\128[\240\144\128\128-\243\182\128\128]|\240\146\144\128[\240\144\128\128-\240\171\160\128]|[\240\147\128\128\240\160\128\128-\240\170\128\128\240\170\160\128-\240\171\128\128][\240\144\128\128-\244\143\176\128]|\240\147\144\128[\240\144\128\128-\240\155\160\128]|\240\150\160\128[\240\144\128\128-\242\158\128\128\242\160\128\128-\242\167\160\128\242\168\128\128-\242\170\144\128\243\132\128\128-\243\139\144\128\243\140\128\128-\243\141\128\128\243\144\128\128-\243\157\160\128\243\160\128\128-\243\160\176\128\243\164\128\128-\243\166\144\128\243\168\176\128-\243\173\176\128\243\175\144\128-\243\179\176\128]|\240\150\176\128[\243\144\128\128-\243\161\128\128\243\164\128\128-\243\175\160\128\243\179\176\128-\243\183\176\128]|\240\155\128\128[\240\144\128\128\240\144\144\128]|\240\155\176\128[\240\144\128\128-\240\170\160\128\240\172\128\128-\240\175\128\128\240\176\128\128-\240\178\128\128\240\180\128\128-\240\182\144\128\240\183\144\128\240\183\160\128]|\240\157\128\128[\241\169\144\128-\241\170\144\128\241\171\144\128-\241\172\160\128\241\174\176\128-\241\176\160\128\241\177\144\128-\241\178\176\128\241\186\160\128-\241\187\144\128\242\160\160\128-\242\161\128\128]|\240\157\144\128[\240\144\128\128-\240\165\128\128\240\165\160\128-\240\183\128\128\240\183\160\128\240\183\176\128\240\184\160\128\240\185\144\128\240\185\160\128\240\186\144\128-\240\187\128\128\240\187\160\128-\240\190\144\128\240\190\176\128\240\191\144\128-\241\128\176\128\241\129\144\128-\241\145\144\128\241\145\176\128-\241\146\160\128\241\147\144\128-\241\149\128\128\241\149\160\128-\241\151\128\128\241\151\160\128-\241\158\144\128\241\158\176\128-\241\159\160\128\241\160\128\128-\241\161\128\128\241\161\160\128\241\162\160\128-\241\164\128\128\241\164\160\128-\242\185\144\128\242\186\128\128-\243\128\128\128\243\128\160\128-\243\134\160\128\243\135\128\128-\243\142\160\128\243\143\128\128-\243\149\128\128\243\149\160\128-\243\157\128\128\243\157\160\128-\243\163\160\128\243\164\128\128-\243\171\160\128\243\172\128\128-\243\178\128\128\243\178\160\128-\243\186\128\128\243\186\160\128-\244\128\160\128\244\129\128\128-\244\130\176\128\244\131\160\128-\244\143\176\128]|\240\158\160\128[\240\144\128\128-\241\129\128\128\241\132\128\128-\241\133\160\128]|\240\158\176\128[\242\144\128\128-\242\144\176\128\242\145\144\128-\242\151\176\128\242\152\144\128\242\152\160\128\242\153\128\128\242\153\176\128\242\154\144\128-\242\156\160\128\242\157\128\128-\242\157\176\128\242\158\144\128\242\158\176\128\242\160\160\128\242\161\176\128\242\162\144\128\242\162\176\128\242\163\144\128-\242\163\176\128\242\164\144\128\242\164\160\128\242\165\128\128\242\165\176\128\242\166\144\128\242\166\176\128\242\167\144\128\242\167\176\128\242\168\144\128\242\168\160\128\242\169\128\128\242\169\176\128-\242\170\160\128\242\171\128\128-\242\172\160\128\242\173\128\128-\242\173\176\128\242\174\144\128-\242\175\128\128\242\175\160\128\242\176\128\128-\242\178\144\128\242\178\176\128-\242\182\176\128\242\184\144\128-\242\184\176\128\242\185\144\128-\242\186\144\128\242\186\176\128-\242\190\176\128]|\240\170\144\128[\240\144\128\128-\243\133\160\128\243\144\128\128-\244\143\176\128]|\240\171\144\128[\240\144\128\128-\243\157\128\128\243\160\128\128-\244\143\176\128]|\240\171\160\128[\240\144\128\128-\240\151\144\128]|\240\175\160\128[\240\144\128\128-\242\151\144\128]|\243\160\128\128[\241\144\128\128-\242\139\176\128]","")
});
WrappingNode.prototype = (function() Node.prototype = _obj({
["processComment"] = (function (this)
local last,comment,i,bottomRight,trailingComments,leadingComments,innerComments,lastChild;
bottomRight = extra.bottomRightStack;
last = bottomRight[(bottomRight.length - 1)];
if (this.type == Syntax.Program) then
if (_gt(this.body.length,0)) then
do return end
end

end

if ((function() local _lev=(this.type == Syntax.BlockStatement); if _bool(_lev) then return (this.body.length == 0); else return _lev; end end)()) then
innerComments = _arr({},0);
i = (extra.leadingComments.length - 1);
while (i>=0) do
comment = extra.leadingComments[i];
if (_ge(this.range[1],comment.range[1])) then
innerComments:unshift(comment);
extra.leadingComments:splice(i,1);
extra.trailingComments:splice(i,1);
end

i = i - 1;
end

if _bool(innerComments.length) then
this.innerComments = innerComments;
do return end
end

end

if (_gt(extra.trailingComments.length,0)) then
trailingComments = _arr({},0);
i = (extra.trailingComments.length - 1);
while (i>=0) do
comment = extra.trailingComments[i];
if (_ge(comment.range[0],this.range[1])) then
trailingComments:unshift(comment);
extra.trailingComments:splice(i,1);
end

i = i - 1;
end

extra.trailingComments = _arr({},0);
else
if _bool(((function() local _lev=((function() if _bool(last) then return last.trailingComments; else return last; end end)()); if _bool(_lev) then return (_ge(last.trailingComments[0].range[0],this.range[1])); else return _lev; end end)())) then
trailingComments = last.trailingComments;
(function () local _r = false; local _g, _s = last["_g" .. "trailingComments"], last["_s" .. "trailingComments"]; last["_g" .. "trailingComments"], last["_s" .. "trailingComments"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = last.trailingComments; last.trailingComments = nil; return _r or _v ~= nil; end)();
end

end

while _bool(((function() if _bool(last) then return (_ge(last.range[0],this.range[0])); else return last; end end)())) do
lastChild = bottomRight:pop();
last = bottomRight[(bottomRight.length - 1)];
::_continue::
end

if _bool(lastChild) then
if _bool(lastChild.leadingComments) then
leadingComments = _arr({},0);
i = (lastChild.leadingComments.length - 1);
while (i>=0) do
comment = lastChild.leadingComments[i];
if (_le(comment.range[1],this.range[0])) then
leadingComments:unshift(comment);
lastChild.leadingComments:splice(i,1);
end

i = i - 1;
end

if not _bool(lastChild.leadingComments.length) then
lastChild.leadingComments = undefined;
end

end

elseif (_gt(extra.leadingComments.length,0)) then
leadingComments = _arr({},0);
i = (extra.leadingComments.length - 1);
while (i>=0) do
comment = extra.leadingComments[i];
if (_le(comment.range[1],this.range[0])) then
leadingComments:unshift(comment);
extra.leadingComments:splice(i,1);
end

i = i - 1;
end

end

if _bool(((function() if _bool(leadingComments) then return (_gt(leadingComments.length,0)); else return leadingComments; end end)())) then
this.leadingComments = leadingComments;
end

if _bool(((function() if _bool(trailingComments) then return (_gt(trailingComments.length,0)); else return trailingComments; end end)())) then
this.trailingComments = trailingComments;
end

bottomRight:push(this);
end),
["finish"] = (function (this)
if _bool(extra.range) then
this.range[1] = lastIndex;
end

if _bool(extra.loc) then
this.loc["end"] = _obj({
["line"] = lastLineNumber,
["column"] = (lastIndex - lastLineStart)
});
if _bool(extra.source) then
this.loc.source = extra.source;
end

end

if _bool(extra.attachComment) then
this:processComment();
end

end),
["finishArrayExpression"] = (function (this, elements)
this.type = Syntax.ArrayExpression;
this.elements = elements;
this:finish();
do return this; end
end),
["finishArrayPattern"] = (function (this, elements)
this.type = Syntax.ArrayPattern;
this.elements = elements;
this:finish();
do return this; end
end),
["finishArrowFunctionExpression"] = (function (this, params, defaults, body, expression)
this.type = Syntax.ArrowFunctionExpression;
this.id = null;
this.params = params;
this.defaults = defaults;
this.body = body;
this.generator = false;
this.expression = expression;
this:finish();
do return this; end
end),
["finishAssignmentExpression"] = (function (this, operator, left, right)
this.type = Syntax.AssignmentExpression;
this.operator = operator;
this.left = left;
this.right = right;
this:finish();
do return this; end
end),
["finishAssignmentPattern"] = (function (this, left, right)
this.type = Syntax.AssignmentPattern;
this.left = left;
this.right = right;
this:finish();
do return this; end
end),
["finishBinaryExpression"] = (function (this, operator, left, right)
this.type = (function() if ((function() local _lev=(operator == "||"); return _bool(_lev) and _lev or (operator == "&&") end)()) then return Syntax.LogicalExpression; else return Syntax.BinaryExpression; end end)();
this.operator = operator;
this.left = left;
this.right = right;
this:finish();
do return this; end
end),
["finishBlockStatement"] = (function (this, body)
this.type = Syntax.BlockStatement;
this.body = body;
this:finish();
do return this; end
end),
["finishBreakStatement"] = (function (this, label)
this.type = Syntax.BreakStatement;
this.label = label;
this:finish();
do return this; end
end),
["finishCallExpression"] = (function (...)
local this, callee, args = ...;
local arguments = _args(...);
this.type = Syntax.CallExpression;
this.callee = callee;
this.arguments = args;
this:finish();
do return this; end
end),
["finishCatchClause"] = (function (this, param, body)
this.type = Syntax.CatchClause;
this.param = param;
this.body = body;
this:finish();
do return this; end
end),
["finishClassBody"] = (function (this, body)
this.type = Syntax.ClassBody;
this.body = body;
this:finish();
do return this; end
end),
["finishClassDeclaration"] = (function (this, id, superClass, body)
this.type = Syntax.ClassDeclaration;
this.id = id;
this.superClass = superClass;
this.body = body;
this:finish();
do return this; end
end),
["finishClassExpression"] = (function (this, id, superClass, body)
this.type = Syntax.ClassExpression;
this.id = id;
this.superClass = superClass;
this.body = body;
this:finish();
do return this; end
end),
["finishConditionalExpression"] = (function (this, test, consequent, alternate)
this.type = Syntax.ConditionalExpression;
this.test = test;
this.consequent = consequent;
this.alternate = alternate;
this:finish();
do return this; end
end),
["finishContinueStatement"] = (function (this, label)
this.type = Syntax.ContinueStatement;
this.label = label;
this:finish();
do return this; end
end),
["finishDebuggerStatement"] = (function (this)
this.type = Syntax.DebuggerStatement;
this:finish();
do return this; end
end),
["finishDoWhileStatement"] = (function (this, body, test)
this.type = Syntax.DoWhileStatement;
this.body = body;
this.test = test;
this:finish();
do return this; end
end),
["finishEmptyStatement"] = (function (this)
this.type = Syntax.EmptyStatement;
this:finish();
do return this; end
end),
["finishExpressionStatement"] = (function (this, expression)
this.type = Syntax.ExpressionStatement;
this.expression = expression;
this:finish();
do return this; end
end),
["finishForStatement"] = (function (this, init, test, update, body)
this.type = Syntax.ForStatement;
this.init = init;
this.test = test;
this.update = update;
this.body = body;
this:finish();
do return this; end
end),
["finishForOfStatement"] = (function (this, left, right, body)
this.type = Syntax.ForOfStatement;
this.left = left;
this.right = right;
this.body = body;
this:finish();
do return this; end
end),
["finishForInStatement"] = (function (this, left, right, body)
this.type = Syntax.ForInStatement;
this.left = left;
this.right = right;
this.body = body;
this.each = false;
this:finish();
do return this; end
end),
["finishFunctionDeclaration"] = (function (this, id, params, defaults, body, generator)
this.type = Syntax.FunctionDeclaration;
this.id = id;
this.params = params;
this.defaults = defaults;
this.body = body;
this.generator = generator;
this.expression = false;
this:finish();
do return this; end
end),
["finishFunctionExpression"] = (function (this, id, params, defaults, body, generator)
this.type = Syntax.FunctionExpression;
this.id = id;
this.params = params;
this.defaults = defaults;
this.body = body;
this.generator = generator;
this.expression = false;
this:finish();
do return this; end
end),
["finishIdentifier"] = (function (this, name)
this.type = Syntax.Identifier;
this.name = name;
this:finish();
do return this; end
end),
["finishIfStatement"] = (function (this, test, consequent, alternate)
this.type = Syntax.IfStatement;
this.test = test;
this.consequent = consequent;
this.alternate = alternate;
this:finish();
do return this; end
end),
["finishLabeledStatement"] = (function (this, label, body)
this.type = Syntax.LabeledStatement;
this.label = label;
this.body = body;
this:finish();
do return this; end
end),
["finishLiteral"] = (function (this, token)
this.type = Syntax.Literal;
this.value = token.value;
this.raw = source:slice(token.start,token["end"]);
if _bool(token.regex) then
this.regex = token.regex;
end

this:finish();
do return this; end
end),
["finishMemberExpression"] = (function (this, accessor, object, property)
this.type = Syntax.MemberExpression;
this.computed = (accessor == "[");
this.object = object;
this.property = property;
this:finish();
do return this; end
end),
["finishMetaProperty"] = (function (this, meta, property)
this.type = Syntax.MetaProperty;
this.meta = meta;
this.property = property;
this:finish();
do return this; end
end),
["finishNewExpression"] = (function (...)
local this, callee, args = ...;
local arguments = _args(...);
this.type = Syntax.NewExpression;
this.callee = callee;
this.arguments = args;
this:finish();
do return this; end
end),
["finishObjectExpression"] = (function (this, properties)
this.type = Syntax.ObjectExpression;
this.properties = properties;
this:finish();
do return this; end
end),
["finishObjectPattern"] = (function (this, properties)
this.type = Syntax.ObjectPattern;
this.properties = properties;
this:finish();
do return this; end
end),
["finishPostfixExpression"] = (function (this, operator, argument)
this.type = Syntax.UpdateExpression;
this.operator = operator;
this.argument = argument;
this.prefix = false;
this:finish();
do return this; end
end),
["finishProgram"] = (function (this, body, sourceType)
this.type = Syntax.Program;
this.body = body;
this.sourceType = sourceType;
this:finish();
do return this; end
end),
["finishProperty"] = (function (this, kind, key, computed, value, method, shorthand)
this.type = Syntax.Property;
this.key = key;
this.computed = computed;
this.value = value;
this.kind = kind;
this.method = method;
this.shorthand = shorthand;
this:finish();
do return this; end
end),
["finishRestElement"] = (function (this, argument)
this.type = Syntax.RestElement;
this.argument = argument;
this:finish();
do return this; end
end),
["finishReturnStatement"] = (function (this, argument)
this.type = Syntax.ReturnStatement;
this.argument = argument;
this:finish();
do return this; end
end),
["finishSequenceExpression"] = (function (this, expressions)
this.type = Syntax.SequenceExpression;
this.expressions = expressions;
this:finish();
do return this; end
end),
["finishSpreadElement"] = (function (this, argument)
this.type = Syntax.SpreadElement;
this.argument = argument;
this:finish();
do return this; end
end),
["finishSwitchCase"] = (function (this, test, consequent)
this.type = Syntax.SwitchCase;
this.test = test;
this.consequent = consequent;
this:finish();
do return this; end
end),
["finishSuper"] = (function (this)
this.type = Syntax.Super;
this:finish();
do return this; end
end),
["finishSwitchStatement"] = (function (this, discriminant, cases)
this.type = Syntax.SwitchStatement;
this.discriminant = discriminant;
this.cases = cases;
this:finish();
do return this; end
end),
["finishTaggedTemplateExpression"] = (function (this, tag, quasi)
this.type = Syntax.TaggedTemplateExpression;
this.tag = tag;
this.quasi = quasi;
this:finish();
do return this; end
end),
["finishTemplateElement"] = (function (this, value, tail)
this.type = Syntax.TemplateElement;
this.value = value;
this.tail = tail;
this:finish();
do return this; end
end),
["finishTemplateLiteral"] = (function (this, quasis, expressions)
this.type = Syntax.TemplateLiteral;
this.quasis = quasis;
this.expressions = expressions;
this:finish();
do return this; end
end),
["finishThisExpression"] = (function (this)
this.type = Syntax.ThisExpression;
this:finish();
do return this; end
end),
["finishThrowStatement"] = (function (this, argument)
this.type = Syntax.ThrowStatement;
this.argument = argument;
this:finish();
do return this; end
end),
["finishTryStatement"] = (function (this, block, handler, finalizer)
this.type = Syntax.TryStatement;
this.block = block;
this.guardedHandlers = _arr({},0);
this.handlers = (function() if _bool(handler) then return _arr({[0]=handler},1); else return _arr({},0); end end)();
this.handler = handler;
this.finalizer = finalizer;
this:finish();
do return this; end
end),
["finishUnaryExpression"] = (function (this, operator, argument)
this.type = (function() if ((function() local _lev=(operator == "++"); return _bool(_lev) and _lev or (operator == "--") end)()) then return Syntax.UpdateExpression; else return Syntax.UnaryExpression; end end)();
this.operator = operator;
this.argument = argument;
this.prefix = true;
this:finish();
do return this; end
end),
["finishVariableDeclaration"] = (function (this, declarations)
this.type = Syntax.VariableDeclaration;
this.declarations = declarations;
this.kind = "var";
this:finish();
do return this; end
end),
["finishLexicalDeclaration"] = (function (this, declarations, kind)
this.type = Syntax.VariableDeclaration;
this.declarations = declarations;
this.kind = kind;
this:finish();
do return this; end
end),
["finishVariableDeclarator"] = (function (this, id, init)
this.type = Syntax.VariableDeclarator;
this.id = id;
this.init = init;
this:finish();
do return this; end
end),
["finishWhileStatement"] = (function (this, test, body)
this.type = Syntax.WhileStatement;
this.test = test;
this.body = body;
this:finish();
do return this; end
end),
["finishWithStatement"] = (function (this, object, body)
this.type = Syntax.WithStatement;
this.object = object;
this.body = body;
this:finish();
do return this; end
end),
["finishExportSpecifier"] = (function (this, _g_local, exported)
this.type = Syntax.ExportSpecifier;
this.exported = (_bool(exported) and exported or _g_local);
this["local"] = _g_local;
this:finish();
do return this; end
end),
["finishImportDefaultSpecifier"] = (function (this, _g_local)
this.type = Syntax.ImportDefaultSpecifier;
this["local"] = _g_local;
this:finish();
do return this; end
end),
["finishImportNamespaceSpecifier"] = (function (this, _g_local)
this.type = Syntax.ImportNamespaceSpecifier;
this["local"] = _g_local;
this:finish();
do return this; end
end),
["finishExportNamedDeclaration"] = (function (this, declaration, specifiers, src)
this.type = Syntax.ExportNamedDeclaration;
this.declaration = declaration;
this.specifiers = specifiers;
this.source = src;
this:finish();
do return this; end
end),
["finishExportDefaultDeclaration"] = (function (this, declaration)
this.type = Syntax.ExportDefaultDeclaration;
this.declaration = declaration;
this:finish();
do return this; end
end),
["finishExportAllDeclaration"] = (function (this, src)
this.type = Syntax.ExportAllDeclaration;
this.source = src;
this:finish();
do return this; end
end),
["finishImportSpecifier"] = (function (this, _g_local, imported)
this.type = Syntax.ImportSpecifier;
this["local"] = (_bool(_g_local) and _g_local or imported);
this.imported = imported;
this:finish();
do return this; end
end),
["finishImportDeclaration"] = (function (this, specifiers, src)
this.type = Syntax.ImportDeclaration;
this.specifiers = specifiers;
this.source = src;
this:finish();
do return this; end
end),
["finishYieldExpression"] = (function (this, argument, delegate)
this.type = Syntax.YieldExpression;
this.argument = argument;
this.delegate = delegate;
this:finish();
do return this; end
end)
}); return Node.prototype end)();
exports.version = "2.7.3";
exports.tokenize = tokenize;
exports.parse = parse;
exports.Syntax = (function (this)
local types,name;
types = _obj({});
if (_type(Object.create) == "function") then
types = Object:create(null);
end

local _p = _props(Syntax, true);
for _,name in _ipairs(_p) do
name = _tostr(name);
if _bool(Syntax:hasOwnProperty(name)) then
types[name] = Syntax[name];
end
::_continue::
end

if (_type(Object.freeze) == "function") then
Object:freeze(types);
end

do return types; end
end)(_ENV);
end));
if exports ~= nil then
    return exports
elseif this.esprima ~= nil then
    return this.esprima
else
    _throw("Error while loading lua version of Esprima")
end
end, _ENV)();
