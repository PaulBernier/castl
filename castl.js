/*
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
*/
(function (root, factory) {
    'use strict';

    // Universal Module Definition (UMD) to support AMD, CommonJS/Node.js,
    // Rhino, and plain browser loading.

    if (typeof define === 'function' && define.amd) {
        define(['exports'], factory);
    } else if (exports !== undefined) {
        factory(exports);
    } else {
        root.castl = {};
        factory(root.castl);
    }
}(this, function (exports) {
    "use strict";

    var luaKeywords = ['and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 'function', 'goto', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat', 'return', 'then', 'true', 'until', 'while'];

    var labelTracker = [];
    var continueNoLabelTracker = [];

    /********************************
     *
     * ProtectedCallManager definition
     *
     * ******************************/

    function ProtectedCallManager() {
        this.protectedCallContext = []; // array of bool
        this.mayReturnStack = []; // array of bool
        this.mayBreakStack = []; // array of bool
        this.mayContinueStack = []; // array of bool
        this.iterationStatement = []; // array of arrays
        this.switchStatement = []; // array of arrays
    }

    ProtectedCallManager.prototype = {
        isInProtectedCallContext: function () {
            if (this.protectedCallContext.length > 0) {
                return true;
            }
            return false;
        },
        noInsideIteration: function () {
            return this.iterationStatement[this.iterationStatement.length - 1].length === 0;
        },
        noInsideSwitch: function () {
            return this.switchStatement[this.switchStatement.length - 1].length === 0;
        },
        may: function () {
            return {
                mayReturn: this.mayReturnStack[this.mayReturnStack.length - 1],
                mayBreak: this.mayBreakStack[this.mayBreakStack.length - 1],
                mayContinue: this.mayContinueStack[this.mayContinueStack.length - 1]
            };
        },
        openContext: function () {
            this.protectedCallContext.push(true);
            this.iterationStatement.push([]);
            this.switchStatement.push([]);
            this.mayBreakStack.push(false);
            this.mayContinueStack.push(false);
            this.mayReturnStack.push(false);
        },
        closeContext: function () {
            this.protectedCallContext.pop();
            this.iterationStatement.pop();
            this.switchStatement.pop();
            this.mayBreakStack.pop();
            this.mayContinueStack.pop();
            this.mayReturnStack.pop();
        },
        openIterationStatement: function () {
            if (this.isInProtectedCallContext()) {
                this.iterationStatement[this.iterationStatement.length - 1].push(true);
            }
        },
        closeIterationStatement: function () {
            if (this.isInProtectedCallContext()) {
                this.iterationStatement[this.iterationStatement.length - 1].pop();
            }
        },
        openSwitchStatement: function () {
            if (this.isInProtectedCallContext()) {
                this.switchStatement[this.iterationStatement.length - 1].push(true);
            }
        },
        closeSwitchStatement: function () {
            if (this.isInProtectedCallContext()) {
                this.switchStatement[this.iterationStatement.length - 1].pop();
            }
        },
        returnStatement: function () {
            if (this.isInProtectedCallContext()) {
                this.mayReturnStack[this.mayReturnStack.length - 1] = true;
            }
        },
        breakOutside: function () {
            if (this.isInProtectedCallContext() && this.noInsideIteration() && this.noInsideSwitch()) {
                this.mayBreakStack[this.mayBreakStack.length - 1] = true;
                return true;
            }
            return false;
        },
        continueOutside: function () {
            if (this.isInProtectedCallContext() && this.noInsideIteration()) {
                this.mayContinueStack[this.mayContinueStack.length - 1] = true;
                return true;
            }
            return false;
        }
    };

    // instance
    var protectedCallManager = new ProtectedCallManager();

    /********************************
     *
     * LocalVarManager definition
     *
     * ******************************/

    function LocalVarManager() {
        this.locals = []; // Array of arrays
        this.functions = []; // Array of arrays
        this.args = []; // Array of booleans
    }

    LocalVarManager.prototype = {
        popLocalContext: function () {
            if (this.locals.length > 0) {
                return [this.locals.pop(), this.args.pop(), this.functions.pop()];
            }

            throw new Error("LocalVarManager error: no current local context");
        },

        // Using a set as context would be better (ECMA6)
        createLocalContext: function () {
            this.locals.push([]);
            this.functions.push([]);
            this.args.push(false);
        },

        pushLocal: function (varName) {
            if (this.locals.length > 0) {
                this.locals[this.locals.length - 1].push(varName);
            } else {
                throw new Error("LocalVarManager error: no current local context");
            }
        },

        pushFunction: function (functionDeclaration) {
            if (this.functions.length > 0) {
                this.functions[this.functions.length - 1].push(functionDeclaration);
            } else {
                throw new Error("LocalVarManager error: no current local context");
            }
        },

        useArguments: function () {
            if (this.args.length > 0) {
                this.args[this.args.length - 1] = true;
            } else {
                throw new Error("LocalVarManager error: no current local context");
            }
        }
    };

    // instance
    var localVarManager = new LocalVarManager();

    /*****************
     *
     * Compile
     *
     * ***************/

    var options;

    function compileAST(ast, opts) {
        options = opts || {};

        // Compile top level
        if (ast.type === 'Program') {
            var compiledProgram = [];

            localVarManager.createLocalContext();
            var topLevelStatements = compileListOfStatements(ast.body);

            // Get local variables, function declarations and arguments
            var context = localVarManager.popLocalContext();
            var useArguments = context[1];

            if (useArguments) {
                compiledProgram.push("local arguments = _args(...);");
            }

            // Locals
            var locals = context[0];
            if (locals.length > 0) {
                var compiledLocalsDeclaration = buildLocalsDeclarationString(locals);
                compiledProgram.push(compiledLocalsDeclaration);
            }

            // Function declarations
            var functions = context[2];
            if (functions.length > 0) {
                var compiledFunctionsDeclaration = [];
                var i;
                for (i = 0; i < functions.length; ++i) {
                    compiledFunctionsDeclaration.push(functions[i]);
                }

                compiledProgram.push(compiledFunctionsDeclaration.join("\n"));
            }

            // Body of the program
            compiledProgram.push(topLevelStatements);

            return ({
                success: true,
                compiled: compiledProgram.join("\n")
            });
        }

        return ({
            success: false,
            compiled: ""
        });
    }

    /*****************
     *
     * Statements
     *
     * ***************/

    function compileStatement(statement) {

        var compiledStatement;

        switch (statement.type) {
        case "ExpressionStatement":
            compiledStatement = compileExpressionStatement(statement.expression);
            break;
        case "BlockStatement":
            compiledStatement = compileListOfStatements(statement.body);
            break;
        case "FunctionDeclaration":
            compiledStatement = compileFunctionDeclaration(statement);
            break;
        case "VariableDeclaration":
            compiledStatement = compileVariableDeclaration(statement);
            break;
        case "IfStatement":
            compiledStatement = compileIfStatement(statement);
            break;
        case "ForStatement":
        case "WhileStatement":
        case "DoWhileStatement":
        case "ForInStatement":
            compiledStatement = compileIterationStatement(statement);
            break;
        case "ReturnStatement":
            compiledStatement = compileReturnStatement(statement);
            break;
        case "BreakStatement":
            compiledStatement = compileBreakStatement(statement);
            break;
        case "TryStatement":
            compiledStatement = compileTryStatement(statement);
            break;
        case "ThrowStatement":
            compiledStatement = compileThrowStatement(statement);
            break;
        case "SwitchStatement":
            compiledStatement = compileSwitchStatement(statement);
            break;
        case "ContinueStatement":
            compiledStatement = compileContinueStatement(statement);
            break;
        case "LabeledStatement":
            compiledStatement = compileLabeledStatement(statement);
            break;
        case "WithStatement":
            compiledStatement = compileWithStatement(statement);
            break;
        case "EmptyStatement":
        case "DebuggerStatement":
            return "";
        default:
            throw new Error("Unknown Statement type: " + statement.type);
        }

        if (compiledStatement !== undefined) {
            if (options.debug) {
                var line = statement.loc.start.line;
                return "--[[" + line + "--]] " + compiledStatement;
            }
            return compiledStatement;
        }
    }

    function compileListOfStatements(statementList) {
        var compiledStatements = [];

        var i, compiledStatement;
        for (i = 0; i < statementList.length; ++i) {
            compiledStatement = compileStatement(statementList[i]);

            // After compilation some statements may become empty strings
            // or 'undefined' such as VariableDeclaration and FunctionDeclaration
            if (compiledStatement !== "" && compiledStatement !== undefined) {
                compiledStatements.push(compiledStatement);
            }
        }

        return compiledStatements.join("\n");
    }

    function compileIfStatement(statement, elif) {
        var compiledIfStatement = [];

        if (elif) {
            compiledIfStatement.push("elseif _bool(");
        } else {
            compiledIfStatement.push("if _bool(");
        }

        compiledIfStatement.push(compileExpression(statement.test));
        compiledIfStatement.push(") then\n");

        compiledIfStatement.push(compileStatement(statement.consequent));

        if (statement.alternate !== null) {
            compiledIfStatement.push("\n");

            // Alternate is a If statement
            if (statement.alternate.type === "IfStatement") {
                compiledIfStatement.push(compileIfStatement(statement.alternate, true));
            } else {
                compiledIfStatement.push("else\n");
                compiledIfStatement.push(compileStatement(statement.alternate));
            }
        }

        if (!elif) {
            compiledIfStatement.push("\n");
            compiledIfStatement.push("end\n");
        }

        return compiledIfStatement.join('');
    }

    function compileForInit(init) {
        var compiledForInit = [];
        if (init !== null) {
            if (init.type === "VariableDeclaration") {
                compiledForInit.push(compileVariableDeclaration(init));
            } else {
                compiledForInit.push(compileExpressionStatement(init));
            }
            compiledForInit.push("\n");
        }

        return compiledForInit.join("");
    }

    function compileForUpdate(update) {
        var compiledForUpdate = [];
        if (update !== null) {
            compiledForUpdate.push(compileExpressionStatement(update));
            compiledForUpdate.push("\n");
        }

        return compiledForUpdate.join("");
    }

    function compileIterationStatement(statement, compiledLabel) {
        var compiledIterationStatement = "";
        continueNoLabelTracker.push(false);
        protectedCallManager.openIterationStatement();

        switch (statement.type) {
        case "ForStatement":
            compiledIterationStatement = compileForStatement(statement, compiledLabel);
            break;
        case "WhileStatement":
            compiledIterationStatement = compileWhileStatement(statement, compiledLabel);
            break;
        case "DoWhileStatement":
            compiledIterationStatement = compileDoWhileStatement(statement, compiledLabel);
            break;
        case "ForInStatement":
            compiledIterationStatement = compileForInStatement(statement, compiledLabel);
            break;
        default:
            throw new Error("Not an IterationStatement " + statement.type);
        }
        protectedCallManager.closeIterationStatement();
        continueNoLabelTracker.pop();

        return compiledIterationStatement;
    }

    function compileForStatement(statement, compiledLabel) {
        var compiledForStatement = [];

        // Init
        compiledForStatement.push(compileForInit(statement.init));

        compiledForStatement.push("while _bool(");

        // Test
        if (statement.test !== null) {
            compiledForStatement.push(compileExpression(statement.test));
        } else {
            compiledForStatement.push("true");
        }

        compiledForStatement.push(") do\n");

        // Body
        compiledForStatement.push(compileStatement(statement.body));
        compiledForStatement.push("\n");

        // Label for continue
        if (continueNoLabelTracker[continueNoLabelTracker.length - 1]) {
            compiledForStatement.push("::_continue::\n");
        }

        // Label for continue with label
        if (compiledLabel && labelTracker[compiledLabel].mayContinue) {
            compiledForStatement.push("::" + compiledLabel + "_c::\n");
        }

        // Update
        compiledForStatement.push(compileForUpdate(statement.update));

        compiledForStatement.push("end\n");

        return compiledForStatement.join("");
    }

    function compileForInStatement(statement, compiledLabel) {
        var compiledForInStatement = ["for "];
        var compiledLeft;

        if (statement.left.type === "VariableDeclaration") {
            compiledLeft = compilePattern(statement.left.declarations[0].id);
            // Add to current local context
            localVarManager.pushLocal(compiledLeft);
            compiledForInStatement.push(compiledLeft);
        } else {
            compiledLeft = compileExpression(statement.left);
            compiledForInStatement.push(compiledLeft);
        }

        compiledForInStatement.push(" in _props(");
        compiledForInStatement.push(compileExpression(statement.right));
        compiledForInStatement.push(") do\n");

        // Cast to string
        compiledForInStatement.push(compiledLeft);
        compiledForInStatement.push(" = _tostr(");
        compiledForInStatement.push(compiledLeft);
        compiledForInStatement.push(");\n");

        // Body
        compiledForInStatement.push(compileStatement(statement.body));

        // Label for continue
        compiledForInStatement.push("::_continue::\n");

        // Label for continue with label
        if (compiledLabel && labelTracker[compiledLabel].mayContinue) {
            compiledForInStatement.push("::" + compiledLabel + "_c::\n");
        }

        compiledForInStatement.push("end\n");

        return compiledForInStatement.join("");
    }

    function compileWhileStatement(statement, compiledLabel) {
        var compiledWhileStatement = ["while _bool("];

        // Test
        compiledWhileStatement.push(compileExpression(statement.test));
        compiledWhileStatement.push(") do\n");

        // Body
        compiledWhileStatement.push(compileStatement(statement.body));
        compiledWhileStatement.push("\n");

        // Label for continue
        compiledWhileStatement.push("::_continue::\n");

        // Label for continue with label
        if (compiledLabel && labelTracker[compiledLabel].mayContinue) {
            compiledWhileStatement.push("::" + compiledLabel + "_c::\n");
        }

        compiledWhileStatement.push("end\n");

        return compiledWhileStatement.join("");
    }

    function compileDoWhileStatement(statement, compiledLabel) {
        var compiledDoWhileStatement = ["repeat\n"];

        // Body
        compiledDoWhileStatement.push(compileStatement(statement.body));
        compiledDoWhileStatement.push("\n");

        // Label for continue
        compiledDoWhileStatement.push("::_continue::\n");

        // Label for continue with label
        if (compiledLabel && labelTracker[compiledLabel].mayContinue) {
            compiledDoWhileStatement.push("::" + compiledLabel + "_c::\n");
        }

        // Test
        compiledDoWhileStatement.push("until not _bool(");
        compiledDoWhileStatement.push(compileExpression(statement.test));
        compiledDoWhileStatement.push(")\n");

        return compiledDoWhileStatement.join("");
    }

    function isIterationStatement(statement) {
        return statement.type === "ForStatement" ||
            statement.type === "DoWhileStatement" ||
            statement.type === "WhileStatement" ||
            statement.type === "ForInStatement";
    }

    function compileLabeledStatement(statement) {
        var compiledLabeledStatement = [];

        var label = statement.label;
        var compiledLabel = compileIdentifier(label);

        // create tracker for this label
        labelTracker[compiledLabel] = {
            mayBreak: false,
            mayContinue: false
        };

        if (isIterationStatement(statement.body)) {
            compiledLabeledStatement.push(compileIterationStatement(statement.body, compiledLabel));
        } else {
            compiledLabeledStatement.push(compileStatement(statement.body));
        }

        if (labelTracker[compiledLabel].mayBreak) {
            compiledLabeledStatement.push("::" + compiledLabel + "_b::\n");
        }

        // delete tracker for this label
        delete labelTracker[compiledLabel];

        return compiledLabeledStatement.join("");
    }

    function compileBreakStatement(statement) {
        if (statement.label === null) {
            // Inside a try catch
            if (protectedCallManager.breakOutside()) {
                return "do return _break; end";
            }

            return "break;";
        }

        var compiledLabel = compileIdentifier(statement.label);
        labelTracker[compiledLabel].mayBreak = true;
        return "goto " + compiledLabel + "_b;";
    }

    // http://lua-users.org/wiki/ContinueProposal
    function compileContinueStatement(statement) {
        if (statement.label === null) {
            continueNoLabelTracker[continueNoLabelTracker.length - 1] = true;

            // Inside a try catch
            if (protectedCallManager.continueOutside()) {
                return "do return _continue; end";
            }

            return "goto _continue";
        }

        var compiledLabel = compileIdentifier(statement.label);
        labelTracker[compiledLabel].mayContinue = true;
        return "goto " + compiledLabel + "_c;";
    }

    function compileSwitchStatement(statement) {
        protectedCallManager.openSwitchStatement();

        var cases = statement.cases;

        if (cases.length > 0) {
            // Use a useless repeat loop to be able to use break
            var compiledSwitchStatement = ["repeat\nlocal _into = false;\n"];
            var compiledDiscriminant = compileExpression(statement.discriminant);

            // Construct lookup table
            var i;
            var casesTable = [];
            var caseTablementElement;
            var compiledTests = [];
            for (i = 0; i < cases.length; ++i) {
                if (cases[i].test !== null) {
                    compiledTests[i] = compileExpression(cases[i].test);

                    caseTablementElement = [];
                    caseTablementElement.push("[");
                    caseTablementElement.push(compiledTests[i]);
                    caseTablementElement.push("] = true");

                    casesTable.push(caseTablementElement.join(""));
                }
            }

            compiledSwitchStatement.push("local _cases = {");
            compiledSwitchStatement.push(casesTable.join(","));
            compiledSwitchStatement.push("};\n");

            // Default jump
            compiledSwitchStatement.push("if (not _cases[");
            compiledSwitchStatement.push(compiledDiscriminant);
            compiledSwitchStatement.push("]) then\n");
            compiledSwitchStatement.push("_into = true;\n");
            compiledSwitchStatement.push("goto _default\n");
            compiledSwitchStatement.push("end\n");

            // Cases
            var hasDefault = false;
            for (i = 0; i < cases.length; ++i) {
                if (cases[i].test !== null) {
                    compiledSwitchStatement.push("if _into or (");
                    compiledSwitchStatement.push(compiledDiscriminant);
                    compiledSwitchStatement.push(" == ");
                    compiledSwitchStatement.push(compiledTests[i]);
                    compiledSwitchStatement.push(") then\n");
                } else {
                    // Default case
                    hasDefault = true;
                    compiledSwitchStatement.push("::_default::\n");
                    compiledSwitchStatement.push("if _into then\n");
                }

                compiledSwitchStatement.push(compileListOfStatements(cases[i].consequent));
                compiledSwitchStatement.push("\n");
                compiledSwitchStatement.push("_into = true;\n");
                compiledSwitchStatement.push("end\n");
            }

            if (!hasDefault) {
                compiledSwitchStatement.push("::_default::\n");
            }

            compiledSwitchStatement.push("until true");

            protectedCallManager.closeSwitchStatement();
            return compiledSwitchStatement.join("");
        }

        protectedCallManager.closeSwitchStatement();
        return "";
    }

    function compileTryStatement(statement) {
        // Esprima TryStatement is slightly different from SpiderMonkey specification
        if (statement.handlers) {
            return compileTryStatementFlavored(statement, true);
        }

        return compileTryStatementFlavored(statement, false);

    }

    // Finally cases: http://stackoverflow.com/a/9688068
    // esprima = true: use statement.handlers array
    // esprima = false: use statement.handler
    function compileTryStatementFlavored(statement, esprima) {
        var hasHandler = esprima ? (statement.handlers.length > 0) : statement.handler !== null;
        var hasFinalizer = (statement.finalizer !== null);
        var finallyStatements;
        var may;

        // Protected call
        protectedCallManager.openContext();
        var compiledTryStatement = ["local _status, _return = _pcall(function()\n"];
        compiledTryStatement.push(compileListOfStatements(statement.block.body));
        compiledTryStatement.push("\n");
        compiledTryStatement.push("end);\n");
        // Collect result of analysis before closing
        may = protectedCallManager.may();
        protectedCallManager.closeContext();

        // No exception raised and something to do after execution of try block
        // either a finally to execute or a return,break or continue to handle
        if (hasFinalizer || may.mayReturn || may.mayBreak || may.mayContinue) {
            compiledTryStatement.push("if _status then\n");

            if (hasFinalizer) {
                finallyStatements = compileListOfStatements(statement.finalizer.body);
                compiledTryStatement.push(finallyStatements);
                compiledTryStatement.push("\n");
            }

            if (may.mayBreak && may.mayContinue) {
                compiledTryStatement.push("if _return == _break then break; elseif _return == _continue then goto _continue end\n");
            } else if (may.mayBreak) {
                compiledTryStatement.push("if _return == _break then break; end\n");
            } else if (may.mayContinue) {
                compiledTryStatement.push("if _return == _continue then goto _continue end\n");
            }

            if (may.mayReturn) {
                compiledTryStatement.push("if _return ~= nil then return _return; end\n");
            }

            // Exception has been raised
            compiledTryStatement.push("else\n");
        } else {
            compiledTryStatement.push("if not _status then\n");
        }

        if (hasHandler) {
            var handler = esprima ? statement.handlers[0] : statement.handler;

            // Protected call
            protectedCallManager.openContext();
            compiledTryStatement.push("local _cstatus, _creturn = _pcall(function()\n");
            compiledTryStatement.push("local ");
            compiledTryStatement.push(compilePattern(handler.param));
            compiledTryStatement.push(" = _return;\n");
            compiledTryStatement.push(compileListOfStatements(handler.body.body));
            compiledTryStatement.push("\n");
            compiledTryStatement.push("end);\n");
            // Collect result of analysis before closing
            may = protectedCallManager.may();
            protectedCallManager.closeContext();
        }

        if (hasFinalizer) {
            compiledTryStatement.push(finallyStatements);
            compiledTryStatement.push("\n");
        }

        if (hasHandler) {
            compiledTryStatement.push("if _cstatus then\n");

            if (may.mayBreak && may.mayContinue) {
                compiledTryStatement.push("if _creturn == _break then break; elseif _creturn == _continue then goto _continue end\n");
            } else if (may.mayBreak) {
                compiledTryStatement.push("if _creturn == _break then break; end\n");
            } else if (may.mayContinue) {
                compiledTryStatement.push("if _creturn == _continue then goto _continue end\n");
            }

            if (may.mayReturn) {
                compiledTryStatement.push("if _creturn ~= nil then return _creturn; end\n");
            }

            compiledTryStatement.push("else _throw(_creturn,0); end\n");
        }

        compiledTryStatement.push("end\n");

        return compiledTryStatement.join("");
    }

    function compileThrowStatement(statement) {
        var compiledThrowStatement = ["_throw("];
        compiledThrowStatement.push(compileExpression(statement.argument));
        compiledThrowStatement.push(",0)");

        return compiledThrowStatement.join("");
    }

    function compileReturnStatement(statement) {
        protectedCallManager.returnStatement();

        if (statement.argument !== null) {
            return " do return " + compileExpression(statement.argument) + "; end";
        }

        return "do return end";
    }

    function compileWithStatement(statement) {
        var compiledWithStatement = ["do\n"];

        // with
        compiledWithStatement.push("local _ENV = _with(");
        compiledWithStatement.push(compileExpression(statement.object));
        compiledWithStatement.push(", _ENV);\n");

        if (options.jit) {
            compiledWithStatement.push("_wenv(function(...)\n");
        }

        // body
        compiledWithStatement.push(compileStatement(statement.body));

        if (options.jit) {
            compiledWithStatement.push("end, _ENV)()\n");
        }

        compiledWithStatement.push("end");

        return compiledWithStatement.join("");
    }

    /*******************
     *
     * Expressions
     *
     * ******************/

    function compileExpression(expression) {
        switch (expression.type) {
        case "AssignmentExpression":
            return compileAssignmentExpression(expression);
        case "FunctionExpression":
            return compileFunction(expression);
        case "Identifier":
            return compileIdentifier(expression);
        case "Literal":
            return compileLiteral(expression);
        case "UnaryExpression":
            return compileUnaryExpression(expression);
        case "BinaryExpression":
            return compileBinaryExpression(expression);
        case "LogicalExpression":
            return compileLogicalExpression(expression);
        case "MemberExpression":
            return compileMemberExpression(expression);
        case "CallExpression":
            return compileCallExpression(expression);
        case "NewExpression":
            return compileNewExpression(expression);
        case "ThisExpression":
            return compileThisExpression(expression);
        case "ObjectExpression":
            return compileObjectExpression(expression);
        case "UpdateExpression":
            return compileUpdateExpression(expression);
        case "ArrayExpression":
            return compileArrayExpression(expression);
        case "ConditionalExpression":
            return compileConditionalExpression(expression);
        case "SequenceExpression":
            return compileSequenceExpression(expression);
        default:
            throw new Error("Unknown Expression type: " + expression.type);
        }
    }

    function compileExpressionStatement(expression) {
        if (options.evalMode) {
            return compileExpressionStatementEvalMode(expression);
        } else {
            return compileExpressionStatementNoEval(expression);
        }
    }

    // Add a semi-colon at the end of ExpressionStatements
    function compileExpressionStatementEvalMode(expression) {
        switch (expression.type) {
        case "UpdateExpression":
        case "Literal":
        case "Identifier":
        case "ThisExpression":
        case "BinaryExpression":
        case "LogicalExpression":
        case "ConditionalExpression":
        case "MemberExpression":
        case "AssignmentExpression":
        case "CallExpression":
        case "UnaryExpression":
        case "NewExpression":
        case "ArrayExpression":
        case "SequenceExpression":
            // Enclose the statement in a _e to be evaluated
            var compiledExpressionStatement = ["_e("];
            compiledExpressionStatement.push(compileExpression(expression));
            compiledExpressionStatement.push(");");
            return compiledExpressionStatement.join("");
        default:
            // FunctionExpression, ObjectExpression
            throw new Error("Impossible expression type:" + expression.type);
        }
    }

    // Add a semi-colon at the end of ExpressionStatements
    function compileExpressionStatementNoEval(expression) {
        switch (expression.type) {
        case "Literal":
        case "Identifier":
        case "ThisExpression":
            return;
        case "UpdateExpression":
            return compileUpdateExpressionNoEval(expression) + ";";
        case "AssignmentExpression":
            return compileAssignmentExpressionNoEval(expression) + ";";
        case "BinaryExpression":
        case "LogicalExpression":
        case "ConditionalExpression":
        case "MemberExpression":
            // Enclose the statement in a _e to be evaluated
            var compiledExpressionStatement = ["_e("];
            compiledExpressionStatement.push(compileExpression(expression));
            compiledExpressionStatement.push(");");
            return compiledExpressionStatement.join("");
        case "UnaryExpression":
            // ! operator conversion is not enclosed in a function
            // so we enclose it in _e
            if (expression.operator === "!") {
                var compiledUnaryExpressionStatement = ["_e("];
                compiledUnaryExpressionStatement.push(compileUnaryExpression(expression));
                compiledUnaryExpressionStatement.push(");");
                return compiledUnaryExpressionStatement.join("");
            }
            return compileUnaryExpression(expression) + ";";
        case "CallExpression":
        case "NewExpression":
        case "ArrayExpression":
        case "SequenceExpression":
            return compileExpression(expression) + ";";
        default:
            // FunctionExpression, ObjectExpression
            throw new Error("Impossible expression type:" + expression.type);
        }
    }

    function compileAssignmentExpressionNoEval(expression) {
        var compiledAssignmentExpression = [];

        var left = compileExpression(expression.left);

        compiledAssignmentExpression.push(left);
        compiledAssignmentExpression.push(" = ");

        switch (expression.operator) {
        case "=":
            var right = compileExpression(expression.right);
            compiledAssignmentExpression.push(right);
            break;
        default:
            // Build a binary expression node to compile
            var binaryExpression = [];
            binaryExpression.type = "BinaryExpression";
            binaryExpression.operator = extractBinaryOperator(expression.operator);
            binaryExpression.left = expression.left;
            binaryExpression.right = expression.right;
            var compiledBinaryExpression = compileBinaryExpression(binaryExpression);
            compiledAssignmentExpression.push(compiledBinaryExpression);
        }

        return compiledAssignmentExpression.join('');
    }

    function compileAssignmentExpression(expression) {
        var compiledAssignmentExpression = ["(function () local _tmp = "];

        var left = compileExpression(expression.left);

        switch (expression.operator) {
        case "=":
            var right = compileExpression(expression.right);

            compiledAssignmentExpression.push(right);
            compiledAssignmentExpression.push("; ");
            compiledAssignmentExpression.push(left);
            compiledAssignmentExpression.push("  = _tmp; return _tmp; end)()");
            break;
        default:
            // Build a binary expression node to compile
            var binaryExpression = [];
            binaryExpression.type = "BinaryExpression";
            binaryExpression.operator = extractBinaryOperator(expression.operator);
            binaryExpression.left = expression.left;
            binaryExpression.right = expression.right;
            var compiledBinaryExpression = compileBinaryExpression(binaryExpression);

            compiledAssignmentExpression.push(compiledBinaryExpression);
            compiledAssignmentExpression.push("; ");
            compiledAssignmentExpression.push(left);
            compiledAssignmentExpression.push("  = _tmp; return _tmp; end)()");
        }

        return compiledAssignmentExpression.join('');
    }

    function extractBinaryOperator(rawOperator) {
        return rawOperator.substring(0, rawOperator.indexOf('='));
    }

    function compileUpdateExpressionNoEval(expression) {
        var compiledUpdateExpression = [];
        var compiledArgument = compileExpression(expression.argument);

        compiledUpdateExpression.push(compiledArgument);
        compiledUpdateExpression.push(" = ");

        switch (expression.operator) {
        case "++":
            compiledUpdateExpression.push("_add(");
            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push(", 1)");
            break;
        case "--":
            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push(" - 1");
            break;
        default:
            throw new Error("Unknown UpdateOperator: " + expression.operator);
        }

        return compiledUpdateExpression.join('');
    }

    function compileUpdateExpression(expression) {
        var compiledUpdateExpression = ["(function () local _tmp = "];
        var compiledArgument = compileExpression(expression.argument);

        if (expression.prefix) {
            // Prefix
            switch (expression.operator) {
            case "++":
                compiledUpdateExpression.push("_add(");
                compiledUpdateExpression.push(compiledArgument);
                compiledUpdateExpression.push(", 1); ");

                break;
            case "--":
                compiledUpdateExpression.push(compiledArgument);
                compiledUpdateExpression.push(" - 1; ");
                break;
            default:
                throw new Error("Unknown UpdateOperator: " + expression.operator);
            }
            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push(" = _tmp");
        } else {
            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push("; ");
            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push(" = ");

            // Postfix
            switch (expression.operator) {
            case "++":
                compiledUpdateExpression.push("_add(_tmp, 1)");
                break;
            case "--":
                compiledUpdateExpression.push("_tmp - 1");
                break;
            default:
                throw new Error("Unknown UpdateOperator: " + expression.operator);
            }
        }

        compiledUpdateExpression.push("; return _tmp; end)()");

        return compiledUpdateExpression.join('');
    }

    // Replace the character in str at the given index by char
    function replaceAt(str, index, char) {
        return str.substr(0, index) + char + str.substr(index + 1);
    }

    function lastTopLevelBracketedGroupStartIndex(str) {
        var startIndex = 0,
            count = 0,
            i;
        for (i = 0; i < str.length; ++i) {
            if (str[i] === '[') {
                if (count === 0) {
                    startIndex = i;
                }
                count++;
            } else if (str[i] === ']') {
                count--;
            }
        }

        return startIndex;
    }

    function compileCallArguments(args) {
        var compiledArguments = [];

        var i;
        for (i = 0; i < args.length; ++i) {
            compiledArguments.push(compileExpression(args[i]));
        }

        return compiledArguments.join(',');
    }

    function compileCallExpression(expression) {
        var compiledCallExpression = [];
        var compiledCallee = compileExpression(expression.callee);
        var compiledArguments = compileCallArguments(expression.arguments);

        // If callee is method of an object
        if (expression.callee.type === "MemberExpression") {
            // If end by a bracket
            if (compiledCallee.match(/\]$/)) {
                var startIndex = lastTopLevelBracketedGroupStartIndex(compiledCallee);
                var base = compiledCallee.substr(0, startIndex);
                var member = compiledCallee.substr(startIndex + 1);

                compiledCallExpression.push("(function() local _this = ");
                compiledCallExpression.push(base);
                compiledCallExpression.push("; local _f = _this[");
                compiledCallExpression.push(member);
                compiledCallExpression.push("; return _f(_this");

                if (compiledArguments !== "") {
                    compiledCallExpression.push("," + compiledArguments);
                }

                compiledCallExpression.push("); end)()");
            } else {
                // Replace last occurence of '.' by ':'
                var lastPointIndex = compiledCallee.lastIndexOf('.');
                compiledCallee = replaceAt(compiledCallee, lastPointIndex, ':');
                compiledCallExpression.push(compiledCallee);
                compiledCallExpression.push("(");
                compiledCallExpression.push(compiledArguments);
                compiledCallExpression.push(")");
            }
        } else {
            compiledCallExpression.push(compiledCallee);
            compiledCallExpression.push("(_ENV");
            if (compiledArguments) {
                compiledCallExpression.push("," + compiledArguments);
            }
            compiledCallExpression.push(")");
        }

        return compiledCallExpression.join('');
    }

    function compileLogicalExpression(expression) {
        var compiledLogicalExpression = ["("];

        var left = compileExpression(expression.left);
        var right = compileExpression(expression.right);

        switch (expression.operator) {
        case "&&":
            // (function() if boolean(a) then return b else return a end end)()
            compiledLogicalExpression.push("(function() if _bool(");
            compiledLogicalExpression.push(left);
            compiledLogicalExpression.push(") then return ");
            compiledLogicalExpression.push(right);
            compiledLogicalExpression.push(";  else return ");
            compiledLogicalExpression.push(left);
            compiledLogicalExpression.push(";  end end)()");
            break;
        case "||":
            // boolean(a) and a or b
            compiledLogicalExpression.push("_bool(");
            compiledLogicalExpression.push(left);
            compiledLogicalExpression.push(") and ");
            compiledLogicalExpression.push(left);
            compiledLogicalExpression.push(" or ");
            compiledLogicalExpression.push(right);

            break;
        default:
            throw new Error("Unknown LogicalOperator: " + expression.operator);
        }

        compiledLogicalExpression.push(")");

        return compiledLogicalExpression.join('');
    }

    function getBaseMember(expession) {
        var startIndex = 0;
        if (expession.match(/\]$/)) {
            startIndex = lastTopLevelBracketedGroupStartIndex(expession);
            return {
                base: expession.slice(0, startIndex),
                member: expession.slice(startIndex + 1, -1)
            };
        } else {
            startIndex = expession.lastIndexOf('.');
            return {
                base: expession.slice(0, startIndex),
                member: '"' + expession.slice(startIndex + 1) + '"'
            };
        }
    }

    function getGetterSetterExpression(expression) {
        var split = getBaseMember(expression);
        return {
            getter: split.base + '["_g" .. ' + split.member + ']',
            setter: split.base + '["_s" .. ' + split.member + ']'
        };
    }

    function compileUnaryExpression(expression) {
        var compiledUnaryExpression = [];
        var compiledExpression = compileExpression(expression.argument);

        if (expression.prefix) {
            // "-" | "+" | "!" | "~" | "typeof" | "void" | "delete"

            switch (expression.operator) {
                // convert to number and negate it
            case "-":
                compiledUnaryExpression.push("-_tonum(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                break;
                // convert to number
            case "+":
                compiledUnaryExpression.push("_tonum(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                break;
                // Negate
            case "!":
                compiledUnaryExpression.push("not _bool(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                break;
                // Bit not
            case "~":
                compiledUnaryExpression.push("_bnot(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                break;
            case "typeof":
                compiledUnaryExpression.push("_type(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                break;
            case "delete":
                var scope = "_ENV.";
                compiledUnaryExpression.push("(function () local _r = false; ");

                // Delete getter/setter
                if (expression.argument.type === "MemberExpression") {
                    scope = "";
                    var gs = getGetterSetterExpression(compiledExpression);

                    compiledUnaryExpression.push("local _g, _s = ");
                    compiledUnaryExpression.push(gs.getter);
                    compiledUnaryExpression.push(", ");
                    compiledUnaryExpression.push(gs.setter);
                    compiledUnaryExpression.push("; ");
                    compiledUnaryExpression.push(gs.getter);
                    compiledUnaryExpression.push(", ");
                    compiledUnaryExpression.push(gs.setter);
                    compiledUnaryExpression.push(" = nil, nil; _r = _g ~= nil or _s ~= nil;\n");
                }

                // Delete value
                compiledUnaryExpression.push("local _v = ");
                compiledUnaryExpression.push(scope + compiledExpression);
                compiledUnaryExpression.push("; ");
                compiledUnaryExpression.push(scope + compiledExpression);
                compiledUnaryExpression.push(" = nil; return _r or _v ~= nil; end)()");
                break;
            case "void":
                compiledUnaryExpression.push("_void(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                break;
            default:
                throw new Error("Unknown UnaryOperator: " + expression.operator);
            }
        } else {
            throw new Error("UnaryExpression: postfix ?!");
        }

        return compiledUnaryExpression.join('');
    }

    function compileBinaryExpression(expression) {
        var compiledBinaryExpression = ["("];
        var left = compileExpression(expression.left);
        var right = compileExpression(expression.right);

        switch (expression.operator) {
            // Equality
        case "==":
            compiledBinaryExpression.push("_eq(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            break;
        case "!=":
            compiledBinaryExpression.push("not _eq(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            break;
        case "===":
            pushSimpleBinaryExpression(compiledBinaryExpression, " == ", left, right);
            break;
        case "!==":
            pushSimpleBinaryExpression(compiledBinaryExpression, " ~= ", left, right);
            break;
            // Comparison
        case "<":
            pushSimpleBinaryExpression(compiledBinaryExpression, " < ", left, right);
            break;
        case "<=":
            pushSimpleBinaryExpression(compiledBinaryExpression, " <= ", left, right);
            break;
        case ">":
            pushSimpleBinaryExpression(compiledBinaryExpression, " > ", left, right);
            break;
        case ">=":
            pushSimpleBinaryExpression(compiledBinaryExpression, " >= ", left, right);
            break;
            // Bits shift
        case "<<":
            compiledBinaryExpression.push("_lshift(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            break;
        case ">>":
            compiledBinaryExpression.push("_arshift(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            break;
        case ">>>":
            compiledBinaryExpression.push("_rshift(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            break;
            // Arithmetic
        case "+":
            compiledBinaryExpression.push("_add(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            break;
        case "-":
            pushSimpleBinaryExpression(compiledBinaryExpression, " - ", left, right);
            break;
        case "*":
            pushSimpleBinaryExpression(compiledBinaryExpression, " * ", left, right);
            break;
        case "/":
            pushSimpleBinaryExpression(compiledBinaryExpression, " / ", left, right);
            break;
        case "%":
            pushSimpleBinaryExpression(compiledBinaryExpression, " % ", left, right);
            break;
            // Bitwise operators
        case "|":
            compiledBinaryExpression.push("_bor(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            break;
        case "^":
            compiledBinaryExpression.push("_bxor(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            break;
        case "&":
            compiledBinaryExpression.push("_band(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            break;
            // Other
        case "in":
            compiledBinaryExpression.push("_in(");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(")");
            break;
        case "instanceof":
            compiledBinaryExpression.push("_instanceof(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            break;
        case "..":
            // E4X operator
            // doesn't worth to be implemented for now
            break;
        default:
            throw new Error("Unknown BinaryOperator: " + expression.operator);
        }

        compiledBinaryExpression.push(")");

        return compiledBinaryExpression.join('');
    }

    function pushSimpleBinaryExpression(compiledBinaryExpression, operator, left, right) {
        compiledBinaryExpression.push(left);
        compiledBinaryExpression.push(operator);
        compiledBinaryExpression.push(right);
    }

    // TernaryOperator: boxing/unboxing solution
    // http://lua-users.org/wiki/TernaryOperator
    function compileConditionalExpression(expression) {
        var compiledConditionalExpression = ["(function() if _bool("];

        // (function() if boolean(a) then return b else return c end end)()
        compiledConditionalExpression.push(compileExpression(expression.test));
        compiledConditionalExpression.push(") then return ");
        compiledConditionalExpression.push(compileExpression(expression.consequent));
        compiledConditionalExpression.push("; else return ");
        compiledConditionalExpression.push(compileExpression(expression.alternate));
        compiledConditionalExpression.push("; end end)()");

        return compiledConditionalExpression.join("");
    }

    function compileSequenceExpression(expression) {
        var compiledSequenceExpression = ["_seq({"];

        var i, expressions = expression.expressions,
            sequence = [];
        for (i = 0; i < expressions.length; ++i) {
            sequence.push(compileExpression(expressions[i]));
        }

        compiledSequenceExpression.push(sequence.join(","));
        compiledSequenceExpression.push("})");

        return compiledSequenceExpression.join("");
    }

    function compileObjectExpression(expression) {
        var compiledObjectExpression = ["_obj({\n"];

        var i, length = expression.properties.length;
        var property;
        var compiledProperty = [],
            compiledProperties = [];
        var compiledKey = "";

        for (i = 0; i < length; ++i) {
            compiledProperty = ["["];
            property = expression.properties[i];

            if (property.key.type === "Literal") {
                compiledKey = compileLiteral(property.key);
            } else if (property.key.type === "Identifier") {
                compiledKey = '"';
                // compile the identifier as a string literal
                compiledKey += sanitizeLiteralString(property.key.name);
                compiledKey += '"';
            } else {
                throw new Error("Unexpected property key type: " + property.key.type);
            }

            if (property.kind === "get") {
                // TODO: related to weak typing
                if (typeof (property.key.value) === "number") {
                    compiledKey = '"' + compiledKey + '"';
                }
                compiledKey = compiledKey.replace(/^"/, '"_g');
            } else if (property.kind === "set") {
                // TODO: related to weak typing
                if (typeof (property.key.value) === "number") {
                    compiledKey = '"' + compiledKey + '"';
                }
                compiledKey = compiledKey.replace(/^"/, '"_s');
            }

            compiledProperty.push(compiledKey);
            compiledProperty.push("] = ");
            compiledProperty.push(compileExpression(property.value));

            compiledProperties.push(compiledProperty.join(""));
        }

        compiledObjectExpression.push(compiledProperties.join(",\n"));
        compiledObjectExpression.push("\n})");

        return compiledObjectExpression.join("");
    }

    function compileMemberExpression(expression) {
        var compiledMemberExpression = [];
        var compiledObject = compileExpression(expression.object);

        if (expression.object.type === "Literal") {
            compiledObject = "(" + compiledObject + ")";
        }
        compiledMemberExpression.push(compiledObject);

        if (expression.computed) {
            compiledMemberExpression.push("[");
            compiledMemberExpression.push(compileExpression(expression.property));
            compiledMemberExpression.push("]");
        } else {
            var compiledProperty = compileIdentifier(expression.property);

            if (compiledProperty !== expression.property.name) {
                compiledMemberExpression.push("[\"");
                compiledMemberExpression.push(sanitizeLiteralString(expression.property.name));
                compiledMemberExpression.push("\"]");
            } else {
                compiledMemberExpression.push(".");
                compiledMemberExpression.push(compiledProperty);
            }
        }

        return compiledMemberExpression.join("");
    }

    function compileNewExpression(expression) {
        var compiledNewExpression = ["_new("];

        var newArguments = [compileExpression(expression.callee)];
        var i, length = expression.arguments.length;
        for (i = 0; i < length; ++i) {
            newArguments.push(compileExpression(expression.arguments[i]));
        }

        compiledNewExpression.push(newArguments.join(","));
        compiledNewExpression.push(")");

        return compiledNewExpression.join("");
    }

    function compileThisExpression() {
        return "this";
    }

    function compileArrayExpression(expression) {
        var compiledArrayExpression = ["_arr({"];

        var compiledElements = [];
        var i, length = expression.elements.length;

        if (length > 0) {
            compiledArrayExpression.push("[0]=");
        }

        for (i = 0; i < length; ++i) {
            if (expression.elements[i] !== null) {
                compiledElements.push(compileExpression(expression.elements[i]));
            } else {
                compiledElements.push("nil");
            }
        }
        compiledArrayExpression.push(compiledElements.join(","));
        compiledArrayExpression.push("},");
        compiledArrayExpression.push(length);
        compiledArrayExpression.push(")");

        return compiledArrayExpression.join("");
    }

    /*******************
     *
     * Declarations
     *
     * ******************/

    function compileFunctionDeclaration(declaration) {
        var compiledFunctionDeclaration = [];
        var compiledId = compileIdentifier(declaration.id);

        compiledFunctionDeclaration.push(compiledId);
        compiledFunctionDeclaration.push(" = ");
        compiledFunctionDeclaration.push(compileFunction(declaration));

        localVarManager.pushLocal(compiledId);
        localVarManager.pushFunction(compiledFunctionDeclaration.join(""));
    }

    function compileVariableDeclaration(variableDeclaration) {
        var compiledDeclarations = [];

        switch (variableDeclaration.kind) {
            // TODO:
            // for now we simply ignore constness
        case "const":
        case "var":

            var declarations = variableDeclaration.declarations;
            var i, declarator, pattern, expression, compiledDeclarationInit;

            for (i = 0; i < declarations.length; ++i) {
                declarator = declarations[i];
                pattern = compilePattern(declarator.id);

                // Add to current local context
                localVarManager.pushLocal(pattern);

                if (declarator.init !== null) {
                    expression = compileExpression(declarator.init);
                    compiledDeclarationInit = [];
                    compiledDeclarationInit.push(pattern);
                    compiledDeclarationInit.push(" = ");
                    compiledDeclarationInit.push(expression);
                    compiledDeclarationInit.push(";");

                    compiledDeclarations.push(compiledDeclarationInit.join(''));
                }
            }

            break;
        case "let":
            // TODO
            throw new Error("let instruction is not supported yet");
        }

        return compiledDeclarations.join("\n");
    }

    /********************
     *
     * Patterns
     *
     * ******************/

    function compilePattern(pattern) {
        switch (pattern.type) {
        case "Identifier":
            return compileIdentifier(pattern);
        default:
            throw new Error("Unknwown Pattern type" + pattern.type);
        }
    }

    /********************
     *
     * Functions
     *
     * ******************/

    function compileFunction(fun) {

        var compiledFunction = ["(function ("];
        var compiledBody = "";

        // New context
        localVarManager.createLocalContext();

        // Compile body of the function
        if (fun.body.type === "BlockStatement") {
            compiledBody = compileStatement(fun.body);
        } else if (fun.body.type === "Expression") {
            compiledBody = compileExpression(fun.body);
        }

        // Get context information
        var context = localVarManager.popLocalContext();
        var useArguments = context[1];

        var params = fun.params;
        var i;
        if (useArguments) {
            compiledFunction.push("...)\n");

            var compiledLocalParams = ["this"];

            for (i = 0; i < params.length; ++i) {
                compiledLocalParams.push(compilePattern(params[i]));
            }

            compiledFunction.push("local " + compiledLocalParams.join(", ") + " = ...;\n");

            compiledFunction.push("local arguments = _args(...);\n");
        } else {
            var compiledParams = ["this"];

            for (i = 0; i < params.length; ++i) {
                compiledParams.push(compilePattern(params[i]));
            }
            compiledFunction.push(compiledParams.join(", "));
            compiledFunction.push(")\n");
        }

        // Locals
        var locals = context[0];
        if (locals.length > 0) {
            var compiledLocalsDeclaration = buildLocalsDeclarationString(locals);
            compiledFunction.push(compiledLocalsDeclaration);
        }

        // Function declarations
        var functions = context[2];
        if (functions.length > 0) {
            var compiledFunctionsDeclaration = [];

            for (i = 0; i < functions.length; ++i) {
                compiledFunctionsDeclaration.push(functions[i]);
            }

            compiledFunction.push(compiledFunctionsDeclaration.join("\n"));
        }

        // Append body and close function
        compiledFunction.push(compiledBody);
        compiledFunction.push("\n");
        compiledFunction.push("end)");

        return compiledFunction.join('');
    }

    function buildLocalsDeclarationString(locals) {
        var compiledLocalsDeclaration = ["local "];
        var namesSequence = [];

        var i, local, length = locals.length;
        for (i = 0; i < length; ++i) {
            local = locals.pop();
            namesSequence.push(local);
        }

        compiledLocalsDeclaration.push(namesSequence.join(","));
        compiledLocalsDeclaration.push(";\n");

        return compiledLocalsDeclaration.join("");
    }

    /*************************
     *
     * Identifier and Literal
     *
     * ***********************/

    function sanitizeIdentifier(id) {
        // Reserved lua keywords are guarded
        if (luaKeywords.indexOf(id) > -1) {
            return '_g_' + id;
        }

        return id
            .replace(/_/g, '__') // (one consequence: CASTL can internally safely use identifiers begining by exactly one undescore) 
            .replace(/\$/g, 'S') // variable name can contain a $ in JS, not in Lua
            .replace(/[\u0080-\uFFFF]/g, function (c) { // Latin-1 Supplement is allowed in JS var names, not yet in Lua
                return '_' + c.charCodeAt(0);
            });
    }

    function compileIdentifier(identifier) {
        if (identifier.name === "arguments") {
            localVarManager.useArguments();
        }
        return sanitizeIdentifier(identifier.name);
    }

    // http://en.wikipedia.org/wiki/UTF-8#Description
    // http://stackoverflow.com/a/18729931/1120148
    function toUTF8Array(str) {
        var utf8 = [];
        var i, charcode;
        for (i = 0; i < str.length; ++i) {
            charcode = str.charCodeAt(i);
            if (charcode < 0x80) {
                utf8.push(charcode);
            } else if (charcode < 0x800) {
                utf8.push(0xc0 | (charcode >> 6),
                    0x80 | (charcode & 0x3f));
            } else if (charcode < 0xd800 || charcode >= 0xe000) {
                utf8.push(0xe0 | (charcode >> 12),
                    0x80 | ((charcode >> 6) & 0x3f),
                    0x80 | (charcode & 0x3f));
            } else { // surrogate pair
                i++;
                // UTF-16 encodes 0x10000-0x10FFFF by
                // subtracting 0x10000 and splitting the
                // 20 bits of 0x0-0xFFFFF into two halves
                charcode = 0x10000 + (((charcode & 0x3ff) << 10) | (str.charCodeAt(i) & 0x3ff));
                utf8.push(0xf0 | (charcode >> 18),
                    0x80 | ((charcode >> 12) & 0x3f),
                    0x80 | ((charcode >> 6) & 0x3f),
                    0x80 | (charcode & 0x3f));
            }
        }
        return utf8;
    }

    function sanitizeLiteralString(str) {
        return str.replace(/\\/g, '\\\\') // escape backslash
            .replace(/"/g, '\\"') // escape double quotes
            .replace(/[\0-\u001f\u007F-\uD7FF\uDC00-\uFFFF]|[\uD800-\uDBFF][\uDC00-\uDFFF]|[\uD800-\uDBFF]/g, // unicode handling
                function (str) {
                    var ut8bytes = toUTF8Array(str);
                    ut8bytes = ut8bytes.map(function (e) {
                        return "\\" + ("00" + e).slice(-3);
                    });
                    return ut8bytes.join("");
                });
    }

    function sanitizeRegExpSource(str) {
        return str.replace(/\\/g, '\\\\') // escape backslash
            .replace(/"/g, '\\"') // escape double quotes
            .replace(/\\\\u([0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f])/g, // convert "\uXXXX" string to character, then handle it
                function (str, hexaCode) {
                    var chars = String.fromCharCode(parseInt(hexaCode, 16));
                    return "\\" + toUTF8Array(chars).join("\\");
                });
    }

    function compileLiteral(literal) {
        var ret = literal.raw;

        if (literal.value instanceof RegExp) {
            var regexp = literal.value;
            var compiledRegExp = ["_regexp(\""];

            var source = sanitizeRegExpSource(regexp.source);
            compiledRegExp.push(source);
            compiledRegExp.push("\",\"");

            var flags = "";
            flags += regexp.global ? "g" : "";
            flags += regexp.ignoreCase ? "i" : "";
            flags += regexp.multiline ? "m" : "";
            compiledRegExp.push(flags);
            compiledRegExp.push("\")");

            ret = compiledRegExp.join("");
        }
        if (typeof (literal.value) === "string") {
            ret = '"' + sanitizeLiteralString(literal.value) + '"';
        }
        if (typeof (literal.value) === "number") {
            // JSON.stringify write numbers in base 10
            // (Lua doesn't handle octal notation)
            ret = JSON.stringify(literal.value);
        }

        return ret;
    }

    /********************
     *
     * Exports
     *
     * ******************/

    exports.compileAST = compileAST;

}));
