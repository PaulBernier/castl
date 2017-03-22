local _ENV = require("castl.runtime");
return setfenv(function(...)
(function (this, root, factory)
if _bool(((function() local _lev=(_type(define) == "function"); if _bool(_lev) then return define.amd; else return _lev; end end)())) then
define(_ENV,_arr({[0]="exports"},1),factory);
elseif (exports ~= undefined) then
factory(_ENV,exports);
else
root.castl = _obj({});
factory(_ENV,root.castl);
end

end)(_ENV,this,(function (this, exports)
local compileLiteral,sanitizeRegExpSource,sanitizeLiteralString,toUTF8Array,compileIdentifier,sanitizeIdentifier,buildLocalsDeclarationString,compileFunction,compilePattern,compileVariableDeclaration,compileFunctionDeclaration,compileArrayExpression,compileThisExpression,compileNewExpression,compileMemberExpression,compileObjectExpression,compileSequenceExpression,compileConditionalExpression,pushSimpleBinaryExpression,compileBinaryExpression,compileComparisonOperator,compileAdditionOperator,compileUnaryExpression,getGetterSetterExpression,getBaseMember,compileGenericLogicalExpression,compileLogicalExpressionLeftIdentifierOrLiteral,compileLogicalExpression,compileCallExpression,compileCallArguments,lastTopLevelBracketedGroupStartIndex,replaceAt,compileUpdateExpression,compileUpdateExpressionNoEval,compileAssignmentExpression,compileAssignmentExpressionNoEval,compileCompoundAssignmentNoEval,storeComputedProperty,compileCompoundAssignmentBinaryExpression,compileExpressionStatementNoEval,compileExpressionStatementEvalMode,compileExpressionStatement,compileExpression,compileWithStatement,compileReturnStatement,compileThrowStatement,compileTryStatementFlavored,compileTryStatement,compileSwitchStatement,compileContinueStatement,compileBreakStatement,compileLabeledStatement,isIterationStatement,compileDoWhileStatement,compileWhileStatement,compileForInStatement,compileForStatement,mayBeNumericFor,isComparisonExpressionWith,isNumericCompoundAssignmentExpressionWith,isUpdateExpressionWith,isCompoundAssignment,compileForTest,compileForUpdate,compileForInit,compileIterationStatement,compileIfStatement,compileBooleanExpression,compileListOfStatements,compileStatement,compileAST,localVarManager,LocalVarManager,protectedCallManager,ProtectedCallManager,setMeta,deductions,withTracker,continueNoLabelTracker,labelTracker,annotations,options,luaKeywords;
setMeta = (function (this, node, meta)
if _bool(options.annotation) then
if _bool(((function() local _lev=annotations[(node.loc.start.line - 1)]; if _bool(_lev) then return meta; else return _lev; end end)())) then
meta.type = annotations[(node.loc.start.line - 1)];
do return end
end

end

if _bool(options.heuristic) then
if _bool(((function() local _lev=deductions[node.loc.start.line]; if _bool(_lev) then return meta; else return _lev; end end)())) then
meta.type = deductions[node.loc.start.line];
end

end

end);
ProtectedCallManager = (function (this)
this.protectedCallContext = _arr({},0);
this.mayReturnStack = _arr({},0);
this.mayBreakStack = _arr({},0);
this.mayContinueStack = _arr({},0);
this.iterationStatement = _arr({},0);
this.switchStatement = _arr({},0);
end);
LocalVarManager = (function (this)
this.locals = _arr({},0);
this.functions = _arr({},0);
this.args = _arr({},0);
end);
compileAST = (function (this, ast, opts, anno)
local i,compiledFunctionsDeclaration,functions,compiledLocalsDeclaration,locals,useArguments,context,topLevelStatements,compiledProgram;
options = (_bool(opts) and opts or _obj({}));
annotations = (_bool(anno) and anno or _obj({}));
if (ast.type == "Program") then
compiledProgram = _arr({},0);
localVarManager:createLocalContext();
topLevelStatements = compileListOfStatements(_ENV,ast.body);
context = localVarManager:popLocalContext();
useArguments = context[1];
if _bool(useArguments) then
compiledProgram:push("local arguments = _args(...);");
end

locals = context[0];
if (locals.length>0) then
compiledLocalsDeclaration = buildLocalsDeclarationString(_ENV,locals);
compiledProgram:push(compiledLocalsDeclaration);
end

functions = context[2];
if (functions.length>0) then
compiledFunctionsDeclaration = _arr({},0);
i = 0;
while (i<functions.length) do
compiledFunctionsDeclaration:push(functions[i]);
i = i + 1;
end

compiledProgram:push(compiledFunctionsDeclaration:join("\010"));
end

compiledProgram:push(topLevelStatements);
do return _obj({
["success"] = true,
["compiled"] = compiledProgram:join("\010")
}); end
end

do return _obj({
["success"] = false,
["compiled"] = ""
}); end
end);
compileStatement = (function (this, statement)
local line,compiledStatement;
repeat
local _into = false;
local _cases = {["ExpressionStatement"] = true,["BlockStatement"] = true,["FunctionDeclaration"] = true,["VariableDeclaration"] = true,["IfStatement"] = true,["ForStatement"] = true,["WhileStatement"] = true,["DoWhileStatement"] = true,["ForInStatement"] = true,["ReturnStatement"] = true,["BreakStatement"] = true,["TryStatement"] = true,["ThrowStatement"] = true,["SwitchStatement"] = true,["ContinueStatement"] = true,["LabeledStatement"] = true,["WithStatement"] = true,["EmptyStatement"] = true,["DebuggerStatement"] = true,["ForOfStatement"] = true,["ClassDeclaration"] = true};
local _v = statement.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "ExpressionStatement") then
compiledStatement = compileExpressionStatement(_ENV,statement.expression);
do break end;
_into = true;
end
if _into or (_v == "BlockStatement") then
compiledStatement = compileListOfStatements(_ENV,statement.body);
do break end;
_into = true;
end
if _into or (_v == "FunctionDeclaration") then
compiledStatement = compileFunctionDeclaration(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "VariableDeclaration") then
compiledStatement = compileVariableDeclaration(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "IfStatement") then
compiledStatement = compileIfStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "ForStatement") then

_into = true;
end
if _into or (_v == "WhileStatement") then

_into = true;
end
if _into or (_v == "DoWhileStatement") then

_into = true;
end
if _into or (_v == "ForInStatement") then
compiledStatement = compileIterationStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "ReturnStatement") then
compiledStatement = compileReturnStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "BreakStatement") then
compiledStatement = compileBreakStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "TryStatement") then
compiledStatement = compileTryStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "ThrowStatement") then
compiledStatement = compileThrowStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "SwitchStatement") then
compiledStatement = compileSwitchStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "ContinueStatement") then
compiledStatement = compileContinueStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "LabeledStatement") then
compiledStatement = compileLabeledStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "WithStatement") then
compiledStatement = compileWithStatement(_ENV,statement);
do break end;
_into = true;
end
if _into or (_v == "EmptyStatement") then

_into = true;
end
if _into or (_v == "DebuggerStatement") then
do return ""; end
_into = true;
end
if _into or (_v == "ForOfStatement") then
_throw(_new(Error,"For...of statement (ES6) not supported yet."),0)
_into = true;
end
if _into or (_v == "ClassDeclaration") then
_throw(_new(Error,"Class declaration (ES6) not supported yet."),0)
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown Statement type: " .. statement.type)),0)
_into = true;
end
until true
if (compiledStatement ~= undefined) then
if _bool(options.debug) then
line = statement.loc.start.line;
do return ((("--[[" .. line) .. "--]] ") .. compiledStatement); end
end

do return compiledStatement; end
end

end);
compileListOfStatements = (function (this, statementList)
local compiledStatement,i,compiledStatements;
compiledStatements = _arr({},0);
i = 0;
while (i<statementList.length) do
compiledStatement = compileStatement(_ENV,statementList[i]);
if ((function() local _lev=(compiledStatement ~= ""); if _bool(_lev) then return (compiledStatement ~= undefined); else return _lev; end end)()) then
compiledStatements:push(compiledStatement);
end

i = i + 1;
end

do return compiledStatements:join("\010"); end
end);
compileBooleanExpression = (function (this, expression)
local compiledExpression,meta,compiledBooleanExpression;
compiledBooleanExpression = _arr({},0);
meta = _obj({});
compiledExpression = compileExpression(_ENV,expression,meta);
if (meta.type == "boolean") then
compiledBooleanExpression:push(compiledExpression);
else
compiledBooleanExpression:push("_bool(");
compiledBooleanExpression:push(compiledExpression);
compiledBooleanExpression:push(")");
end

do return compiledBooleanExpression:join(""); end
end);
compileIfStatement = (function (this, statement, elif)
local compiledIfStatement;
compiledIfStatement = _arr({},0);
if _bool(elif) then
compiledIfStatement:push("elseif ");
else
compiledIfStatement:push("if ");
end

compiledIfStatement:push(compileBooleanExpression(_ENV,statement.test));
compiledIfStatement:push(" then\010");
compiledIfStatement:push(compileStatement(_ENV,statement.consequent));
if (statement.alternate ~= null) then
compiledIfStatement:push("\010");
if (statement.alternate.type == "IfStatement") then
compiledIfStatement:push(compileIfStatement(_ENV,statement.alternate,true));
else
compiledIfStatement:push("else\010");
compiledIfStatement:push(compileStatement(_ENV,statement.alternate));
end

end

if not _bool(elif) then
compiledIfStatement:push("\010");
compiledIfStatement:push("end\010");
end

do return compiledIfStatement:join(""); end
end);
compileIterationStatement = (function (this, statement, compiledLabel)
local compiledIterationStatement;
compiledIterationStatement = "";
continueNoLabelTracker:push(false);
protectedCallManager:openIterationStatement();
repeat
local _into = false;
local _cases = {["ForStatement"] = true,["WhileStatement"] = true,["DoWhileStatement"] = true,["ForInStatement"] = true};
local _v = statement.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "ForStatement") then
compiledIterationStatement = compileForStatement(_ENV,statement,compiledLabel);
do break end;
_into = true;
end
if _into or (_v == "WhileStatement") then
compiledIterationStatement = compileWhileStatement(_ENV,statement,compiledLabel);
do break end;
_into = true;
end
if _into or (_v == "DoWhileStatement") then
compiledIterationStatement = compileDoWhileStatement(_ENV,statement,compiledLabel);
do break end;
_into = true;
end
if _into or (_v == "ForInStatement") then
compiledIterationStatement = compileForInStatement(_ENV,statement,compiledLabel);
do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Not an IterationStatement " .. statement.type)),0)
_into = true;
end
until true
protectedCallManager:closeIterationStatement();
continueNoLabelTracker:pop();
do return compiledIterationStatement; end
end);
compileForInit = (function (this, init)
local compiledForInit;
compiledForInit = _arr({},0);
if (init ~= null) then
if (init.type == "VariableDeclaration") then
compiledForInit:push(compileVariableDeclaration(_ENV,init));
else
compiledForInit:push(compileExpressionStatement(_ENV,init));
end

compiledForInit:push("\010");
end

do return compiledForInit:join(""); end
end);
compileForUpdate = (function (this, update)
local compiledForUpdate;
compiledForUpdate = _arr({},0);
if (update ~= null) then
compiledForUpdate:push(compileExpressionStatement(_ENV,update));
compiledForUpdate:push("\010");
end

do return compiledForUpdate:join(""); end
end);
compileForTest = (function (this, test)
if (test ~= null) then
do return compileBooleanExpression(_ENV,test); end
end

do return "true"; end
end);
isCompoundAssignment = (function (this, expression)
if (expression.type == "AssignmentExpression") then
do return (_gt(_arr({[0]="*=","/=","%=","+=","-=","<<=",">>=",">>>=","&=","^=","|="},11):indexOf(expression.operator),-1)); end
end

do return false; end
end);
isUpdateExpressionWith = (function (this, expression, variables)
if ((function() local _lev=(expression ~= null); if _bool(_lev) then return (expression.type == "UpdateExpression"); else return _lev; end end)()) then
if (expression.argument.type == "Identifier") then
do return (variables:indexOf(expression.argument.name)>-1); end
end

end

do return false; end
end);
isNumericCompoundAssignmentExpressionWith = (function (this, expression, variables)
local metaRight;
if _bool(((function() local _lev=(expression ~= null); if _bool(_lev) then return isCompoundAssignment(_ENV,expression); else return _lev; end end)())) then
if ((function() local _lev=(expression.left.type == "Identifier"); if _bool(_lev) then return (variables:indexOf(expression.left.name)>-1); else return _lev; end end)()) then
if (expression.operator == "+=") then
metaRight = _obj({});
compileExpression(_ENV,expression.right,metaRight);
do return (metaRight.type == "number"); end
end

do return true; end
end

end

do return false; end
end);
isComparisonExpressionWith = (function (this, expression, variables)
if (expression ~= null) then
if (expression.type == "BinaryExpression") then
if (_arr({[0]="<","<=",">",">="},4):indexOf(expression.operator)>-1) then
if (expression.left.type == "Identifier") then
if (variables:indexOf(expression.left.name)>-1) then
do return true; end
end

elseif (expression.right.type == "Identifier") then
if (variables:indexOf(expression.right.name)>-1) then
do return true; end
end

end

end

end

end

do return false; end
end);
mayBeNumericFor = (function (this, statement)
local i,declarations,metaRight,init,possibleNumericForVariable;
possibleNumericForVariable = _arr({},0);
init = statement.init;
if (init == null) then
do return false; end
end

if (init.type == "VariableDeclaration") then
declarations = init.declarations;
i = 0;
while (i<declarations.length) do
if (declarations[i].init ~= null) then
metaRight = _obj({});
compileExpression(_ENV,declarations[i].init,metaRight);
if (metaRight.type == "number") then
possibleNumericForVariable:push(declarations[i].id.name);
end

end

i = i + 1;
end

elseif (init.type == "AssignmentExpression") then
if (init.left.type == "Identifier") then
metaRight = _obj({});
compileExpression(_ENV,init.right,metaRight);
if (metaRight.type == "number") then
possibleNumericForVariable:push(init.left.name);
end

end

end

if (possibleNumericForVariable.length>0) then
if _bool(isComparisonExpressionWith(_ENV,statement.test,possibleNumericForVariable)) then
if _bool(isUpdateExpressionWith(_ENV,statement.update,possibleNumericForVariable)) then
do return true; end
end

if _bool(isNumericCompoundAssignmentExpressionWith(_ENV,statement.update,possibleNumericForVariable)) then
do return true; end
end

end

end

do return false; end
end);
compileForStatement = (function (this, statement, compiledLabel)
local compiledForStatement;
compiledForStatement = _arr({},0);
if _bool(options.heuristic) then
if _bool(mayBeNumericFor(_ENV,statement)) then
deductions[statement.loc.start.line] = "number";
end

end

compiledForStatement:push(compileForInit(_ENV,statement.init));
compiledForStatement:push("while ");
compiledForStatement:push(compileForTest(_ENV,statement.test));
compiledForStatement:push(" do\010");
compiledForStatement:push(compileStatement(_ENV,statement.body));
compiledForStatement:push("\010");
if _bool(continueNoLabelTracker[(continueNoLabelTracker.length - 1)]) then
compiledForStatement:push("::_continue::\010");
end

if _bool(((function() if _bool(compiledLabel) then return labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
compiledForStatement:push((("::" .. compiledLabel) .. "_c::\010"));
end

compiledForStatement:push(compileForUpdate(_ENV,statement.update));
compiledForStatement:push("end\010");
do return compiledForStatement:join(""); end
end);
compileForInStatement = (function (this, statement, compiledLabel)
local compiledLeft,compiledForInStatement;
compiledForInStatement = _arr({},0);
compiledForInStatement:push("local _p = _props(");
compiledForInStatement:push(compileExpression(_ENV,statement.right));
compiledForInStatement:push(", true);\010");
if (statement.left.type == "VariableDeclaration") then
compiledLeft = compilePattern(_ENV,statement.left.declarations[0].id);
localVarManager:pushLocal(compiledLeft);
else
compiledLeft = compileExpression(_ENV,statement.left);
end

compiledForInStatement:push("for _,");
compiledForInStatement:push(compiledLeft);
compiledForInStatement:push(" in _ipairs(_p) do\010");
compiledForInStatement:push(compiledLeft);
compiledForInStatement:push(" = _tostr(");
compiledForInStatement:push(compiledLeft);
compiledForInStatement:push(");\010");
compiledForInStatement:push(compileStatement(_ENV,statement.body));
compiledForInStatement:push("::_continue::\010");
if _bool(((function() if _bool(compiledLabel) then return labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
compiledForInStatement:push((("::" .. compiledLabel) .. "_c::\010"));
end

compiledForInStatement:push("end\010");
do return compiledForInStatement:join(""); end
end);
compileWhileStatement = (function (this, statement, compiledLabel)
local compiledWhileStatement;
compiledWhileStatement = _arr({[0]="while "},1);
compiledWhileStatement:push(compileBooleanExpression(_ENV,statement.test));
compiledWhileStatement:push(" do\010");
compiledWhileStatement:push(compileStatement(_ENV,statement.body));
compiledWhileStatement:push("\010");
compiledWhileStatement:push("::_continue::\010");
if _bool(((function() if _bool(compiledLabel) then return labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
compiledWhileStatement:push((("::" .. compiledLabel) .. "_c::\010"));
end

compiledWhileStatement:push("end\010");
do return compiledWhileStatement:join(""); end
end);
compileDoWhileStatement = (function (this, statement, compiledLabel)
local compiledDoWhileStatement;
compiledDoWhileStatement = _arr({[0]="repeat\010"},1);
compiledDoWhileStatement:push(compileStatement(_ENV,statement.body));
compiledDoWhileStatement:push("\010");
compiledDoWhileStatement:push("::_continue::\010");
if _bool(((function() if _bool(compiledLabel) then return labelTracker[compiledLabel].mayContinue; else return compiledLabel; end end)())) then
compiledDoWhileStatement:push((("::" .. compiledLabel) .. "_c::\010"));
end

compiledDoWhileStatement:push("until not ");
compiledDoWhileStatement:push(compileBooleanExpression(_ENV,statement.test));
compiledDoWhileStatement:push("\010");
do return compiledDoWhileStatement:join(""); end
end);
isIterationStatement = (function (this, statement)
do return ((function() local _lev=((function() local _lev=((function() local _lev=(statement.type == "ForStatement"); return _bool(_lev) and _lev or (statement.type == "DoWhileStatement") end)()); return _bool(_lev) and _lev or (statement.type == "WhileStatement") end)()); return _bool(_lev) and _lev or (statement.type == "ForInStatement") end)()); end
end);
compileLabeledStatement = (function (this, statement)
local compiledLabel,label,compiledLabeledStatement;
compiledLabeledStatement = _arr({},0);
label = statement.label;
compiledLabel = compileIdentifier(_ENV,label);
labelTracker[compiledLabel] = _obj({
["mayBreak"] = false,
["mayContinue"] = false
});
if _bool(isIterationStatement(_ENV,statement.body)) then
compiledLabeledStatement:push(compileIterationStatement(_ENV,statement.body,compiledLabel));
else
compiledLabeledStatement:push(compileStatement(_ENV,statement.body));
end

if _bool(labelTracker[compiledLabel].mayBreak) then
compiledLabeledStatement:push((("::" .. compiledLabel) .. "_b::\010"));
end

(function () local _r = false; local _g, _s = labelTracker["_g" .. compiledLabel], labelTracker["_s" .. compiledLabel]; labelTracker["_g" .. compiledLabel], labelTracker["_s" .. compiledLabel] = nil, nil; _r = _g ~= nil or _s ~= nil;
local _v = labelTracker[compiledLabel]; labelTracker[compiledLabel] = nil; return _r or _v ~= nil; end)();
do return compiledLabeledStatement:join(""); end
end);
compileBreakStatement = (function (this, statement)
local compiledLabel;
if (statement.label == null) then
if _bool(protectedCallManager:breakOutside()) then
do return "do return _break; end"; end
end

if _bool(options.jit) then
do return "do break end;"; end
else
do return "break;"; end
end

end

compiledLabel = compileIdentifier(_ENV,statement.label);
labelTracker[compiledLabel].mayBreak = true;
do return (("goto " .. compiledLabel) .. "_b;"); end
end);
compileContinueStatement = (function (this, statement)
local compiledLabel;
if (statement.label == null) then
continueNoLabelTracker[(continueNoLabelTracker.length - 1)] = true;
if _bool(protectedCallManager:continueOutside()) then
do return "do return _continue; end"; end
end

do return "goto _continue"; end
end

compiledLabel = compileIdentifier(_ENV,statement.label);
labelTracker[compiledLabel].mayContinue = true;
do return (("goto " .. compiledLabel) .. "_c;"); end
end);
compileSwitchStatement = (function (this, statement)
local hasDefault,compiledTests,caseTablementElement,casesTable,i,compiledSwitchStatement,cases;
protectedCallManager:openSwitchStatement();
cases = statement.cases;
if (cases.length>0) then
compiledSwitchStatement = _arr({[0]="repeat\010local _into = false;\010"},1);
casesTable = _arr({},0);
compiledTests = _arr({},0);
i = 0;
while (i<cases.length) do
if (cases[i].test ~= null) then
compiledTests[i] = compileExpression(_ENV,cases[i].test);
caseTablementElement = _arr({},0);
caseTablementElement:push("[");
caseTablementElement:push(compiledTests[i]);
caseTablementElement:push("] = true");
casesTable:push(caseTablementElement:join(""));
end

i = i + 1;
end

compiledSwitchStatement:push("local _cases = {");
compiledSwitchStatement:push(casesTable:join(","));
compiledSwitchStatement:push("};\010");
compiledSwitchStatement:push("local _v = ");
compiledSwitchStatement:push(compileExpression(_ENV,statement.discriminant));
compiledSwitchStatement:push(";\010");
compiledSwitchStatement:push("if not _cases[_v] then\010");
compiledSwitchStatement:push("_into = true;\010");
compiledSwitchStatement:push("goto _default\010");
compiledSwitchStatement:push("end\010");
hasDefault = false;
i = 0;
while (i<cases.length) do
if (cases[i].test ~= null) then
compiledSwitchStatement:push("if _into or (_v == ");
compiledSwitchStatement:push(compiledTests[i]);
compiledSwitchStatement:push(") then\010");
else
hasDefault = true;
compiledSwitchStatement:push("::_default::\010");
compiledSwitchStatement:push("if _into then\010");
end

compiledSwitchStatement:push(compileListOfStatements(_ENV,cases[i].consequent));
compiledSwitchStatement:push("\010");
compiledSwitchStatement:push("_into = true;\010");
compiledSwitchStatement:push("end\010");
i = i + 1;
end

if not _bool(hasDefault) then
compiledSwitchStatement:push("::_default::\010");
end

compiledSwitchStatement:push("until true");
protectedCallManager:closeSwitchStatement();
do return compiledSwitchStatement:join(""); end
end

protectedCallManager:closeSwitchStatement();
do return ""; end
end);
compileTryStatement = (function (this, statement)
if _bool(statement.handlers) then
do return compileTryStatementFlavored(_ENV,statement,true); end
end

do return compileTryStatementFlavored(_ENV,statement,false); end
end);
compileTryStatementFlavored = (function (this, statement, esprima)
local handler,compiledTryStatement,may,finallyStatements,hasFinalizer,hasHandler;
hasHandler = (function() if _bool(esprima) then return (statement.handlers.length>0); else return (statement.handler ~= null); end end)();
hasFinalizer = (statement.finalizer ~= null);
protectedCallManager:openContext();
compiledTryStatement = _arr({[0]="local _status, _return = _pcall(function()\010"},1);
compiledTryStatement:push(compileListOfStatements(_ENV,statement.block.body));
compiledTryStatement:push("\010");
compiledTryStatement:push("end);\010");
may = protectedCallManager:may();
protectedCallManager:closeContext();
if _bool(((function() local _lev=((function() local _lev=(_bool(hasFinalizer) and hasFinalizer or may.mayReturn); return _bool(_lev) and _lev or may.mayBreak end)()); return _bool(_lev) and _lev or may.mayContinue end)())) then
compiledTryStatement:push("if _status then\010");
if _bool(hasFinalizer) then
finallyStatements = compileListOfStatements(_ENV,statement.finalizer.body);
compiledTryStatement:push(finallyStatements);
compiledTryStatement:push("\010");
end

if _bool(((function() local _lev=may.mayBreak; if _bool(_lev) then return may.mayContinue; else return _lev; end end)())) then
compiledTryStatement:push("if _return == _break then break; elseif _return == _continue then goto _continue end\010");
elseif _bool(may.mayBreak) then
compiledTryStatement:push("if _return == _break then break; end\010");
elseif _bool(may.mayContinue) then
compiledTryStatement:push("if _return == _continue then goto _continue end\010");
end

if _bool(may.mayReturn) then
compiledTryStatement:push("if _return ~= nil then return _return; end\010");
end

compiledTryStatement:push("else\010");
else
compiledTryStatement:push("if not _status then\010");
end

if _bool(hasHandler) then
handler = (function() if _bool(esprima) then return statement.handlers[0]; else return statement.handler; end end)();
protectedCallManager:openContext();
compiledTryStatement:push("local _cstatus, _creturn = _pcall(function()\010");
compiledTryStatement:push("local ");
compiledTryStatement:push(compilePattern(_ENV,handler.param));
compiledTryStatement:push(" = _return;\010");
compiledTryStatement:push(compileListOfStatements(_ENV,handler.body.body));
compiledTryStatement:push("\010");
compiledTryStatement:push("end);\010");
may = protectedCallManager:may();
protectedCallManager:closeContext();
end

if _bool(hasFinalizer) then
compiledTryStatement:push(finallyStatements);
compiledTryStatement:push("\010");
end

if _bool(hasHandler) then
compiledTryStatement:push("if _cstatus then\010");
if _bool(((function() local _lev=may.mayBreak; if _bool(_lev) then return may.mayContinue; else return _lev; end end)())) then
compiledTryStatement:push("if _creturn == _break then break; elseif _creturn == _continue then goto _continue end\010");
elseif _bool(may.mayBreak) then
compiledTryStatement:push("if _creturn == _break then break; end\010");
elseif _bool(may.mayContinue) then
compiledTryStatement:push("if _creturn == _continue then goto _continue end\010");
end

if _bool(may.mayReturn) then
compiledTryStatement:push("if _creturn ~= nil then return _creturn; end\010");
end

compiledTryStatement:push("else _throw(_creturn,0); end\010");
end

compiledTryStatement:push("end\010");
do return compiledTryStatement:join(""); end
end);
compileThrowStatement = (function (this, statement)
local compiledThrowStatement;
compiledThrowStatement = _arr({[0]="_throw("},1);
compiledThrowStatement:push(compileExpression(_ENV,statement.argument));
compiledThrowStatement:push(",0)");
do return compiledThrowStatement:join(""); end
end);
compileReturnStatement = (function (this, statement)
protectedCallManager:returnStatement();
if (statement.argument ~= null) then
do return (("do return " .. compileExpression(_ENV,statement.argument)) .. "; end"); end
end

do return "do return end"; end
end);
compileWithStatement = (function (this, statement)
local compiledWithStatement;
withTracker:push(true);
compiledWithStatement = _arr({[0]="do\010"},1);
compiledWithStatement:push("local _oldENV = _ENV;\010");
compiledWithStatement:push("local _ENV = _with(");
compiledWithStatement:push(compileExpression(_ENV,statement.object));
compiledWithStatement:push(", _ENV);\010");
if _bool(options.jit) then
compiledWithStatement:push("_wenv(function(...)\010");
end

compiledWithStatement:push(compileStatement(_ENV,statement.body));
if _bool(options.jit) then
compiledWithStatement:push("\010end, _ENV)()");
end

compiledWithStatement:push("\010end");
withTracker:pop();
do return compiledWithStatement:join(""); end
end);
compileExpression = (function (this, expression, meta)
repeat
local _into = false;
local _cases = {["AssignmentExpression"] = true,["FunctionExpression"] = true,["Identifier"] = true,["Literal"] = true,["UnaryExpression"] = true,["BinaryExpression"] = true,["LogicalExpression"] = true,["MemberExpression"] = true,["CallExpression"] = true,["NewExpression"] = true,["ThisExpression"] = true,["ObjectExpression"] = true,["UpdateExpression"] = true,["ArrayExpression"] = true,["ConditionalExpression"] = true,["SequenceExpression"] = true,["ArrowFunctionExpression"] = true,["TemplateLiteral"] = true,["SpreadElement"] = true,["MetaProperty"] = true};
local _v = expression.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "AssignmentExpression") then
do return compileAssignmentExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "FunctionExpression") then
do return compileFunction(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "Identifier") then
do return compileIdentifier(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "Literal") then
do return compileLiteral(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "UnaryExpression") then
do return compileUnaryExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "BinaryExpression") then
do return compileBinaryExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "LogicalExpression") then
do return compileLogicalExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "MemberExpression") then
do return compileMemberExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "CallExpression") then
do return compileCallExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "NewExpression") then
do return compileNewExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "ThisExpression") then
do return compileThisExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "ObjectExpression") then
do return compileObjectExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "UpdateExpression") then
do return compileUpdateExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "ArrayExpression") then
do return compileArrayExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "ConditionalExpression") then
do return compileConditionalExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "SequenceExpression") then
do return compileSequenceExpression(_ENV,expression,meta); end
_into = true;
end
if _into or (_v == "ArrowFunctionExpression") then
_throw(_new(Error,"Arrow functions (ES6) not supported yet."),0)
_into = true;
end
if _into or (_v == "TemplateLiteral") then
_throw(_new(Error,"String templating (ES6) not supported yet."),0)
_into = true;
end
if _into or (_v == "SpreadElement") then
_throw(_new(Error,"Spread operator (ES6) not supported yet."),0)
_into = true;
end
if _into or (_v == "MetaProperty") then
_throw(_new(Error,"Meta property (ES6) not supported yet."),0)
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown Expression type: " .. expression.type)),0)
_into = true;
end
until true
end);
compileExpressionStatement = (function (this, expression, meta)
if _bool(options.evalMode) then
do return compileExpressionStatementEvalMode(_ENV,expression,meta); end
else
do return compileExpressionStatementNoEval(_ENV,expression,meta); end
end

end);
compileExpressionStatementEvalMode = (function (this, expression, meta)
local compiledExpressionStatement;
compiledExpressionStatement = _arr({[0]="_e("},1);
compiledExpressionStatement:push(compileExpression(_ENV,expression,meta));
compiledExpressionStatement:push(");");
do return compiledExpressionStatement:join(""); end
end);
compileExpressionStatementNoEval = (function (this, expression, meta)
local compiledUnaryExpressionStatement,compiledExpressionStatement;
repeat
local _into = false;
local _cases = {["Literal"] = true,["Identifier"] = true,["ThisExpression"] = true,["UpdateExpression"] = true,["AssignmentExpression"] = true,["BinaryExpression"] = true,["LogicalExpression"] = true,["ConditionalExpression"] = true,["MemberExpression"] = true,["FunctionExpression"] = true,["UnaryExpression"] = true,["CallExpression"] = true,["NewExpression"] = true,["ArrayExpression"] = true,["ObjectExpression"] = true,["SequenceExpression"] = true,["YieldExpression"] = true};
local _v = expression.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "Literal") then

_into = true;
end
if _into or (_v == "Identifier") then

_into = true;
end
if _into or (_v == "ThisExpression") then
do return end
_into = true;
end
if _into or (_v == "UpdateExpression") then
do return (compileUpdateExpressionNoEval(_ENV,expression,meta) .. ";"); end
_into = true;
end
if _into or (_v == "AssignmentExpression") then
do return (compileAssignmentExpressionNoEval(_ENV,expression,meta) .. ";"); end
_into = true;
end
if _into or (_v == "BinaryExpression") then

_into = true;
end
if _into or (_v == "LogicalExpression") then

_into = true;
end
if _into or (_v == "ConditionalExpression") then

_into = true;
end
if _into or (_v == "MemberExpression") then

_into = true;
end
if _into or (_v == "FunctionExpression") then
compiledExpressionStatement = _arr({[0]="_e("},1);
compiledExpressionStatement:push(compileExpression(_ENV,expression,meta));
compiledExpressionStatement:push(");");
do return compiledExpressionStatement:join(""); end
_into = true;
end
if _into or (_v == "UnaryExpression") then
if (expression.operator == "!") then
compiledUnaryExpressionStatement = _arr({[0]="_e("},1);
compiledUnaryExpressionStatement:push(compileUnaryExpression(_ENV,expression,meta));
compiledUnaryExpressionStatement:push(");");
do return compiledUnaryExpressionStatement:join(""); end
end

do return (compileUnaryExpression(_ENV,expression,meta) .. ";"); end
_into = true;
end
if _into or (_v == "CallExpression") then

_into = true;
end
if _into or (_v == "NewExpression") then

_into = true;
end
if _into or (_v == "ArrayExpression") then

_into = true;
end
if _into or (_v == "ObjectExpression") then

_into = true;
end
if _into or (_v == "SequenceExpression") then
do return (compileExpression(_ENV,expression,meta) .. ";"); end
_into = true;
end
if _into or (_v == "YieldExpression") then
_throw(_new(Error,"Yield expression not supported yet."),0)
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown expression type: " .. expression.type)),0)
_into = true;
end
until true
end);
compileCompoundAssignmentBinaryExpression = (function (this, left, right, operator, metaLeft, metaRight, meta)
local compiledCompoundAssignmentBinaryExpression;
compiledCompoundAssignmentBinaryExpression = _arr({[0]="("},1);
repeat
local _into = false;
local _cases = {["<<="] = true,[">>="] = true,[">>>="] = true,["+="] = true,["-="] = true,["*="] = true,["/="] = true,["%="] = true,["|="] = true,["^="] = true,["&="] = true};
local _v = operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "<<=") then
compiledCompoundAssignmentBinaryExpression:push("_lshift(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == ">>=") then
compiledCompoundAssignmentBinaryExpression:push("_arshift(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == ">>>=") then
compiledCompoundAssignmentBinaryExpression:push("_rshift(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "+=") then
compiledCompoundAssignmentBinaryExpression:push(compileAdditionOperator(_ENV,left,right,metaLeft,metaRight,meta));
do break end;
_into = true;
end
if _into or (_v == "-=") then
pushSimpleBinaryExpression(_ENV,compiledCompoundAssignmentBinaryExpression," - ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "*=") then
pushSimpleBinaryExpression(_ENV,compiledCompoundAssignmentBinaryExpression," * ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "/=") then
pushSimpleBinaryExpression(_ENV,compiledCompoundAssignmentBinaryExpression," / ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "%=") then
compiledCompoundAssignmentBinaryExpression:push("_mod(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "|=") then
compiledCompoundAssignmentBinaryExpression:push("_bor(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "^=") then
compiledCompoundAssignmentBinaryExpression:push("_bxor(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "&=") then
compiledCompoundAssignmentBinaryExpression:push("_band(");
compiledCompoundAssignmentBinaryExpression:push(left);
compiledCompoundAssignmentBinaryExpression:push(",");
compiledCompoundAssignmentBinaryExpression:push(right);
compiledCompoundAssignmentBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown BinaryOperator: " .. operator)),0)
_into = true;
end
until true
compiledCompoundAssignmentBinaryExpression:push(")");
do return compiledCompoundAssignmentBinaryExpression:join(""); end
end);
storeComputedProperty = (function (this, expression)
local hasComputedProperty;
hasComputedProperty = ((function() local _lev=(expression.type == "MemberExpression"); if _bool(_lev) then return expression.computed; else return _lev; end end)());
if _bool(hasComputedProperty) then
if (expression.property.type == "Literal") then
do return false; end
end

else
do return false; end
end

do return true; end
end);
compileCompoundAssignmentNoEval = (function (this, expression)
local split,right,left,metaRight,metaLeft,mustStore,compiledAssignmentBinaryExpression;
compiledAssignmentBinaryExpression = _arr({},0);
mustStore = storeComputedProperty(_ENV,expression.left);
metaLeft = _obj({});
metaRight = _obj({});
left = compileExpression(_ENV,expression.left,metaLeft);
right = compileExpression(_ENV,expression.right,metaRight);
if _bool(mustStore) then
split = getBaseMember(_ENV,left);
left = (split.base .. "[_cp]");
compiledAssignmentBinaryExpression:push("do local _cp = ");
compiledAssignmentBinaryExpression:push(split.member);
compiledAssignmentBinaryExpression:push("; ");
end

compiledAssignmentBinaryExpression:push(left);
compiledAssignmentBinaryExpression:push(" = ");
compiledAssignmentBinaryExpression:push(compileCompoundAssignmentBinaryExpression(_ENV,left,right,expression.operator,metaLeft,metaRight));
if _bool(mustStore) then
compiledAssignmentBinaryExpression:push(" end");
end

do return compiledAssignmentBinaryExpression:join(""); end
end);
compileAssignmentExpressionNoEval = (function (this, expression)
local right,left,compiledAssignmentExpression;
compiledAssignmentExpression = _arr({},0);
repeat
local _into = false;
local _cases = {["="] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "=") then
left = compileExpression(_ENV,expression.left);
right = compileExpression(_ENV,expression.right);
compiledAssignmentExpression:push(left);
compiledAssignmentExpression:push(" = ");
compiledAssignmentExpression:push(right);
do break end;
_into = true;
end
::_default::
if _into then
do return compileCompoundAssignmentNoEval(_ENV,expression); end
_into = true;
end
until true
do return compiledAssignmentExpression:join(""); end
end);
compileAssignmentExpression = (function (this, expression, meta)
local split,right,left,metaRight,metaLeft,mustStore,compiledAssignmentExpression;
compiledAssignmentExpression = _arr({[0]="(function() "},1);
mustStore = storeComputedProperty(_ENV,expression.left);
metaLeft = _obj({});
metaRight = _obj({});
left = compileExpression(_ENV,expression.left,metaLeft);
right = compileExpression(_ENV,expression.right,metaRight);
if _bool(mustStore) then
split = getBaseMember(_ENV,left);
compiledAssignmentExpression:push("local _cp = ");
compiledAssignmentExpression:push(split.member);
compiledAssignmentExpression:push(";");
left = (split.base .. "[_cp]");
end

compiledAssignmentExpression:push(left);
compiledAssignmentExpression:push(" = ");
repeat
local _into = false;
local _cases = {["="] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "=") then
compiledAssignmentExpression:push(right);
if _bool(meta) then
meta.type = metaRight.type;
end

do break end;
_into = true;
end
::_default::
if _into then
compiledAssignmentExpression:push(compileCompoundAssignmentBinaryExpression(_ENV,left,right,expression.operator,metaLeft,metaRight,meta));
_into = true;
end
until true
compiledAssignmentExpression:push("; return ");
compiledAssignmentExpression:push(left);
compiledAssignmentExpression:push(" end)()");
do return compiledAssignmentExpression:join(""); end
end);
compileUpdateExpressionNoEval = (function (this, expression)
local split,compiledArgument,metaArgument,mustStore,compiledUpdateExpression;
compiledUpdateExpression = _arr({},0);
mustStore = storeComputedProperty(_ENV,expression.argument);
metaArgument = _obj({});
compiledArgument = compileExpression(_ENV,expression.argument,metaArgument);
if _bool(mustStore) then
split = getBaseMember(_ENV,compiledArgument);
compiledArgument = (split.base .. "[_cp]");
compiledUpdateExpression:push("do local _cp = ");
compiledUpdateExpression:push(split.member);
compiledUpdateExpression:push("; ");
end

compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" = ");
repeat
local _into = false;
local _cases = {["++"] = true,["--"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "++") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" + 1");
else
compiledUpdateExpression:push("_inc(");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(")");
end

do break end;
_into = true;
end
if _into or (_v == "--") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" - 1");
else
compiledUpdateExpression:push("_dec(");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(")");
end

do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown UpdateOperator: " .. expression.operator)),0)
_into = true;
end
until true
if _bool(mustStore) then
compiledUpdateExpression:push(";end");
end

do return compiledUpdateExpression:join(""); end
end);
compileUpdateExpression = (function (this, expression, meta)
local split,compiledArgument,metaArgument,mustStore,compiledUpdateExpression;
compiledUpdateExpression = _arr({[0]="(function () "},1);
mustStore = storeComputedProperty(_ENV,expression.argument);
metaArgument = _obj({});
compiledArgument = compileExpression(_ENV,expression.argument,metaArgument);
if _bool(mustStore) then
split = getBaseMember(_ENV,compiledArgument);
compiledUpdateExpression:push("local _cp = ");
compiledUpdateExpression:push(split.member);
compiledUpdateExpression:push(";");
compiledArgument = (split.base .. "[_cp]");
end

compiledUpdateExpression:push("local _tmp = ");
if _bool(expression.prefix) then
repeat
local _into = false;
local _cases = {["++"] = true,["--"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "++") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" + 1; ");
else
compiledUpdateExpression:push("_inc(");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push("); ");
end

do break end;
_into = true;
end
if _into or (_v == "--") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push(" - 1; ");
else
compiledUpdateExpression:push("_dec(");
compiledUpdateExpression:push(compiledArgument);
compiledUpdateExpression:push("); ");
end

do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown UpdateOperator: " .. expression.operator)),0)
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
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "++") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push("_tmp + 1");
else
compiledUpdateExpression:push("_inc(_tmp)");
end

do break end;
_into = true;
end
if _into or (_v == "--") then
if (metaArgument.type == "number") then
compiledUpdateExpression:push("_tmp - 1");
else
compiledUpdateExpression:push("_dec(_tmp)");
end

do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown UpdateOperator: " .. expression.operator)),0)
_into = true;
end
until true
end

compiledUpdateExpression:push("; return _tmp; end)()");
if _bool(meta) then
meta.type = "number";
end

do return compiledUpdateExpression:join(""); end
end);
replaceAt = (function (this, str, index, char)
do return ((str:substr(0,index) .. char) .. str:substr((index + 1))); end
end);
lastTopLevelBracketedGroupStartIndex = (function (this, str)
local i,count,startIndex;
startIndex = 0;
count = 0;
i = 0;
while (i<str.length) do
if (str[i] == "[") then
if (count == 0) then
startIndex = i;
end

count = count + 1;
elseif (str[i] == "]") then
count = count - 1;
end

i = i + 1;
end

do return startIndex; end
end);
compileCallArguments = (function (this, args)
local i,compiledArguments;
compiledArguments = _arr({},0);
i = 0;
while (i<args.length) do
compiledArguments:push(compileExpression(_ENV,args[i]));
i = i + 1;
end

do return compiledArguments:join(","); end
end);
compileCallExpression = (function (...)
local this, expression, meta = ...;
local arguments = _args(...);
local lastPointIndex,member,base,startIndex,compiledArguments,compiledCallee,compiledCallExpression;
compiledCallExpression = _arr({},0);
compiledCallee = compileExpression(_ENV,expression.callee);
compiledArguments = compileCallArguments(_ENV,expression.arguments);
if (expression.callee.type == "MemberExpression") then
if _bool(compiledCallee:match(_regexp("\\]$",""))) then
startIndex = lastTopLevelBracketedGroupStartIndex(_ENV,compiledCallee);
base = compiledCallee:substr(0,startIndex);
member = compiledCallee:substr((startIndex + 1));
compiledCallExpression:push("(function() local _this = ");
compiledCallExpression:push(base);
compiledCallExpression:push("; local _f = _this[");
compiledCallExpression:push(member);
compiledCallExpression:push("; return _f(_this");
if (compiledArguments ~= "") then
compiledCallExpression:push(",");
compiledCallExpression:push(compiledArguments);
end

compiledCallExpression:push("); end)()");
else
lastPointIndex = compiledCallee:lastIndexOf(".");
compiledCallee = replaceAt(_ENV,compiledCallee,lastPointIndex,":");
compiledCallExpression:push(compiledCallee);
compiledCallExpression:push("(");
compiledCallExpression:push(compiledArguments);
compiledCallExpression:push(")");
end

else
compiledCallExpression:push(compiledCallee);
if (withTracker.length == 0) then
compiledCallExpression:push("(_ENV");
else
compiledCallExpression:push("(_oldENV");
end

if _bool(compiledArguments) then
compiledCallExpression:push(",");
compiledCallExpression:push(compiledArguments);
end

compiledCallExpression:push(")");
end

setMeta(_ENV,expression,meta);
do return compiledCallExpression:join(""); end
end);
compileLogicalExpression = (function (this, expression, meta)
local compiledRight,compiledLeft,metaRight,metaLeft;
metaLeft = _obj({});
metaRight = _obj({});
compiledLeft = compileExpression(_ENV,expression.left,metaLeft);
compiledRight = compileExpression(_ENV,expression.right,metaRight);
if _bool(meta) then
if ((function() local _lev=(metaLeft.type == metaRight.type); if _bool(_lev) then return (metaLeft.type ~= undefined); else return _lev; end end)()) then
meta.type = metaLeft.type;
end

end

if ((function() local _lev=(expression.left.type == "Identifier"); return _bool(_lev) and _lev or (expression.left.type == "Literal") end)()) then
do return compileLogicalExpressionLeftIdentifierOrLiteral(_ENV,expression,compiledLeft,compiledRight); end
else
do return compileGenericLogicalExpression(_ENV,expression,compiledLeft,compiledRight); end
end

end);
compileLogicalExpressionLeftIdentifierOrLiteral = (function (this, expression, compiledLeft, compiledRight)
local leftCondition,compiledLogicalExpression;
compiledLogicalExpression = _arr({[0]="("},1);
leftCondition = compileBooleanExpression(_ENV,expression.left);
repeat
local _into = false;
local _cases = {["&&"] = true,["||"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "&&") then
compiledLogicalExpression:push("(function() if ");
compiledLogicalExpression:push(leftCondition);
compiledLogicalExpression:push(" then return ");
compiledLogicalExpression:push(compiledRight);
compiledLogicalExpression:push("; else return ");
compiledLogicalExpression:push(compiledLeft);
compiledLogicalExpression:push("; end end)()");
do break end;
_into = true;
end
if _into or (_v == "||") then
compiledLogicalExpression:push(leftCondition);
compiledLogicalExpression:push(" and ");
compiledLogicalExpression:push(compiledLeft);
compiledLogicalExpression:push(" or ");
compiledLogicalExpression:push(compiledRight);
do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown LogicalOperator: " .. expression.operator)),0)
_into = true;
end
until true
compiledLogicalExpression:push(")");
do return compiledLogicalExpression:join(""); end
end);
compileGenericLogicalExpression = (function (this, expression, compiledLeft, compiledRight)
local compiledLogicalExpression;
compiledLogicalExpression = _arr({[0]="("},1);
repeat
local _into = false;
local _cases = {["&&"] = true,["||"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "&&") then
compiledLogicalExpression:push("(function() local _lev=");
compiledLogicalExpression:push(compiledLeft);
compiledLogicalExpression:push("; if _bool(_lev) then return ");
compiledLogicalExpression:push(compiledRight);
compiledLogicalExpression:push("; else return _lev; end end)()");
do break end;
_into = true;
end
if _into or (_v == "||") then
compiledLogicalExpression:push("(function() local _lev=");
compiledLogicalExpression:push(compiledLeft);
compiledLogicalExpression:push("; return _bool(_lev) and _lev or ");
compiledLogicalExpression:push(compiledRight);
compiledLogicalExpression:push(" end)()");
do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown LogicalOperator: " .. expression.operator)),0)
_into = true;
end
until true
compiledLogicalExpression:push(")");
do return compiledLogicalExpression:join(""); end
end);
getBaseMember = (function (this, compiledExpression)
local startIndex;
startIndex = 0;
if _bool(compiledExpression:match(_regexp("\\]$",""))) then
startIndex = lastTopLevelBracketedGroupStartIndex(_ENV,compiledExpression);
do return _obj({
["base"] = compiledExpression:slice(0,startIndex),
["member"] = compiledExpression:slice((startIndex + 1),-1)
}); end
else
startIndex = compiledExpression:lastIndexOf(".");
do return _obj({
["base"] = compiledExpression:slice(0,startIndex),
["member"] = (("\"" .. compiledExpression:slice((startIndex + 1))) .. "\"")
}); end
end

end);
getGetterSetterExpression = (function (this, compiledExpression)
local split;
split = getBaseMember(_ENV,compiledExpression);
do return _obj({
["getter"] = (((split.base .. "[\"_g\" .. ") .. split.member) .. "]"),
["setter"] = (((split.base .. "[\"_s\" .. ") .. split.member) .. "]")
}); end
end);
compileUnaryExpression = (function (this, expression, meta)
local gs,scope,compiledExpression,metaArgument,compiledUnaryExpression;
compiledUnaryExpression = _arr({},0);
metaArgument = _obj({});
compiledExpression = compileExpression(_ENV,expression.argument,metaArgument);
if _bool(expression.prefix) then
repeat
local _into = false;
local _cases = {["-"] = true,["+"] = true,["!"] = true,["~"] = true,["typeof"] = true,["delete"] = true,["void"] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "-") then
if (metaArgument.type == "number") then
compiledUnaryExpression:push("-");
compiledUnaryExpression:push(compiledExpression);
else
compiledUnaryExpression:push("-_tonum(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
end

if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "+") then
if (metaArgument.type == "number") then
compiledUnaryExpression:push(compiledExpression);
else
compiledUnaryExpression:push("_tonum(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
end

if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "!") then
compiledUnaryExpression:push("not ");
compiledUnaryExpression:push(compileBooleanExpression(_ENV,expression.argument));
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "~") then
compiledUnaryExpression:push("_bnot(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "typeof") then
compiledUnaryExpression:push("_type(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
if _bool(meta) then
meta.type = "string";
end

do break end;
_into = true;
end
if _into or (_v == "delete") then
if (withTracker.length == 0) then
scope = "_ENV.";
else
scope = "_oldENV.";
end

compiledUnaryExpression:push("(function () local _r = false; ");
if (expression.argument.type == "MemberExpression") then
scope = "";
gs = getGetterSetterExpression(_ENV,compiledExpression);
compiledUnaryExpression:push("local _g, _s = ");
compiledUnaryExpression:push(gs.getter);
compiledUnaryExpression:push(", ");
compiledUnaryExpression:push(gs.setter);
compiledUnaryExpression:push("; ");
compiledUnaryExpression:push(gs.getter);
compiledUnaryExpression:push(", ");
compiledUnaryExpression:push(gs.setter);
compiledUnaryExpression:push(" = nil, nil; _r = _g ~= nil or _s ~= nil;\010");
end

compiledUnaryExpression:push("local _v = ");
compiledUnaryExpression:push((scope .. compiledExpression));
compiledUnaryExpression:push("; ");
compiledUnaryExpression:push((scope .. compiledExpression));
compiledUnaryExpression:push(" = nil; return _r or _v ~= nil; end)()");
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "void") then
compiledUnaryExpression:push("_void(");
compiledUnaryExpression:push(compiledExpression);
compiledUnaryExpression:push(")");
if _bool(meta) then
meta.type = "undefined";
end

do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown UnaryOperator: " .. expression.operator)),0)
_into = true;
end
until true
else
_throw(_new(Error,"UnaryExpression: postfix ?!"),0)
end

do return compiledUnaryExpression:join(""); end
end);
compileAdditionOperator = (function (this, left, right, metaLeft, metaRight, meta)
local compiledAdditionOperator;
compiledAdditionOperator = _arr({},0);
if ((function() local _lev=(metaLeft.type == "number"); if _bool(_lev) then return (metaRight.type == "number"); else return _lev; end end)()) then
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(" + ");
compiledAdditionOperator:push(right);
if _bool(meta) then
meta.type = "number";
end

elseif (metaLeft.type == "string") then
if ((function() local _lev=(metaRight.type == "number"); return _bool(_lev) and _lev or (metaRight.type == "string") end)()) then
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(" .. ");
compiledAdditionOperator:push(right);
else
compiledAdditionOperator:push("_addStr1(");
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(",");
compiledAdditionOperator:push(right);
compiledAdditionOperator:push(")");
end

if _bool(meta) then
meta.type = "string";
end

elseif (metaRight.type == "string") then
if ((function() local _lev=(metaLeft.type == "number"); return _bool(_lev) and _lev or (metaLeft.type == "string") end)()) then
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(" .. ");
compiledAdditionOperator:push(right);
else
compiledAdditionOperator:push("_addStr2(");
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(",");
compiledAdditionOperator:push(right);
compiledAdditionOperator:push(")");
end

if _bool(meta) then
meta.type = "string";
end

elseif (metaLeft.type == "number") then
compiledAdditionOperator:push("_addNum1(");
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(",");
compiledAdditionOperator:push(right);
compiledAdditionOperator:push(")");
elseif (metaRight.type == "number") then
compiledAdditionOperator:push("_addNum2(");
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(",");
compiledAdditionOperator:push(right);
compiledAdditionOperator:push(")");
else
compiledAdditionOperator:push("_add(");
compiledAdditionOperator:push(left);
compiledAdditionOperator:push(",");
compiledAdditionOperator:push(right);
compiledAdditionOperator:push(")");
end

do return compiledAdditionOperator:join(""); end
end);
compileComparisonOperator = (function (this, left, right, operator, metaLeft, metaRight, meta)
local compiledComparisonOperator;
compiledComparisonOperator = _arr({},0);
if ((function() local _lev=((function() local _lev=(metaLeft.type == "string"); if _bool(_lev) then return (metaRight.type == "string"); else return _lev; end end)()); return _bool(_lev) and _lev or ((function() local _lev=(metaLeft.type == "number"); if _bool(_lev) then return (metaRight.type == "number"); else return _lev; end end)()) end)()) then
compiledComparisonOperator:push(left);
compiledComparisonOperator:push(operator);
compiledComparisonOperator:push(right);
else
repeat
local _into = false;
local _cases = {["<"] = true,["<="] = true,[">"] = true,[">="] = true};
local _v = operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "<") then
compiledComparisonOperator:push("_lt(");
do break end;
_into = true;
end
if _into or (_v == "<=") then
compiledComparisonOperator:push("_le(");
do break end;
_into = true;
end
if _into or (_v == ">") then
compiledComparisonOperator:push("_gt(");
do break end;
_into = true;
end
if _into or (_v == ">=") then
compiledComparisonOperator:push("_ge(");
do break end;
_into = true;
end
::_default::
until true
compiledComparisonOperator:push(left);
compiledComparisonOperator:push(",");
compiledComparisonOperator:push(right);
compiledComparisonOperator:push(")");
end

if _bool(meta) then
meta.type = "boolean";
end

do return compiledComparisonOperator:join(""); end
end);
compileBinaryExpression = (function (this, expression, meta)
local right,left,metaRight,metaLeft,compiledBinaryExpression;
compiledBinaryExpression = _arr({[0]="("},1);
metaLeft = _obj({});
metaRight = _obj({});
left = compileExpression(_ENV,expression.left,metaLeft);
right = compileExpression(_ENV,expression.right,metaRight);
repeat
local _into = false;
local _cases = {["=="] = true,["!="] = true,["==="] = true,["!=="] = true,["<"] = true,["<="] = true,[">"] = true,[">="] = true,["<<"] = true,[">>"] = true,[">>>"] = true,["+"] = true,["-"] = true,["*"] = true,["/"] = true,["%"] = true,["|"] = true,["^"] = true,["&"] = true,["in"] = true,["instanceof"] = true,[".."] = true};
local _v = expression.operator;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "==") then
compiledBinaryExpression:push("_eq(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "!=") then
compiledBinaryExpression:push("not _eq(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "===") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," == ",left,right);
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "!==") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," ~= ",left,right);
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "<") then

_into = true;
end
if _into or (_v == "<=") then

_into = true;
end
if _into or (_v == ">") then

_into = true;
end
if _into or (_v == ">=") then
compiledBinaryExpression:push(compileComparisonOperator(_ENV,left,right,expression.operator,metaLeft,metaRight,meta));
do break end;
_into = true;
end
if _into or (_v == "<<") then
compiledBinaryExpression:push("_lshift(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == ">>") then
compiledBinaryExpression:push("_arshift(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == ">>>") then
compiledBinaryExpression:push("_rshift(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "+") then
compiledBinaryExpression:push(compileAdditionOperator(_ENV,left,right,metaLeft,metaRight,meta));
do break end;
_into = true;
end
if _into or (_v == "-") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," - ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "*") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," * ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "/") then
pushSimpleBinaryExpression(_ENV,compiledBinaryExpression," / ",left,right);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "%") then
compiledBinaryExpression:push("_mod(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "|") then
compiledBinaryExpression:push("_bor(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "^") then
compiledBinaryExpression:push("_bxor(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "&") then
compiledBinaryExpression:push("_band(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "in") then
compiledBinaryExpression:push("_in(");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "instanceof") then
compiledBinaryExpression:push("_instanceof(");
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(",");
compiledBinaryExpression:push(right);
compiledBinaryExpression:push(")");
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
if _into or (_v == "..") then
do break end;
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknown BinaryOperator: " .. expression.operator)),0)
_into = true;
end
until true
compiledBinaryExpression:push(")");
do return compiledBinaryExpression:join(""); end
end);
pushSimpleBinaryExpression = (function (this, compiledBinaryExpression, operator, left, right)
compiledBinaryExpression:push(left);
compiledBinaryExpression:push(operator);
compiledBinaryExpression:push(right);
end);
compileConditionalExpression = (function (this, expression, meta)
local metaAlternate,metaConsequent,compiledConditionalExpression;
compiledConditionalExpression = _arr({[0]="(function() if "},1);
metaConsequent = _obj({});
metaAlternate = _obj({});
compiledConditionalExpression:push(compileBooleanExpression(_ENV,expression.test));
compiledConditionalExpression:push(" then return ");
compiledConditionalExpression:push(compileExpression(_ENV,expression.consequent,metaConsequent));
compiledConditionalExpression:push("; else return ");
compiledConditionalExpression:push(compileExpression(_ENV,expression.alternate,metaAlternate));
compiledConditionalExpression:push("; end end)()");
if _bool(meta) then
if ((function() local _lev=(metaConsequent.type == metaAlternate.type); if _bool(_lev) then return (metaConsequent.type ~= undefined); else return _lev; end end)()) then
meta.type = metaConsequent.type;
end

end

do return compiledConditionalExpression:join(""); end
end);
compileSequenceExpression = (function (this, expression, meta)
local metaLast,sequence,expressions,i,compiledSequenceExpression;
compiledSequenceExpression = _arr({[0]="_seq({"},1);
expressions = expression.expressions;
sequence = _arr({},0);
metaLast = _obj({});
i = 0;
while (i<expressions.length) do
sequence:push(compileExpression(_ENV,expressions[i],metaLast));
i = i + 1;
end

compiledSequenceExpression:push(sequence:join(","));
compiledSequenceExpression:push("})");
if _bool(meta) then
meta.type = metaLast.type;
end

do return compiledSequenceExpression:join(""); end
end);
compileObjectExpression = (function (this, expression, meta)
local compiledKey,compiledProperties,compiledProperty,property,length,i,compiledObjectExpression;
compiledObjectExpression = _arr({[0]="_obj({"},1);
length = expression.properties.length;
compiledProperty = _arr({},0);
compiledProperties = _arr({},0);
compiledKey = "";
i = 0;
while (i<length) do
compiledProperty = _arr({[0]="["},1);
property = expression.properties[i];
if (property.key.type == "Literal") then
compiledKey = compileLiteral(_ENV,property.key);
elseif (property.key.type == "Identifier") then
compiledKey = "\"";
compiledKey = (compiledKey .. sanitizeLiteralString(_ENV,property.key.name));
compiledKey = (compiledKey .. "\"");
else
_throw(_new(Error,("Unexpected property key type: " .. property.key.type)),0)
end

if (property.kind == "get") then
if (_type(property.key.value) == "number") then
compiledKey = (("\"" .. compiledKey) .. "\"");
end

compiledKey = compiledKey:replace(_regexp("^\"",""),"\"_g");
elseif (property.kind == "set") then
if (_type(property.key.value) == "number") then
compiledKey = (("\"" .. compiledKey) .. "\"");
end

compiledKey = compiledKey:replace(_regexp("^\"",""),"\"_s");
end

compiledProperty:push(compiledKey);
compiledProperty:push("] = ");
compiledProperty:push(compileExpression(_ENV,property.value));
compiledProperties:push(compiledProperty:join(""));
i = i + 1;
end

if (length>0) then
compiledObjectExpression:push("\010");
compiledObjectExpression:push(compiledProperties:join(",\010"));
compiledObjectExpression:push("\010");
end

compiledObjectExpression:push("})");
if _bool(meta) then
meta.type = "object";
end

do return compiledObjectExpression:join(""); end
end);
compileMemberExpression = (function (this, expression, meta)
local compiledProperty,compiledObject,compiledMemberExpression;
compiledMemberExpression = _arr({},0);
compiledObject = compileExpression(_ENV,expression.object);
if (expression.object.type == "Literal") then
compiledObject = (("(" .. compiledObject) .. ")");
end

compiledMemberExpression:push(compiledObject);
if _bool(expression.computed) then
compiledMemberExpression:push("[");
compiledMemberExpression:push(compileExpression(_ENV,expression.property));
compiledMemberExpression:push("]");
else
compiledProperty = compileIdentifier(_ENV,expression.property);
if (compiledProperty ~= expression.property.name) then
compiledMemberExpression:push("[\"");
compiledMemberExpression:push(sanitizeLiteralString(_ENV,expression.property.name));
compiledMemberExpression:push("\"]");
else
compiledMemberExpression:push(".");
compiledMemberExpression:push(compiledProperty);
end

end

setMeta(_ENV,expression,meta);
do return compiledMemberExpression:join(""); end
end);
compileNewExpression = (function (...)
local this, expression = ...;
local arguments = _args(...);
local length,i,newArguments,compiledNewExpression;
compiledNewExpression = _arr({[0]="_new("},1);
newArguments = _arr({[0]=compileExpression(_ENV,expression.callee)},1);
length = expression.arguments.length;
i = 0;
while (i<length) do
newArguments:push(compileExpression(_ENV,expression.arguments[i]));
i = i + 1;
end

compiledNewExpression:push(newArguments:join(","));
compiledNewExpression:push(")");
do return compiledNewExpression:join(""); end
end);
compileThisExpression = (function (this)
do return "this"; end
end);
compileArrayExpression = (function (this, expression, meta)
local length,i,compiledElements,compiledArrayExpression;
compiledArrayExpression = _arr({[0]="_arr({"},1);
compiledElements = _arr({},0);
length = expression.elements.length;
if (length>0) then
compiledArrayExpression:push("[0]=");
end

i = 0;
while (i<length) do
if (expression.elements[i] ~= null) then
compiledElements:push(compileExpression(_ENV,expression.elements[i]));
else
compiledElements:push("nil");
end

i = i + 1;
end

compiledArrayExpression:push(compiledElements:join(","));
compiledArrayExpression:push("},");
compiledArrayExpression:push(length);
compiledArrayExpression:push(")");
if _bool(meta) then
meta.type = "object";
end

do return compiledArrayExpression:join(""); end
end);
compileFunctionDeclaration = (function (this, declaration)
local compiledId,compiledFunctionDeclaration;
compiledFunctionDeclaration = _arr({},0);
compiledId = compileIdentifier(_ENV,declaration.id);
compiledFunctionDeclaration:push(compiledId);
compiledFunctionDeclaration:push(" = ");
compiledFunctionDeclaration:push(compileFunction(_ENV,declaration));
compiledFunctionDeclaration:push(";");
localVarManager:pushLocal(compiledId);
localVarManager:pushFunction(compiledFunctionDeclaration:join(""));
end);
compileVariableDeclaration = (function (this, variableDeclaration)
local compiledDeclarationInit,expression,pattern,declarator,i,declarations,compiledDeclarations;
compiledDeclarations = _arr({},0);
repeat
local _into = false;
local _cases = {["const"] = true,["var"] = true,["let"] = true};
local _v = variableDeclaration.kind;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "const") then

_into = true;
end
if _into or (_v == "var") then
declarations = variableDeclaration.declarations;
i = 0;
while (i<declarations.length) do
declarator = declarations[i];
pattern = compilePattern(_ENV,declarator.id);
localVarManager:pushLocal(pattern);
if (declarator.init ~= null) then
expression = compileExpression(_ENV,declarator.init);
compiledDeclarationInit = _arr({},0);
compiledDeclarationInit:push(pattern);
compiledDeclarationInit:push(" = ");
compiledDeclarationInit:push(expression);
compiledDeclarationInit:push(";");
compiledDeclarations:push(compiledDeclarationInit:join(""));
end

i = i + 1;
end

do break end;
_into = true;
end
if _into or (_v == "let") then
_throw(_new(Error,"let instruction is not supported yet"),0)
_into = true;
end
::_default::
until true
do return compiledDeclarations:join("\010"); end
end);
compilePattern = (function (this, pattern, meta)
repeat
local _into = false;
local _cases = {["Identifier"] = true,["RestElement"] = true};
local _v = pattern.type;
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "Identifier") then
do return compileIdentifier(_ENV,pattern,meta); end
_into = true;
end
if _into or (_v == "RestElement") then
_throw(_new(Error,"Rest parameters (ES6) not supported yet."),0)
_into = true;
end
::_default::
if _into then
_throw(_new(Error,("Unknwown Pattern type: " .. pattern.type)),0)
_into = true;
end
until true
end);
compileFunction = (function (this, fun)
local compiledFunctionsDeclaration,functions,compiledLocalsDeclaration,useArguments,locals,context,compiledParams,params,i,compiledBody,compiledFunction;
compiledFunction = _arr({[0]="(function ("},1);
compiledBody = "";
localVarManager:createLocalContext();
if (fun.body.type == "BlockStatement") then
compiledBody = compileStatement(_ENV,fun.body);
elseif (fun.body.type == "Expression") then
compiledBody = compileExpression(_ENV,fun.body);
end

if _bool(((function() local _lev=fun.defaults; if _bool(_lev) then return (_gt(fun.defaults.length,0)); else return _lev; end end)())) then
console:log("Warning: default parameters of functions are ignored");
end

params = fun.params;
compiledParams = _arr({[0]="this"},1);
i = 0;
while (i<params.length) do
compiledParams:push(compilePattern(_ENV,params[i]));
i = i + 1;
end

context = localVarManager:popLocalContext();
locals = context[0];
useArguments = ((function() local _lev=context[1]; if _bool(_lev) then return (compiledParams:indexOf("arguments") == -1); else return _lev; end end)());
if _bool(useArguments) then
compiledFunction:push("...)\010");
compiledFunction:push((("local " .. compiledParams:join(", ")) .. " = ...;\010"));
compiledFunction:push("local arguments = _args(...);\010");
compiledParams:push("arguments");
else
compiledFunction:push(compiledParams:join(", "));
compiledFunction:push(")\010");
end

if (locals.length>0) then
compiledLocalsDeclaration = buildLocalsDeclarationString(_ENV,locals,compiledParams);
compiledFunction:push(compiledLocalsDeclaration);
end

functions = context[2];
if (functions.length>0) then
compiledFunctionsDeclaration = _arr({},0);
i = 0;
while (i<functions.length) do
compiledFunctionsDeclaration:push(functions[i]);
i = i + 1;
end

compiledFunction:push(compiledFunctionsDeclaration:join("\010"));
end

compiledFunction:push(compiledBody);
compiledFunction:push("\010");
compiledFunction:push("end)");
do return compiledFunction:join(""); end
end);
buildLocalsDeclarationString = (function (this, locals, ignore)
local compiledLocalsDeclaration,length,_g_local,i,namesSequence;
ignore = (_bool(ignore) and ignore or _arr({},0));
namesSequence = _arr({},0);
length = locals.length;
i = 0;
while (i<length) do
_g_local = locals:pop();
if ((function() local _lev=(ignore:indexOf(_g_local) == -1); if _bool(_lev) then return (namesSequence:indexOf(_g_local) == -1); else return _lev; end end)()) then
namesSequence:push(_g_local);
end

i = i + 1;
end

if (namesSequence.length>0) then
compiledLocalsDeclaration = _arr({[0]="local "},1);
compiledLocalsDeclaration:push(namesSequence:join(","));
compiledLocalsDeclaration:push(";\010");
do return compiledLocalsDeclaration:join(""); end
end

do return ""; end
end);
sanitizeIdentifier = (function (this, id)
if (luaKeywords:indexOf(id)>-1) then
do return ("_g_" .. id); end
end

do return id:replace(_regexp("_","g"),"__"):replace(_regexp("\\$","g"),"S"):replace(_regexp("[\194\128-\239\191\191]","g"),(function (this, c)
do return ("_" .. c:charCodeAt(0)); end
end)); end
end);
compileIdentifier = (function (this, identifier, meta)
if (identifier.name == "arguments") then
localVarManager:useArguments();
end

setMeta(_ENV,identifier,meta);
do return sanitizeIdentifier(_ENV,identifier.name); end
end);
toUTF8Array = (function (this, str)
local charcode,i,utf8;
utf8 = _arr({},0);
i = 0;
while (i<str.length) do
charcode = str:charCodeAt(i);
if (charcode<128) then
utf8:push(charcode);
elseif (charcode<2048) then
utf8:push((_bor(192,(_arshift(charcode,6)))),(_bor(128,(_band(charcode,63)))));
elseif ((function() local _lev=(charcode<55296); return _bool(_lev) and _lev or (charcode>=57344) end)()) then
utf8:push((_bor(224,(_arshift(charcode,12)))),(_bor(128,(_band((_arshift(charcode,6)),63)))),(_bor(128,(_band(charcode,63)))));
else
i = i + 1;
charcode = (65536 + (_bor((_lshift((_band(charcode,1023)),10)),(_band(str:charCodeAt(i),1023)))));
utf8:push((_bor(240,(_arshift(charcode,18)))),(_bor(128,(_band((_arshift(charcode,12)),63)))),(_bor(128,(_band((_arshift(charcode,6)),63)))),(_bor(128,(_band(charcode,63)))));
end

i = i + 1;
end

do return utf8; end
end);
sanitizeLiteralString = (function (this, str)
do return str:replace(_regexp("\\\\","g"),"\\\\"):replace(_regexp("\"","g"),"\\\""):replace(_regexp("\194\160","g")," "):replace(_regexp("[\\0-\31\127-\237\159\191\240\144\128\128-\239\191\191]|[\240\144\128\128-\244\143\176\128][\240\144\128\128-\244\143\176\128]|[\240\144\128\128-\244\143\176\128]","g"),(function (this, str)
local ut8bytes;
ut8bytes = toUTF8Array(_ENV,str);
ut8bytes = ut8bytes:map((function (this, e)
do return ("\\" .. ("00" .. e):slice(-3)); end
end));
do return ut8bytes:join(""); end
end)); end
end);
sanitizeRegExpSource = (function (this, str)
do return str:replace(_regexp("\\\\","g"),"\\\\"):replace(_regexp("\"","g"),"\\\""):replace(_regexp("\\\\\\\\u([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])","g"),(function (this, str, hexaCode)
local chars;
chars = String:fromCharCode(parseInt(_ENV,hexaCode,16));
do return ("\\" .. toUTF8Array(_ENV,chars):join("\\")); end
end)); end
end);
compileLiteral = (function (this, literal, meta)
local flags,source,compiledRegExp,regexp,ret;
ret = literal.raw;
if (_instanceof(literal.value,RegExp)) then
regexp = literal.value;
compiledRegExp = _arr({[0]="_regexp(\""},1);
source = sanitizeRegExpSource(_ENV,regexp.source);
compiledRegExp:push(source);
compiledRegExp:push("\",\"");
flags = "";
flags = (flags .. (function() if _bool(regexp.global) then return "g"; else return ""; end end)());
flags = (flags .. (function() if _bool(regexp.ignoreCase) then return "i"; else return ""; end end)());
flags = (flags .. (function() if _bool(regexp.multiline) then return "m"; else return ""; end end)());
compiledRegExp:push(flags);
compiledRegExp:push("\")");
ret = compiledRegExp:join("");
if _bool(meta) then
meta.type = "object";
end

do return ret; end
end

repeat
local _into = false;
local _cases = {["string"] = true,["number"] = true,["boolean"] = true};
local _v = _type(literal.value);
if not _cases[_v] then
_into = true;
goto _default
end
if _into or (_v == "string") then
ret = (("\"" .. sanitizeLiteralString(_ENV,literal.value)) .. "\"");
if _bool(meta) then
meta.type = "string";
end

do break end;
_into = true;
end
if _into or (_v == "number") then
ret = JSON:stringify(literal.value);
if _bool(meta) then
meta.type = "number";
end

do break end;
_into = true;
end
if _into or (_v == "boolean") then
if _bool(meta) then
meta.type = "boolean";
end

do break end;
_into = true;
end
::_default::
until true
do return ret; end
end);luaKeywords = _arr({[0]="and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while"},22);
labelTracker = _arr({},0);
continueNoLabelTracker = _arr({},0);
withTracker = _arr({},0);
deductions = _arr({},0);
ProtectedCallManager.prototype = _obj({
["isInProtectedCallContext"] = (function (this)
if (this.protectedCallContext.length>0) then
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
this.mayReturnStack[(this.mayReturnStack.length - 1)] = true;
end

end),
["breakOutside"] = (function (this)
if _bool(((function() local _lev=((function() local _lev=this:isInProtectedCallContext(); if _bool(_lev) then return this:noInsideIteration(); else return _lev; end end)()); if _bool(_lev) then return this:noInsideSwitch(); else return _lev; end end)())) then
this.mayBreakStack[(this.mayBreakStack.length - 1)] = true;
do return true; end
end

do return false; end
end),
["continueOutside"] = (function (this)
if _bool(((function() local _lev=this:isInProtectedCallContext(); if _bool(_lev) then return this:noInsideIteration(); else return _lev; end end)())) then
this.mayContinueStack[(this.mayContinueStack.length - 1)] = true;
do return true; end
end

do return false; end
end)
});
protectedCallManager = _new(ProtectedCallManager);
LocalVarManager.prototype = _obj({
["popLocalContext"] = (function (this)
if (this.locals.length>0) then
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
if (this.locals.length>0) then
this.locals[(this.locals.length - 1)]:push(varName);
else
_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end

end),
["pushFunction"] = (function (this, functionDeclaration)
if (this.functions.length>0) then
this.functions[(this.functions.length - 1)]:push(functionDeclaration);
else
_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end

end),
["useArguments"] = (function (this)
if (this.args.length>0) then
this.args[(this.args.length - 1)] = true;
else
_throw(_new(Error,"LocalVarManager error: no current local context"),0)
end

end)
});
localVarManager = _new(LocalVarManager);
exports.compileAST = compileAST;
end));
if exports ~= nil then
    return exports
elseif this.castl ~= nil then
    return this.castl
else
    _throw("Error while loading lua version of CASTL")
end
end, _ENV)();
