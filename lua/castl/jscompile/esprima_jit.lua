local _ENV = require("castl.runtime");
return setfenv(function(...)
(function (this, root, factory)
if _bool(((function() if (_type(define) == "function") then return define.amd;  else return (_type(define) == "function");  end end)())) then
define(_ENV,_arr({[0]="exports"},1),factory);
elseif (_type(exports) ~= "undefined") then
factory(_ENV,exports);
else
factory(_ENV,(function () root.esprima = _obj({}); return root.esprima end)());
end

end)(_ENV,this,(function (this, exports)
local parse,tokenize,filterTokenLocation,parseProgram,parseSourceElements,parseSourceElement,parseFunctionExpression,parseFunctionDeclaration,parseParams,parseFunctionSourceElements,parseStatement,parseDebuggerStatement,parseTryStatement,parseCatchClause,parseThrowStatement,parseSwitchStatement,parseSwitchCase,parseWithStatement,parseReturnStatement,parseBreakStatement,parseContinueStatement,parseForStatement,parseForVariableDeclaration,parseWhileStatement,parseDoWhileStatement,parseIfStatement,parseExpressionStatement,parseEmptyStatement,parseConstLetDeclaration,parseVariableStatement,parseVariableDeclarationList,parseVariableDeclaration,parseVariableIdentifier,parseBlock,parseStatementList,parseExpression,parseAssignmentExpression,parseConditionalExpression,parseBinaryExpression,binaryPrecedence,parseUnaryExpression,parsePostfixExpression,parseLeftHandSideExpression,parseLeftHandSideExpressionAllowCall,parseNewExpression,parseComputedMember,parseNonComputedMember,parseNonComputedProperty,parseArguments,parsePrimaryExpression,parseGroupExpression,parseObjectInitialiser,parseObjectProperty,parseObjectPropertyKey,parsePropertyFunction,parseArrayInitialiser,isLeftHandSide,consumeSemicolon,matchAssign,matchKeyword,match,expectKeyword,expect,throwUnexpected,throwErrorTolerant,throwError,peekLineTerminator,SourceLocation,Position,peek,lex,collectToken,advance,advanceSlash,isIdentifierName,collectRegex,scanRegExp,scanRegExpFlags,scanRegExpBody,testRegExp,scanStringLiteral,scanNumericLiteral,scanOctalLiteral,scanHexLiteral,scanPunctuator,scanIdentifier,getIdentifier,getEscapedIdentifier,scanHexEscape,skipComment,skipMultiLineComment,skipSingleLineComment,addComment,isKeyword,isRestrictedWord,isStrictModeReservedWord,isFutureReservedWord,isIdentifierPart,isIdentifierStart,isLineTerminator,isWhiteSpace,isOctalDigit,isHexDigit,isDecimalDigit,assert,extra,state,lookahead,delegate,length,lineStart,lineNumber,index,strict,source,SyntaxTreeDelegate,Regex,Messages,PropertyKind,Syntax,FnExprTokens,TokenName,Token;
assert = (function (this, condition, message)
if not _bool(condition) then
_throw(_new(Error,(_addStr1("ASSERT: ",message))),0)
end

end);
isDecimalDigit = (function (this, ch)
do return ((function() if (_ge(ch,48)) then return (_le(ch,57));  else return (_ge(ch,48));  end end)()); end
end);
isHexDigit = (function (this, ch)
do return (_ge(("0123456789abcdefABCDEF"):indexOf(ch),0)); end
end);
isOctalDigit = (function (this, ch)
do return (_ge(("01234567"):indexOf(ch),0)); end
end);
isWhiteSpace = (function (this, ch)
do return ((((((ch == 32) and (ch == 32) or (ch == 9)) and ((ch == 32) and (ch == 32) or (ch == 9)) or (ch == 11)) and (((ch == 32) and (ch == 32) or (ch == 9)) and ((ch == 32) and (ch == 32) or (ch == 9)) or (ch == 11)) or (ch == 12)) and ((((ch == 32) and (ch == 32) or (ch == 9)) and ((ch == 32) and (ch == 32) or (ch == 9)) or (ch == 11)) and (((ch == 32) and (ch == 32) or (ch == 9)) and ((ch == 32) and (ch == 32) or (ch == 9)) or (ch == 11)) or (ch == 12)) or (ch == 160)) and (((((ch == 32) and (ch == 32) or (ch == 9)) and ((ch == 32) and (ch == 32) or (ch == 9)) or (ch == 11)) and (((ch == 32) and (ch == 32) or (ch == 9)) and ((ch == 32) and (ch == 32) or (ch == 9)) or (ch == 11)) or (ch == 12)) and ((((ch == 32) and (ch == 32) or (ch == 9)) and ((ch == 32) and (ch == 32) or (ch == 9)) or (ch == 11)) and (((ch == 32) and (ch == 32) or (ch == 9)) and ((ch == 32) and (ch == 32) or (ch == 9)) or (ch == 11)) or (ch == 12)) or (ch == 160)) or ((function() if (_ge(ch,5760)) then return (_ge(_arr({[0]=5760,6158,8192,8193,8194,8195,8196,8197,8198,8199,8200,8201,8202,8239,8287,12288,65279},17):indexOf(ch),0));  else return (_ge(ch,5760));  end end)())); end
end);
isLineTerminator = (function (this, ch)
do return ((((ch == 10) and (ch == 10) or (ch == 13)) and ((ch == 10) and (ch == 10) or (ch == 13)) or (ch == 8232)) and (((ch == 10) and (ch == 10) or (ch == 13)) and ((ch == 10) and (ch == 10) or (ch == 13)) or (ch == 8232)) or (ch == 8233)); end
end);
isIdentifierStart = (function (this, ch)
do return ((((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) and ((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) or (ch == 92)) and (((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) and ((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) or (ch == 92)) or ((function() if (_ge(ch,128)) then return Regex.NonAsciiIdentifierStart:test(String:fromCharCode(ch));  else return (_ge(ch,128));  end end)())); end
end);
isIdentifierPart = (function (this, ch)
do return (((((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) and ((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) or ((function() if (_ge(ch,48)) then return (_le(ch,57));  else return (_ge(ch,48));  end end)())) and (((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) and ((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) or ((function() if (_ge(ch,48)) then return (_le(ch,57));  else return (_ge(ch,48));  end end)())) or (ch == 92)) and ((((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) and ((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) or ((function() if (_ge(ch,48)) then return (_le(ch,57));  else return (_ge(ch,48));  end end)())) and (((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) and ((((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) and (((ch == 36) and (ch == 36) or (ch == 95)) and ((ch == 36) and (ch == 36) or (ch == 95)) or ((function() if (_ge(ch,65)) then return (_le(ch,90));  else return (_ge(ch,65));  end end)())) or ((function() if (_ge(ch,97)) then return (_le(ch,122));  else return (_ge(ch,97));  end end)())) or ((function() if (_ge(ch,48)) then return (_le(ch,57));  else return (_ge(ch,48));  end end)())) or (ch == 92)) or ((function() if (_ge(ch,128)) then return Regex.NonAsciiIdentifierPart:test(String:fromCharCode(ch));  else return (_ge(ch,128));  end end)())); end
end);
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
end);
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
end);
isRestrictedWord = (function (this, id)
do return ((id == "eval") and (id == "eval") or (id == "arguments")); end
end);
isKeyword = (function (this, id)
if _bool(((function() if _bool(strict) then return isStrictModeReservedWord(_ENV,id);  else return strict;  end end)())) then
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
do return (((id == "if") and (id == "if") or (id == "in")) and ((id == "if") and (id == "if") or (id == "in")) or (id == "do")); end
_into = true;
end
if _into or (id.length == 3) then
do return (((((id == "var") and (id == "var") or (id == "for")) and ((id == "var") and (id == "var") or (id == "for")) or (id == "new")) and (((id == "var") and (id == "var") or (id == "for")) and ((id == "var") and (id == "var") or (id == "for")) or (id == "new")) or (id == "try")) and ((((id == "var") and (id == "var") or (id == "for")) and ((id == "var") and (id == "var") or (id == "for")) or (id == "new")) and (((id == "var") and (id == "var") or (id == "for")) and ((id == "var") and (id == "var") or (id == "for")) or (id == "new")) or (id == "try")) or (id == "let")); end
_into = true;
end
if _into or (id.length == 4) then
do return ((((((id == "this") and (id == "this") or (id == "else")) and ((id == "this") and (id == "this") or (id == "else")) or (id == "case")) and (((id == "this") and (id == "this") or (id == "else")) and ((id == "this") and (id == "this") or (id == "else")) or (id == "case")) or (id == "void")) and ((((id == "this") and (id == "this") or (id == "else")) and ((id == "this") and (id == "this") or (id == "else")) or (id == "case")) and (((id == "this") and (id == "this") or (id == "else")) and ((id == "this") and (id == "this") or (id == "else")) or (id == "case")) or (id == "void")) or (id == "with")) and (((((id == "this") and (id == "this") or (id == "else")) and ((id == "this") and (id == "this") or (id == "else")) or (id == "case")) and (((id == "this") and (id == "this") or (id == "else")) and ((id == "this") and (id == "this") or (id == "else")) or (id == "case")) or (id == "void")) and ((((id == "this") and (id == "this") or (id == "else")) and ((id == "this") and (id == "this") or (id == "else")) or (id == "case")) and (((id == "this") and (id == "this") or (id == "else")) and ((id == "this") and (id == "this") or (id == "else")) or (id == "case")) or (id == "void")) or (id == "with")) or (id == "enum")); end
_into = true;
end
if _into or (id.length == 5) then
do return ((((((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) and ((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) or (id == "const")) and (((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) and ((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) or (id == "const")) or (id == "yield")) and ((((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) and ((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) or (id == "const")) and (((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) and ((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) or (id == "const")) or (id == "yield")) or (id == "class")) and (((((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) and ((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) or (id == "const")) and (((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) and ((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) or (id == "const")) or (id == "yield")) and ((((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) and ((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) or (id == "const")) and (((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) and ((((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) and (((id == "while") and (id == "while") or (id == "break")) and ((id == "while") and (id == "while") or (id == "break")) or (id == "catch")) or (id == "throw")) or (id == "const")) or (id == "yield")) or (id == "class")) or (id == "super")); end
_into = true;
end
if _into or (id.length == 6) then
do return ((((((id == "return") and (id == "return") or (id == "typeof")) and ((id == "return") and (id == "return") or (id == "typeof")) or (id == "delete")) and (((id == "return") and (id == "return") or (id == "typeof")) and ((id == "return") and (id == "return") or (id == "typeof")) or (id == "delete")) or (id == "switch")) and ((((id == "return") and (id == "return") or (id == "typeof")) and ((id == "return") and (id == "return") or (id == "typeof")) or (id == "delete")) and (((id == "return") and (id == "return") or (id == "typeof")) and ((id == "return") and (id == "return") or (id == "typeof")) or (id == "delete")) or (id == "switch")) or (id == "export")) and (((((id == "return") and (id == "return") or (id == "typeof")) and ((id == "return") and (id == "return") or (id == "typeof")) or (id == "delete")) and (((id == "return") and (id == "return") or (id == "typeof")) and ((id == "return") and (id == "return") or (id == "typeof")) or (id == "delete")) or (id == "switch")) and ((((id == "return") and (id == "return") or (id == "typeof")) and ((id == "return") and (id == "return") or (id == "typeof")) or (id == "delete")) and (((id == "return") and (id == "return") or (id == "typeof")) and ((id == "return") and (id == "return") or (id == "typeof")) or (id == "delete")) or (id == "switch")) or (id == "export")) or (id == "import")); end
_into = true;
end
if _into or (id.length == 7) then
do return (((id == "default") and (id == "default") or (id == "finally")) and ((id == "default") and (id == "default") or (id == "finally")) or (id == "extends")); end
_into = true;
end
if _into or (id.length == 8) then
do return (((id == "function") and (id == "function") or (id == "continue")) and ((id == "function") and (id == "function") or (id == "continue")) or (id == "debugger")); end
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
end);
addComment = (function (this, type, value, start, _g_end, loc)
local attacher,comment;
assert(_ENV,(_type(start) == "number"),"Comment must have valid position");
if (_ge(state.lastCommentStart,start)) then
do return end
end

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
index = index + 1;
if _bool(isLineTerminator(_ENV,ch)) then
if _bool(extra.comments) then
comment = source:slice((_add(start,offset)),(index - 1));
loc["end"] = _obj({
["line"] = lineNumber,
["column"] = ((index - lineStart) - 1)
});
addComment(_ENV,"Line",comment,start,(index - 1),loc);
end

if ((function() if (ch == 13) then return (source:charCodeAt(index) == 10);  else return (ch == 13);  end end)()) then
index = index + 1;
end

lineNumber = lineNumber + 1;
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
if ((function() if (ch == 13) then return (source:charCodeAt((_addNum2(index,1))) == 10);  else return (ch == 13);  end end)()) then
index = index + 1;
end

lineNumber = lineNumber + 1;
index = index + 1;
lineStart = index;
if (_ge(index,length)) then
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
end

elseif (ch == 42) then
if (source:charCodeAt((_addNum2(index,1))) == 47) then
index = index + 1;
index = index + 1;
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

index = index + 1;
else
index = index + 1;
end

::_continue::
end

throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
end);
skipComment = (function (this)
local start,ch;
start = (index == 0);
while (_lt(index,length)) do
ch = source:charCodeAt(index);
if _bool(isWhiteSpace(_ENV,ch)) then
index = index + 1;
elseif _bool(isLineTerminator(_ENV,ch)) then
index = index + 1;
if ((function() if (ch == 13) then return (source:charCodeAt(index) == 10);  else return (ch == 13);  end end)()) then
index = index + 1;
end

lineNumber = lineNumber + 1;
lineStart = index;
start = true;
elseif (ch == 47) then
ch = source:charCodeAt((_addNum2(index,1)));
if (ch == 47) then
index = index + 1;
index = index + 1;
skipSingleLineComment(_ENV,2);
start = true;
elseif (ch == 42) then
index = index + 1;
index = index + 1;
skipMultiLineComment(_ENV);
else
do break end;
end

elseif _bool(((function() if _bool(start) then return (ch == 45);  else return start;  end end)())) then
if ((function() if (source:charCodeAt((_addNum2(index,1))) == 45) then return (source:charCodeAt((_addNum2(index,2))) == 62);  else return (source:charCodeAt((_addNum2(index,1))) == 45);  end end)()) then
index = (_addNum2(index,3));
skipSingleLineComment(_ENV,3);
else
do break end;
end

elseif (ch == 60) then
if (source:slice((_addNum2(index,1)),(_addNum2(index,4))) == "!--") then
index = index + 1;
index = index + 1;
index = index + 1;
index = index + 1;
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
if _bool(((function() if (_lt(index,length)) then return isHexDigit(_ENV,source[index]);  else return (_lt(index,length));  end end)())) then
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
code = (_addNum1((code * 16),("0123456789abcdef"):indexOf(ch:toLowerCase())));
else
do return ""; end
end

i = i + 1;
end

do return String:fromCharCode(code); end
end);
getEscapedIdentifier = (function (this)
local id,ch;
ch = source:charCodeAt((function () local _tmp = index; index = _inc(_tmp); return _tmp; end)());
id = String:fromCharCode(ch);
if (ch == 92) then
if (source:charCodeAt(index) ~= 117) then
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
end

index = index + 1;
ch = scanHexEscape(_ENV,"u");
if ((not _bool(ch) and not _bool(ch) or (ch == "\\")) and (not _bool(ch) and not _bool(ch) or (ch == "\\")) or not _bool(isIdentifierStart(_ENV,ch:charCodeAt(0)))) then
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
end

id = ch;
end

while (_lt(index,length)) do
ch = source:charCodeAt(index);
if not _bool(isIdentifierPart(_ENV,ch)) then
do break end;
end

index = index + 1;
id = (_add(id,String:fromCharCode(ch)));
if (ch == 92) then
id = id:substr(0,(id.length - 1));
if (source:charCodeAt(index) ~= 117) then
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
end

index = index + 1;
ch = scanHexEscape(_ENV,"u");
if ((not _bool(ch) and not _bool(ch) or (ch == "\\")) and (not _bool(ch) and not _bool(ch) or (ch == "\\")) or not _bool(isIdentifierPart(_ENV,ch:charCodeAt(0)))) then
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
end

id = (_add(id,ch));
end

::_continue::
end

do return id; end
end);
getIdentifier = (function (this)
local ch,start;
start = (function () local _tmp = index; index = _tmp + 1; return _tmp; end)();
while (_lt(index,length)) do
ch = source:charCodeAt(index);
if (ch == 92) then
index = start;
do return getEscapedIdentifier(_ENV); end
end

if _bool(isIdentifierPart(_ENV,ch)) then
index = index + 1;
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
id = (function() if (source:charCodeAt(index) == 92) then return getEscapedIdentifier(_ENV); else return getIdentifier(_ENV); end end)();
if (id.length == 1) then
type = Token.Identifier;
elseif _bool(isKeyword(_ENV,id)) then
type = Token.Keyword;
elseif (id == "null") then
type = Token.NullLiteral;
elseif ((id == "true") and (id == "true") or (id == "false")) then
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
index = index + 1;
if _bool(extra.tokenize) then
if (code == 40) then
extra.openParenToken = extra.tokens.length;
elseif (code == 123) then
extra.openCurlyToken = extra.tokens.length;
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
code2 = source:charCodeAt((_addNum2(index,1)));
if (code2 == 61) then
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
index = (_addNum2(index,2));
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
index = (_addNum2(index,2));
if (source:charCodeAt(index) == 61) then
index = index + 1;
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
ch4 = source:substr(index,4);
if (ch4 == ">>>=") then
index = (_addNum2(index,4));
do return _obj({
["type"] = Token.Punctuator,
["value"] = ch4,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end

ch3 = ch4:substr(0,3);
if (((ch3 == ">>>") and (ch3 == ">>>") or (ch3 == "<<=")) and ((ch3 == ">>>") and (ch3 == ">>>") or (ch3 == "<<=")) or (ch3 == ">>=")) then
index = (_addNum2(index,3));
do return _obj({
["type"] = Token.Punctuator,
["value"] = ch3,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end

ch2 = ch3:substr(0,2);
if (((function() if (ch1 == ch2[1]) then return (_ge(("+-<>&|"):indexOf(ch1),0));  else return (ch1 == ch2[1]);  end end)()) and ((function() if (ch1 == ch2[1]) then return (_ge(("+-<>&|"):indexOf(ch1),0));  else return (ch1 == ch2[1]);  end end)()) or (ch2 == "=>")) then
index = (_addNum2(index,2));
do return _obj({
["type"] = Token.Punctuator,
["value"] = ch2,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end

if (_ge(("<>=!+-*%&|^/"):indexOf(ch1),0)) then
index = index + 1;
do return _obj({
["type"] = Token.Punctuator,
["value"] = ch1,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = start,
["end"] = index
}); end
end

throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
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
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
end

if _bool(isIdentifierStart(_ENV,source:charCodeAt(index))) then
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
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
scanOctalLiteral = (function (this, start)
local number;
number = (_addStr1("0",source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
while (_lt(index,length)) do
if not _bool(isOctalDigit(_ENV,source[index])) then
do break end;
end

number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

if _bool((_bool(isIdentifierStart(_ENV,source:charCodeAt(index))) and isIdentifierStart(_ENV,source:charCodeAt(index)) or isDecimalDigit(_ENV,source:charCodeAt(index)))) then
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
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
end);
scanNumericLiteral = (function (this)
local ch,start,number;
ch = source[index];
assert(_ENV,(_bool(isDecimalDigit(_ENV,ch:charCodeAt(0))) and isDecimalDigit(_ENV,ch:charCodeAt(0)) or (ch == ".")),"Numeric literal must start with a decimal digit or a decimal point");
start = index;
number = "";
if (ch ~= ".") then
number = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
ch = source[index];
if (number == "0") then
if ((ch == "x") and (ch == "x") or (ch == "X")) then
index = index + 1;
do return scanHexLiteral(_ENV,start); end
end

if _bool(isOctalDigit(_ENV,ch)) then
do return scanOctalLiteral(_ENV,start); end
end

if _bool(((function() if _bool(ch) then return isDecimalDigit(_ENV,ch:charCodeAt(0));  else return ch;  end end)())) then
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
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

if ((ch == "e") and (ch == "e") or (ch == "E")) then
number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
ch = source[index];
if ((ch == "+") and (ch == "+") or (ch == "-")) then
number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
end

if _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) then
while _bool(isDecimalDigit(_ENV,source:charCodeAt(index))) do
number = (_add(number,source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()]));
::_continue::
end

else
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
end

end

if _bool(isIdentifierStart(_ENV,source:charCodeAt(index))) then
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
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
local startLineStart,startLineNumber,octal,restore,unescaped,code,ch,start,quote,str;
str = "";
octal = false;
startLineNumber = lineNumber;
startLineStart = lineStart;
quote = source[index];
assert(_ENV,((quote == "'") and (quote == "'") or (quote == "\"")),"String literal must starts with a quote");
start = index;
index = index + 1;
while (_lt(index,length)) do
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
if (ch == quote) then
quote = "";
do break end;
elseif (ch == "\\") then
ch = source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()];
if (not _bool(ch) and not _bool(ch) or not _bool(isLineTerminator(_ENV,ch:charCodeAt(0)))) then
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
restore = index;
unescaped = scanHexEscape(_ENV,ch);
if _bool(unescaped) then
str = (_add(str,unescaped));
else
index = restore;
str = (_add(str,ch));
end

do break end;
_into = true;
end
if _into or (ch == "n") then
str = (_addStr2(str,"\010"));
do break end;
_into = true;
end
if _into or (ch == "r") then
str = (_addStr2(str,"\013"));
do break end;
_into = true;
end
if _into or (ch == "t") then
str = (_addStr2(str,"\009"));
do break end;
_into = true;
end
if _into or (ch == "b") then
str = (_addStr2(str,"\008"));
do break end;
_into = true;
end
if _into or (ch == "f") then
str = (_addStr2(str,"\012"));
do break end;
_into = true;
end
if _into or (ch == "v") then
str = (_addStr2(str,"\011"));
do break end;
_into = true;
end
::_default::
if _into then
if _bool(isOctalDigit(_ENV,ch)) then
code = ("01234567"):indexOf(ch);
if (code ~= 0) then
octal = true;
end

if _bool(((function() if (_lt(index,length)) then return isOctalDigit(_ENV,source[index]);  else return (_lt(index,length));  end end)())) then
octal = true;
code = (_addNum1((code * 8),("01234567"):indexOf(source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()])));
if _bool(((function() if ((function() if (_ge(("0123"):indexOf(ch),0)) then return (_lt(index,length));  else return (_ge(("0123"):indexOf(ch),0));  end end)()) then return isOctalDigit(_ENV,source[index]);  else return ((function() if (_ge(("0123"):indexOf(ch),0)) then return (_lt(index,length));  else return (_ge(("0123"):indexOf(ch),0));  end end)());  end end)())) then
code = (_addNum1((code * 8),("01234567"):indexOf(source[(function () local _tmp = index; index = _inc(_tmp); return _tmp; end)()])));
end

end

str = (_add(str,String:fromCharCode(code)));
else
str = (_add(str,ch));
end

do break end;
_into = true;
end
until true
else
lineNumber = lineNumber + 1;
if ((function() if (ch == "\013") then return (source[index] == "\010");  else return (ch == "\013");  end end)()) then
index = index + 1;
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
throwError(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
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
end);
testRegExp = (function (this, pattern, flags)
local value;
local _status, _return = _pcall(function()
value = _new(RegExp,pattern,flags);
end);
if not _status then
local _cstatus, _creturn = _pcall(function()
local e = _return;
throwError(_ENV,_obj({}),Messages.InvalidRegExp);
end);
if _cstatus then
else _throw(_creturn,0); end
end

do return value; end
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
throwError(_ENV,_obj({}),Messages.UnterminatedRegExp);
end

str = (_add(str,ch));
elseif _bool(isLineTerminator(_ENV,ch:charCodeAt(0))) then
throwError(_ENV,_obj({}),Messages.UnterminatedRegExp);
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
throwError(_ENV,_obj({}),Messages.UnterminatedRegExp);
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

index = index + 1;
if ((function() if (ch == "\\") then return (_lt(index,length));  else return (ch == "\\");  end end)()) then
ch = source[index];
if (ch == "u") then
index = index + 1;
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

throwErrorTolerant(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
else
str = (_addStr2(str,"\\"));
throwErrorTolerant(_ENV,_obj({}),Messages.UnexpectedToken,"ILLEGAL");
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
local value,pattern,flags,body,start;
lookahead = null;
skipComment(_ENV);
start = index;
body = scanRegExpBody(_ENV);
flags = scanRegExpFlags(_ENV);
value = testRegExp(_ENV,body.value,flags.value);
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
if ((function() if (token.range[0] == pos) then return (token.type == "Punctuator");  else return (token.range[0] == pos);  end end)()) then
if ((token.value == "/") and (token.value == "/") or (token.value == "/=")) then
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
end);
isIdentifierName = (function (this, token)
do return ((((token.type == Token.Identifier) and (token.type == Token.Identifier) or (token.type == Token.Keyword)) and ((token.type == Token.Identifier) and (token.type == Token.Identifier) or (token.type == Token.Keyword)) or (token.type == Token.BooleanLiteral)) and (((token.type == Token.Identifier) and (token.type == Token.Identifier) or (token.type == Token.Keyword)) and ((token.type == Token.Identifier) and (token.type == Token.Identifier) or (token.type == Token.Keyword)) or (token.type == Token.BooleanLiteral)) or (token.type == Token.NullLiteral)); end
end);
advanceSlash = (function (this)
local checkToken,prevToken;
prevToken = extra.tokens[(extra.tokens.length - 1)];
if not _bool(prevToken) then
do return collectRegex(_ENV); end
end

if (prevToken.type == "Punctuator") then
if (prevToken.value == "]") then
do return scanPunctuator(_ENV); end
end

if (prevToken.value == ")") then
checkToken = extra.tokens[(extra.openParenToken - 1)];
if _bool(((function() if _bool(((function() if _bool(checkToken) then return (checkToken.type == "Keyword");  else return checkToken;  end end)())) then return ((((checkToken.value == "if") and (checkToken.value == "if") or (checkToken.value == "while")) and ((checkToken.value == "if") and (checkToken.value == "if") or (checkToken.value == "while")) or (checkToken.value == "for")) and (((checkToken.value == "if") and (checkToken.value == "if") or (checkToken.value == "while")) and ((checkToken.value == "if") and (checkToken.value == "if") or (checkToken.value == "while")) or (checkToken.value == "for")) or (checkToken.value == "with"));  else return ((function() if _bool(checkToken) then return (checkToken.type == "Keyword");  else return checkToken;  end end)());  end end)())) then
do return collectRegex(_ENV); end
end

do return scanPunctuator(_ENV); end
end

if (prevToken.value == "}") then
if _bool(((function() if _bool(extra.tokens[(extra.openCurlyToken - 3)]) then return (extra.tokens[(extra.openCurlyToken - 3)].type == "Keyword");  else return extra.tokens[(extra.openCurlyToken - 3)];  end end)())) then
checkToken = extra.tokens[(extra.openCurlyToken - 4)];
if not _bool(checkToken) then
do return scanPunctuator(_ENV); end
end

elseif _bool(((function() if _bool(extra.tokens[(extra.openCurlyToken - 4)]) then return (extra.tokens[(extra.openCurlyToken - 4)].type == "Keyword");  else return extra.tokens[(extra.openCurlyToken - 4)];  end end)())) then
checkToken = extra.tokens[(extra.openCurlyToken - 5)];
if not _bool(checkToken) then
do return collectRegex(_ENV); end
end

else
do return scanPunctuator(_ENV); end
end

if (_ge(FnExprTokens:indexOf(checkToken.value),0)) then
do return scanPunctuator(_ENV); end
end

do return collectRegex(_ENV); end
end

do return collectRegex(_ENV); end
end

if (prevToken.type == "Keyword") then
do return collectRegex(_ENV); end
end

do return scanPunctuator(_ENV); end
end);
advance = (function (this)
local ch;
skipComment(_ENV);
if (_ge(index,length)) then
do return _obj({
["type"] = Token.EOF,
["lineNumber"] = lineNumber,
["lineStart"] = lineStart,
["start"] = index,
["end"] = index
}); end
end

ch = source:charCodeAt(index);
if _bool(isIdentifierStart(_ENV,ch)) then
do return scanIdentifier(_ENV); end
end

if (((ch == 40) and (ch == 40) or (ch == 41)) and ((ch == 40) and (ch == 40) or (ch == 41)) or (ch == 59)) then
do return scanPunctuator(_ENV); end
end

if ((ch == 39) and (ch == 39) or (ch == 34)) then
do return scanStringLiteral(_ENV); end
end

if (ch == 46) then
if _bool(isDecimalDigit(_ENV,source:charCodeAt((_addNum2(index,1))))) then
do return scanNumericLiteral(_ENV); end
end

do return scanPunctuator(_ENV); end
end

if _bool(isDecimalDigit(_ENV,ch)) then
do return scanNumericLiteral(_ENV); end
end

if _bool(((function() if _bool(extra.tokenize) then return (ch == 47);  else return extra.tokenize;  end end)())) then
do return advanceSlash(_ENV); end
end

do return scanPunctuator(_ENV); end
end);
collectToken = (function (this)
local value,range,token,loc;
skipComment(_ENV);
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
extra.tokens:push(_obj({
["type"] = TokenName[token.type],
["value"] = value,
["range"] = _arr({[0]=token.start,token["end"]},2),
["loc"] = loc
}));
end

do return token; end
end);
lex = (function (this)
local token;
token = lookahead;
index = token["end"];
lineNumber = token.lineNumber;
lineStart = token.lineStart;
lookahead = (function() if (_type(extra.tokens) ~= "undefined") then return collectToken(_ENV); else return advance(_ENV); end end)();
index = token["end"];
lineNumber = token.lineNumber;
lineStart = token.lineStart;
do return token; end
end);
peek = (function (this)
local start,line,pos;
pos = index;
line = lineNumber;
start = lineStart;
lookahead = (function() if (_type(extra.tokens) ~= "undefined") then return collectToken(_ENV); else return advance(_ENV); end end)();
index = pos;
lineNumber = line;
lineStart = start;
end);
Position = (function (this, line, column)
this.line = line;
this.column = column;
end);
SourceLocation = (function (this, startLine, startColumn, line, column)
this.start = _new(Position,startLine,startColumn);
this["end"] = _new(Position,line,column);
end);
peekLineTerminator = (function (this)
local found,start,line,pos;
pos = index;
line = lineNumber;
start = lineStart;
skipComment(_ENV);
found = (lineNumber ~= line);
index = pos;
lineNumber = line;
lineStart = start;
do return found; end
end);
throwError = (function (...)
local this, token, messageFormat = ...;
local arguments = _args(...);
local msg,args,error;
args = Array.prototype.slice:call(arguments,2);
msg = messageFormat:replace(_regexp("%(\\d)","g"),(function (this, whole, index)
assert(_ENV,(_lt(index,args.length)),"Message reference must be in range");
do return args[index]; end
end));
if (_type(token.lineNumber) == "number") then
error = _new(SyntaxError,(_addStr1(((_addStr1("Line ",token.lineNumber)) .. ": "),msg)));
error.index = token.start;
error.lineNumber = token.lineNumber;
error.column = ((token.start - lineStart) + 1);
else
error = _new(SyntaxError,(_addStr1(((_addStr1("Line ",lineNumber)) .. ": "),msg)));
error.index = index;
error.lineNumber = lineNumber;
error.column = ((index - lineStart) + 1);
end

error.description = msg;
_throw(error,0)
end);
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

end);
throwUnexpected = (function (this, token)
if (token.type == Token.EOF) then
throwError(_ENV,token,Messages.UnexpectedEOS);
end

if (token.type == Token.NumericLiteral) then
throwError(_ENV,token,Messages.UnexpectedNumber);
end

if (token.type == Token.StringLiteral) then
throwError(_ENV,token,Messages.UnexpectedString);
end

if (token.type == Token.Identifier) then
throwError(_ENV,token,Messages.UnexpectedIdentifier);
end

if (token.type == Token.Keyword) then
if _bool(isFutureReservedWord(_ENV,token.value)) then
throwError(_ENV,token,Messages.UnexpectedReserved);
elseif _bool(((function() if _bool(strict) then return isStrictModeReservedWord(_ENV,token.value);  else return strict;  end end)())) then
throwErrorTolerant(_ENV,token,Messages.StrictReservedWord);
do return end
end

throwError(_ENV,token,Messages.UnexpectedToken,token.value);
end

throwError(_ENV,token,Messages.UnexpectedToken,token.value);
end);
expect = (function (this, value)
local token;
token = lex(_ENV);
if ((token.type ~= Token.Punctuator) and (token.type ~= Token.Punctuator) or (token.value ~= value)) then
throwUnexpected(_ENV,token);
end

end);
expectKeyword = (function (this, keyword)
local token;
token = lex(_ENV);
if ((token.type ~= Token.Keyword) and (token.type ~= Token.Keyword) or (token.value ~= keyword)) then
throwUnexpected(_ENV,token);
end

end);
match = (function (this, value)
do return ((function() if (lookahead.type == Token.Punctuator) then return (lookahead.value == value);  else return (lookahead.type == Token.Punctuator);  end end)()); end
end);
matchKeyword = (function (this, keyword)
do return ((function() if (lookahead.type == Token.Keyword) then return (lookahead.value == keyword);  else return (lookahead.type == Token.Keyword);  end end)()); end
end);
matchAssign = (function (this)
local op;
if (lookahead.type ~= Token.Punctuator) then
do return false; end
end

op = lookahead.value;
do return ((((((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) and ((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) or (op == ">>>=")) and (((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) and ((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) or (op == ">>>=")) or (op == "&=")) and ((((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) and ((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) or (op == ">>>=")) and (((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) and ((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) or (op == ">>>=")) or (op == "&=")) or (op == "^=")) and (((((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) and ((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) or (op == ">>>=")) and (((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) and ((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) or (op == ">>>=")) or (op == "&=")) and ((((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) and ((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) or (op == ">>>=")) and (((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) and ((((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) and (((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) and ((((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) and (((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) and ((((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) and (((op == "=") and (op == "=") or (op == "*=")) and ((op == "=") and (op == "=") or (op == "*=")) or (op == "/=")) or (op == "%=")) or (op == "+=")) or (op == "-=")) or (op == "<<=")) or (op == ">>=")) or (op == ">>>=")) or (op == "&=")) or (op == "^=")) or (op == "|=")); end
end);
consumeSemicolon = (function (this)
local line;
if _bool(((source:charCodeAt(index) == 59) and (source:charCodeAt(index) == 59) or match(_ENV,";"))) then
lex(_ENV);
do return end
end

line = lineNumber;
skipComment(_ENV);
if (lineNumber ~= line) then
do return end
end

if ((function() if (lookahead.type ~= Token.EOF) then return not _bool(match(_ENV,"}"));  else return (lookahead.type ~= Token.EOF);  end end)()) then
throwUnexpected(_ENV,lookahead);
end

end);
isLeftHandSide = (function (this, expr)
do return ((expr.type == Syntax.Identifier) and (expr.type == Syntax.Identifier) or (expr.type == Syntax.MemberExpression)); end
end);
parseArrayInitialiser = (function (this)
local startToken,elements;
elements = _arr({},0);
startToken = lookahead;
expect(_ENV,"[");
while not _bool(match(_ENV,"]")) do
if _bool(match(_ENV,",")) then
lex(_ENV);
elements:push(null);
else
elements:push(parseAssignmentExpression(_ENV));
if not _bool(match(_ENV,"]")) then
expect(_ENV,",");
end

end

::_continue::
end

lex(_ENV);
do return delegate:markEnd(delegate:createArrayExpression(elements),startToken); end
end);
parsePropertyFunction = (function (this, param, first)
local startToken,body,previousStrict;
previousStrict = strict;
startToken = lookahead;
body = parseFunctionSourceElements(_ENV);
if _bool(((function() if _bool(((function() if _bool(first) then return strict;  else return first;  end end)())) then return isRestrictedWord(_ENV,param[0].name);  else return ((function() if _bool(first) then return strict;  else return first;  end end)());  end end)())) then
throwErrorTolerant(_ENV,first,Messages.StrictParamName);
end

strict = previousStrict;
do return delegate:markEnd(delegate:createFunctionExpression(null,param,_arr({},0),body),startToken); end
end);
parseObjectPropertyKey = (function (this)
local startToken,token;
startToken = lookahead;
token = lex(_ENV);
if ((token.type == Token.StringLiteral) and (token.type == Token.StringLiteral) or (token.type == Token.NumericLiteral)) then
if _bool(((function() if _bool(strict) then return token.octal;  else return strict;  end end)())) then
throwErrorTolerant(_ENV,token,Messages.StrictOctalLiteral);
end

do return delegate:markEnd(delegate:createLiteral(token),startToken); end
end

do return delegate:markEnd(delegate:createIdentifier(token.value),startToken); end
end);
parseObjectProperty = (function (this)
local startToken,param,value,id,key,token;
token = lookahead;
startToken = lookahead;
if (token.type == Token.Identifier) then
id = parseObjectPropertyKey(_ENV);
if ((function() if (token.value == "get") then return not _bool(match(_ENV,":"));  else return (token.value == "get");  end end)()) then
key = parseObjectPropertyKey(_ENV);
expect(_ENV,"(");
expect(_ENV,")");
value = parsePropertyFunction(_ENV,_arr({},0));
do return delegate:markEnd(delegate:createProperty("get",key,value),startToken); end
end

if ((function() if (token.value == "set") then return not _bool(match(_ENV,":"));  else return (token.value == "set");  end end)()) then
key = parseObjectPropertyKey(_ENV);
expect(_ENV,"(");
token = lookahead;
if (token.type ~= Token.Identifier) then
expect(_ENV,")");
throwErrorTolerant(_ENV,token,Messages.UnexpectedToken,token.value);
value = parsePropertyFunction(_ENV,_arr({},0));
else
param = _arr({[0]=parseVariableIdentifier(_ENV)},1);
expect(_ENV,")");
value = parsePropertyFunction(_ENV,param,token);
end

do return delegate:markEnd(delegate:createProperty("set",key,value),startToken); end
end

expect(_ENV,":");
value = parseAssignmentExpression(_ENV);
do return delegate:markEnd(delegate:createProperty("init",id,value),startToken); end
end

if ((token.type == Token.EOF) and (token.type == Token.EOF) or (token.type == Token.Punctuator)) then
throwUnexpected(_ENV,token);
else
key = parseObjectPropertyKey(_ENV);
expect(_ENV,":");
value = parseAssignmentExpression(_ENV);
do return delegate:markEnd(delegate:createProperty("init",key,value),startToken); end
end

end);
parseObjectInitialiser = (function (this)
local startToken,toString,map,kind,key,name,property,properties;
properties = _arr({},0);
map = _obj({});
toString = String;
startToken = lookahead;
expect(_ENV,"{");
while not _bool(match(_ENV,"}")) do
property = parseObjectProperty(_ENV);
if (property.key.type == Syntax.Identifier) then
name = property.key.name;
else
name = toString(_ENV,property.key.value);
end

kind = (function() if (property.kind == "init") then return PropertyKind.Data; else return (function() if (property.kind == "get") then return PropertyKind.Get; else return PropertyKind.Set; end end)(); end end)();
key = (_addStr1("$",name));
if _bool(Object.prototype.hasOwnProperty:call(map,key)) then
if (map[key] == PropertyKind.Data) then
if _bool(((function() if _bool(strict) then return (kind == PropertyKind.Data);  else return strict;  end end)())) then
throwErrorTolerant(_ENV,_obj({}),Messages.StrictDuplicateProperty);
elseif (kind ~= PropertyKind.Data) then
throwErrorTolerant(_ENV,_obj({}),Messages.AccessorDataProperty);
end

else
if (kind == PropertyKind.Data) then
throwErrorTolerant(_ENV,_obj({}),Messages.AccessorDataProperty);
elseif _bool((_band(map[key],kind))) then
throwErrorTolerant(_ENV,_obj({}),Messages.AccessorGetSet);
end

end

do local _cp = key; map[_cp] = (_bor(map[_cp],kind)) end;
else
map[key] = kind;
end

properties:push(property);
if not _bool(match(_ENV,"}")) then
expect(_ENV,",");
end

::_continue::
end

expect(_ENV,"}");
do return delegate:markEnd(delegate:createObjectExpression(properties),startToken); end
end);
parseGroupExpression = (function (this)
local expr;
expect(_ENV,"(");
expr = parseExpression(_ENV);
expect(_ENV,")");
do return expr; end
end);
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

type = lookahead.type;
startToken = lookahead;
if (type == Token.Identifier) then
expr = delegate:createIdentifier(lex(_ENV).value);
elseif ((type == Token.StringLiteral) and (type == Token.StringLiteral) or (type == Token.NumericLiteral)) then
if _bool(((function() if _bool(strict) then return lookahead.octal;  else return strict;  end end)())) then
throwErrorTolerant(_ENV,lookahead,Messages.StrictOctalLiteral);
end

expr = delegate:createLiteral(lex(_ENV));
elseif (type == Token.Keyword) then
if _bool(matchKeyword(_ENV,"function")) then
do return parseFunctionExpression(_ENV); end
end

if _bool(matchKeyword(_ENV,"this")) then
lex(_ENV);
expr = delegate:createThisExpression();
else
throwUnexpected(_ENV,lex(_ENV));
end

elseif (type == Token.BooleanLiteral) then
token = lex(_ENV);
token.value = (token.value == "true");
expr = delegate:createLiteral(token);
elseif (type == Token.NullLiteral) then
token = lex(_ENV);
token.value = null;
expr = delegate:createLiteral(token);
elseif _bool((_bool(match(_ENV,"/")) and match(_ENV,"/") or match(_ENV,"/="))) then
if (_type(extra.tokens) ~= "undefined") then
expr = delegate:createLiteral(collectRegex(_ENV));
else
expr = delegate:createLiteral(scanRegExp(_ENV));
end

peek(_ENV);
else
throwUnexpected(_ENV,lex(_ENV));
end

do return delegate:markEnd(expr,startToken); end
end);
parseArguments = (function (this)
local args;
args = _arr({},0);
expect(_ENV,"(");
if not _bool(match(_ENV,")")) then
while (_lt(index,length)) do
args:push(parseAssignmentExpression(_ENV));
if _bool(match(_ENV,")")) then
do break end;
end

expect(_ENV,",");
::_continue::
end

end

expect(_ENV,")");
do return args; end
end);
parseNonComputedProperty = (function (this)
local startToken,token;
startToken = lookahead;
token = lex(_ENV);
if not _bool(isIdentifierName(_ENV,token)) then
throwUnexpected(_ENV,token);
end

do return delegate:markEnd(delegate:createIdentifier(token.value),startToken); end
end);
parseNonComputedMember = (function (this)
expect(_ENV,".");
do return parseNonComputedProperty(_ENV); end
end);
parseComputedMember = (function (this)
local expr;
expect(_ENV,"[");
expr = parseExpression(_ENV);
expect(_ENV,"]");
do return expr; end
end);
parseNewExpression = (function (this)
local startToken,args,callee;
startToken = lookahead;
expectKeyword(_ENV,"new");
callee = parseLeftHandSideExpression(_ENV);
args = (function() if _bool(match(_ENV,"(")) then return parseArguments(_ENV); else return _arr({},0); end end)();
do return delegate:markEnd(delegate:createNewExpression(callee,args),startToken); end
end);
parseLeftHandSideExpressionAllowCall = (function (this)
local startToken,property,args,expr,previousAllowIn;
startToken = lookahead;
previousAllowIn = state.allowIn;
state.allowIn = true;
expr = (function() if _bool(matchKeyword(_ENV,"new")) then return parseNewExpression(_ENV); else return parsePrimaryExpression(_ENV); end end)();
state.allowIn = previousAllowIn;
while true do
if _bool(match(_ENV,".")) then
property = parseNonComputedMember(_ENV);
expr = delegate:createMemberExpression(".",expr,property);
elseif _bool(match(_ENV,"(")) then
args = parseArguments(_ENV);
expr = delegate:createCallExpression(expr,args);
elseif _bool(match(_ENV,"[")) then
property = parseComputedMember(_ENV);
expr = delegate:createMemberExpression("[",expr,property);
else
do break end;
end

delegate:markEnd(expr,startToken);
end

do return expr; end
end);
parseLeftHandSideExpression = (function (this)
local startToken,property,expr,previousAllowIn;
startToken = lookahead;
previousAllowIn = state.allowIn;
expr = (function() if _bool(matchKeyword(_ENV,"new")) then return parseNewExpression(_ENV); else return parsePrimaryExpression(_ENV); end end)();
state.allowIn = previousAllowIn;
while _bool((_bool(match(_ENV,".")) and match(_ENV,".") or match(_ENV,"["))) do
if _bool(match(_ENV,"[")) then
property = parseComputedMember(_ENV);
expr = delegate:createMemberExpression("[",expr,property);
else
property = parseNonComputedMember(_ENV);
expr = delegate:createMemberExpression(".",expr,property);
end

delegate:markEnd(expr,startToken);
::_continue::
end

do return expr; end
end);
parsePostfixExpression = (function (this)
local startToken,token,expr;
startToken = lookahead;
expr = parseLeftHandSideExpressionAllowCall(_ENV);
if (lookahead.type == Token.Punctuator) then
if _bool(((function() if _bool((_bool(match(_ENV,"++")) and match(_ENV,"++") or match(_ENV,"--"))) then return not _bool(peekLineTerminator(_ENV));  else return (_bool(match(_ENV,"++")) and match(_ENV,"++") or match(_ENV,"--"));  end end)())) then
if _bool(((function() if _bool(((function() if _bool(strict) then return (expr.type == Syntax.Identifier);  else return strict;  end end)())) then return isRestrictedWord(_ENV,expr.name);  else return ((function() if _bool(strict) then return (expr.type == Syntax.Identifier);  else return strict;  end end)());  end end)())) then
throwErrorTolerant(_ENV,_obj({}),Messages.StrictLHSPostfix);
end

if not _bool(isLeftHandSide(_ENV,expr)) then
throwErrorTolerant(_ENV,_obj({}),Messages.InvalidLHSInAssignment);
end

token = lex(_ENV);
expr = delegate:markEnd(delegate:createPostfixExpression(token.value,expr),startToken);
end

end

do return expr; end
end);
parseUnaryExpression = (function (this)
local startToken,expr,token;
if ((function() if (lookahead.type ~= Token.Punctuator) then return (lookahead.type ~= Token.Keyword);  else return (lookahead.type ~= Token.Punctuator);  end end)()) then
expr = parsePostfixExpression(_ENV);
elseif _bool((_bool(match(_ENV,"++")) and match(_ENV,"++") or match(_ENV,"--"))) then
startToken = lookahead;
token = lex(_ENV);
expr = parseUnaryExpression(_ENV);
if _bool(((function() if _bool(((function() if _bool(strict) then return (expr.type == Syntax.Identifier);  else return strict;  end end)())) then return isRestrictedWord(_ENV,expr.name);  else return ((function() if _bool(strict) then return (expr.type == Syntax.Identifier);  else return strict;  end end)());  end end)())) then
throwErrorTolerant(_ENV,_obj({}),Messages.StrictLHSPrefix);
end

if not _bool(isLeftHandSide(_ENV,expr)) then
throwErrorTolerant(_ENV,_obj({}),Messages.InvalidLHSInAssignment);
end

expr = delegate:createUnaryExpression(token.value,expr);
expr = delegate:markEnd(expr,startToken);
elseif _bool((_bool((_bool((_bool(match(_ENV,"+")) and match(_ENV,"+") or match(_ENV,"-"))) and (_bool(match(_ENV,"+")) and match(_ENV,"+") or match(_ENV,"-")) or match(_ENV,"~"))) and (_bool((_bool(match(_ENV,"+")) and match(_ENV,"+") or match(_ENV,"-"))) and (_bool(match(_ENV,"+")) and match(_ENV,"+") or match(_ENV,"-")) or match(_ENV,"~")) or match(_ENV,"!"))) then
startToken = lookahead;
token = lex(_ENV);
expr = parseUnaryExpression(_ENV);
expr = delegate:createUnaryExpression(token.value,expr);
expr = delegate:markEnd(expr,startToken);
elseif _bool((_bool((_bool(matchKeyword(_ENV,"delete")) and matchKeyword(_ENV,"delete") or matchKeyword(_ENV,"void"))) and (_bool(matchKeyword(_ENV,"delete")) and matchKeyword(_ENV,"delete") or matchKeyword(_ENV,"void")) or matchKeyword(_ENV,"typeof"))) then
startToken = lookahead;
token = lex(_ENV);
expr = parseUnaryExpression(_ENV);
expr = delegate:createUnaryExpression(token.value,expr);
expr = delegate:markEnd(expr,startToken);
if _bool(((function() if _bool(((function() if _bool(strict) then return (expr.operator == "delete");  else return strict;  end end)())) then return (expr.argument.type == Syntax.Identifier);  else return ((function() if _bool(strict) then return (expr.operator == "delete");  else return strict;  end end)());  end end)())) then
throwErrorTolerant(_ENV,_obj({}),Messages.StrictDelete);
end

else
expr = parsePostfixExpression(_ENV);
end

do return expr; end
end);
binaryPrecedence = (function (this, token, allowIn)
local prec;
prec = 0;
if ((function() if (token.type ~= Token.Punctuator) then return (token.type ~= Token.Keyword);  else return (token.type ~= Token.Punctuator);  end end)()) then
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
prec = 1;
do break end;
_into = true;
end
if _into or (token.value == "&&") then
prec = 2;
do break end;
_into = true;
end
if _into or (token.value == "|") then
prec = 3;
do break end;
_into = true;
end
if _into or (token.value == "^") then
prec = 4;
do break end;
_into = true;
end
if _into or (token.value == "&") then
prec = 5;
do break end;
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
prec = 6;
do break end;
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
prec = 7;
do break end;
_into = true;
end
if _into or (token.value == "in") then
prec = (function() if _bool(allowIn) then return 7; else return 0; end end)();
do break end;
_into = true;
end
if _into or (token.value == "<<") then

_into = true;
end
if _into or (token.value == ">>") then

_into = true;
end
if _into or (token.value == ">>>") then
prec = 8;
do break end;
_into = true;
end
if _into or (token.value == "+") then

_into = true;
end
if _into or (token.value == "-") then
prec = 9;
do break end;
_into = true;
end
if _into or (token.value == "*") then

_into = true;
end
if _into or (token.value == "/") then

_into = true;
end
if _into or (token.value == "%") then
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
left = parseUnaryExpression(_ENV);
token = lookahead;
prec = binaryPrecedence(_ENV,token,state.allowIn);
if (prec == 0) then
do return left; end
end

token.prec = prec;
lex(_ENV);
markers = _arr({[0]=marker,lookahead},2);
right = parseUnaryExpression(_ENV);
stack = _arr({[0]=left,token,right},3);
while (_gt((function () prec = binaryPrecedence(_ENV,lookahead,state.allowIn); return prec end)(),0)) do
while ((function() if (_gt(stack.length,2)) then return (_le(prec,stack[(stack.length - 2)].prec));  else return (_gt(stack.length,2));  end end)()) do
right = stack:pop();
operator = stack:pop().value;
left = stack:pop();
expr = delegate:createBinaryExpression(operator,left,right);
markers:pop();
marker = markers[(markers.length - 1)];
delegate:markEnd(expr,marker);
stack:push(expr);
::_continue::
end

token = lex(_ENV);
token.prec = prec;
stack:push(token);
markers:push(lookahead);
expr = parseUnaryExpression(_ENV);
stack:push(expr);
::_continue::
end

i = (stack.length - 1);
expr = stack[i];
markers:pop();
while (_gt(i,1)) do
expr = delegate:createBinaryExpression(stack[(i - 1)].value,stack[(i - 2)],expr);
i = (i - 2);
marker = markers:pop();
delegate:markEnd(expr,marker);
::_continue::
end

do return expr; end
end);
parseConditionalExpression = (function (this)
local startToken,alternate,consequent,previousAllowIn,expr;
startToken = lookahead;
expr = parseBinaryExpression(_ENV);
if _bool(match(_ENV,"?")) then
lex(_ENV);
previousAllowIn = state.allowIn;
state.allowIn = true;
consequent = parseAssignmentExpression(_ENV);
state.allowIn = previousAllowIn;
expect(_ENV,":");
alternate = parseAssignmentExpression(_ENV);
expr = delegate:createConditionalExpression(expr,consequent,alternate);
delegate:markEnd(expr,startToken);
end

do return expr; end
end);
parseAssignmentExpression = (function (this)
local startToken,node,right,left,token;
token = lookahead;
startToken = lookahead;
node = (function () left = parseConditionalExpression(_ENV); return left end)();
if _bool(matchAssign(_ENV)) then
if not _bool(isLeftHandSide(_ENV,left)) then
throwErrorTolerant(_ENV,_obj({}),Messages.InvalidLHSInAssignment);
end

if _bool(((function() if _bool(((function() if _bool(strict) then return (left.type == Syntax.Identifier);  else return strict;  end end)())) then return isRestrictedWord(_ENV,left.name);  else return ((function() if _bool(strict) then return (left.type == Syntax.Identifier);  else return strict;  end end)());  end end)())) then
throwErrorTolerant(_ENV,token,Messages.StrictLHSAssignment);
end

token = lex(_ENV);
right = parseAssignmentExpression(_ENV);
node = delegate:markEnd(delegate:createAssignmentExpression(token.value,left,right),startToken);
end

do return node; end
end);
parseExpression = (function (this)
local startToken,expr;
startToken = lookahead;
expr = parseAssignmentExpression(_ENV);
if _bool(match(_ENV,",")) then
expr = delegate:createSequenceExpression(_arr({[0]=expr},1));
while (_lt(index,length)) do
if not _bool(match(_ENV,",")) then
do break end;
end

lex(_ENV);
expr.expressions:push(parseAssignmentExpression(_ENV));
::_continue::
end

delegate:markEnd(expr,startToken);
end

do return expr; end
end);
parseStatementList = (function (this)
local statement,list;
list = _arr({},0);
while (_lt(index,length)) do
if _bool(match(_ENV,"}")) then
do break end;
end

statement = parseSourceElement(_ENV);
if (_type(statement) == "undefined") then
do break end;
end

list:push(statement);
::_continue::
end

do return list; end
end);
parseBlock = (function (this)
local startToken,block;
startToken = lookahead;
expect(_ENV,"{");
block = parseStatementList(_ENV);
expect(_ENV,"}");
do return delegate:markEnd(delegate:createBlockStatement(block),startToken); end
end);
parseVariableIdentifier = (function (this)
local startToken,token;
startToken = lookahead;
token = lex(_ENV);
if (token.type ~= Token.Identifier) then
throwUnexpected(_ENV,token);
end

do return delegate:markEnd(delegate:createIdentifier(token.value),startToken); end
end);
parseVariableDeclaration = (function (this, kind)
local startToken,id,init;
init = null;
startToken = lookahead;
id = parseVariableIdentifier(_ENV);
if _bool(((function() if _bool(strict) then return isRestrictedWord(_ENV,id.name);  else return strict;  end end)())) then
throwErrorTolerant(_ENV,_obj({}),Messages.StrictVarName);
end

if (kind == "const") then
expect(_ENV,"=");
init = parseAssignmentExpression(_ENV);
elseif _bool(match(_ENV,"=")) then
lex(_ENV);
init = parseAssignmentExpression(_ENV);
end

do return delegate:markEnd(delegate:createVariableDeclarator(id,init),startToken); end
end);
parseVariableDeclarationList = (function (this, kind)
local list;
list = _arr({},0);
repeat
list:push(parseVariableDeclaration(_ENV,kind));
if not _bool(match(_ENV,",")) then
do break end;
end

lex(_ENV);
::_continue::
until not (_lt(index,length))

do return list; end
end);
parseVariableStatement = (function (this)
local declarations;
expectKeyword(_ENV,"var");
declarations = parseVariableDeclarationList(_ENV);
consumeSemicolon(_ENV);
do return delegate:createVariableDeclaration(declarations,"var"); end
end);
parseConstLetDeclaration = (function (this, kind)
local startToken,declarations;
startToken = lookahead;
expectKeyword(_ENV,kind);
declarations = parseVariableDeclarationList(_ENV,kind);
consumeSemicolon(_ENV);
do return delegate:markEnd(delegate:createVariableDeclaration(declarations,kind),startToken); end
end);
parseEmptyStatement = (function (this)
expect(_ENV,";");
do return delegate:createEmptyStatement(); end
end);
parseExpressionStatement = (function (this)
local expr;
expr = parseExpression(_ENV);
consumeSemicolon(_ENV);
do return delegate:createExpressionStatement(expr); end
end);
parseIfStatement = (function (this)
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

do return delegate:createIfStatement(test,consequent,alternate); end
end);
parseDoWhileStatement = (function (this)
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

do return delegate:createDoWhileStatement(body,test); end
end);
parseWhileStatement = (function (this)
local oldInIteration,body,test;
expectKeyword(_ENV,"while");
expect(_ENV,"(");
test = parseExpression(_ENV);
expect(_ENV,")");
oldInIteration = state.inIteration;
state.inIteration = true;
body = parseStatement(_ENV);
state.inIteration = oldInIteration;
do return delegate:createWhileStatement(test,body); end
end);
parseForVariableDeclaration = (function (this)
local startToken,declarations,token;
startToken = lookahead;
token = lex(_ENV);
declarations = parseVariableDeclarationList(_ENV);
do return delegate:markEnd(delegate:createVariableDeclaration(declarations,token.value),startToken); end
end);
parseForStatement = (function (this)
local oldInIteration,body,right,left,update,test,init;
init = (function () test = (function () update = null; return update end)(); return test end)();
expectKeyword(_ENV,"for");
expect(_ENV,"(");
if _bool(match(_ENV,";")) then
lex(_ENV);
else
if _bool((_bool(matchKeyword(_ENV,"var")) and matchKeyword(_ENV,"var") or matchKeyword(_ENV,"let"))) then
state.allowIn = false;
init = parseForVariableDeclaration(_ENV);
state.allowIn = true;
if _bool(((function() if (init.declarations.length == 1) then return matchKeyword(_ENV,"in");  else return (init.declarations.length == 1);  end end)())) then
lex(_ENV);
left = init;
right = parseExpression(_ENV);
init = null;
end

else
state.allowIn = false;
init = parseExpression(_ENV);
state.allowIn = true;
if _bool(matchKeyword(_ENV,"in")) then
if not _bool(isLeftHandSide(_ENV,init)) then
throwErrorTolerant(_ENV,_obj({}),Messages.InvalidLHSInForIn);
end

lex(_ENV);
left = init;
right = parseExpression(_ENV);
init = null;
end

end

if (_type(left) == "undefined") then
expect(_ENV,";");
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
body = parseStatement(_ENV);
state.inIteration = oldInIteration;
do return (function() if (_type(left) == "undefined") then return delegate:createForStatement(init,test,update,body); else return delegate:createForInStatement(left,right,body); end end)(); end
end);
parseContinueStatement = (function (this)
local key,label;
label = null;
expectKeyword(_ENV,"continue");
if (source:charCodeAt(index) == 59) then
lex(_ENV);
if not _bool(state.inIteration) then
throwError(_ENV,_obj({}),Messages.IllegalContinue);
end

do return delegate:createContinueStatement(null); end
end

if _bool(peekLineTerminator(_ENV)) then
if not _bool(state.inIteration) then
throwError(_ENV,_obj({}),Messages.IllegalContinue);
end

do return delegate:createContinueStatement(null); end
end

if (lookahead.type == Token.Identifier) then
label = parseVariableIdentifier(_ENV);
key = (_addStr1("$",label.name));
if not _bool(Object.prototype.hasOwnProperty:call(state.labelSet,key)) then
throwError(_ENV,_obj({}),Messages.UnknownLabel,label.name);
end

end

consumeSemicolon(_ENV);
if ((function() if (label == null) then return not _bool(state.inIteration);  else return (label == null);  end end)()) then
throwError(_ENV,_obj({}),Messages.IllegalContinue);
end

do return delegate:createContinueStatement(label); end
end);
parseBreakStatement = (function (this)
local key,label;
label = null;
expectKeyword(_ENV,"break");
if (source:charCodeAt(index) == 59) then
lex(_ENV);
if not _bool((_bool(state.inIteration) and state.inIteration or state.inSwitch)) then
throwError(_ENV,_obj({}),Messages.IllegalBreak);
end

do return delegate:createBreakStatement(null); end
end

if _bool(peekLineTerminator(_ENV)) then
if not _bool((_bool(state.inIteration) and state.inIteration or state.inSwitch)) then
throwError(_ENV,_obj({}),Messages.IllegalBreak);
end

do return delegate:createBreakStatement(null); end
end

if (lookahead.type == Token.Identifier) then
label = parseVariableIdentifier(_ENV);
key = (_addStr1("$",label.name));
if not _bool(Object.prototype.hasOwnProperty:call(state.labelSet,key)) then
throwError(_ENV,_obj({}),Messages.UnknownLabel,label.name);
end

end

consumeSemicolon(_ENV);
if ((function() if (label == null) then return not _bool((_bool(state.inIteration) and state.inIteration or state.inSwitch));  else return (label == null);  end end)()) then
throwError(_ENV,_obj({}),Messages.IllegalBreak);
end

do return delegate:createBreakStatement(label); end
end);
parseReturnStatement = (function (this)
local argument;
argument = null;
expectKeyword(_ENV,"return");
if not _bool(state.inFunctionBody) then
throwErrorTolerant(_ENV,_obj({}),Messages.IllegalReturn);
end

if (source:charCodeAt(index) == 32) then
if _bool(isIdentifierStart(_ENV,source:charCodeAt((_addNum2(index,1))))) then
argument = parseExpression(_ENV);
consumeSemicolon(_ENV);
do return delegate:createReturnStatement(argument); end
end

end

if _bool(peekLineTerminator(_ENV)) then
do return delegate:createReturnStatement(null); end
end

if not _bool(match(_ENV,";")) then
if ((function() if not _bool(match(_ENV,"}")) then return (lookahead.type ~= Token.EOF);  else return not _bool(match(_ENV,"}"));  end end)()) then
argument = parseExpression(_ENV);
end

end

consumeSemicolon(_ENV);
do return delegate:createReturnStatement(argument); end
end);
parseWithStatement = (function (this)
local body,object;
if _bool(strict) then
skipComment(_ENV);
throwErrorTolerant(_ENV,_obj({}),Messages.StrictModeWith);
end

expectKeyword(_ENV,"with");
expect(_ENV,"(");
object = parseExpression(_ENV);
expect(_ENV,")");
body = parseStatement(_ENV);
do return delegate:createWithStatement(object,body); end
end);
parseSwitchCase = (function (this)
local startToken,statement,consequent,test;
consequent = _arr({},0);
startToken = lookahead;
if _bool(matchKeyword(_ENV,"default")) then
lex(_ENV);
test = null;
else
expectKeyword(_ENV,"case");
test = parseExpression(_ENV);
end

expect(_ENV,":");
while (_lt(index,length)) do
if _bool((_bool((_bool(match(_ENV,"}")) and match(_ENV,"}") or matchKeyword(_ENV,"default"))) and (_bool(match(_ENV,"}")) and match(_ENV,"}") or matchKeyword(_ENV,"default")) or matchKeyword(_ENV,"case"))) then
do break end;
end

statement = parseStatement(_ENV);
consequent:push(statement);
::_continue::
end

do return delegate:markEnd(delegate:createSwitchCase(test,consequent),startToken); end
end);
parseSwitchStatement = (function (this)
local defaultFound,oldInSwitch,clause,cases,discriminant;
expectKeyword(_ENV,"switch");
expect(_ENV,"(");
discriminant = parseExpression(_ENV);
expect(_ENV,")");
expect(_ENV,"{");
cases = _arr({},0);
if _bool(match(_ENV,"}")) then
lex(_ENV);
do return delegate:createSwitchStatement(discriminant,cases); end
end

oldInSwitch = state.inSwitch;
state.inSwitch = true;
defaultFound = false;
while (_lt(index,length)) do
if _bool(match(_ENV,"}")) then
do break end;
end

clause = parseSwitchCase(_ENV);
if (clause.test == null) then
if _bool(defaultFound) then
throwError(_ENV,_obj({}),Messages.MultipleDefaultsInSwitch);
end

defaultFound = true;
end

cases:push(clause);
::_continue::
end

state.inSwitch = oldInSwitch;
expect(_ENV,"}");
do return delegate:createSwitchStatement(discriminant,cases); end
end);
parseThrowStatement = (function (this)
local argument;
expectKeyword(_ENV,"throw");
if _bool(peekLineTerminator(_ENV)) then
throwError(_ENV,_obj({}),Messages.NewlineAfterThrow);
end

argument = parseExpression(_ENV);
consumeSemicolon(_ENV);
do return delegate:createThrowStatement(argument); end
end);
parseCatchClause = (function (this)
local startToken,body,param;
startToken = lookahead;
expectKeyword(_ENV,"catch");
expect(_ENV,"(");
if _bool(match(_ENV,")")) then
throwUnexpected(_ENV,lookahead);
end

param = parseVariableIdentifier(_ENV);
if _bool(((function() if _bool(strict) then return isRestrictedWord(_ENV,param.name);  else return strict;  end end)())) then
throwErrorTolerant(_ENV,_obj({}),Messages.StrictCatchVariable);
end

expect(_ENV,")");
body = parseBlock(_ENV);
do return delegate:markEnd(delegate:createCatchClause(param,body),startToken); end
end);
parseTryStatement = (function (this)
local finalizer,handlers,block;
handlers = _arr({},0);
finalizer = null;
expectKeyword(_ENV,"try");
block = parseBlock(_ENV);
if _bool(matchKeyword(_ENV,"catch")) then
handlers:push(parseCatchClause(_ENV));
end

if _bool(matchKeyword(_ENV,"finally")) then
lex(_ENV);
finalizer = parseBlock(_ENV);
end

if ((function() if (handlers.length == 0) then return not _bool(finalizer);  else return (handlers.length == 0);  end end)()) then
throwError(_ENV,_obj({}),Messages.NoCatchOrFinally);
end

do return delegate:createTryStatement(block,_arr({},0),handlers,finalizer); end
end);
parseDebuggerStatement = (function (this)
expectKeyword(_ENV,"debugger");
consumeSemicolon(_ENV);
do return delegate:createDebuggerStatement(); end
end);
parseStatement = (function (this)
local startToken,key,labeledBody,expr,type;
type = lookahead.type;
if (type == Token.EOF) then
throwUnexpected(_ENV,lookahead);
end

if ((function() if (type == Token.Punctuator) then return (lookahead.value == "{");  else return (type == Token.Punctuator);  end end)()) then
do return parseBlock(_ENV); end
end

startToken = lookahead;
if (type == Token.Punctuator) then
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
do break end;
_into = true;
end
until true
end

if (type == Token.Keyword) then
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
do break end;
_into = true;
end
until true
end

expr = parseExpression(_ENV);
if _bool(((function() if (expr.type == Syntax.Identifier) then return match(_ENV,":");  else return (expr.type == Syntax.Identifier);  end end)())) then
lex(_ENV);
key = (_addStr1("$",expr.name));
if _bool(Object.prototype.hasOwnProperty:call(state.labelSet,key)) then
throwError(_ENV,_obj({}),Messages.Redeclaration,"Label",expr.name);
end

state.labelSet[key] = true;
labeledBody = parseStatement(_ENV);
(function () local _r = false; local _g, _s = state.labelSet["_g" .. key], state.labelSet["_s" .. key]; state.labelSet["_g" .. key], state.labelSet["_s" .. key] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = state.labelSet[key]; state.labelSet[key] = nil; return _r or _v ~= nil; end)();
do return delegate:markEnd(delegate:createLabeledStatement(expr,labeledBody),startToken); end
end

consumeSemicolon(_ENV);
do return delegate:markEnd(delegate:createExpressionStatement(expr),startToken); end
end);
parseFunctionSourceElements = (function (this)
local startToken,oldInFunctionBody,oldInSwitch,oldInIteration,oldLabelSet,firstRestricted,directive,token,sourceElements,sourceElement;
sourceElements = _arr({},0);
startToken = lookahead;
expect(_ENV,"{");
while (_lt(index,length)) do
if (lookahead.type ~= Token.StringLiteral) then
do break end;
end

token = lookahead;
sourceElement = parseSourceElement(_ENV);
sourceElements:push(sourceElement);
if (sourceElement.expression.type ~= Syntax.Literal) then
do break end;
end

directive = source:slice((_addNum2(token.start,1)),(token["end"] - 1));
if (directive == "use strict") then
strict = true;
if _bool(firstRestricted) then
throwErrorTolerant(_ENV,firstRestricted,Messages.StrictOctalLiteral);
end

else
if _bool(((function() if not _bool(firstRestricted) then return token.octal;  else return not _bool(firstRestricted);  end end)())) then
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
while (_lt(index,length)) do
if _bool(match(_ENV,"}")) then
do break end;
end

sourceElement = parseSourceElement(_ENV);
if (_type(sourceElement) == "undefined") then
do break end;
end

sourceElements:push(sourceElement);
::_continue::
end

expect(_ENV,"}");
state.labelSet = oldLabelSet;
state.inIteration = oldInIteration;
state.inSwitch = oldInSwitch;
state.inFunctionBody = oldInFunctionBody;
do return delegate:markEnd(delegate:createBlockStatement(sourceElements),startToken); end
end);
parseParams = (function (this, firstRestricted)
local message,key,paramSet,stricted,token,params,param;
params = _arr({},0);
expect(_ENV,"(");
if not _bool(match(_ENV,")")) then
paramSet = _obj({});
while (_lt(index,length)) do
token = lookahead;
param = parseVariableIdentifier(_ENV);
key = (_addStr1("$",token.value));
if _bool(strict) then
if _bool(isRestrictedWord(_ENV,token.value)) then
stricted = token;
message = Messages.StrictParamName;
end

if _bool(Object.prototype.hasOwnProperty:call(paramSet,key)) then
stricted = token;
message = Messages.StrictParamDupe;
end

elseif not _bool(firstRestricted) then
if _bool(isRestrictedWord(_ENV,token.value)) then
firstRestricted = token;
message = Messages.StrictParamName;
elseif _bool(isStrictModeReservedWord(_ENV,token.value)) then
firstRestricted = token;
message = Messages.StrictReservedWord;
elseif _bool(Object.prototype.hasOwnProperty:call(paramSet,key)) then
firstRestricted = token;
message = Messages.StrictParamDupe;
end

end

params:push(param);
paramSet[key] = true;
if _bool(match(_ENV,")")) then
do break end;
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
end);
parseFunctionDeclaration = (function (this)
local startToken,previousStrict,message,firstRestricted,tmp,stricted,token,body,params,id;
params = _arr({},0);
startToken = lookahead;
expectKeyword(_ENV,"function");
token = lookahead;
id = parseVariableIdentifier(_ENV);
if _bool(strict) then
if _bool(isRestrictedWord(_ENV,token.value)) then
throwErrorTolerant(_ENV,token,Messages.StrictFunctionName);
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

tmp = parseParams(_ENV,firstRestricted);
params = tmp.params;
stricted = tmp.stricted;
firstRestricted = tmp.firstRestricted;
if _bool(tmp.message) then
message = tmp.message;
end

previousStrict = strict;
body = parseFunctionSourceElements(_ENV);
if _bool(((function() if _bool(strict) then return firstRestricted;  else return strict;  end end)())) then
throwError(_ENV,firstRestricted,message);
end

if _bool(((function() if _bool(strict) then return stricted;  else return strict;  end end)())) then
throwErrorTolerant(_ENV,stricted,message);
end

strict = previousStrict;
do return delegate:markEnd(delegate:createFunctionDeclaration(id,params,_arr({},0),body),startToken); end
end);
parseFunctionExpression = (function (this)
local startToken,previousStrict,body,params,tmp,message,firstRestricted,stricted,id,token;
id = null;
params = _arr({},0);
startToken = lookahead;
expectKeyword(_ENV,"function");
if not _bool(match(_ENV,"(")) then
token = lookahead;
id = parseVariableIdentifier(_ENV);
if _bool(strict) then
if _bool(isRestrictedWord(_ENV,token.value)) then
throwErrorTolerant(_ENV,token,Messages.StrictFunctionName);
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
stricted = tmp.stricted;
firstRestricted = tmp.firstRestricted;
if _bool(tmp.message) then
message = tmp.message;
end

previousStrict = strict;
body = parseFunctionSourceElements(_ENV);
if _bool(((function() if _bool(strict) then return firstRestricted;  else return strict;  end end)())) then
throwError(_ENV,firstRestricted,message);
end

if _bool(((function() if _bool(strict) then return stricted;  else return strict;  end end)())) then
throwErrorTolerant(_ENV,stricted,message);
end

strict = previousStrict;
do return delegate:markEnd(delegate:createFunctionExpression(id,params,_arr({},0),body),startToken); end
end);
parseSourceElement = (function (this)
if (lookahead.type == Token.Keyword) then
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

if (lookahead.type ~= Token.EOF) then
do return parseStatement(_ENV); end
end

end);
parseSourceElements = (function (this)
local firstRestricted,directive,token,sourceElements,sourceElement;
sourceElements = _arr({},0);
while (_lt(index,length)) do
token = lookahead;
if (token.type ~= Token.StringLiteral) then
do break end;
end

sourceElement = parseSourceElement(_ENV);
sourceElements:push(sourceElement);
if (sourceElement.expression.type ~= Syntax.Literal) then
do break end;
end

directive = source:slice((_addNum2(token.start,1)),(token["end"] - 1));
if (directive == "use strict") then
strict = true;
if _bool(firstRestricted) then
throwErrorTolerant(_ENV,firstRestricted,Messages.StrictOctalLiteral);
end

else
if _bool(((function() if not _bool(firstRestricted) then return token.octal;  else return not _bool(firstRestricted);  end end)())) then
firstRestricted = token;
end

end

::_continue::
end

while (_lt(index,length)) do
sourceElement = parseSourceElement(_ENV);
if (_type(sourceElement) == "undefined") then
do break end;
end

sourceElements:push(sourceElement);
::_continue::
end

do return sourceElements; end
end);
parseProgram = (function (this)
local startToken,body;
skipComment(_ENV);
peek(_ENV);
startToken = lookahead;
strict = false;
body = parseSourceElements(_ENV);
do return delegate:markEnd(delegate:createProgram(body),startToken); end
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
tokenize = (function (this, code, options)
local tokens,token,toString;
toString = String;
if ((function() if (_type(code) ~= "string") then return not (_instanceof(code,String));  else return (_type(code) ~= "string");  end end)()) then
code = toString(_ENV,code);
end

delegate = SyntaxTreeDelegate;
source = code;
index = 0;
lineNumber = (function() if (_gt(source.length,0)) then return 1; else return 0; end end)();
lineStart = 0;
length = source.length;
lookahead = null;
state = _obj({
["allowIn"] = true,
["labelSet"] = _obj({}),
["inFunctionBody"] = false,
["inIteration"] = false,
["inSwitch"] = false,
["lastCommentStart"] = -1
});
extra = _obj({});
options = (_bool(options) and options or _obj({}));
options.tokens = true;
extra.tokens = _arr({},0);
extra.tokenize = true;
extra.openParenToken = -1;
extra.openCurlyToken = -1;
extra.range = ((function() if (_type(options.range) == "boolean") then return options.range;  else return (_type(options.range) == "boolean");  end end)());
extra.loc = ((function() if (_type(options.loc) == "boolean") then return options.loc;  else return (_type(options.loc) == "boolean");  end end)());
if _bool(((function() if (_type(options.comment) == "boolean") then return options.comment;  else return (_type(options.comment) == "boolean");  end end)())) then
extra.comments = _arr({},0);
end

if _bool(((function() if (_type(options.tolerant) == "boolean") then return options.tolerant;  else return (_type(options.tolerant) == "boolean");  end end)())) then
extra.errors = _arr({},0);
end

local _status, _return = _pcall(function()
peek(_ENV);
if (lookahead.type == Token.EOF) then
do return extra.tokens; end
end

token = lex(_ENV);
while (lookahead.type ~= Token.EOF) do
local _status, _return = _pcall(function()
token = lex(_ENV);
end);
if not _status then
local _cstatus, _creturn = _pcall(function()
local lexError = _return;
token = lookahead;
if _bool(extra.errors) then
extra.errors:push(lexError);
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

filterTokenLocation(_ENV);
tokens = extra.tokens;
if (_type(extra.comments) ~= "undefined") then
tokens.comments = extra.comments;
end

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
if ((function() if (_type(code) ~= "string") then return not (_instanceof(code,String));  else return (_type(code) ~= "string");  end end)()) then
code = toString(_ENV,code);
end

delegate = SyntaxTreeDelegate;
source = code;
index = 0;
lineNumber = (function() if (_gt(source.length,0)) then return 1; else return 0; end end)();
lineStart = 0;
length = source.length;
lookahead = null;
state = _obj({
["allowIn"] = true,
["labelSet"] = _obj({}),
["inFunctionBody"] = false,
["inIteration"] = false,
["inSwitch"] = false,
["lastCommentStart"] = -1
});
extra = _obj({});
if (_type(options) ~= "undefined") then
extra.range = ((function() if (_type(options.range) == "boolean") then return options.range;  else return (_type(options.range) == "boolean");  end end)());
extra.loc = ((function() if (_type(options.loc) == "boolean") then return options.loc;  else return (_type(options.loc) == "boolean");  end end)());
extra.attachComment = ((function() if (_type(options.attachComment) == "boolean") then return options.attachComment;  else return (_type(options.attachComment) == "boolean");  end end)());
if _bool(((function() if _bool(((function() if _bool(extra.loc) then return (options.source ~= null);  else return extra.loc;  end end)())) then return (options.source ~= undefined);  else return ((function() if _bool(extra.loc) then return (options.source ~= null);  else return extra.loc;  end end)());  end end)())) then
extra.source = toString(_ENV,options.source);
end

if _bool(((function() if (_type(options.tokens) == "boolean") then return options.tokens;  else return (_type(options.tokens) == "boolean");  end end)())) then
extra.tokens = _arr({},0);
end

if _bool(((function() if (_type(options.comment) == "boolean") then return options.comment;  else return (_type(options.comment) == "boolean");  end end)())) then
extra.comments = _arr({},0);
end

if _bool(((function() if (_type(options.tolerant) == "boolean") then return options.tolerant;  else return (_type(options.tolerant) == "boolean");  end end)())) then
extra.errors = _arr({},0);
end

if _bool(extra.attachComment) then
extra.range = true;
extra.comments = _arr({},0);
extra.bottomRightStack = _arr({},0);
extra.trailingComments = _arr({},0);
extra.leadingComments = _arr({},0);
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
["RegularExpression"] = 9
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
FnExprTokens = _arr({[0]="(","{","[","in","typeof","instanceof","new","return","case","delete","throw","void","=","+=","-=","*=","/=","%=","<<=",">>=",">>>=","&=","|=","^=",",","+","-","*","/","%","++","--","<<",">>",">>>","&","|","^","!","~","&&","||","?",":","===","==",">=","<=","<",">","!=","!=="},52);
Syntax = _obj({
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
});
PropertyKind = _obj({
["Data"] = 1,
["Get"] = 2,
["Set"] = 4
});
Messages = _obj({
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
});
Regex = _obj({
["NonAsciiIdentifierStart"] = _new(RegExp,"[\194\170\194\181\194\186\195\128-\195\150\195\152-\195\182\195\184-\203\129\203\134-\203\145\203\160-\203\164\203\172\203\174\205\176-\205\180\205\182\205\183\205\186-\205\189\206\134\206\136-\206\138\206\140\206\142-\206\161\206\163-\207\181\207\183-\210\129\210\138-\212\167\212\177-\213\150\213\153\213\161-\214\135\215\144-\215\170\215\176-\215\178\216\160-\217\138\217\174\217\175\217\177-\219\147\219\149\219\165\219\166\219\174\219\175\219\186-\219\188\219\191\220\144\220\146-\220\175\221\141-\222\165\222\177\223\138-\223\170\223\180\223\181\223\186\224\160\128-\224\160\149\224\160\154\224\160\164\224\160\168\224\161\128-\224\161\152\224\162\160\224\162\162-\224\162\172\224\164\132-\224\164\185\224\164\189\224\165\144\224\165\152-\224\165\161\224\165\177-\224\165\183\224\165\185-\224\165\191\224\166\133-\224\166\140\224\166\143\224\166\144\224\166\147-\224\166\168\224\166\170-\224\166\176\224\166\178\224\166\182-\224\166\185\224\166\189\224\167\142\224\167\156\224\167\157\224\167\159-\224\167\161\224\167\176\224\167\177\224\168\133-\224\168\138\224\168\143\224\168\144\224\168\147-\224\168\168\224\168\170-\224\168\176\224\168\178\224\168\179\224\168\181\224\168\182\224\168\184\224\168\185\224\169\153-\224\169\156\224\169\158\224\169\178-\224\169\180\224\170\133-\224\170\141\224\170\143-\224\170\145\224\170\147-\224\170\168\224\170\170-\224\170\176\224\170\178\224\170\179\224\170\181-\224\170\185\224\170\189\224\171\144\224\171\160\224\171\161\224\172\133-\224\172\140\224\172\143\224\172\144\224\172\147-\224\172\168\224\172\170-\224\172\176\224\172\178\224\172\179\224\172\181-\224\172\185\224\172\189\224\173\156\224\173\157\224\173\159-\224\173\161\224\173\177\224\174\131\224\174\133-\224\174\138\224\174\142-\224\174\144\224\174\146-\224\174\149\224\174\153\224\174\154\224\174\156\224\174\158\224\174\159\224\174\163\224\174\164\224\174\168-\224\174\170\224\174\174-\224\174\185\224\175\144\224\176\133-\224\176\140\224\176\142-\224\176\144\224\176\146-\224\176\168\224\176\170-\224\176\179\224\176\181-\224\176\185\224\176\189\224\177\152\224\177\153\224\177\160\224\177\161\224\178\133-\224\178\140\224\178\142-\224\178\144\224\178\146-\224\178\168\224\178\170-\224\178\179\224\178\181-\224\178\185\224\178\189\224\179\158\224\179\160\224\179\161\224\179\177\224\179\178\224\180\133-\224\180\140\224\180\142-\224\180\144\224\180\146-\224\180\186\224\180\189\224\181\142\224\181\160\224\181\161\224\181\186-\224\181\191\224\182\133-\224\182\150\224\182\154-\224\182\177\224\182\179-\224\182\187\224\182\189\224\183\128-\224\183\134\224\184\129-\224\184\176\224\184\178\224\184\179\224\185\128-\224\185\134\224\186\129\224\186\130\224\186\132\224\186\135\224\186\136\224\186\138\224\186\141\224\186\148-\224\186\151\224\186\153-\224\186\159\224\186\161-\224\186\163\224\186\165\224\186\167\224\186\170\224\186\171\224\186\173-\224\186\176\224\186\178\224\186\179\224\186\189\224\187\128-\224\187\132\224\187\134\224\187\156-\224\187\159\224\188\128\224\189\128-\224\189\135\224\189\137-\224\189\172\224\190\136-\224\190\140\225\128\128-\225\128\170\225\128\191\225\129\144-\225\129\149\225\129\154-\225\129\157\225\129\161\225\129\165\225\129\166\225\129\174-\225\129\176\225\129\181-\225\130\129\225\130\142\225\130\160-\225\131\133\225\131\135\225\131\141\225\131\144-\225\131\186\225\131\188-\225\137\136\225\137\138-\225\137\141\225\137\144-\225\137\150\225\137\152\225\137\154-\225\137\157\225\137\160-\225\138\136\225\138\138-\225\138\141\225\138\144-\225\138\176\225\138\178-\225\138\181\225\138\184-\225\138\190\225\139\128\225\139\130-\225\139\133\225\139\136-\225\139\150\225\139\152-\225\140\144\225\140\146-\225\140\149\225\140\152-\225\141\154\225\142\128-\225\142\143\225\142\160-\225\143\180\225\144\129-\225\153\172\225\153\175-\225\153\191\225\154\129-\225\154\154\225\154\160-\225\155\170\225\155\174-\225\155\176\225\156\128-\225\156\140\225\156\142-\225\156\145\225\156\160-\225\156\177\225\157\128-\225\157\145\225\157\160-\225\157\172\225\157\174-\225\157\176\225\158\128-\225\158\179\225\159\151\225\159\156\225\160\160-\225\161\183\225\162\128-\225\162\168\225\162\170\225\162\176-\225\163\181\225\164\128-\225\164\156\225\165\144-\225\165\173\225\165\176-\225\165\180\225\166\128-\225\166\171\225\167\129-\225\167\135\225\168\128-\225\168\150\225\168\160-\225\169\148\225\170\167\225\172\133-\225\172\179\225\173\133-\225\173\139\225\174\131-\225\174\160\225\174\174\225\174\175\225\174\186-\225\175\165\225\176\128-\225\176\163\225\177\141-\225\177\143\225\177\154-\225\177\189\225\179\169-\225\179\172\225\179\174-\225\179\177\225\179\181\225\179\182\225\180\128-\225\182\191\225\184\128-\225\188\149\225\188\152-\225\188\157\225\188\160-\225\189\133\225\189\136-\225\189\141\225\189\144-\225\189\151\225\189\153\225\189\155\225\189\157\225\189\159-\225\189\189\225\190\128-\225\190\180\225\190\182-\225\190\188\225\190\190\225\191\130-\225\191\132\225\191\134-\225\191\140\225\191\144-\225\191\147\225\191\150-\225\191\155\225\191\160-\225\191\172\225\191\178-\225\191\180\225\191\182-\225\191\188\226\129\177\226\129\191\226\130\144-\226\130\156\226\132\130\226\132\135\226\132\138-\226\132\147\226\132\149\226\132\153-\226\132\157\226\132\164\226\132\166\226\132\168\226\132\170-\226\132\173\226\132\175-\226\132\185\226\132\188-\226\132\191\226\133\133-\226\133\137\226\133\142\226\133\160-\226\134\136\226\176\128-\226\176\174\226\176\176-\226\177\158\226\177\160-\226\179\164\226\179\171-\226\179\174\226\179\178\226\179\179\226\180\128-\226\180\165\226\180\167\226\180\173\226\180\176-\226\181\167\226\181\175\226\182\128-\226\182\150\226\182\160-\226\182\166\226\182\168-\226\182\174\226\182\176-\226\182\182\226\182\184-\226\182\190\226\183\128-\226\183\134\226\183\136-\226\183\142\226\183\144-\226\183\150\226\183\152-\226\183\158\226\184\175\227\128\133-\227\128\135\227\128\161-\227\128\169\227\128\177-\227\128\181\227\128\184-\227\128\188\227\129\129-\227\130\150\227\130\157-\227\130\159\227\130\161-\227\131\186\227\131\188-\227\131\191\227\132\133-\227\132\173\227\132\177-\227\134\142\227\134\160-\227\134\186\227\135\176-\227\135\191\227\144\128-\228\182\181\228\184\128-\233\191\140\234\128\128-\234\146\140\234\147\144-\234\147\189\234\148\128-\234\152\140\234\152\144-\234\152\159\234\152\170\234\152\171\234\153\128-\234\153\174\234\153\191-\234\154\151\234\154\160-\234\155\175\234\156\151-\234\156\159\234\156\162-\234\158\136\234\158\139-\234\158\142\234\158\144-\234\158\147\234\158\160-\234\158\170\234\159\184-\234\160\129\234\160\131-\234\160\133\234\160\135-\234\160\138\234\160\140-\234\160\162\234\161\128-\234\161\179\234\162\130-\234\162\179\234\163\178-\234\163\183\234\163\187\234\164\138-\234\164\165\234\164\176-\234\165\134\234\165\160-\234\165\188\234\166\132-\234\166\178\234\167\143\234\168\128-\234\168\168\234\169\128-\234\169\130\234\169\132-\234\169\139\234\169\160-\234\169\182\234\169\186\234\170\128-\234\170\175\234\170\177\234\170\181\234\170\182\234\170\185-\234\170\189\234\171\128\234\171\130\234\171\155-\234\171\157\234\171\160-\234\171\170\234\171\178-\234\171\180\234\172\129-\234\172\134\234\172\137-\234\172\142\234\172\145-\234\172\150\234\172\160-\234\172\166\234\172\168-\234\172\174\234\175\128-\234\175\162\234\176\128-\237\158\163\237\158\176-\237\159\134\237\159\139-\237\159\187\239\164\128-\239\169\173\239\169\176-\239\171\153\239\172\128-\239\172\134\239\172\147-\239\172\151\239\172\157\239\172\159-\239\172\168\239\172\170-\239\172\182\239\172\184-\239\172\188\239\172\190\239\173\128\239\173\129\239\173\131\239\173\132\239\173\134-\239\174\177\239\175\147-\239\180\189\239\181\144-\239\182\143\239\182\146-\239\183\135\239\183\176-\239\183\187\239\185\176-\239\185\180\239\185\182-\239\187\188\239\188\161-\239\188\186\239\189\129-\239\189\154\239\189\166-\239\190\190\239\191\130-\239\191\135\239\191\138-\239\191\143\239\191\146-\239\191\151\239\191\154-\239\191\156]"),
["NonAsciiIdentifierPart"] = _new(RegExp,"[\194\170\194\181\194\186\195\128-\195\150\195\152-\195\182\195\184-\203\129\203\134-\203\145\203\160-\203\164\203\172\203\174\204\128-\205\180\205\182\205\183\205\186-\205\189\206\134\206\136-\206\138\206\140\206\142-\206\161\206\163-\207\181\207\183-\210\129\210\131-\210\135\210\138-\212\167\212\177-\213\150\213\153\213\161-\214\135\214\145-\214\189\214\191\215\129\215\130\215\132\215\133\215\135\215\144-\215\170\215\176-\215\178\216\144-\216\154\216\160-\217\169\217\174-\219\147\219\149-\219\156\219\159-\219\168\219\170-\219\188\219\191\220\144-\221\138\221\141-\222\177\223\128-\223\181\223\186\224\160\128-\224\160\173\224\161\128-\224\161\155\224\162\160\224\162\162-\224\162\172\224\163\164-\224\163\190\224\164\128-\224\165\163\224\165\166-\224\165\175\224\165\177-\224\165\183\224\165\185-\224\165\191\224\166\129-\224\166\131\224\166\133-\224\166\140\224\166\143\224\166\144\224\166\147-\224\166\168\224\166\170-\224\166\176\224\166\178\224\166\182-\224\166\185\224\166\188-\224\167\132\224\167\135\224\167\136\224\167\139-\224\167\142\224\167\151\224\167\156\224\167\157\224\167\159-\224\167\163\224\167\166-\224\167\177\224\168\129-\224\168\131\224\168\133-\224\168\138\224\168\143\224\168\144\224\168\147-\224\168\168\224\168\170-\224\168\176\224\168\178\224\168\179\224\168\181\224\168\182\224\168\184\224\168\185\224\168\188\224\168\190-\224\169\130\224\169\135\224\169\136\224\169\139-\224\169\141\224\169\145\224\169\153-\224\169\156\224\169\158\224\169\166-\224\169\181\224\170\129-\224\170\131\224\170\133-\224\170\141\224\170\143-\224\170\145\224\170\147-\224\170\168\224\170\170-\224\170\176\224\170\178\224\170\179\224\170\181-\224\170\185\224\170\188-\224\171\133\224\171\135-\224\171\137\224\171\139-\224\171\141\224\171\144\224\171\160-\224\171\163\224\171\166-\224\171\175\224\172\129-\224\172\131\224\172\133-\224\172\140\224\172\143\224\172\144\224\172\147-\224\172\168\224\172\170-\224\172\176\224\172\178\224\172\179\224\172\181-\224\172\185\224\172\188-\224\173\132\224\173\135\224\173\136\224\173\139-\224\173\141\224\173\150\224\173\151\224\173\156\224\173\157\224\173\159-\224\173\163\224\173\166-\224\173\175\224\173\177\224\174\130\224\174\131\224\174\133-\224\174\138\224\174\142-\224\174\144\224\174\146-\224\174\149\224\174\153\224\174\154\224\174\156\224\174\158\224\174\159\224\174\163\224\174\164\224\174\168-\224\174\170\224\174\174-\224\174\185\224\174\190-\224\175\130\224\175\134-\224\175\136\224\175\138-\224\175\141\224\175\144\224\175\151\224\175\166-\224\175\175\224\176\129-\224\176\131\224\176\133-\224\176\140\224\176\142-\224\176\144\224\176\146-\224\176\168\224\176\170-\224\176\179\224\176\181-\224\176\185\224\176\189-\224\177\132\224\177\134-\224\177\136\224\177\138-\224\177\141\224\177\149\224\177\150\224\177\152\224\177\153\224\177\160-\224\177\163\224\177\166-\224\177\175\224\178\130\224\178\131\224\178\133-\224\178\140\224\178\142-\224\178\144\224\178\146-\224\178\168\224\178\170-\224\178\179\224\178\181-\224\178\185\224\178\188-\224\179\132\224\179\134-\224\179\136\224\179\138-\224\179\141\224\179\149\224\179\150\224\179\158\224\179\160-\224\179\163\224\179\166-\224\179\175\224\179\177\224\179\178\224\180\130\224\180\131\224\180\133-\224\180\140\224\180\142-\224\180\144\224\180\146-\224\180\186\224\180\189-\224\181\132\224\181\134-\224\181\136\224\181\138-\224\181\142\224\181\151\224\181\160-\224\181\163\224\181\166-\224\181\175\224\181\186-\224\181\191\224\182\130\224\182\131\224\182\133-\224\182\150\224\182\154-\224\182\177\224\182\179-\224\182\187\224\182\189\224\183\128-\224\183\134\224\183\138\224\183\143-\224\183\148\224\183\150\224\183\152-\224\183\159\224\183\178\224\183\179\224\184\129-\224\184\186\224\185\128-\224\185\142\224\185\144-\224\185\153\224\186\129\224\186\130\224\186\132\224\186\135\224\186\136\224\186\138\224\186\141\224\186\148-\224\186\151\224\186\153-\224\186\159\224\186\161-\224\186\163\224\186\165\224\186\167\224\186\170\224\186\171\224\186\173-\224\186\185\224\186\187-\224\186\189\224\187\128-\224\187\132\224\187\134\224\187\136-\224\187\141\224\187\144-\224\187\153\224\187\156-\224\187\159\224\188\128\224\188\152\224\188\153\224\188\160-\224\188\169\224\188\181\224\188\183\224\188\185\224\188\190-\224\189\135\224\189\137-\224\189\172\224\189\177-\224\190\132\224\190\134-\224\190\151\224\190\153-\224\190\188\224\191\134\225\128\128-\225\129\137\225\129\144-\225\130\157\225\130\160-\225\131\133\225\131\135\225\131\141\225\131\144-\225\131\186\225\131\188-\225\137\136\225\137\138-\225\137\141\225\137\144-\225\137\150\225\137\152\225\137\154-\225\137\157\225\137\160-\225\138\136\225\138\138-\225\138\141\225\138\144-\225\138\176\225\138\178-\225\138\181\225\138\184-\225\138\190\225\139\128\225\139\130-\225\139\133\225\139\136-\225\139\150\225\139\152-\225\140\144\225\140\146-\225\140\149\225\140\152-\225\141\154\225\141\157-\225\141\159\225\142\128-\225\142\143\225\142\160-\225\143\180\225\144\129-\225\153\172\225\153\175-\225\153\191\225\154\129-\225\154\154\225\154\160-\225\155\170\225\155\174-\225\155\176\225\156\128-\225\156\140\225\156\142-\225\156\148\225\156\160-\225\156\180\225\157\128-\225\157\147\225\157\160-\225\157\172\225\157\174-\225\157\176\225\157\178\225\157\179\225\158\128-\225\159\147\225\159\151\225\159\156\225\159\157\225\159\160-\225\159\169\225\160\139-\225\160\141\225\160\144-\225\160\153\225\160\160-\225\161\183\225\162\128-\225\162\170\225\162\176-\225\163\181\225\164\128-\225\164\156\225\164\160-\225\164\171\225\164\176-\225\164\187\225\165\134-\225\165\173\225\165\176-\225\165\180\225\166\128-\225\166\171\225\166\176-\225\167\137\225\167\144-\225\167\153\225\168\128-\225\168\155\225\168\160-\225\169\158\225\169\160-\225\169\188\225\169\191-\225\170\137\225\170\144-\225\170\153\225\170\167\225\172\128-\225\173\139\225\173\144-\225\173\153\225\173\171-\225\173\179\225\174\128-\225\175\179\225\176\128-\225\176\183\225\177\128-\225\177\137\225\177\141-\225\177\189\225\179\144-\225\179\146\225\179\148-\225\179\182\225\180\128-\225\183\166\225\183\188-\225\188\149\225\188\152-\225\188\157\225\188\160-\225\189\133\225\189\136-\225\189\141\225\189\144-\225\189\151\225\189\153\225\189\155\225\189\157\225\189\159-\225\189\189\225\190\128-\225\190\180\225\190\182-\225\190\188\225\190\190\225\191\130-\225\191\132\225\191\134-\225\191\140\225\191\144-\225\191\147\225\191\150-\225\191\155\225\191\160-\225\191\172\225\191\178-\225\191\180\225\191\182-\225\191\188\226\128\140\226\128\141\226\128\191\226\129\128\226\129\148\226\129\177\226\129\191\226\130\144-\226\130\156\226\131\144-\226\131\156\226\131\161\226\131\165-\226\131\176\226\132\130\226\132\135\226\132\138-\226\132\147\226\132\149\226\132\153-\226\132\157\226\132\164\226\132\166\226\132\168\226\132\170-\226\132\173\226\132\175-\226\132\185\226\132\188-\226\132\191\226\133\133-\226\133\137\226\133\142\226\133\160-\226\134\136\226\176\128-\226\176\174\226\176\176-\226\177\158\226\177\160-\226\179\164\226\179\171-\226\179\179\226\180\128-\226\180\165\226\180\167\226\180\173\226\180\176-\226\181\167\226\181\175\226\181\191-\226\182\150\226\182\160-\226\182\166\226\182\168-\226\182\174\226\182\176-\226\182\182\226\182\184-\226\182\190\226\183\128-\226\183\134\226\183\136-\226\183\142\226\183\144-\226\183\150\226\183\152-\226\183\158\226\183\160-\226\183\191\226\184\175\227\128\133-\227\128\135\227\128\161-\227\128\175\227\128\177-\227\128\181\227\128\184-\227\128\188\227\129\129-\227\130\150\227\130\153\227\130\154\227\130\157-\227\130\159\227\130\161-\227\131\186\227\131\188-\227\131\191\227\132\133-\227\132\173\227\132\177-\227\134\142\227\134\160-\227\134\186\227\135\176-\227\135\191\227\144\128-\228\182\181\228\184\128-\233\191\140\234\128\128-\234\146\140\234\147\144-\234\147\189\234\148\128-\234\152\140\234\152\144-\234\152\171\234\153\128-\234\153\175\234\153\180-\234\153\189\234\153\191-\234\154\151\234\154\159-\234\155\177\234\156\151-\234\156\159\234\156\162-\234\158\136\234\158\139-\234\158\142\234\158\144-\234\158\147\234\158\160-\234\158\170\234\159\184-\234\160\167\234\161\128-\234\161\179\234\162\128-\234\163\132\234\163\144-\234\163\153\234\163\160-\234\163\183\234\163\187\234\164\128-\234\164\173\234\164\176-\234\165\147\234\165\160-\234\165\188\234\166\128-\234\167\128\234\167\143-\234\167\153\234\168\128-\234\168\182\234\169\128-\234\169\141\234\169\144-\234\169\153\234\169\160-\234\169\182\234\169\186\234\169\187\234\170\128-\234\171\130\234\171\155-\234\171\157\234\171\160-\234\171\175\234\171\178-\234\171\182\234\172\129-\234\172\134\234\172\137-\234\172\142\234\172\145-\234\172\150\234\172\160-\234\172\166\234\172\168-\234\172\174\234\175\128-\234\175\170\234\175\172\234\175\173\234\175\176-\234\175\185\234\176\128-\237\158\163\237\158\176-\237\159\134\237\159\139-\237\159\187\239\164\128-\239\169\173\239\169\176-\239\171\153\239\172\128-\239\172\134\239\172\147-\239\172\151\239\172\157-\239\172\168\239\172\170-\239\172\182\239\172\184-\239\172\188\239\172\190\239\173\128\239\173\129\239\173\131\239\173\132\239\173\134-\239\174\177\239\175\147-\239\180\189\239\181\144-\239\182\143\239\182\146-\239\183\135\239\183\176-\239\183\187\239\184\128-\239\184\143\239\184\160-\239\184\166\239\184\179\239\184\180\239\185\141-\239\185\143\239\185\176-\239\185\180\239\185\182-\239\187\188\239\188\144-\239\188\153\239\188\161-\239\188\186\239\188\191\239\189\129-\239\189\154\239\189\166-\239\190\190\239\191\130-\239\191\135\239\191\138-\239\191\143\239\191\146-\239\191\151\239\191\154-\239\191\156]")
});
SyntaxTreeDelegate = _obj({
["name"] = "SyntaxTree",
["processComment"] = (function (this, node)
local trailingComments,lastChild;
if (node.type == Syntax.Program) then
if (_gt(node.body.length,0)) then
do return end
end

end

if (_gt(extra.trailingComments.length,0)) then
if (_ge(extra.trailingComments[0].range[0],node.range[1])) then
trailingComments = extra.trailingComments;
extra.trailingComments = _arr({},0);
else
extra.trailingComments.length = 0;
end

else
if _bool(((function() if _bool(((function() if (_gt(extra.bottomRightStack.length,0)) then return extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments;  else return (_gt(extra.bottomRightStack.length,0));  end end)())) then return (_ge(extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments[0].range[0],node.range[1]));  else return ((function() if (_gt(extra.bottomRightStack.length,0)) then return extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments;  else return (_gt(extra.bottomRightStack.length,0));  end end)());  end end)())) then
trailingComments = extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments;
(function () local _r = false; local _g, _s = extra.bottomRightStack[(extra.bottomRightStack.length - 1)]["_g" .. "trailingComments"], extra.bottomRightStack[(extra.bottomRightStack.length - 1)]["_s" .. "trailingComments"]; extra.bottomRightStack[(extra.bottomRightStack.length - 1)]["_g" .. "trailingComments"], extra.bottomRightStack[(extra.bottomRightStack.length - 1)]["_s" .. "trailingComments"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments; extra.bottomRightStack[(extra.bottomRightStack.length - 1)].trailingComments = nil; return _r or _v ~= nil; end)();
end

end

while ((function() if (_gt(extra.bottomRightStack.length,0)) then return (_ge(extra.bottomRightStack[(extra.bottomRightStack.length - 1)].range[0],node.range[0]));  else return (_gt(extra.bottomRightStack.length,0));  end end)()) do
lastChild = extra.bottomRightStack:pop();
::_continue::
end

if _bool(lastChild) then
if _bool(((function() if _bool(lastChild.leadingComments) then return (_le(lastChild.leadingComments[(lastChild.leadingComments.length - 1)].range[1],node.range[0]));  else return lastChild.leadingComments;  end end)())) then
node.leadingComments = lastChild.leadingComments;
(function () local _r = false; local _g, _s = lastChild["_g" .. "leadingComments"], lastChild["_s" .. "leadingComments"]; lastChild["_g" .. "leadingComments"], lastChild["_s" .. "leadingComments"] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = lastChild.leadingComments; lastChild.leadingComments = nil; return _r or _v ~= nil; end)();
end

elseif ((function() if (_gt(extra.leadingComments.length,0)) then return (_le(extra.leadingComments[(extra.leadingComments.length - 1)].range[1],node.range[0]));  else return (_gt(extra.leadingComments.length,0));  end end)()) then
node.leadingComments = extra.leadingComments;
extra.leadingComments = _arr({},0);
end

if _bool(trailingComments) then
node.trailingComments = trailingComments;
end

extra.bottomRightStack:push(node);
end),
["markEnd"] = (function (this, node, startToken)
if _bool(extra.range) then
node.range = _arr({[0]=startToken.start,index},2);
end

if _bool(extra.loc) then
node.loc = _new(SourceLocation,(function() if (startToken.startLineNumber == undefined) then return startToken.lineNumber; else return startToken.startLineNumber; end end)(),(startToken.start - (function() if (startToken.startLineStart == undefined) then return startToken.lineStart; else return startToken.startLineStart; end end)()),lineNumber,(index - lineStart));
this:postProcess(node);
end

if _bool(extra.attachComment) then
this:processComment(node);
end

do return node; end
end),
["postProcess"] = (function (this, node)
if _bool(extra.source) then
node.loc.source = extra.source;
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
type = (function() if ((operator == "||") and (operator == "||") or (operator == "&&")) then return Syntax.LogicalExpression; else return Syntax.BinaryExpression; end end)();
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
if ((operator == "++") and (operator == "++") or (operator == "--")) then
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
});
exports.version = "1.2.2";
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
return this.esprima
end, _ENV)();
