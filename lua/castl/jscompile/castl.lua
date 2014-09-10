local _ENV = require("castl.runtime");
(function (this, root, factory)
_e("use strict");
if _bool(((_type(define) == "function") and define.amd)) then
define(_ENV,_arr({[0]="exports"},1),factory);
elseif _bool((exports ~= undefined)) then
factory(_ENV,exports);
else
_e((function () local _tmp = _obj({

}); root.castl  = _tmp; return _tmp; end)());
factory(_ENV,root.castl);
end

end)(_ENV,this,(function (this, exports)
local compileLiteral,sanitizeRegExpSource,sanitizeLiteralString,toUTF8Array,compileIdentifier,sanitizeIdentifier,buildLocalsDeclarationString,compileFunction,compilePattern,compileVariableDeclaration,compileFunctionDeclaration,compileArrayExpression,compileThisExpression,compileNewExpression,compileMemberExpression,compileObjectExpression,compileSequenceExpression,compileConditionalExpression,pushSimpleBinaryExpression,compileBinaryExpression,compileUnaryExpression,getGetterSetterExpression,getBaseMember,compileLogicalExpression,compileCallExpression,compileCallArguments,lastTopLevelBracketedGroupStartIndex,replaceAt,compileUpdateExpression,extractBinaryOperator,compileAssignmentExpression,compileExpressionStatement,compileExpression,compileWithStatement,compileReturnStatement,compileThrowStatement,compileTryStatementFlavored,compileTryStatement,compileSwitchStatement,compileContinueStatement,compileBreakStatement,compileLabeledStatement,isIterationStatement,compileDoWhileStatement,compileWhileStatement,compileForInStatement,compileForStatement,compileIterationStatement,compileForUpdate,compileForInit,compileIfStatement,compileListOfStatements,compileStatement,compileAST,localVarManager,LocalVarManager,protectedCallManager,ProtectedCallManager,continueNoLabelTracker,labelTracker,luaKeywords;
ProtectedCallManager = (function (this)
_e((function () local _tmp = _arr({},0); this.protectedCallContext  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); this.mayReturnStack  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); this.mayBreakStack  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); this.mayContinueStack  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); this.iterationStatement  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); this.switchStatement  = _tmp; return _tmp; end)());
end)
LocalVarManager = (function (this)
_e((function () local _tmp = _arr({},0); this.locals  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); this.functions  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); this.args  = _tmp; return _tmp; end)());
end)
compileAST = (function (this, ast)
local i,compiledFunctionsDeclaration,functions,compiledLocalsDeclaration,locals,useArguments,context,topLevelStatements,compiledProgram;
if _bool((ast.type == "Program")) then
compiledProgram = _arr({},0);
localVarManager:createLocalContext();
topLevelStatements = compileListOfStatements(_ENV,ast.body);
context = localVarManager:popLocalContext();
useArguments = context[1];
if _bool(useArguments) then
compiledProgram:push("local arguments = _args(...);");
end

locals = context[0];
if _bool((locals.length > 0)) then
compiledLocalsDeclaration = buildLocalsDeclarationString(_ENV,locals);
compiledProgram:push(compiledLocalsDeclaration);
end

functions = context[2];
if _bool((functions.length > 0)) then
compiledFunctionsDeclaration = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < functions.length)) do
compiledFunctionsDeclaration:push(functions[i]);
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledProgram:push(compiledFunctionsDeclaration:join("\10"));
end

compiledProgram:push(topLevelStatements);
 do return _obj({
["success"] = true,
["compiled"] = compiledProgram:join("\10")
}); end
end

 do return _obj({
["success"] = false,
["compiled"] = ""
}); end
end)
compileStatement = (function (this, statement)
repeat
local _into = false;
local _cases = {["ExpressionStatement"] = true,["BlockStatement"] = true,["FunctionDeclaration"] = true,["VariableDeclaration"] = true,["IfStatement"] = true,["ForStatement"] = true,["WhileStatement"] = true,["DoWhileStatement"] = true,["ForInStatement"] = true,["ReturnStatement"] = true,["BreakStatement"] = true,["TryStatement"] = true,["ThrowStatement"] = true,["SwitchStatement"] = true,["ContinueStatement"] = true,["LabeledStatement"] = true,["WithStatement"] = true,["EmptyStatement"] = true,["DebuggerStatement"] = true};
if (not _cases[statement.type]) then
_into = true;
goto _default
end
if _into or (statement.type == "ExpressionStatement") then
 do return compileExpressionStatement(_ENV,statement.expression); end
_into = true;
end
if _into or (statement.type == "BlockStatement") then
 do return compileListOfStatements(_ENV,statement.body); end
_into = true;
end
if _into or (statement.type == "FunctionDeclaration") then
 do return compileFunctionDeclaration(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "VariableDeclaration") then
 do return compileVariableDeclaration(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "IfStatement") then
 do return compileIfStatement(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "ForStatement") then

_into = true;
end
if _into or (statement.type == "WhileStatement") then

_into = true;
end
if _into or (statement.type == "DoWhileStatement") then

_into = true;
end
if _into or (statement.type == "ForInStatement") then
 do return compileIterationStatement(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "ReturnStatement") then
 do return compileReturnStatement(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "BreakStatement") then
 do return compileBreakStatement(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "TryStatement") then
 do return compileTryStatement(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "ThrowStatement") then
 do return compileThrowStatement(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "SwitchStatement") then
 do return compileSwitchStatement(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "ContinueStatement") then
 do return compileContinueStatement(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "LabeledStatement") then
 do return compileLabeledStatement(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "WithStatement") then
 do return compileWithStatement(_ENV,statement); end
_into = true;
end
if _into or (statement.type == "EmptyStatement") then

_into = true;
end
if _into or (statement.type == "DebuggerStatement") then
 do return ""; end
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_add("Unknown Statement type: ",statement.type))),0)
_into = true;
end
until true
end)
compileListOfStatements = (function (this, statementList)
local compiledStatement,i,compiledStatements;
compiledStatements = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < statementList.length)) do
_e((function () local _tmp = compileStatement(_ENV,statementList[i]); compiledStatement  = _tmp; return _tmp; end)());
if _bool(((compiledStatement ~= "") and (compiledStatement ~= undefined))) then
compiledStatements:push(compiledStatement);
end

_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

 do return compiledStatements:join("\10"); end
end)
compileIfStatement = (function (this, statement, elif)
local compiledIfStatement;
compiledIfStatement = _arr({},0);
if _bool(elif) then
compiledIfStatement:push("elseif _bool(");
else
compiledIfStatement:push("if _bool(");
end

compiledIfStatement:push(compileExpression(_ENV,statement.test));
compiledIfStatement:push(") then\10");
compiledIfStatement:push(compileStatement(_ENV,statement.consequent));
if _bool((statement.alternate ~= null)) then
compiledIfStatement:push("\10");
if _bool((statement.alternate.type == "IfStatement")) then
compiledIfStatement:push(compileIfStatement(_ENV,statement.alternate,true));
else
compiledIfStatement:push("else\10");
compiledIfStatement:push(compileStatement(_ENV,statement.alternate));
end

end

if _bool(not _bool(elif)) then
compiledIfStatement:push("\10");
compiledIfStatement:push("end\10");
end

 do return compiledIfStatement:join(""); end
end)
compileForInit = (function (this, init)
local compiledForInit;
compiledForInit = _arr({},0);
if _bool((init ~= null)) then
if _bool((init.type == "VariableDeclaration")) then
compiledForInit:push(compileVariableDeclaration(_ENV,init));
else
compiledForInit:push(compileExpressionStatement(_ENV,init));
end

compiledForInit:push("\10");
end

 do return compiledForInit:join(""); end
end)
compileForUpdate = (function (this, update)
local compiledForUpdate;
compiledForUpdate = _arr({},0);
if _bool((update ~= null)) then
compiledForUpdate:push(compileExpressionStatement(_ENV,update));
compiledForUpdate:push("\10");
end

 do return compiledForUpdate:join(""); end
end)
compileIterationStatement = (function (this, statement, compiledLabel)
local compiledIterationStatement;
compiledIterationStatement = "";
continueNoLabelTracker:push(false);
protectedCallManager:openIterationStatement();
repeat
local _into = false;
local _cases = {["ForStatement"] = true,["WhileStatement"] = true,["DoWhileStatement"] = true,["ForInStatement"] = true};
if (not _cases[statement.type]) then
_into = true;
goto _default
end
if _into or (statement.type == "ForStatement") then
_e((function () local _tmp = compileForStatement(_ENV,statement,compiledLabel); compiledIterationStatement  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (statement.type == "WhileStatement") then
_e((function () local _tmp = compileWhileStatement(_ENV,statement,compiledLabel); compiledIterationStatement  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (statement.type == "DoWhileStatement") then
_e((function () local _tmp = compileDoWhileStatement(_ENV,statement,compiledLabel); compiledIterationStatement  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (statement.type == "ForInStatement") then
_e((function () local _tmp = compileForInStatement(_ENV,statement,compiledLabel); compiledIterationStatement  = _tmp; return _tmp; end)());
break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_add("Not an IterationStatement ",statement.type))),0)
_into = true;
end
until true
protectedCallManager:closeIterationStatement();
continueNoLabelTracker:pop();
 do return compiledIterationStatement; end
end)
compileForStatement = (function (this, statement, compiledLabel)
local compiledUpdate,compiledForStatement;
compiledForStatement = _arr({},0);
compiledUpdate = compileForUpdate(_ENV,statement.update);
compiledForStatement:push(compileForInit(_ENV,statement.init));
compiledForStatement:push("while _bool(");
if _bool((statement.test ~= null)) then
compiledForStatement:push(compileExpression(_ENV,statement.test));
else
compiledForStatement:push("true");
end

compiledForStatement:push(") do\10");
compiledForStatement:push(compileStatement(_ENV,statement.body));
compiledForStatement:push("\10");
if _bool(continueNoLabelTracker[(continueNoLabelTracker.length - 1)]) then
compiledForStatement:push("::_continue::\10");
end

if _bool((compiledLabel and labelTracker[compiledLabel].mayContinue)) then
compiledForStatement:push((_add((_add("::",compiledLabel)),"_c::\10")));
end

compiledForStatement:push(compiledUpdate);
compiledForStatement:push("end\10");
 do return compiledForStatement:join(""); end
end)
compileForInStatement = (function (this, statement, compiledLabel)
local compiledLeft,compiledForInStatement;
compiledForInStatement = _arr({[0]="for "},1);
if _bool((statement.left.type == "VariableDeclaration")) then
_e((function () local _tmp = compilePattern(_ENV,statement.left.declarations[0].id); compiledLeft  = _tmp; return _tmp; end)());
localVarManager:pushLocal(compiledLeft);
compiledForInStatement:push(compiledLeft);
else
_e((function () local _tmp = compileExpression(_ENV,statement.left); compiledLeft  = _tmp; return _tmp; end)());
compiledForInStatement:push(compiledLeft);
end

compiledForInStatement:push(" in _props(");
compiledForInStatement:push(compileExpression(_ENV,statement.right));
compiledForInStatement:push(") do\10");
compiledForInStatement:push(compiledLeft);
compiledForInStatement:push(" = _tostr(");
compiledForInStatement:push(compiledLeft);
compiledForInStatement:push(");\10");
compiledForInStatement:push(compileStatement(_ENV,statement.body));
compiledForInStatement:push("::_continue::\10");
if _bool((compiledLabel and labelTracker[compiledLabel].mayContinue)) then
compiledForInStatement:push((_add((_add("::",compiledLabel)),"_c::\10")));
end

compiledForInStatement:push("end\10");
 do return compiledForInStatement:join(""); end
end)
compileWhileStatement = (function (this, statement, compiledLabel)
local compiledWhileStatement;
compiledWhileStatement = _arr({[0]="while _bool("},1);
compiledWhileStatement:push(compileExpression(_ENV,statement.test));
compiledWhileStatement:push(") do\10");
compiledWhileStatement:push(compileStatement(_ENV,statement.body));
compiledWhileStatement:push("\10");
compiledWhileStatement:push("::_continue::\10");
if _bool((compiledLabel and labelTracker[compiledLabel].mayContinue)) then
compiledWhileStatement:push((_add((_add("::",compiledLabel)),"_c::\10")));
end

compiledWhileStatement:push("end\10");
 do return compiledWhileStatement:join(""); end
end)
compileDoWhileStatement = (function (this, statement, compiledLabel)
local compiledDoWhileStatement;
compiledDoWhileStatement = _arr({[0]="repeat\10"},1);
compiledDoWhileStatement:push(compileStatement(_ENV,statement.body));
compiledDoWhileStatement:push("\10");
compiledDoWhileStatement:push("::_continue::\10");
if _bool((compiledLabel and labelTracker[compiledLabel].mayContinue)) then
compiledDoWhileStatement:push((_add((_add("::",compiledLabel)),"_c::\10")));
end

compiledDoWhileStatement:push("until not _bool(");
compiledDoWhileStatement:push(compileExpression(_ENV,statement.test));
compiledDoWhileStatement:push(")\10");
 do return compiledDoWhileStatement:join(""); end
end)
isIterationStatement = (function (this, statement)
 do return ((((statement.type == "ForStatement") or (statement.type == "DoWhileStatement")) or (statement.type == "WhileStatement")) or (statement.type == "ForInStatement")); end
end)
compileLabeledStatement = (function (this, statement)
local compiledLabel,label,compiledLabeledStatement;
compiledLabeledStatement = _arr({},0);
if _bool(isIterationStatement(_ENV,statement.body)) then
label = statement.label;
compiledLabel = compileIdentifier(_ENV,label);
_e((function () local _tmp = _obj({
["mayBreak"] = false,
["mayContinue"] = false
}); labelTracker[compiledLabel]  = _tmp; return _tmp; end)());
compiledLabeledStatement:push(compileIterationStatement(_ENV,statement.body,compiledLabel));
if _bool(labelTracker[compiledLabel].mayBreak) then
compiledLabeledStatement:push((_add((_add("::",compiledLabel)),"_b::\10")));
end

_e((function () local _r = false; local _g, _s = labelTracker._gcompiledLabel, labelTracker._scompiledLabel; labelTracker._gcompiledLabel, labelTracker._scompiledLabel = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = labelTracker[compiledLabel]; labelTracker[compiledLabel] = nil; return _r or _v ~= nil; end)());
else
compiledLabeledStatement:push(compileStatement(_ENV,statement.body));
end

 do return compiledLabeledStatement:join(""); end
end)
compileBreakStatement = (function (this, statement)
local compiledLabel;
if _bool((statement.label == null)) then
if _bool(protectedCallManager:breakOutside()) then
 do return "do return _break; end"; end
end

 do return "break;"; end
end

compiledLabel = compileIdentifier(_ENV,statement.label);
_e((function () local _tmp = true; labelTracker[compiledLabel].mayBreak  = _tmp; return _tmp; end)());
 do return (_add((_add("goto ",compiledLabel)),"_b;")); end
end)
compileContinueStatement = (function (this, statement)
local compiledLabel;
if _bool((statement.label == null)) then
_e((function () local _tmp = true; continueNoLabelTracker[(continueNoLabelTracker.length - 1)]  = _tmp; return _tmp; end)());
if _bool(protectedCallManager:continueOutside()) then
 do return "do return _continue; end"; end
end

 do return "goto _continue"; end
end

compiledLabel = compileIdentifier(_ENV,statement.label);
_e((function () local _tmp = true; labelTracker[compiledLabel].mayContinue  = _tmp; return _tmp; end)());
 do return (_add((_add("goto ",compiledLabel)),"_c;")); end
end)
compileSwitchStatement = (function (this, statement)
local hasDefault,compiledTests,caseTablementElement,casesTable,i,compiledDiscriminant,compiledSwitchStatement,cases;
protectedCallManager:openSwitchStatement();
cases = statement.cases;
if _bool((cases.length > 0)) then
compiledSwitchStatement = _arr({[0]="repeat\10local _into = false;\10"},1);
compiledDiscriminant = compileExpression(_ENV,statement.discriminant);
casesTable = _arr({},0);
compiledTests = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < cases.length)) do
if _bool((cases[i].test ~= null)) then
_e((function () local _tmp = compileExpression(_ENV,cases[i].test); compiledTests[i]  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); caseTablementElement  = _tmp; return _tmp; end)());
caseTablementElement:push("[");
caseTablementElement:push(compiledTests[i]);
caseTablementElement:push("] = true");
casesTable:push(caseTablementElement:join(""));
end

_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledSwitchStatement:push("local _cases = {");
compiledSwitchStatement:push(casesTable:join(","));
compiledSwitchStatement:push("};\10");
compiledSwitchStatement:push("if (not _cases[");
compiledSwitchStatement:push(compiledDiscriminant);
compiledSwitchStatement:push("]) then\10");
compiledSwitchStatement:push("_into = true;\10");
compiledSwitchStatement:push("goto _default\10");
compiledSwitchStatement:push("end\10");
hasDefault = false;
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < cases.length)) do
if _bool((cases[i].test ~= null)) then
compiledSwitchStatement:push("if _into or (");
compiledSwitchStatement:push(compiledDiscriminant);
compiledSwitchStatement:push(" == ");
compiledSwitchStatement:push(compiledTests[i]);
compiledSwitchStatement:push(") then\10");
else
_e((function () local _tmp = true; hasDefault  = _tmp; return _tmp; end)());
compiledSwitchStatement:push("::_default::\10");
compiledSwitchStatement:push("if _into then\10");
end

compiledSwitchStatement:push(compileListOfStatements(_ENV,cases[i].consequent));
compiledSwitchStatement:push("\10");
compiledSwitchStatement:push("_into = true;\10");
compiledSwitchStatement:push("end\10");
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

if _bool(not _bool(hasDefault)) then
compiledSwitchStatement:push("::_default::\10");
end

compiledSwitchStatement:push("until true");
protectedCallManager:openSwitchStatement();
 do return compiledSwitchStatement:join(""); end
end

protectedCallManager:openSwitchStatement();
 do return ""; end
end)
compileTryStatement = (function (this, statement)
if _bool(statement.handlers) then
 do return compileTryStatementFlavored(_ENV,statement,true); end
end

 do return compileTryStatementFlavored(_ENV,statement,false); end
end)
compileTryStatementFlavored = (function (this, statement, esprima)
local handler,compiledTryStatement,may,finallyStatements,hasFinalizer,hasHandler;
hasHandler = (_bool(esprima) and {(statement.handlers.length > 0)} or {(statement.handler ~= null)})[1];
hasFinalizer = (statement.finalizer ~= null);
protectedCallManager:openContext();
compiledTryStatement = _arr({[0]="local _status, _return = _pcall(function()\10"},1);
compiledTryStatement:push(compileListOfStatements(_ENV,statement.block.body));
compiledTryStatement:push("\10");
compiledTryStatement:push("end);\10");
_e((function () local _tmp = protectedCallManager:may(); may  = _tmp; return _tmp; end)());
protectedCallManager:closeContext();
if _bool((((hasFinalizer or may.mayReturn) or may.mayBreak) or may.mayContinue)) then
compiledTryStatement:push("if _status then\10");
if _bool(hasFinalizer) then
_e((function () local _tmp = compileListOfStatements(_ENV,statement.finalizer.body); finallyStatements  = _tmp; return _tmp; end)());
compiledTryStatement:push(finallyStatements);
compiledTryStatement:push("\10");
end

if _bool((may.mayBreak and may.mayContinue)) then
compiledTryStatement:push("if _return == _break then break; elseif _return == _continue then goto _continue end\10");
elseif _bool(may.mayBreak) then
compiledTryStatement:push("if _return == _break then break; end\10");
elseif _bool(may.mayContinue) then
compiledTryStatement:push("if _return == _continue then goto _continue end\10");
end

if _bool(may.mayReturn) then
compiledTryStatement:push("if _return ~= nil then return _return; end\10");
end

compiledTryStatement:push("else\10");
else
compiledTryStatement:push("if not _status then\10");
end

if _bool(hasHandler) then
handler = (_bool(esprima) and {statement.handlers[0]} or {statement.handler})[1];
protectedCallManager:openContext();
compiledTryStatement:push("local _cstatus, _creturn = _pcall(function()\10");
compiledTryStatement:push("local ");
compiledTryStatement:push(compilePattern(_ENV,handler.param));
compiledTryStatement:push(" = _return;\10");
compiledTryStatement:push(compileListOfStatements(_ENV,handler.body.body));
compiledTryStatement:push("\10");
compiledTryStatement:push("end);\10");
_e((function () local _tmp = protectedCallManager:may(); may  = _tmp; return _tmp; end)());
protectedCallManager:closeContext();
end

if _bool(hasFinalizer) then
compiledTryStatement:push(finallyStatements);
compiledTryStatement:push("\10");
end

if _bool(hasHandler) then
compiledTryStatement:push("if _cstatus then\10");
if _bool((may.mayBreak and may.mayContinue)) then
compiledTryStatement:push("if _creturn == _break then break; elseif _creturn == _continue then goto _continue end\10");
elseif _bool(may.mayBreak) then
compiledTryStatement:push("if _creturn == _break then break; end\10");
elseif _bool(may.mayContinue) then
compiledTryStatement:push("if _creturn == _continue then goto _continue end\10");
end

if _bool(may.mayReturn) then
compiledTryStatement:push("if _creturn ~= nil then return _creturn; end\10");
end

compiledTryStatement:push("else _throw(_creturn,0); end\10");
end

compiledTryStatement:push("end\10");
 do return compiledTryStatement:join(""); end
end)
compileThrowStatement = (function (this, statement)
local compiledThrowStatement;
compiledThrowStatement = _arr({[0]="_throw("},1);
compiledThrowStatement:push(compileExpression(_ENV,statement.argument));
compiledThrowStatement:push(",0)");
 do return compiledThrowStatement:join(""); end
end)
compileReturnStatement = (function (this, statement)
protectedCallManager:returnStatement();
if _bool((statement.argument ~= null)) then
 do return (_add((_add(" do return ",compileExpression(_ENV,statement.argument))),"; end")); end
end

 do return "do return end"; end
end)
compileWithStatement = (function (this, statement)
local compiledWithStatement;
compiledWithStatement = _arr({[0]="do\10"},1);
compiledWithStatement:push("local _ENV = _with(");
compiledWithStatement:push(compileExpression(_ENV,statement.object));
compiledWithStatement:push(", _ENV);\10");
compiledWithStatement:push(compileStatement(_ENV,statement.body));
compiledWithStatement:push("end");
 do return compiledWithStatement:join(""); end
end)
compileExpression = (function (this, expression)
repeat
local _into = false;
local _cases = {["AssignmentExpression"] = true,["FunctionExpression"] = true,["Identifier"] = true,["Literal"] = true,["UnaryExpression"] = true,["BinaryExpression"] = true,["LogicalExpression"] = true,["MemberExpression"] = true,["CallExpression"] = true,["NewExpression"] = true,["ThisExpression"] = true,["ObjectExpression"] = true,["UpdateExpression"] = true,["ArrayExpression"] = true,["ConditionalExpression"] = true,["SequenceExpression"] = true};
if (not _cases[expression.type]) then
_into = true;
goto _default
end
if _into or (expression.type == "AssignmentExpression") then
 do return compileAssignmentExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "FunctionExpression") then
 do return compileFunction(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "Identifier") then
 do return compileIdentifier(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "Literal") then
 do return compileLiteral(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "UnaryExpression") then
 do return compileUnaryExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "BinaryExpression") then
 do return compileBinaryExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "LogicalExpression") then
 do return compileLogicalExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "MemberExpression") then
 do return compileMemberExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "CallExpression") then
 do return compileCallExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "NewExpression") then
 do return compileNewExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "ThisExpression") then
 do return compileThisExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "ObjectExpression") then
 do return compileObjectExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "UpdateExpression") then
 do return compileUpdateExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "ArrayExpression") then
 do return compileArrayExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "ConditionalExpression") then
 do return compileConditionalExpression(_ENV,expression); end
_into = true;
end
if _into or (expression.type == "SequenceExpression") then
 do return compileSequenceExpression(_ENV,expression); end
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_add("Unknown Expression type: ",expression.type))),0)
_into = true;
end
until true
end)
compileExpressionStatement = (function (this, expression)
local compiledExpressionStatement;
repeat
local _into = false;
local _cases = {["FunctionExpression"] = true,["UpdateExpression"] = true,["Literal"] = true,["Identifier"] = true,["ThisExpression"] = true,["UnaryExpression"] = true,["BinaryExpression"] = true,["LogicalExpression"] = true,["ConditionalExpression"] = true,["MemberExpression"] = true,["AssignmentExpression"] = true};
if (not _cases[expression.type]) then
_into = true;
goto _default
end
if _into or (expression.type == "FunctionExpression") then

_into = true;
end
if _into or (expression.type == "UpdateExpression") then

_into = true;
end
if _into or (expression.type == "Literal") then

_into = true;
end
if _into or (expression.type == "Identifier") then

_into = true;
end
if _into or (expression.type == "ThisExpression") then

_into = true;
end
if _into or (expression.type == "UnaryExpression") then

_into = true;
end
if _into or (expression.type == "BinaryExpression") then

_into = true;
end
if _into or (expression.type == "LogicalExpression") then

_into = true;
end
if _into or (expression.type == "ConditionalExpression") then

_into = true;
end
if _into or (expression.type == "MemberExpression") then

_into = true;
end
if _into or (expression.type == "AssignmentExpression") then
compiledExpressionStatement = _arr({[0]="_e("},1);
compiledExpressionStatement:push(compileExpression(_ENV,expression));
compiledExpressionStatement:push(");");
 do return compiledExpressionStatement:join(""); end
_into = true;
end
::_default::
if _into then
 do return (_add(compileExpression(_ENV,expression),";")); end
_into = true;
end
until true
end)
compileAssignmentExpression = (function (this, expression)
local compiledBinaryExpression,binaryExpression,right,left,compiledAssignmentExpression;
compiledAssignmentExpression = _arr({[0]="(function () local _tmp = "},1);
left = compileExpression(_ENV,expression.left);
repeat
local _into = false;
local _cases = {["="] = true};
if (not _cases[expression.operator]) then
_into = true;
goto _default
end
if _into or (expression.operator == "=") then
right = compileExpression(_ENV,expression.right);
compiledAssignmentExpression:push(right);
compiledAssignmentExpression:push("; ");
compiledAssignmentExpression:push(left);
compiledAssignmentExpression:push("  = _tmp; return _tmp; end)()");
break;
_into = true;
end
::_default::
if _into then
binaryExpression = _arr({},0);
_e((function () local _tmp = "BinaryExpression"; binaryExpression.type  = _tmp; return _tmp; end)());
_e((function () local _tmp = extractBinaryOperator(_ENV,expression.operator); binaryExpression.operator  = _tmp; return _tmp; end)());
_e((function () local _tmp = expression.left; binaryExpression.left  = _tmp; return _tmp; end)());
_e((function () local _tmp = expression.right; binaryExpression.right  = _tmp; return _tmp; end)());
compiledBinaryExpression = compileBinaryExpression(_ENV,binaryExpression);
compiledAssignmentExpression:push(compiledBinaryExpression);
compiledAssignmentExpression:push("; ");
compiledAssignmentExpression:push(left);
compiledAssignmentExpression:push("  = _tmp; return _tmp; end)()");
_into = true;
end
until true
 do return compiledAssignmentExpression:join(""); end
end)
extractBinaryOperator = (function (this, rawOperator)
 do return rawOperator:substring(0,rawOperator:indexOf("=")); end
end)
compileUpdateExpression = (function (this, expression)
local compiledArgument,compiledUpdateExpression;
compiledUpdateExpression = _arr({[0]="(function () local _tmp = "},1);
compiledArgument = compileExpression(_ENV,expression.argument);
if _bool(expression.prefix) then
repeat
local _into = false;
local _cases = {["++"] = true,["--"] = true};
if (not _cases[expression.operator]) then
_into = true;
goto _default
end
if _into or (expression.operator == "++") then
compiledUpdateExpression:push("_add(");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(", 1); ");
break;
_into = true;
end
if _into or (expression.operator == "--") then
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" - 1; ");
break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_add("Unknown UpdateOperator: ",expression.operator))),0)
_into = true;
end
until true
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" = _tmp");
else
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push("; ");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" = ");
repeat
local _into = false;
local _cases = {["++"] = true,["--"] = true};
if (not _cases[expression.operator]) then
_into = true;
goto _default
end
if _into or (expression.operator == "++") then
compiledUpdateExpression:push("_add(_tmp, 1)");
break;
_into = true;
end
if _into or (expression.operator == "--") then
compiledUpdateExpression:push("_tmp - 1");
break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_add("Unknown UpdateOperator: ",expression.operator))),0)
_into = true;
end
until true
end

compiledUpdateExpression:push("; return _tmp; end)()");
 do return compiledUpdateExpression:join(""); end
end)
replaceAt = (function (this, str, index, char)
 do return (_add((_add(str:substr(0,index),char)),str:substr((_add(index,1))))); end
end)
lastTopLevelBracketedGroupStartIndex = (function (this, str)
local i,count,startIndex;
startIndex = 0;
count = 0;
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < str.length)) do
if _bool((str[i] == "[")) then
if _bool((count == 0)) then
_e((function () local _tmp = i; startIndex  = _tmp; return _tmp; end)());
end

_e((function () local _tmp = count; count = _add(_tmp, 1); return _tmp; end)());
elseif _bool((str[i] == "]")) then
_e((function () local _tmp = count; count = _tmp - 1; return _tmp; end)());
end

_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

 do return startIndex; end
end)
compileCallArguments = (function (this, args)
local i,compiledArguments;
compiledArguments = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < args.length)) do
compiledArguments:push(compileExpression(_ENV,args[i]));
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

 do return compiledArguments:join(","); end
end)
compileCallExpression = (function (...)
local this, expression = ...;
local arguments = _args(...);
local lastPointIndex,member,base,startIndex,compiledArguments,compiledCallee,compiledCallExpression;
compiledCallExpression = _arr({},0);
compiledCallee = compileExpression(_ENV,expression.callee);
compiledArguments = compileCallArguments(_ENV,expression.arguments);
if _bool((expression.callee.type == "MemberExpression")) then
if _bool(compiledCallee:match(_regexp("\\]$",""))) then
startIndex = lastTopLevelBracketedGroupStartIndex(_ENV,compiledCallee);
base = compiledCallee:substr(0,startIndex);
member = compiledCallee:substr((_add(startIndex,1)));
compiledCallExpression:push("(function() local _this = ");
compiledCallExpression:push(base);
compiledCallExpression:push("; local _f = _this[");
compiledCallExpression:push(member);
compiledCallExpression:push("; return _f(_this");
if _bool((compiledArguments ~= "")) then
compiledCallExpression:push((_add(",",compiledArguments)));
end

compiledCallExpression:push("); end)()");
else
lastPointIndex = compiledCallee:lastIndexOf(".");
_e((function () local _tmp = replaceAt(_ENV,compiledCallee,lastPointIndex,":"); compiledCallee  = _tmp; return _tmp; end)());
compiledCallExpression:push(compiledCallee);
compiledCallExpression:push("(");
compiledCallExpression:push(compiledArguments);
compiledCallExpression:push(")");
end

else
compiledCallExpression:push(compiledCallee);
compiledCallExpression:push("(_ENV");
if _bool(compiledArguments) then
compiledCallExpression:push((_add(",",compiledArguments)));
end

compiledCallExpression:push(")");
end

 do return compiledCallExpression:join(""); end
end)
compileLogicalExpression = (function (this, expression)
local right,left,compiledLogicalExpression;
compiledLogicalExpression = _arr({[0]="("},1);
left = compileExpression(_ENV,expression.left);
right = compileExpression(_ENV,expression.right);
compiledLogicalExpression:push(left);
repeat
local _into = false;
local _cases = {["&&"] = true,["||"] = true};
if (not _cases[expression.operator]) then
_into = true;
goto _default
end
if _into or (expression.operator == "&&") then
compiledLogicalExpression:push(" and ");
break;
_into = true;
end
if _into or (expression.operator == "||") then
compiledLogicalExpression:push(" or ");
break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_add("Unknown LogicalOperator: ",expression.operator))),0)
_into = true;
end
until true
compiledLogicalExpression:push(right);
compiledLogicalExpression:push(")");
 do return compiledLogicalExpression:join(""); end
end)
getBaseMember = (function (this, expession)
local startIndex;
startIndex = 0;
if _bool(expession:match(_regexp("\\]$",""))) then
_e((function () local _tmp = lastTopLevelBracketedGroupStartIndex(_ENV,expession); startIndex  = _tmp; return _tmp; end)());
 do return _obj({
["base"] = expession:slice(0,startIndex),
["member"] = expession:slice((_add(startIndex,1)),-_tonum(1))
}); end
else
_e((function () local _tmp = expession:lastIndexOf("."); startIndex  = _tmp; return _tmp; end)());
 do return _obj({
["base"] = expession:slice(0,startIndex),
["member"] = expession:slice((_add(startIndex,1)))
}); end
end

end)
getGetterSetterExpression = (function (this, expression)
local split;
split = getBaseMember(_ENV,expression);
 do return _obj({
["getter"] = (_add((_add(split.base,"._g")),split.member)),
["setter"] = (_add((_add(split.base,"._s")),split.member))
}); end
end)
compileUnaryExpression = (function (this, expression)
local gs,scope,compiledExpression,compiledUnaryExpression;
compiledUnaryExpression = _arr({},0);
compiledExpression = compileExpression(_ENV,expression.argument);
if _bool(expression.prefix) then
repeat
local _into = false;
local _cases = {["-"] = true,["+"] = true,["!"] = true,["~"] = true,["typeof"] = true,["delete"] = true,["void"] = true};
if (not _cases[expression.operator]) then
_into = true;
goto _default
end
if _into or (expression.operator == "-") then
compiledUnaryExpression:push("-_tonum(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "+") then
compiledUnaryExpression:push("_tonum(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "!") then
compiledUnaryExpression:push("not _bool(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "~") then
compiledUnaryExpression:push("_bit.bnot(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "typeof") then
compiledUnaryExpression:push("_type(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "delete") then
scope = "_ENV.";
compiledUnaryExpression:push("(function () local _r = false; ");
if _bool((expression.argument.type == "MemberExpression")) then
_e((function () local _tmp = ""; scope  = _tmp; return _tmp; end)());
gs = getGetterSetterExpression(_ENV,compiledExpression);
compiledUnaryExpression:push("local _g, _s = ");
compiledUnaryExpression:push(gs.getter);
compiledUnaryExpression:push(", ");
compiledUnaryExpression:push(gs.setter);
compiledUnaryExpression:push("; ");
compiledUnaryExpression:push(gs.getter);
compiledUnaryExpression:push(", ");
compiledUnaryExpression:push(gs.setter);
compiledUnaryExpression:push(" = nil, nil; _r = _g ~= nil or _s ~= nil;\10");
end

compiledUnaryExpression:push("local _v = ");
compiledUnaryExpression:push((_add(scope,compiledExpression)));
compiledUnaryExpression:push("; ");
compiledUnaryExpression:push((_add(scope,compiledExpression)));
compiledUnaryExpression:push(" = nil; return _r or _v ~= nil; end)()");
break;
_into = true;
end
if _into or (expression.operator == "void") then
compiledUnaryExpression:push("_void(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_add("Unknown UnaryOperator: ",expression.operator))),0)
_into = true;
end
until true
else
_throw(_new(Error,"UnaryExpression: postfix ?!"),0)
end

 do return compiledUnaryExpression:join(""); end
end)
compileBinaryExpression = (function (this, expression)
local right,left,compiledBinaryExpression;
compiledBinaryExpression = _arr({[0]="("},1);
left = compileExpression(_ENV,expression.left);
right = compileExpression(_ENV,expression.right);
repeat
local _into = false;
local _cases = {["=="] = true,["!="] = true,["==="] = true,["!=="] = true,["<"] = true,["<="] = true,[">"] = true,[">="] = true,["<<"] = true,[">>"] = true,[">>>"] = true,["+"] = true,["-"] = true,["*"] = true,["/"] = true,["%"] = true,["|"] = true,["^"] = true,["&"] = true,["in"] = true,["instanceof"] = true,[".."] = true};
if (not _cases[expression.operator]) then
_into = true;
goto _default
end
if _into or (expression.operator == "==") then
compiledBinaryExpression:push("_eq(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "!=") then
compiledBinaryExpression:push("not _eq(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "===") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," == ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "!==") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," ~= ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "<") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," < ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "<=") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," <= ",left,right);
break;
_into = true;
end
if _into or (expression.operator == ">") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," > ",left,right);
break;
_into = true;
end
if _into or (expression.operator == ">=") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," >= ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "<<") then
compiledBinaryExpression:push("_bit.lshift(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == ">>") then
compiledBinaryExpression:push("_bit.arshift(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == ">>>") then
compiledBinaryExpression:push("_bit.rshift(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "+") then
compiledBinaryExpression:push("_add(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "-") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," - ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "*") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," * ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "/") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," / ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "%") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," % ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "|") then
compiledBinaryExpression:push("_bit.bor(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "^") then
compiledBinaryExpression:push("_bit.bxor(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "&") then
compiledBinaryExpression:push("_bit.band(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "in") then
compiledBinaryExpression:push("_in(");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "instanceof") then
compiledBinaryExpression:push("_instanceof(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
break;
_into = true;
end
if _into or (expression.operator == "..") then
break;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_add("Unknown BinaryOperator: ",expression.operator))),0)
_into = true;
end
until true
compiledBinaryExpression:push(")");
 do return compiledBinaryExpression:join(""); end
end)
pushSimpleBinaryExpression = (function (this, compiledBinaryExpression, operator, left, right)
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(operator);
compiledBinaryExpression:push(right);
end)
compileConditionalExpression = (function (this, expression)
local compiledConditionalExpression;
compiledConditionalExpression = _arr({[0]="(_bool("},1);
compiledConditionalExpression:push(compileExpression(_ENV,expression.test));
compiledConditionalExpression:push(") and {");
compiledConditionalExpression:push(compileExpression(_ENV,expression.consequent));
compiledConditionalExpression:push("} or {");
compiledConditionalExpression:push(compileExpression(_ENV,expression.alternate));
compiledConditionalExpression:push("})[1]");
 do return compiledConditionalExpression:join(""); end
end)
compileSequenceExpression = (function (this, expression)
local sequence,expressions,i,compiledSequenceExpression;
compiledSequenceExpression = _arr({[0]="_seq({"},1);
expressions = expression.expressions;
sequence = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < expressions.length)) do
sequence:push(compileExpression(_ENV,expressions[i]));
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledSequenceExpression:push(sequence:join(","));
compiledSequenceExpression:push("})");
 do return compiledSequenceExpression:join(""); end
end)
compileObjectExpression = (function (this, expression)
local compiledKey,compiledProperties,compiledProperty,property,length,i,compiledObjectExpression;
compiledObjectExpression = _arr({[0]="_obj({\10"},1);
length = expression.properties.length;
compiledProperty = _arr({},0);
compiledProperties = _arr({},0);
compiledKey = "";
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < length)) do
_e((function () local _tmp = _arr({[0]="["},1); compiledProperty  = _tmp; return _tmp; end)());
_e((function () local _tmp = expression.properties[i]; property  = _tmp; return _tmp; end)());
if _bool((property.key.type == "Literal")) then
_e((function () local _tmp = compileLiteral(_ENV,property.key); compiledKey  = _tmp; return _tmp; end)());
elseif _bool((property.key.type == "Identifier")) then
_e((function () local _tmp = "\""; compiledKey  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(compiledKey,sanitizeLiteralString(_ENV,property.key.name))); compiledKey  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(compiledKey,"\"")); compiledKey  = _tmp; return _tmp; end)());
else
_throw(_new(Error,(_add("Unexpected property key type: ",property.key.type))),0)
end

if _bool((property.kind == "get")) then
if _bool((_type(property.key.value) == "number")) then
_e((function () local _tmp = (_add((_add("\"",compiledKey)),"\"")); compiledKey  = _tmp; return _tmp; end)());
end

_e((function () local _tmp = compiledKey:replace(_regexp("^\"",""),"\"_g"); compiledKey  = _tmp; return _tmp; end)());
elseif _bool((property.kind == "set")) then
if _bool((_type(property.key.value) == "number")) then
_e((function () local _tmp = (_add((_add("\"",compiledKey)),"\"")); compiledKey  = _tmp; return _tmp; end)());
end

_e((function () local _tmp = compiledKey:replace(_regexp("^\"",""),"\"_s"); compiledKey  = _tmp; return _tmp; end)());
end

compiledProperty:push(compiledKey);
compiledProperty:push("] = ");
compiledProperty:push(compileExpression(_ENV,property.value));
compiledProperties:push(compiledProperty:join(""));
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledObjectExpression:push(compiledProperties:join(",\10"));
compiledObjectExpression:push("\10})");
 do return compiledObjectExpression:join(""); end
end)
compileMemberExpression = (function (this, expression)
local compiledProperty,compiledObject,compiledMemberExpression;
compiledMemberExpression = _arr({},0);
compiledObject = compileExpression(_ENV,expression.object);
if _bool((expression.object.type == "Literal")) then
_e((function () local _tmp = (_add((_add("(",compiledObject)),")")); compiledObject  = _tmp; return _tmp; end)());
end

compiledMemberExpression:push(compiledObject);
if _bool(expression.computed) then
compiledMemberExpression:push("[");
compiledMemberExpression:push(compileExpression(_ENV,expression.property));
compiledMemberExpression:push("]");
else
compiledProperty = compileIdentifier(_ENV,expression.property);
if _bool((compiledProperty ~= expression.property.name)) then
compiledMemberExpression:push("[\"");
compiledMemberExpression:push(sanitizeLiteralString(_ENV,expression.property.name));
compiledMemberExpression:push("\"]");
else
compiledMemberExpression:push(".");
compiledMemberExpression:push(compiledProperty);
end

end

 do return compiledMemberExpression:join(""); end
end)
compileNewExpression = (function (...)
local this, expression = ...;
local arguments = _args(...);
local length,i,newArguments,compiledNewExpression;
compiledNewExpression = _arr({[0]="_new("},1);
newArguments = _arr({[0]=compileExpression(_ENV,expression.callee)},1);
length = expression.arguments.length;
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < length)) do
newArguments:push(compileExpression(_ENV,expression.arguments[i]));
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledNewExpression:push(newArguments:join(","));
compiledNewExpression:push(")");
 do return compiledNewExpression:join(""); end
end)
compileThisExpression = (function (this)
 do return "this"; end
end)
compileArrayExpression = (function (this, expression)
local length,i,compiledElements,compiledArrayExpression;
compiledArrayExpression = _arr({[0]="_arr({"},1);
compiledElements = _arr({},0);
length = expression.elements.length;
if _bool((length > 0)) then
compiledArrayExpression:push("[0]=");
end

_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < length)) do
if _bool((expression.elements[i] ~= null)) then
compiledElements:push(compileExpression(_ENV,expression.elements[i]));
else
compiledElements:push("nil");
end

_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledArrayExpression:push(compiledElements:join(","));
compiledArrayExpression:push("},");
compiledArrayExpression:push(length);
compiledArrayExpression:push(")");
 do return compiledArrayExpression:join(""); end
end)
compileFunctionDeclaration = (function (this, declaration)
local compiledId,compiledFunctionDeclaration;
compiledFunctionDeclaration = _arr({},0);
compiledId = compileIdentifier(_ENV,declaration.id);
compiledFunctionDeclaration:push(compiledId);
compiledFunctionDeclaration:push(" = ");
compiledFunctionDeclaration:push(compileFunction(_ENV,declaration));
localVarManager:pushLocal(compiledId);
localVarManager:pushFunction(compiledFunctionDeclaration:join(""));
end)
compileVariableDeclaration = (function (this, variableDeclaration)
local compiledDeclarationInit,expression,pattern,declarator,i,declarations,compiledDeclarations;
compiledDeclarations = _arr({},0);
repeat
local _into = false;
local _cases = {["const"] = true,["var"] = true,["let"] = true};
if (not _cases[variableDeclaration.kind]) then
_into = true;
goto _default
end
if _into or (variableDeclaration.kind == "const") then

_into = true;
end
if _into or (variableDeclaration.kind == "var") then
declarations = variableDeclaration.declarations;
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < declarations.length)) do
_e((function () local _tmp = declarations[i]; declarator  = _tmp; return _tmp; end)());
_e((function () local _tmp = compilePattern(_ENV,declarator.id); pattern  = _tmp; return _tmp; end)());
localVarManager:pushLocal(pattern);
if _bool((declarator.init ~= null)) then
_e((function () local _tmp = compileExpression(_ENV,declarator.init); expression  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); compiledDeclarationInit  = _tmp; return _tmp; end)());
compiledDeclarationInit:push(pattern);
compiledDeclarationInit:push(" = ");
compiledDeclarationInit:push(expression);
compiledDeclarationInit:push(";");
compiledDeclarations:push(compiledDeclarationInit:join(""));
end

_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

break;
_into = true;
end
if _into or (variableDeclaration.kind == "let") then
_throw(_new(Error,"let instruction is not supported yet"),0)
_into = true;
end
::_default::
until true
 do return compiledDeclarations:join("\10"); end
end)
compilePattern = (function (this, pattern)
repeat
local _into = false;
local _cases = {["Identifier"] = true};
if (not _cases[pattern.type]) then
_into = true;
goto _default
end
if _into or (pattern.type == "Identifier") then
 do return compileIdentifier(_ENV,pattern); end
_into = true;
end
::_default::
if _into then
_throw(_new(Error,(_add("Unknwown Pattern type",pattern.type))),0)
_into = true;
end
until true
end)
compileFunction = (function (this, fun)
local compiledFunctionsDeclaration,functions,compiledLocalsDeclaration,locals,compiledParams,compiledLocalParams,i,params,useArguments,context,compiledBody,compiledFunction;
compiledFunction = _arr({[0]="(function ("},1);
compiledBody = "";
localVarManager:createLocalContext();
if _bool((fun.body.type == "BlockStatement")) then
_e((function () local _tmp = compileStatement(_ENV,fun.body); compiledBody  = _tmp; return _tmp; end)());
elseif _bool((fun.body.type == "Expression")) then
_e((function () local _tmp = compileExpression(_ENV,fun.body); compiledBody  = _tmp; return _tmp; end)());
end

context = localVarManager:popLocalContext();
useArguments = context[1];
params = fun.params;
if _bool(useArguments) then
compiledFunction:push("...)\10");
compiledLocalParams = _arr({[0]="this"},1);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < params.length)) do
compiledLocalParams:push(compilePattern(_ENV,params[i]));
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledFunction:push((_add((_add("local ",compiledLocalParams:join(", ")))," = ...;\10")));
compiledFunction:push("local arguments = _args(...);\10");
else
compiledParams = _arr({[0]="this"},1);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < params.length)) do
compiledParams:push(compilePattern(_ENV,params[i]));
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledFunction:push(compiledParams:join(", "));
compiledFunction:push(")\10");
end

locals = context[0];
if _bool((locals.length > 0)) then
compiledLocalsDeclaration = buildLocalsDeclarationString(_ENV,locals);
compiledFunction:push(compiledLocalsDeclaration);
end

functions = context[2];
if _bool((functions.length > 0)) then
compiledFunctionsDeclaration = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < functions.length)) do
compiledFunctionsDeclaration:push(functions[i]);
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledFunction:push(compiledFunctionsDeclaration:join("\10"));
end

compiledFunction:push(compiledBody);
compiledFunction:push("\10");
compiledFunction:push("end)");
 do return compiledFunction:join(""); end
end)
buildLocalsDeclarationString = (function (this, locals)
local length,_g_local,i,namesSequence,compiledLocalsDeclaration;
compiledLocalsDeclaration = _arr({[0]="local "},1);
namesSequence = _arr({},0);
length = locals.length;
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < length)) do
_e((function () local _tmp = locals:pop(); _g_local  = _tmp; return _tmp; end)());
namesSequence:push(_g_local);
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledLocalsDeclaration:push(namesSequence:join(","));
compiledLocalsDeclaration:push(";\10");
 do return compiledLocalsDeclaration:join(""); end
end)
sanitizeIdentifier = (function (this, id)
if _bool((luaKeywords:indexOf(id) > -_tonum(1))) then
 do return (_add("_g_",id)); end
end

 do return id:replace(_regexp("_","g"),"__"):replace(_regexp("\\$","g"),"S"):replace(_regexp("[\194\128-\239\191\191]","g"),(function (this, c)
 do return (_add("_",c:charCodeAt(0))); end
end)); end
end)
compileIdentifier = (function (this, identifier)
if _bool((identifier.name == "arguments")) then
localVarManager:useArguments();
end

 do return sanitizeIdentifier(_ENV,identifier.name); end
end)
toUTF8Array = (function (this, str)
local charcode,i,utf8;
utf8 = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < str.length)) do
_e((function () local _tmp = str:charCodeAt(i); charcode  = _tmp; return _tmp; end)());
if _bool((charcode < 128)) then
utf8:push(charcode);
elseif _bool((charcode < 2048)) then
utf8:push((_bit.bor(192,(_bit.arshift(charcode,6)))),(_bit.bor(128,(_bit.band(charcode,63)))));
elseif _bool(((charcode < 55296) or (charcode >= 57344))) then
utf8:push((_bit.bor(224,(_bit.arshift(charcode,12)))),(_bit.bor(128,(_bit.band((_bit.arshift(charcode,6)),63)))),(_bit.bor(128,(_bit.band(charcode,63)))));
else
_e((function () local _tmp = i; i = _add(_tmp, 1); return _tmp; end)());
_e((function () local _tmp = (_add(65536,(_bit.bor((_bit.lshift((_bit.band(charcode,1023)),10)),(_bit.band(str:charCodeAt(i),1023)))))); charcode  = _tmp; return _tmp; end)());
utf8:push((_bit.bor(240,(_bit.arshift(charcode,18)))),(_bit.bor(128,(_bit.band((_bit.arshift(charcode,12)),63)))),(_bit.bor(128,(_bit.band((_bit.arshift(charcode,6)),63)))),(_bit.bor(128,(_bit.band(charcode,63)))));
end

_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

 do return utf8; end
end)
sanitizeLiteralString = (function (this, str)
 do return str:replace(_regexp("\\\\","g"),"\\\\"):replace(_regexp("\"","g"),"\\\""):replace(_regexp("[\\0-\31\127-\237\159\191\240\144\128\128-\239\191\191]|[\240\144\128\128-\244\143\176\128][\240\144\128\128-\244\143\176\128]|[\240\144\128\128-\244\143\176\128]","g"),(function (this, str)
 do return (_add("\\",toUTF8Array(_ENV,str):join("\\"))); end
end)); end
end)
sanitizeRegExpSource = (function (this, str)
 do return str:replace(_regexp("\\\\","g"),"\\\\"):replace(_regexp("\"","g"),"\\\""):replace(_regexp("\\\\\\\\u([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])","g"),(function (this, str, hexaCode)
local chars;
chars = String:fromCharCode(parseInt(_ENV,hexaCode,16));
 do return (_add("\\",toUTF8Array(_ENV,chars):join("\\"))); end
end)); end
end)
compileLiteral = (function (this, literal)
local flags,source,compiledRegExp,regexp,ret;
ret = literal.raw;
if _bool((_instanceof(literal.value,RegExp))) then
regexp = literal.value;
compiledRegExp = _arr({[0]="_regexp(\""},1);
source = sanitizeRegExpSource(_ENV,regexp.source);
compiledRegExp:push(source);
compiledRegExp:push("\",\"");
flags = "";
_e((function () local _tmp = (_add(flags,(_bool(regexp.global) and {"g"} or {""})[1])); flags  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(flags,(_bool(regexp.ignoreCase) and {"i"} or {""})[1])); flags  = _tmp; return _tmp; end)());
_e((function () local _tmp = (_add(flags,(_bool(regexp.multiline) and {"m"} or {""})[1])); flags  = _tmp; return _tmp; end)());
compiledRegExp:push(flags);
compiledRegExp:push("\")");
_e((function () local _tmp = compiledRegExp:join(""); ret  = _tmp; return _tmp; end)());
end

if _bool((_type(literal.value) == "string")) then
_e((function () local _tmp = (_add((_add("\"",sanitizeLiteralString(_ENV,literal.value))),"\"")); ret  = _tmp; return _tmp; end)());
end

if _bool((_type(literal.value) == "number")) then
_e((function () local _tmp = JSON:stringify(literal.value); ret  = _tmp; return _tmp; end)());
end

 do return ret; end
end)_e("use strict");
luaKeywords = _arr({[0]="and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while"},22);
labelTracker = _arr({},0);
continueNoLabelTracker = _arr({},0);
_e((function () local _tmp = _obj({
["isInProtectedCallContext"] = (function (this)
if _bool((this.protectedCallContext.length > 0)) then
 do return true; end
end

 do return false; end
end),
["noInsideIteration"] = (function (this)
 do return (this.iterationStatement[(this.iterationStatement.length - 1)].length == 0); end
end),
["noInsideSwitch"] = (function (this)
 do return (this.switchStatement[(this.switchStatement.length - 1)].length == 0); end
end),
["may"] = (function (this)
 do return _obj({
["mayReturn"] = this.mayReturnStack[(this.mayReturnStack.length - 1)],
["mayBreak"] = this.mayBreakStack[(this.mayBreakStack.length - 1)],
["mayContinue"] = this.mayContinueStack[(this.mayContinueStack.length - 1)]
}); end
end),
["openContext"] = (function (this)
this.protectedCallContext:push(true);
this.iterationStatement:push(_arr({},0));
this.switchStatement:push(_arr({},0));
this.mayBreakStack:push(false);
this.mayContinueStack:push(false);
this.mayReturnStack:push(false);
end),
["closeContext"] = (function (this)
this.protectedCallContext:pop();
this.iterationStatement:pop();
this.switchStatement:pop();
this.mayBreakStack:pop();
this.mayContinueStack:pop();
this.mayReturnStack:pop();
end),
["openIterationStatement"] = (function (this)
if _bool(this:isInProtectedCallContext()) then
this.iterationStatement[(this.iterationStatement.length - 1)]:push(true);
end

end),
["closeIterationStatement"] = (function (this)
if _bool(this:isInProtectedCallContext()) then
this.iterationStatement[(this.iterationStatement.length - 1)]:pop();
end

end),
["openSwitchStatement"] = (function (this)
if _bool(this:isInProtectedCallContext()) then
this.switchStatement[(this.iterationStatement.length - 1)]:push(true);
end

end),
["closeSwitchStatement"] = (function (this)
if _bool(this:isInProtectedCallContext()) then
this.switchStatement[(this.iterationStatement.length - 1)]:pop();
end

end),
["returnStatement"] = (function (this)
if _bool(this:isInProtectedCallContext()) then
_e((function () local _tmp = true; this.mayReturnStack[(this.mayReturnStack.length - 1)]  = _tmp; return _tmp; end)());
end

end),
["breakOutside"] = (function (this)
if _bool(((this:isInProtectedCallContext() and this:noInsideIteration()) and this:noInsideSwitch())) then
_e((function () local _tmp = true; this.mayBreakStack[(this.mayBreakStack.length - 1)]  = _tmp; return _tmp; end)());
 do return true; end
end

 do return false; end
end),
["continueOutside"] = (function (this)
if _bool((this:isInProtectedCallContext() and this:noInsideIteration())) then
_e((function () local _tmp = true; this.mayContinueStack[(this.mayContinueStack.length - 1)]  = _tmp; return _tmp; end)());
 do return true; end
end

 do return false; end
end)
}); ProtectedCallManager.prototype  = _tmp; return _tmp; end)());
protectedCallManager = _new(ProtectedCallManager);
_e((function () local _tmp = _obj({
["popLocalContext"] = (function (this)
if _bool((this.locals.length > 0)) then
 do return _arr({[0]=this.locals:pop(),this.args:pop(),this.functions:pop()},3); end
end

_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end),
["createLocalContext"] = (function (this)
this.locals:push(_arr({},0));
this.functions:push(_arr({},0));
this.args:push(false);
end),
["pushLocal"] = (function (this, varName)
if _bool((this.locals.length > 0)) then
this.locals[(this.locals.length - 1)]:push(varName);
else
_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end

end),
["pushFunction"] = (function (this, functionDeclaration)
if _bool((this.functions.length > 0)) then
this.functions[(this.functions.length - 1)]:push(functionDeclaration);
else
_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end

end),
["useArguments"] = (function (this)
if _bool((this.args.length > 0)) then
_e((function () local _tmp = true; this.args[(this.args.length - 1)]  = _tmp; return _tmp; end)());
else
_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end

end)
}); LocalVarManager.prototype  = _tmp; return _tmp; end)());
localVarManager = _new(LocalVarManager);
_e((function () local _tmp = compileAST; exports.compileAST  = _tmp; return _tmp; end)());
end));

return this.castl
