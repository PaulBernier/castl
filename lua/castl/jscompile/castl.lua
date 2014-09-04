_ENV = require("castl.runtime");
(function (this, root, factory)
_e("use strict");
if _bool((_type(define) == "function") and define.amd) then
define(this,_arr({[0]="exports"},1),factory);
elseif _bool((exports ~= undefined)) then
factory(this,exports);
else
_e((function () local _tmp = _obj({

}); root.castl  = _tmp; return _tmp; end)());
factory(this,root.castl);
end

end)(this,this,(function (this, exports)
local compileLiteral,sanitizeRegExpSource,sanitizeLiteralString,toUTF8Array,compileIdentifier,sanitizeIdentifier,buildLocalsDeclarationString,compileFunction,compilePattern,compileVariableDeclaration,compileDeclaration,compileArrayExpression,compileThisExpression,compileNewExpression,compileMemberExpression,compileObjectExpression,compileSequenceExpression,compileConditionalExpression,pushSimpleBinaryExpression,compileBinaryExpression,compileUnaryExpression,compileLogicalExpression,compileCallExpression,compileCallArguments,lastTopLevelBracketedGroupStartIndex,replaceAt,compileUpdateExpression,extractBinaryOperator,compileAssignmentExpression,compileExpressionStatement,compileExpression,compileWithStatement,compileReturnStatement,compileThrowStatement,compileTryStatementFlavored,compileTryStatement,compileSwitchStatement,compileContinueStatement,compileBreakStatement,compileLabeledStatement,isIterationStatement,compileDoWhileStatement,compileWhileStatement,compileForInStatement,compileForStatement,compileIterationStatement,compileForUpdate,compileForInit,compileIfStatement,compileListOfStatements,compileStatement,compileAST,localVarManager,LocalVarManager,protectedCallManager,ProtectedCallManager,continueNoLabelTracker,labelTracker,luaKeywords;
_e("use strict");
luaKeywords = _arr({[0]="and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while"},22);
labelTracker = _arr({},0);
continueNoLabelTracker = _arr({},0);
ProtectedCallManager = (function (this)
_e((function () local _tmp = false; this.isInProtectedCallContext  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; this.mayReturn  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; this.mayBreak  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; this.mayContinue  = _tmp; return _tmp; end)());
end)
_e((function () local _tmp = _obj({
["openContext"] = (function (this)
_e((function () local _tmp = true; this.isInProtectedCallContext  = _tmp; return _tmp; end)());
end),
["closeContext"] = (function (this)
_e((function () local _tmp = false; this.isInProtectedCallContext  = _tmp; return _tmp; end)());
end),
["reset"] = (function (this)
this:closeContext();
_e((function () local _tmp = false; this.mayReturn  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; this.mayBreak  = _tmp; return _tmp; end)());
_e((function () local _tmp = false; this.mayContinue  = _tmp; return _tmp; end)());
end),
["returnStatement"] = (function (this)
if _bool(this.isInProtectedCallContext) then
_e((function () local _tmp = true; this.mayReturn  = _tmp; return _tmp; end)());
end

end),
["breakStatement"] = (function (this)
if _bool(this.isInProtectedCallContext) then
_e((function () local _tmp = true; this.mayBreak  = _tmp; return _tmp; end)());
end

end),
["continueStatement"] = (function (this)
if _bool(this.isInProtectedCallContext) then
_e((function () local _tmp = true; this.mayContinue  = _tmp; return _tmp; end)());
end

end),
["mayModifyFlow"] = (function (this)
 do return this.mayReturn or this.mayBreak or this.mayContinue; end
end)
}); ProtectedCallManager.prototype  = _tmp; return _tmp; end)());
protectedCallManager = _new(ProtectedCallManager);
LocalVarManager = (function (this)
_e((function () local _tmp = _arr({},0); this.stack  = _tmp; return _tmp; end)());
_e((function () local _tmp = _arr({},0); this.args  = _tmp; return _tmp; end)());
end)
_e((function () local _tmp = _obj({
["popLocalContext"] = (function (this)
if _bool((this.stack.length > 0)) then
 do return _arr({[0]=this.stack:pop(),this.args:pop()},2); end
end

_error(_new(Error,"LocalVarManager error: no current local context"),0)
end),
["createLocalContext"] = (function (this)
this.stack:push(_arr({},0));
this.args:push(false);
end),
["pushLocal"] = (function (this, varName)
if _bool((this.stack.length > 0)) then
this.stack[(this.stack.length - 1)]:push(varName);
else
_error(_new(Error,"LocalVarManager error: no current local context"),0)
end

end),
["useArguments"] = (function (this)
if _bool((this.args.length > 0)) then
_e((function () local _tmp = true; this.args[(this.args.length - 1)]  = _tmp; return _tmp; end)());
else
_error(_new(Error,"LocalVarManager error: no current local context"),0)
end

end)
}); LocalVarManager.prototype  = _tmp; return _tmp; end)());
localVarManager = _new(LocalVarManager);
compileAST = (function (this, ast)
local compiledLocalsDeclaration,locals,useArguments,context,topLevelStatements,compiledProgram;
if _bool((ast.type == "Program")) then
compiledProgram = _arr({},0);
localVarManager:createLocalContext();
topLevelStatements = compileListOfStatements(this,ast.body);
context = localVarManager:popLocalContext();
useArguments = context[1];
if _bool(useArguments) then
compiledProgram:push("local arguments = _args(...);");
end

locals = context[0];
if _bool((locals.length > 0)) then
compiledLocalsDeclaration = buildLocalsDeclarationString(this,locals);
compiledProgram:push(compiledLocalsDeclaration);
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
 do return compileExpressionStatement(this,statement.expression); end
_into = true;
end
if _into or (statement.type == "BlockStatement") then
 do return compileListOfStatements(this,statement.body); end
_into = true;
end
if _into or (statement.type == "FunctionDeclaration") then

_into = true;
end
if _into or (statement.type == "VariableDeclaration") then
 do return compileDeclaration(this,statement); end
_into = true;
end
if _into or (statement.type == "IfStatement") then
 do return compileIfStatement(this,statement); end
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
 do return compileIterationStatement(this,statement); end
_into = true;
end
if _into or (statement.type == "ReturnStatement") then
 do return compileReturnStatement(this,statement); end
_into = true;
end
if _into or (statement.type == "BreakStatement") then
 do return compileBreakStatement(this,statement); end
_into = true;
end
if _into or (statement.type == "TryStatement") then
 do return compileTryStatement(this,statement); end
_into = true;
end
if _into or (statement.type == "ThrowStatement") then
 do return compileThrowStatement(this,statement); end
_into = true;
end
if _into or (statement.type == "SwitchStatement") then
 do return compileSwitchStatement(this,statement); end
_into = true;
end
if _into or (statement.type == "ContinueStatement") then
 do return compileContinueStatement(this,statement); end
_into = true;
end
if _into or (statement.type == "LabeledStatement") then
 do return compileLabeledStatement(this,statement); end
_into = true;
end
if _into or (statement.type == "WithStatement") then
 do return compileWithStatement(this,statement); end
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
_error(_new(Error,(_add("Unknown Statement type: ",statement.type))),0)
_into = true;
end
until true
end)
compileListOfStatements = (function (this, statementList)
local compiledStatement,i,compiledStatements;
compiledStatements = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < statementList.length)) do
_e((function () local _tmp = compileStatement(this,statementList[i]); compiledStatement  = _tmp; return _tmp; end)());
if _bool((compiledStatement ~= "")) then
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

compiledIfStatement:push(compileExpression(this,statement.test));
compiledIfStatement:push(") then\10");
compiledIfStatement:push(compileStatement(this,statement.consequent));
if _bool((statement.alternate ~= null)) then
compiledIfStatement:push("\10");
if _bool((statement.alternate.type == "IfStatement")) then
compiledIfStatement:push(compileIfStatement(this,statement.alternate,true));
else
compiledIfStatement:push("else\10");
compiledIfStatement:push(compileStatement(this,statement.alternate));
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
compiledForInit:push(compileVariableDeclaration(this,init));
else
compiledForInit:push(compileExpressionStatement(this,init));
end

compiledForInit:push("\10");
end

 do return compiledForInit:join(""); end
end)
compileForUpdate = (function (this, update)
local compiledForUpdate;
compiledForUpdate = _arr({},0);
if _bool((update ~= null)) then
compiledForUpdate:push(compileExpressionStatement(this,update));
compiledForUpdate:push("\10");
end

 do return compiledForUpdate:join(""); end
end)
compileIterationStatement = (function (this, statement, compiledLabel)
local compiledIterationStatement;
compiledIterationStatement = "";
continueNoLabelTracker:push(false);
repeat
local _into = false;
local _cases = {["ForStatement"] = true,["WhileStatement"] = true,["DoWhileStatement"] = true,["ForInStatement"] = true};
if (not _cases[statement.type]) then
_into = true;
goto _default
end
if _into or (statement.type == "ForStatement") then
_e((function () local _tmp = compileForStatement(this,statement,compiledLabel); compiledIterationStatement  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (statement.type == "WhileStatement") then
_e((function () local _tmp = compileWhileStatement(this,statement,compiledLabel); compiledIterationStatement  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (statement.type == "DoWhileStatement") then
_e((function () local _tmp = compileDoWhileStatement(this,statement,compiledLabel); compiledIterationStatement  = _tmp; return _tmp; end)());
break;
_into = true;
end
if _into or (statement.type == "ForInStatement") then
_e((function () local _tmp = compileForInStatement(this,statement,compiledLabel); compiledIterationStatement  = _tmp; return _tmp; end)());
break;
_into = true;
end
::_default::
if _into then
_error(_new(Error,(_add("Not an IterationStatement ",statement.type))),0)
_into = true;
end
until true
continueNoLabelTracker:pop();
 do return compiledIterationStatement; end
end)
compileForStatement = (function (this, statement, compiledLabel)
local compiledUpdate,compiledForStatement;
compiledForStatement = _arr({},0);
compiledUpdate = compileForUpdate(this,statement.update);
compiledForStatement:push(compileForInit(this,statement.init));
compiledForStatement:push("while _bool(");
if _bool((statement.test ~= null)) then
compiledForStatement:push(compileExpression(this,statement.test));
else
compiledForStatement:push("true");
end

compiledForStatement:push(") do\10");
compiledForStatement:push(compileStatement(this,statement.body));
compiledForStatement:push("\10");
if _bool(continueNoLabelTracker[(continueNoLabelTracker.length - 1)]) then
compiledForStatement:push("::_continue::\10");
end

if _bool(compiledLabel and labelTracker[compiledLabel].mayContinue) then
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
_e((function () local _tmp = compilePattern(this,statement.left.declarations[0].id); compiledLeft  = _tmp; return _tmp; end)());
localVarManager:pushLocal(compiledLeft);
compiledForInStatement:push(compiledLeft);
else
_e((function () local _tmp = compileExpression(this,statement.left); compiledLeft  = _tmp; return _tmp; end)());
compiledForInStatement:push(compiledLeft);
end

compiledForInStatement:push(" in _props(");
compiledForInStatement:push(compileExpression(this,statement.right));
compiledForInStatement:push(") do\10");
compiledForInStatement:push(compiledLeft);
compiledForInStatement:push(" = _tostr(");
compiledForInStatement:push(compiledLeft);
compiledForInStatement:push(");\10");
compiledForInStatement:push(compileStatement(this,statement.body));
compiledForInStatement:push("::_continue::\10");
if _bool(compiledLabel and labelTracker[compiledLabel].mayContinue) then
compiledForInStatement:push((_add((_add("::",compiledLabel)),"_c::\10")));
end

compiledForInStatement:push("end\10");
 do return compiledForInStatement:join(""); end
end)
compileWhileStatement = (function (this, statement, compiledLabel)
local compiledWhileStatement;
compiledWhileStatement = _arr({[0]="while _bool("},1);
compiledWhileStatement:push(compileExpression(this,statement.test));
compiledWhileStatement:push(") do\10");
compiledWhileStatement:push(compileStatement(this,statement.body));
compiledWhileStatement:push("\10");
compiledWhileStatement:push("::_continue::\10");
if _bool(compiledLabel and labelTracker[compiledLabel].mayContinue) then
compiledWhileStatement:push((_add((_add("::",compiledLabel)),"_c::\10")));
end

compiledWhileStatement:push("end\10");
 do return compiledWhileStatement:join(""); end
end)
compileDoWhileStatement = (function (this, statement, compiledLabel)
local compiledDoWhileStatement;
compiledDoWhileStatement = _arr({[0]="repeat\10"},1);
compiledDoWhileStatement:push(compileStatement(this,statement.body));
compiledDoWhileStatement:push("\10");
compiledDoWhileStatement:push("::_continue::\10");
if _bool(compiledLabel and labelTracker[compiledLabel].mayContinue) then
compiledDoWhileStatement:push((_add((_add("::",compiledLabel)),"_c::\10")));
end

compiledDoWhileStatement:push("until not _bool(");
compiledDoWhileStatement:push(compileExpression(this,statement.test));
compiledDoWhileStatement:push(")\10");
 do return compiledDoWhileStatement:join(""); end
end)
isIterationStatement = (function (this, statement)
 do return (statement.type == "ForStatement") or (statement.type == "DoWhileStatement") or (statement.type == "WhileStatement") or (statement.type == "ForInStatement"); end
end)
compileLabeledStatement = (function (this, statement)
local compiledLabel,label,compiledLabeledStatement;
compiledLabeledStatement = _arr({},0);
if _bool(isIterationStatement(this,statement.body)) then
label = statement.label;
compiledLabel = compileIdentifier(this,label);
_e((function () local _tmp = _obj({
["mayBreak"] = false,
["mayContinue"] = false
}); labelTracker[compiledLabel]  = _tmp; return _tmp; end)());
compiledLabeledStatement:push(compileIterationStatement(this,statement.body,compiledLabel));
if _bool(labelTracker[compiledLabel].mayBreak) then
compiledLabeledStatement:push((_add((_add("::",compiledLabel)),"_b::\10")));
end

_e((function () local _tmp = labelTracker[compiledLabel]; labelTracker[compiledLabel] = nil; return _tmp ~= nil; end)());
else
compiledLabeledStatement:push(compileStatement(this,statement.body));
end

 do return compiledLabeledStatement:join(""); end
end)
compileBreakStatement = (function (this, statement)
local compiledLabel;
protectedCallManager:breakStatement();
if _bool((statement.label == null)) then
if _bool(protectedCallManager.isInProtectedCallContext) then
 do return "do return _break; end"; end
end

 do return "break;"; end
end

compiledLabel = compileIdentifier(this,statement.label);
_e((function () local _tmp = true; labelTracker[compiledLabel].mayBreak  = _tmp; return _tmp; end)());
 do return (_add((_add("goto ",compiledLabel)),"_b;")); end
end)
compileContinueStatement = (function (this, statement)
local compiledLabel;
protectedCallManager:continueStatement();
if _bool((statement.label == null)) then
_e((function () local _tmp = true; continueNoLabelTracker[(continueNoLabelTracker.length - 1)]  = _tmp; return _tmp; end)());
if _bool(protectedCallManager.isInProtectedCallContext) then
 do return "do return _continue; end"; end
end

 do return "goto _continue"; end
end

compiledLabel = compileIdentifier(this,statement.label);
_e((function () local _tmp = true; labelTracker[compiledLabel].mayContinue  = _tmp; return _tmp; end)());
 do return (_add((_add("goto ",compiledLabel)),"_c;")); end
end)
compileSwitchStatement = (function (this, statement)
local hasDefault,compiledTests,caseTablementElement,casesTable,i,compiledDiscriminant,compiledSwitchStatement,cases;
cases = statement.cases;
if _bool((cases.length > 0)) then
compiledSwitchStatement = _arr({[0]="repeat\10local _into = false;\10"},1);
compiledDiscriminant = compileExpression(this,statement.discriminant);
casesTable = _arr({},0);
compiledTests = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < cases.length)) do
if _bool((cases[i].test ~= null)) then
_e((function () local _tmp = compileExpression(this,cases[i].test); compiledTests[i]  = _tmp; return _tmp; end)());
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

compiledSwitchStatement:push(compileListOfStatements(this,cases[i].consequent));
compiledSwitchStatement:push("\10");
compiledSwitchStatement:push("_into = true;\10");
compiledSwitchStatement:push("end\10");
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

if _bool(not _bool(hasDefault)) then
compiledSwitchStatement:push("::_default::\10");
end

compiledSwitchStatement:push("until true");
 do return compiledSwitchStatement:join(""); end
end

 do return ""; end
end)
compileTryStatement = (function (this, statement)
if _bool(statement.handlers) then
 do return compileTryStatementFlavored(this,statement,true); end
end

 do return compileTryStatementFlavored(this,statement,false); end
end)
compileTryStatementFlavored = (function (this, statement, esprima)
local handler,compiledTryStatement,finallyStatements,hasFinalizer,hasHandler;
hasHandler = (_bool(esprima) and {(statement.handlers.length > 0)} or {(statement.handler ~= null)})[1];
hasFinalizer = (statement.finalizer ~= null);
protectedCallManager:openContext();
compiledTryStatement = _arr({[0]="local _status, _return = _pcall(function()\10"},1);
compiledTryStatement:push(compileListOfStatements(this,statement.block.body));
compiledTryStatement:push("\10");
compiledTryStatement:push("end);\10");
protectedCallManager:closeContext();
if _bool(hasFinalizer or protectedCallManager:mayModifyFlow()) then
compiledTryStatement:push("if _status then\10");
if _bool(hasFinalizer) then
_e((function () local _tmp = compileListOfStatements(this,statement.finalizer.body); finallyStatements  = _tmp; return _tmp; end)());
compiledTryStatement:push(finallyStatements);
compiledTryStatement:push("\10");
end

if _bool(protectedCallManager.mayBreak and protectedCallManager.mayContinue) then
compiledTryStatement:push("if _return == _break then break; elseif _return == _continue then goto _continue end\10");
elseif _bool(protectedCallManager.mayBreak) then
compiledTryStatement:push("if _return == _break then break; end\10");
elseif _bool(protectedCallManager.mayContinue) then
compiledTryStatement:push("if _return == _continue then goto _continue end\10");
end

if _bool(protectedCallManager.mayReturn) then
compiledTryStatement:push("if _return ~= nil then return _return; end\10");
end

compiledTryStatement:push("else\10");
else
compiledTryStatement:push("if not _status then\10");
end

if _bool(hasHandler) then
handler = (_bool(esprima) and {statement.handlers[0]} or {statement.handler})[1];
protectedCallManager:reset();
protectedCallManager:openContext();
compiledTryStatement:push("local _cstatus, _creturn = _pcall(function()\10");
compiledTryStatement:push("local ");
compiledTryStatement:push(compilePattern(this,handler.param));
compiledTryStatement:push(" = _return;\10");
compiledTryStatement:push(compileListOfStatements(this,handler.body.body));
compiledTryStatement:push("\10");
compiledTryStatement:push("end);\10");
protectedCallManager:closeContext();
end

if _bool(hasFinalizer) then
compiledTryStatement:push(finallyStatements);
compiledTryStatement:push("\10");
end

if _bool(hasHandler) then
compiledTryStatement:push("if _cstatus then\10");
if _bool(protectedCallManager.mayBreak and protectedCallManager.mayContinue) then
compiledTryStatement:push("if _return == _break then break; elseif _return == _continue then goto _continue end\10");
elseif _bool(protectedCallManager.mayBreak) then
compiledTryStatement:push("if _return == _break then break; end\10");
elseif _bool(protectedCallManager.mayContinue) then
compiledTryStatement:push("if _return == _continue then goto _continue end\10");
end

if _bool(protectedCallManager.mayReturn) then
compiledTryStatement:push("if _creturn ~= nil then return _creturn; end\10");
end

compiledTryStatement:push("else _error(_creturn,0); end\10");
end

compiledTryStatement:push("end\10");
protectedCallManager:reset();
 do return compiledTryStatement:join(""); end
end)
compileThrowStatement = (function (this, statement)
local compiledThrowStatement;
compiledThrowStatement = _arr({[0]="_error("},1);
compiledThrowStatement:push(compileExpression(this,statement.argument));
compiledThrowStatement:push(",0)");
 do return compiledThrowStatement:join(""); end
end)
compileReturnStatement = (function (this, statement)
protectedCallManager:returnStatement();
if _bool((statement.argument ~= null)) then
 do return (_add((_add(" do return ",compileExpression(this,statement.argument))),"; end")); end
end

 do return "do return end"; end
end)
compileWithStatement = (function (this, statement)
local compiledWithStatement;
compiledWithStatement = _arr({[0]="do\10"},1);
compiledWithStatement:push("local _ENV = _with(");
compiledWithStatement:push(compileExpression(this,statement.object));
compiledWithStatement:push(", _ENV);\10");
compiledWithStatement:push(compileStatement(this,statement.body));
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
 do return compileAssignmentExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "FunctionExpression") then
 do return compileFunction(this,expression); end
_into = true;
end
if _into or (expression.type == "Identifier") then
 do return compileIdentifier(this,expression); end
_into = true;
end
if _into or (expression.type == "Literal") then
 do return compileLiteral(this,expression); end
_into = true;
end
if _into or (expression.type == "UnaryExpression") then
 do return compileUnaryExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "BinaryExpression") then
 do return compileBinaryExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "LogicalExpression") then
 do return compileLogicalExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "MemberExpression") then
 do return compileMemberExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "CallExpression") then
 do return compileCallExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "NewExpression") then
 do return compileNewExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "ThisExpression") then
 do return compileThisExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "ObjectExpression") then
 do return compileObjectExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "UpdateExpression") then
 do return compileUpdateExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "ArrayExpression") then
 do return compileArrayExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "ConditionalExpression") then
 do return compileConditionalExpression(this,expression); end
_into = true;
end
if _into or (expression.type == "SequenceExpression") then
 do return compileSequenceExpression(this,expression); end
_into = true;
end
::_default::
if _into then
_error(_new(Error,(_add("Unknown Expression type: ",expression.type))),0)
_into = true;
end
until true
end)
compileExpressionStatement = (function (this, expression)
local compiledExpressionStatement;
repeat
local _into = false;
local _cases = {["AssignmentExpression"] = true,["UpdateExpression"] = true,["Literal"] = true,["Identifier"] = true,["ThisExpression"] = true,["UnaryExpression"] = true,["BinaryExpression"] = true,["LogicalExpression"] = true,["ConditionalExpression"] = true,["MemberExpression"] = true};
if (not _cases[expression.type]) then
_into = true;
goto _default
end
if _into or (expression.type == "AssignmentExpression") then

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
compiledExpressionStatement = _arr({[0]="_e("},1);
compiledExpressionStatement:push(compileExpression(this,expression));
compiledExpressionStatement:push(");");
 do return compiledExpressionStatement:join(""); end
_into = true;
end
::_default::
if _into then
 do return (_add(compileExpression(this,expression),";")); end
_into = true;
end
until true
end)
compileAssignmentExpression = (function (this, expression)
local compiledBinaryExpression,binaryExpression,right,left,compiledAssignmentExpression;
compiledAssignmentExpression = _arr({[0]="(function () local _tmp = "},1);
left = compileExpression(this,expression.left);
repeat
local _into = false;
local _cases = {["="] = true};
if (not _cases[expression.operator]) then
_into = true;
goto _default
end
if _into or (expression.operator == "=") then
right = compileExpression(this,expression.right);
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
_e((function () local _tmp = extractBinaryOperator(this,expression.operator); binaryExpression.operator  = _tmp; return _tmp; end)());
_e((function () local _tmp = expression.left; binaryExpression.left  = _tmp; return _tmp; end)());
_e((function () local _tmp = expression.right; binaryExpression.right  = _tmp; return _tmp; end)());
compiledBinaryExpression = compileBinaryExpression(this,binaryExpression);
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
compiledArgument = compileExpression(this,expression.argument);
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
_error(_new(Error,(_add("Unknown UpdateOperator: ",expression.operator))),0)
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
_error(_new(Error,(_add("Unknown UpdateOperator: ",expression.operator))),0)
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
compiledArguments:push(compileExpression(this,args[i]));
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

 do return compiledArguments:join(","); end
end)
compileCallExpression = (function (this, ...)
local expression = ...;
local arguments = _args(...);
local lastPointIndex,member,base,startIndex,compiledArguments,compiledCallee,compiledCallExpression;
compiledCallExpression = _arr({},0);
compiledCallee = compileExpression(this,expression.callee);
compiledArguments = compileCallArguments(this,expression.arguments);
if _bool((expression.callee.type == "MemberExpression")) then
if _bool(compiledCallee:match(_regexp("\\]$",""))) then
startIndex = lastTopLevelBracketedGroupStartIndex(this,compiledCallee);
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
_e((function () local _tmp = replaceAt(this,compiledCallee,lastPointIndex,":"); compiledCallee  = _tmp; return _tmp; end)());
compiledCallExpression:push(compiledCallee);
compiledCallExpression:push("(");
compiledCallExpression:push(compiledArguments);
compiledCallExpression:push(")");
end

else
compiledCallExpression:push(compiledCallee);
compiledCallExpression:push("(this");
if _bool(compiledArguments) then
compiledCallExpression:push((_add(",",compiledArguments)));
end

compiledCallExpression:push(")");
end

 do return compiledCallExpression:join(""); end
end)
compileLogicalExpression = (function (this, expression)
local right,left,compiledLogicalExpression;
compiledLogicalExpression = _arr({},0);
left = compileExpression(this,expression.left);
right = compileExpression(this,expression.right);
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
_error(_new(Error,(_add("Unknown LogicalOperator: ",expression.operator))),0)
_into = true;
end
until true
compiledLogicalExpression:push(right);
 do return compiledLogicalExpression:join(""); end
end)
compileUnaryExpression = (function (this, expression)
local compiledExpression,compiledUnaryExpression;
compiledUnaryExpression = _arr({},0);
compiledExpression = compileExpression(this,expression.argument);
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
compiledUnaryExpression:push("(function () local _tmp = ");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push("; ");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(" = nil; return _tmp ~= nil; end)()");
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
_error(_new(Error,(_add("Unknown UnaryOperator: ",expression.operator))),0)
_into = true;
end
until true
else
_error(_new(Error,"UnaryExpression: postfix ?!"),0)
end

 do return compiledUnaryExpression:join(""); end
end)
compileBinaryExpression = (function (this, expression)
local right,left,compiledBinaryExpression;
compiledBinaryExpression = _arr({[0]="("},1);
left = compileExpression(this,expression.left);
right = compileExpression(this,expression.right);
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
pushSimpleBinaryExpression(this,compiledBinaryExpression," == ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "!==") then
pushSimpleBinaryExpression(this,compiledBinaryExpression," ~= ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "<") then
pushSimpleBinaryExpression(this,compiledBinaryExpression," < ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "<=") then
pushSimpleBinaryExpression(this,compiledBinaryExpression," <= ",left,right);
break;
_into = true;
end
if _into or (expression.operator == ">") then
pushSimpleBinaryExpression(this,compiledBinaryExpression," > ",left,right);
break;
_into = true;
end
if _into or (expression.operator == ">=") then
pushSimpleBinaryExpression(this,compiledBinaryExpression," >= ",left,right);
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
pushSimpleBinaryExpression(this,compiledBinaryExpression," - ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "*") then
pushSimpleBinaryExpression(this,compiledBinaryExpression," * ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "/") then
pushSimpleBinaryExpression(this,compiledBinaryExpression," / ",left,right);
break;
_into = true;
end
if _into or (expression.operator == "%") then
pushSimpleBinaryExpression(this,compiledBinaryExpression," % ",left,right);
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
_error(_new(Error,(_add("Unknown BinaryOperator: ",expression.operator))),0)
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
compiledConditionalExpression:push(compileExpression(this,expression.test));
compiledConditionalExpression:push(") and {");
compiledConditionalExpression:push(compileExpression(this,expression.consequent));
compiledConditionalExpression:push("} or {");
compiledConditionalExpression:push(compileExpression(this,expression.alternate));
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
sequence:push(compileExpression(this,expressions[i]));
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledSequenceExpression:push(sequence:join(","));
compiledSequenceExpression:push("})");
 do return compiledSequenceExpression:join(""); end
end)
compileObjectExpression = (function (this, expression)
local compiledProperties,compiledProperty,property,length,i,compiledObjectExpression;
compiledObjectExpression = _arr({[0]="_obj({\10"},1);
length = expression.properties.length;
compiledProperty = _arr({},0);
compiledProperties = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < length)) do
_e((function () local _tmp = _arr({[0]="["},1); compiledProperty  = _tmp; return _tmp; end)());
_e((function () local _tmp = expression.properties[i]; property  = _tmp; return _tmp; end)());
if _bool((property.kind == "get") or (property.kind == "set")) then
_error(_new(Error,"Getters/setters not handled yet"),0)
end

if _bool((property.key.type == "Literal")) then
compiledProperty:push(compileLiteral(this,property.key));
elseif _bool((property.key.type == "Identifier")) then
compiledProperty:push("\"");
compiledProperty:push(sanitizeLiteralString(this,property.key.name));
compiledProperty:push("\"");
else
_error(_new(Error,(_add("Unexpected property key type: ",property.key.type))),0)
end

compiledProperty:push("] = ");
compiledProperty:push(compileExpression(this,property.value));
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
compiledObject = compileExpression(this,expression.object);
if _bool((expression.object.type == "Literal")) then
_e((function () local _tmp = (_add((_add("(",compiledObject)),")")); compiledObject  = _tmp; return _tmp; end)());
end

compiledMemberExpression:push(compiledObject);
if _bool(expression.computed) then
compiledMemberExpression:push("[");
compiledMemberExpression:push(compileExpression(this,expression.property));
compiledMemberExpression:push("]");
else
compiledProperty = compileIdentifier(this,expression.property);
if _bool((compiledProperty ~= expression.property.name)) then
compiledMemberExpression:push("[\"");
compiledMemberExpression:push(sanitizeLiteralString(this,expression.property.name));
compiledMemberExpression:push("\"]");
else
compiledMemberExpression:push(".");
compiledMemberExpression:push(compiledProperty);
end

end

 do return compiledMemberExpression:join(""); end
end)
compileNewExpression = (function (this, ...)
local expression = ...;
local arguments = _args(...);
local length,i,newArguments,compiledNewExpression;
compiledNewExpression = _arr({[0]="_new("},1);
newArguments = _arr({[0]=compileExpression(this,expression.callee)},1);
length = expression.arguments.length;
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < length)) do
newArguments:push(compileExpression(this,expression.arguments[i]));
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
compiledElements:push(compileExpression(this,expression.elements[i]));
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
compileDeclaration = (function (this, declaration)
repeat
local _into = false;
local _cases = {["FunctionDeclaration"] = true,["VariableDeclaration"] = true};
if (not _cases[declaration.type]) then
_into = true;
goto _default
end
if _into or (declaration.type == "FunctionDeclaration") then
 do return compileFunction(this,declaration); end
_into = true;
end
if _into or (declaration.type == "VariableDeclaration") then
 do return compileVariableDeclaration(this,declaration); end
_into = true;
end
::_default::
if _into then
_error(_new(Error,(_add("Unknwown Declaration type: ",declaration.type))),0)
_into = true;
end
until true
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
_e((function () local _tmp = compilePattern(this,declarator.id); pattern  = _tmp; return _tmp; end)());
localVarManager:pushLocal(pattern);
if _bool((declarator.init ~= null)) then
_e((function () local _tmp = compileExpression(this,declarator.init); expression  = _tmp; return _tmp; end)());
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
_error(_new(Error,"let instruction is not supported yet"),0)
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
 do return compileIdentifier(this,pattern); end
_into = true;
end
::_default::
if _into then
_error(_new(Error,(_add("Unknwown Pattern type",pattern.type))),0)
_into = true;
end
until true
end)
compileFunction = (function (this, fun)
local compiledLocalsDeclaration,locals,compiledParams,compiledLocalParams,i,params,useArguments,context,functionName,compiledBody,compiledFunction;
compiledFunction = _arr({[0]="(function"},1);
compiledBody = "";
if _bool((fun.id ~= null)) then
functionName = compileIdentifier(this,fun.id);
localVarManager:pushLocal(functionName);
compiledFunction:unshift((_add(functionName," = ")));
end

compiledFunction:push(" (");
localVarManager:createLocalContext();
if _bool((fun.body.type == "BlockStatement")) then
_e((function () local _tmp = compileStatement(this,fun.body); compiledBody  = _tmp; return _tmp; end)());
elseif _bool((fun.body.type == "Expression")) then
_e((function () local _tmp = compileExpression(this,fun.body); compiledBody  = _tmp; return _tmp; end)());
end

context = localVarManager:popLocalContext();
useArguments = context[1];
params = fun.params;
if _bool(useArguments) then
compiledFunction:push("this, ...)\10");
if _bool((params.length > 0)) then
compiledLocalParams = _arr({},0);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < params.length)) do
compiledLocalParams:push(compilePattern(this,params[i]));
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledFunction:push((_add((_add("local ",compiledLocalParams:join(", ")))," = ...;\10")));
end

compiledFunction:push("local arguments = _args(...);\10");
else
compiledParams = _arr({[0]="this"},1);
_e((function () local _tmp = 0; i  = _tmp; return _tmp; end)());
while _bool((i < params.length)) do
compiledParams:push(compilePattern(this,params[i]));
_e((function () local _tmp = _add(i, 1); i = _tmp; return _tmp; end)());
end

compiledFunction:push(compiledParams:join(", "));
compiledFunction:push(")\10");
end

locals = context[0];
if _bool((locals.length > 0)) then
compiledLocalsDeclaration = buildLocalsDeclarationString(this,locals);
compiledFunction:push(compiledLocalsDeclaration);
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

 do return sanitizeIdentifier(this,identifier.name); end
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
elseif _bool((charcode < 55296) or (charcode >= 57344)) then
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
 do return (_add("\\",toUTF8Array(this,str):join("\\"))); end
end)); end
end)
sanitizeRegExpSource = (function (this, str)
 do return str:replace(_regexp("\\\\","g"),"\\\\"):replace(_regexp("\"","g"),"\\\""):replace(_regexp("\\\\\\\\u([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])","g"),(function (this, str, hexaCode)
local chars;
chars = String:fromCharCode(parseInt(this,hexaCode,16));
 do return (_add("\\",toUTF8Array(this,chars):join("\\"))); end
end)); end
end)
compileLiteral = (function (this, literal)
local flags,source,compiledRegExp,regexp,ret;
ret = literal.raw;
if _bool((_instanceof(literal.value,RegExp))) then
regexp = literal.value;
compiledRegExp = _arr({[0]="_regexp(\""},1);
source = sanitizeRegExpSource(this,regexp.source);
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
_e((function () local _tmp = (_add((_add("\"",sanitizeLiteralString(this,literal.value))),"\"")); ret  = _tmp; return _tmp; end)());
end

if _bool((_type(literal.value) == "number")) then
_e((function () local _tmp = JSON:stringify(literal.value); ret  = _tmp; return _tmp; end)());
end

 do return ret; end
end)
_e((function () local _tmp = compileAST; exports.compileAST  = _tmp; return _tmp; end)());
end));

return this.castl
