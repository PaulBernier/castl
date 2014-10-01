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
    var withTracker = [];

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
            // @number
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
            // @number
            if (this.locals.length > 0) {
                return [this.locals.pop(), this.args.pop(), this.functions.pop()];
            }

            throw new Error("LocalVarManager error: no current local context");
        },

        createLocalContext: function () {
            this.locals.push([]);
            this.functions.push([]);
            this.args.push(false);
        },

        pushLocal: function (varName) {
            // @number
            if (this.locals.length > 0) {
                this.locals[this.locals.length - 1].push(varName);
            } else {
                throw new Error("LocalVarManager error: no current local context");
            }
        },

        pushFunction: function (functionDeclaration) {
            // @number
            if (this.functions.length > 0) {
                this.functions[this.functions.length - 1].push(functionDeclaration);
            } else {
                throw new Error("LocalVarManager error: no current local context");
            }
        },

        useArguments: function () {
            // @number
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

    var options, annotations;

    function compileAST(ast, opts, anno) {
        options = opts || {};
        annotations = anno || {};

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
            // @number
            if (locals.length > 0) {
                var compiledLocalsDeclaration = buildLocalsDeclarationString(locals);
                compiledProgram.push(compiledLocalsDeclaration);
            }

            // Function declarations
            var functions = context[2];
            // @number
            if (functions.length > 0) {
                var compiledFunctionsDeclaration = [];
                var i;
                // @number
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
            // @string
            throw new Error("Unknown Statement type: " + statement.type);
        }

        if (compiledStatement !== undefined) {
            if (options.debug) {
                var line = statement.loc.start.line;
                // @string
                return "--[[" + line + "--]] " + compiledStatement;
            }
            return compiledStatement;
        }
    }

    function compileListOfStatements(statementList) {
        var compiledStatements = [];

        var i, compiledStatement;
        // @number
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

    function compileBooleanExpression(expression) {
        var compiledBooleanExpression = [];
        var meta = {};
        var compiledExpression = compileExpression(expression, meta);

        if (meta.type === "boolean") {
            compiledBooleanExpression.push(compiledExpression);
        } else {
            compiledBooleanExpression.push("_bool(");
            compiledBooleanExpression.push(compiledExpression);
            compiledBooleanExpression.push(")");
        }

        return compiledBooleanExpression.join("");
    }

    function compileIfStatement(statement, elif) {
        var compiledIfStatement = [];

        if (elif) {
            compiledIfStatement.push("elseif ");
        } else {
            compiledIfStatement.push("if ");
        }

        compiledIfStatement.push(compileBooleanExpression(statement.test));
        compiledIfStatement.push(" then\n");

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
            // @string
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

        compiledForStatement.push("while ");

        // Test
        if (statement.test !== null) {
            compiledForStatement.push(compileBooleanExpression(statement.test));
        } else {
            compiledForStatement.push("true");
        }

        compiledForStatement.push(" do\n");

        // Body
        compiledForStatement.push(compileStatement(statement.body));
        compiledForStatement.push("\n");

        // Label for continue
        if (continueNoLabelTracker[continueNoLabelTracker.length - 1]) {
            compiledForStatement.push("::_continue::\n");
        }

        // Label for continue with label
        if (compiledLabel && labelTracker[compiledLabel].mayContinue) {
            // @string
            compiledForStatement.push("::" + compiledLabel + "_c::\n");
        }

        // Update
        compiledForStatement.push(compileForUpdate(statement.update));

        compiledForStatement.push("end\n");

        return compiledForStatement.join("");
    }

    function compileForInStatement(statement, compiledLabel) {
        var compiledForInStatement = [];
        var compiledLeft;

        compiledForInStatement.push("local _p = _props(");
        compiledForInStatement.push(compileExpression(statement.right));
        compiledForInStatement.push(", true);\n");

        if (statement.left.type === "VariableDeclaration") {
            compiledLeft = compilePattern(statement.left.declarations[0].id);
            // Add to current local context
            localVarManager.pushLocal(compiledLeft);
        } else {
            compiledLeft = compileExpression(statement.left);
        }

        compiledForInStatement.push("for _,");
        compiledForInStatement.push(compiledLeft);
        compiledForInStatement.push(" in _ipairs(_p) do\n");

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
            // @string
            compiledForInStatement.push("::" + compiledLabel + "_c::\n");
        }

        compiledForInStatement.push("end\n");

        return compiledForInStatement.join("");
    }

    function compileWhileStatement(statement, compiledLabel) {
        var compiledWhileStatement = ["while "];

        // Test
        compiledWhileStatement.push(compileBooleanExpression(statement.test));
        compiledWhileStatement.push(" do\n");

        // Body
        compiledWhileStatement.push(compileStatement(statement.body));
        compiledWhileStatement.push("\n");

        // Label for continue
        compiledWhileStatement.push("::_continue::\n");

        // Label for continue with label
        if (compiledLabel && labelTracker[compiledLabel].mayContinue) {
            // @string
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
            // @string
            compiledDoWhileStatement.push("::" + compiledLabel + "_c::\n");
        }

        // Test
        compiledDoWhileStatement.push("until not ");
        compiledDoWhileStatement.push(compileBooleanExpression(statement.test));
        compiledDoWhileStatement.push("\n");

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
            // @string
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
            if (options.jit) {
                return "do break end;";
            } else {
                return "break;";
            }
        }

        var compiledLabel = compileIdentifier(statement.label);
        labelTracker[compiledLabel].mayBreak = true;
        // @string
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
        // @string
        return "goto " + compiledLabel + "_c;";
    }

    function compileSwitchStatement(statement) {
        protectedCallManager.openSwitchStatement();

        var cases = statement.cases;

        // @number
        if (cases.length > 0) {
            // Use a useless repeat loop to be able to use break
            var compiledSwitchStatement = ["repeat\nlocal _into = false;\n"];
            var compiledDiscriminant = compileExpression(statement.discriminant);

            // Construct lookup table
            var i;
            var casesTable = [];
            var caseTablementElement;
            var compiledTests = [];
            // @number
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
            // @number
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
        // @number
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
            // @string
            return " do return " + compileExpression(statement.argument) + "; end";
        }

        return "do return end";
    }

    function compileWithStatement(statement) {
        withTracker.push(true);
        var compiledWithStatement = ["do\n"];

        // with
        compiledWithStatement.push("local _oldENV = _ENV;\n");
        compiledWithStatement.push("local _ENV = _with(");
        compiledWithStatement.push(compileExpression(statement.object));
        compiledWithStatement.push(", _ENV);\n");

        if (options.jit) {
            compiledWithStatement.push("_wenv(function(...)\n");
        }

        // body
        compiledWithStatement.push(compileStatement(statement.body));

        if (options.jit) {
            compiledWithStatement.push("\nend, _ENV)()");
        }

        compiledWithStatement.push("\nend");

        withTracker.pop();
        return compiledWithStatement.join("");
    }

    /*******************
     *
     * Expressions
     *
     * ******************/

    function compileExpression(expression, meta) {
        switch (expression.type) {
        case "AssignmentExpression":
            return compileAssignmentExpression(expression, meta);
        case "FunctionExpression":
            return compileFunction(expression, meta);
        case "Identifier":
            return compileIdentifier(expression, meta);
        case "Literal":
            return compileLiteral(expression, meta);
        case "UnaryExpression":
            return compileUnaryExpression(expression, meta);
        case "BinaryExpression":
            return compileBinaryExpression(expression, meta);
        case "LogicalExpression":
            return compileLogicalExpression(expression, meta);
        case "MemberExpression":
            return compileMemberExpression(expression, meta);
        case "CallExpression":
            return compileCallExpression(expression, meta);
        case "NewExpression":
            return compileNewExpression(expression, meta);
        case "ThisExpression":
            return compileThisExpression(expression, meta);
        case "ObjectExpression":
            return compileObjectExpression(expression, meta);
        case "UpdateExpression":
            return compileUpdateExpression(expression, meta);
        case "ArrayExpression":
            return compileArrayExpression(expression, meta);
        case "ConditionalExpression":
            return compileConditionalExpression(expression, meta);
        case "SequenceExpression":
            return compileSequenceExpression(expression, meta);
        default:
            // @string
            throw new Error("Unknown Expression type: " + expression.type);
        }
    }

    function compileExpressionStatement(expression, meta) {
        if (options.evalMode) {
            return compileExpressionStatementEvalMode(expression, meta);
        } else {
            return compileExpressionStatementNoEval(expression, meta);
        }
    }

    // Add a semi-colon at the end of ExpressionStatements
    function compileExpressionStatementEvalMode(expression, meta) {
        // Enclose the statement in a _e to be evaluated
        var compiledExpressionStatement = ["_e("];
        compiledExpressionStatement.push(compileExpression(expression, meta));
        compiledExpressionStatement.push(");");
        return compiledExpressionStatement.join("");
    }

    // Add a semi-colon at the end of ExpressionStatements
    function compileExpressionStatementNoEval(expression, meta) {
        switch (expression.type) {
        case "Literal":
        case "Identifier":
        case "ThisExpression":
            return;
        case "UpdateExpression":
            // @string
            return compileUpdateExpressionNoEval(expression, meta) + ";";
        case "AssignmentExpression":
            // @string
            return compileAssignmentExpressionNoEval(expression, meta) + ";";
        case "BinaryExpression":
        case "LogicalExpression":
        case "ConditionalExpression":
        case "MemberExpression":
        case "FunctionExpression":
            // Enclose the statement in a _e to be evaluated
            var compiledExpressionStatement = ["_e("];
            compiledExpressionStatement.push(compileExpression(expression, meta));
            compiledExpressionStatement.push(");");
            return compiledExpressionStatement.join("");
        case "UnaryExpression":
            // ! operator conversion is not enclosed in a function
            // so we enclose it in _e
            if (expression.operator === "!") {
                var compiledUnaryExpressionStatement = ["_e("];
                compiledUnaryExpressionStatement.push(compileUnaryExpression(expression, meta));
                compiledUnaryExpressionStatement.push(");");
                return compiledUnaryExpressionStatement.join("");
            }
            // @string
            return compileUnaryExpression(expression, meta) + ";";
        case "CallExpression":
        case "NewExpression":
        case "ArrayExpression":
        case "ObjectExpression":
        case "SequenceExpression":
            // @string
            return compileExpression(expression, meta) + ";";
        default:
            // @string
            throw new Error("Impossible expression type:" + expression.type);
        }
    }

    function compileCompoundAssignmentBinaryExpression(left, right, operator, metaLeft, metaRight, meta) {
        var compiledCompoundAssignmentBinaryExpression = ["("];

        switch (operator) {
            // Bits shift
        case "<<=":
            compiledCompoundAssignmentBinaryExpression.push("_lshift(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case ">>=":
            compiledCompoundAssignmentBinaryExpression.push("_arshift(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case ">>>=":
            compiledCompoundAssignmentBinaryExpression.push("_rshift(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
            // Arithmetic
        case "+=":
            compiledCompoundAssignmentBinaryExpression.push(compileAdditionOperator(left, right, metaLeft, metaRight, meta));
            break;
        case "-=":
            pushSimpleBinaryExpression(compiledCompoundAssignmentBinaryExpression, " - ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "*=":
            pushSimpleBinaryExpression(compiledCompoundAssignmentBinaryExpression, " * ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "/=":
            pushSimpleBinaryExpression(compiledCompoundAssignmentBinaryExpression, " / ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "%=":
            compiledCompoundAssignmentBinaryExpression.push("_mod(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
            // Bitwise operators
        case "|=":
            compiledCompoundAssignmentBinaryExpression.push("_bor(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case "^=":
            compiledCompoundAssignmentBinaryExpression.push("_bxor(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case "&=":
            compiledCompoundAssignmentBinaryExpression.push("_band(");
            compiledCompoundAssignmentBinaryExpression.push(left);
            compiledCompoundAssignmentBinaryExpression.push(",");
            compiledCompoundAssignmentBinaryExpression.push(right);
            compiledCompoundAssignmentBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        default:
            // @string
            throw new Error("Unknown BinaryOperator: " + operator);
        }

        compiledCompoundAssignmentBinaryExpression.push(")");

        return compiledCompoundAssignmentBinaryExpression.join('');
    }

    function storeComputedProperty(expression) {
        var hasComputedProperty = expression.type === "MemberExpression" && expression.computed;

        if (hasComputedProperty) {
            if (expression.property.type === "Literal") {
                return false;
            }
        } else {
            return false;
        }
        return true;
    }

    function compileCompoundAssignmentNoEval(expression) {
        var compiledAssignmentBinaryExpression = [];
        var mustStore = storeComputedProperty(expression.left);
        var metaLeft = {},
            metaRight = {};

        var left = compileExpression(expression.left, metaLeft);
        var right = compileExpression(expression.right, metaRight);

        if (mustStore) {
            var split = getBaseMember(left);
            // @string
            left = split.base + "[_cp]";

            // store computed property to evalute it only once
            compiledAssignmentBinaryExpression.push("do local _cp = ");
            compiledAssignmentBinaryExpression.push(split.member);
            compiledAssignmentBinaryExpression.push("; ");
        }

        compiledAssignmentBinaryExpression.push(left);
        compiledAssignmentBinaryExpression.push(" = ");
        compiledAssignmentBinaryExpression.push(compileCompoundAssignmentBinaryExpression(left, right, expression.operator, metaLeft, metaRight));

        if (mustStore) {
            compiledAssignmentBinaryExpression.push(" end");
        }

        return compiledAssignmentBinaryExpression.join("");
    }

    function compileAssignmentExpressionNoEval(expression) {
        var compiledAssignmentExpression = [];

        switch (expression.operator) {
            // Regular assignement
        case "=":
            var left = compileExpression(expression.left);
            var right = compileExpression(expression.right);
            compiledAssignmentExpression.push(left);
            compiledAssignmentExpression.push(" = ");
            compiledAssignmentExpression.push(right);
            break;
        default:
            // Compound assignments
            return compileCompoundAssignmentNoEval(expression);
        }

        return compiledAssignmentExpression.join('');
    }

    function compileAssignmentExpression(expression, meta) {
        var compiledAssignmentExpression = ["(function () "];
        var mustStore = storeComputedProperty(expression.left);
        var metaLeft = {},
            metaRight = {};
        var left = compileExpression(expression.left, metaLeft);
        var right = compileExpression(expression.right, metaRight);

        if (mustStore) {
            var split = getBaseMember(left);
            // store computed property to evalute it only once
            compiledAssignmentExpression.push("local _cp = ");
            compiledAssignmentExpression.push(split.member);
            compiledAssignmentExpression.push(";");

            // @string
            left = split.base + "[_cp]";
        }

        compiledAssignmentExpression.push(left);
        compiledAssignmentExpression.push(" = ");

        switch (expression.operator) {
            // regular assignment
        case "=":
            compiledAssignmentExpression.push(right);
            if (meta) {
                meta.type = metaRight.type;
            }
            break;
        default:
            // Compound assignments
            compiledAssignmentExpression.push(compileCompoundAssignmentBinaryExpression(left, right, expression.operator, metaLeft, metaRight, meta));
        }

        compiledAssignmentExpression.push("; return ");
        compiledAssignmentExpression.push(left);
        compiledAssignmentExpression.push(" end)()");

        return compiledAssignmentExpression.join('');
    }

    function compileUpdateExpressionNoEval(expression) {
        var compiledUpdateExpression = [];
        var metaArgument = {};
        var compiledArgument = compileExpression(expression.argument, metaArgument);

        compiledUpdateExpression.push(compiledArgument);
        compiledUpdateExpression.push(" = ");

        switch (expression.operator) {
        case "++":
            if (metaArgument.type === "number") {
                compiledUpdateExpression.push(compiledArgument);
                compiledUpdateExpression.push(" + 1");
            } else {
                compiledUpdateExpression.push("_inc(");
                compiledUpdateExpression.push(compiledArgument);
                compiledUpdateExpression.push(")");
            }
            break;
        case "--":
            if (metaArgument.type === "number") {
                compiledUpdateExpression.push(compiledArgument);
                compiledUpdateExpression.push(" - 1");
            } else {
                compiledUpdateExpression.push("_dec(");
                compiledUpdateExpression.push(compiledArgument);
                compiledUpdateExpression.push(")");
            }
            break;
        default:
            // @string
            throw new Error("Unknown UpdateOperator: " + expression.operator);
        }

        return compiledUpdateExpression.join('');
    }

    function compileUpdateExpression(expression, meta) {
        var compiledUpdateExpression = ["(function () local _tmp = "];
        var metaArgument = {};
        var compiledArgument = compileExpression(expression.argument, metaArgument);

        if (expression.prefix) {
            // Prefix
            switch (expression.operator) {
            case "++":
                if (metaArgument.type === "number") {
                    compiledUpdateExpression.push(compiledArgument);
                    compiledUpdateExpression.push(" + 1; ");
                } else {
                    compiledUpdateExpression.push("_inc(");
                    compiledUpdateExpression.push(compiledArgument);
                    compiledUpdateExpression.push("); ");
                }
                break;
            case "--":
                if (metaArgument.type === "number") {
                    compiledUpdateExpression.push(compiledArgument);
                    compiledUpdateExpression.push(" - 1; ");
                } else {
                    compiledUpdateExpression.push("_dec(");
                    compiledUpdateExpression.push(compiledArgument);
                    compiledUpdateExpression.push("); ");
                }
                break;
            default:
                // @string
                throw new Error("Unknown UpdateOperator: " + expression.operator);
            }

            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push(" = _tmp");
        } else {
            // Postfix
            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push("; ");
            compiledUpdateExpression.push(compiledArgument);
            compiledUpdateExpression.push(" = ");

            switch (expression.operator) {
            case "++":
                if (metaArgument.type === "number") {
                    compiledUpdateExpression.push("_tmp + 1");
                } else {
                    compiledUpdateExpression.push("_inc(_tmp)");
                }
                break;
            case "--":
                if (metaArgument.type === "number") {
                    compiledUpdateExpression.push("_tmp - 1");
                } else {
                    compiledUpdateExpression.push("_dec(_tmp)");
                }
                break;
            default:
                // @string
                throw new Error("Unknown UpdateOperator: " + expression.operator);
            }
        }

        compiledUpdateExpression.push("; return _tmp; end)()");

        // UpdateExpression always returns a number
        if (meta) {
            meta.type = "number";
        }

        return compiledUpdateExpression.join('');
    }

    // Replace the character in str at the given index by char
    function replaceAt(str, index, char) {
        // @string
        return str.substr(0, index) + char + str.substr(
            // @number
            index + 1);
    }

    function lastTopLevelBracketedGroupStartIndex(str) {
        var startIndex = 0,
            count = 0,
            i;
        // @number
        for (i = 0; i < str.length; ++i) {
            if (str[i] === '[') {
                if (count === 0) {
                    startIndex = i;
                }
                // @number
                count++;
            } else if (str[i] === ']') {
                // @number
                count--;
            }
        }

        return startIndex;
    }

    function compileCallArguments(args) {
        var compiledArguments = [];

        var i;
        // @number
        for (i = 0; i < args.length; ++i) {
            compiledArguments.push(compileExpression(args[i]));
        }

        return compiledArguments.join(',');
    }

    function compileCallExpression(expression, meta) {
        var compiledCallExpression = [];
        var compiledCallee = compileExpression(expression.callee);
        var compiledArguments = compileCallArguments(expression.arguments);

        // If callee is method of an object
        if (expression.callee.type === "MemberExpression") {
            // If end by a bracket
            if (compiledCallee.match(/\]$/)) {
                var startIndex = lastTopLevelBracketedGroupStartIndex(compiledCallee);
                var base = compiledCallee.substr(0, startIndex);
                // @number
                var member = compiledCallee.substr(startIndex + 1);

                compiledCallExpression.push("(function() local _this = ");
                compiledCallExpression.push(base);
                compiledCallExpression.push("; local _f = _this[");
                compiledCallExpression.push(member);
                compiledCallExpression.push("; return _f(_this");

                if (compiledArguments !== "") {
                    compiledCallExpression.push(",");
                    compiledCallExpression.push(compiledArguments);
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
            if (withTracker.length === 0) {
                compiledCallExpression.push("(_ENV");
            } else {
                compiledCallExpression.push("(_oldENV");
            }

            if (compiledArguments) {
                compiledCallExpression.push(",");
                compiledCallExpression.push(compiledArguments);
            }
            compiledCallExpression.push(")");
        }

        if (options.annotation) {
            // if there is an annotation the line before
            if (annotations[expression.loc.start.line - 1] && meta) {
                meta.type = annotations[expression.loc.start.line - 1];
            }
        }

        return compiledCallExpression.join('');
    }

    function compileLogicalExpression(expression, meta) {
        var compiledLogicalExpression = ["("];

        var leftCondition = compileBooleanExpression(expression.left);
        var metaLeft = {},
            metaRight = {};
        var left = compileExpression(expression.left, metaLeft),
            right = compileExpression(expression.right, metaRight);

        switch (expression.operator) {
        case "&&":
            // (function() if boolean(a) then return b else return a end end)()
            compiledLogicalExpression.push("(function() if ");
            compiledLogicalExpression.push(leftCondition);
            compiledLogicalExpression.push(" then return ");
            compiledLogicalExpression.push(right);
            compiledLogicalExpression.push(";  else return ");
            compiledLogicalExpression.push(left);
            compiledLogicalExpression.push(";  end end)()");
            break;
        case "||":
            // boolean(a) and a or b
            compiledLogicalExpression.push(leftCondition);
            compiledLogicalExpression.push(" and ");
            compiledLogicalExpression.push(left);
            compiledLogicalExpression.push(" or ");
            compiledLogicalExpression.push(right);

            break;
        default:
            // @string
            throw new Error("Unknown LogicalOperator: " + expression.operator);
        }

        compiledLogicalExpression.push(")");

        if (meta) {
            // if left and right are same type then return type is known
            if (metaLeft.type === metaRight.type && metaLeft.type !== undefined) {
                meta.type = metaLeft.type;
            }
        }

        return compiledLogicalExpression.join('');
    }

    function getBaseMember(compiledExpression) {
        var startIndex = 0;
        if (compiledExpression.match(/\]$/)) {
            startIndex = lastTopLevelBracketedGroupStartIndex(compiledExpression);
            return {
                base: compiledExpression.slice(0, startIndex),
                // @number
                member: compiledExpression.slice(startIndex + 1, -1)
            };
        } else {
            startIndex = compiledExpression.lastIndexOf('.');
            return {
                base: compiledExpression.slice(0, startIndex),
                // @string
                member: '"' + compiledExpression.slice(
                    // @number
                    startIndex + 1
                ) + '"'
            };
        }
    }

    function getGetterSetterExpression(compiledExpression) {
        var split = getBaseMember(compiledExpression);
        return {
            // @string
            getter: split.base + '["_g" .. ' + split.member + ']',
            // @string
            setter: split.base + '["_s" .. ' + split.member + ']'
        };
    }

    function compileUnaryExpression(expression, meta) {
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
                if (meta) {
                    meta.type = "number";
                }
                break;
                // convert to number
            case "+":
                compiledUnaryExpression.push("_tonum(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                if (meta) {
                    meta.type = "number";
                }
                break;
                // Negate
            case "!":
                compiledUnaryExpression.push("not ");
                compiledUnaryExpression.push(compileBooleanExpression(expression.argument));
                if (meta) {
                    meta.type = "boolean";
                }
                break;
                // Bit not
            case "~":
                compiledUnaryExpression.push("_bnot(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                if (meta) {
                    meta.type = "number";
                }
                break;
            case "typeof":
                compiledUnaryExpression.push("_type(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                if (meta) {
                    meta.type = "string";
                }
                break;
            case "delete":
                var scope;
                if (withTracker.length === 0) {
                    scope = "_ENV.";
                } else {
                    scope = "_oldENV.";
                }
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
                // @string
                compiledUnaryExpression.push(scope + compiledExpression);
                compiledUnaryExpression.push("; ");
                // @string
                compiledUnaryExpression.push(scope + compiledExpression);
                compiledUnaryExpression.push(" = nil; return _r or _v ~= nil; end)()");

                if (meta) {
                    meta.type = "boolean";
                }
                break;
            case "void":
                compiledUnaryExpression.push("_void(");
                compiledUnaryExpression.push(compiledExpression);
                compiledUnaryExpression.push(")");
                if (meta) {
                    meta.type = "undefined";
                }
                break;
            default:
                // @string
                throw new Error("Unknown UnaryOperator: " + expression.operator);
            }
        } else {
            throw new Error("UnaryExpression: postfix ?!");
        }

        return compiledUnaryExpression.join('');
    }

    function compileAdditionOperator(left, right, metaLeft, metaRight, meta) {
        var compiledAdditionOperator = [];

        if (metaLeft.type === "number" && metaRight.type === "number") {
            compiledAdditionOperator.push(left);
            compiledAdditionOperator.push(" + ");
            compiledAdditionOperator.push(right);
            if (meta) {
                meta.type = "number";
            }
        } else if (metaLeft.type === "string") {
            if (metaRight.type === "number" || metaRight.type === "string") {
                compiledAdditionOperator.push(left);
                compiledAdditionOperator.push(" .. ");
                compiledAdditionOperator.push(right);
            } else {
                compiledAdditionOperator.push("_addStr1(");
                compiledAdditionOperator.push(left);
                compiledAdditionOperator.push(",");
                compiledAdditionOperator.push(right);
                compiledAdditionOperator.push(")");
            }
            if (meta) {
                meta.type = "string";
            }
        } else if (metaRight.type === "string") {
            if (metaLeft.type === "number" || metaLeft.type === "string") {
                compiledAdditionOperator.push(left);
                compiledAdditionOperator.push(" .. ");
                compiledAdditionOperator.push(right);
            } else {
                compiledAdditionOperator.push("_addStr2(");
                compiledAdditionOperator.push(left);
                compiledAdditionOperator.push(",");
                compiledAdditionOperator.push(right);
                compiledAdditionOperator.push(")");
            }
            if (meta) {
                meta.type = "string";
            }
        } else if (metaLeft.type === "number") {
            compiledAdditionOperator.push("_addNum1(");
            compiledAdditionOperator.push(left);
            compiledAdditionOperator.push(",");
            compiledAdditionOperator.push(right);
            compiledAdditionOperator.push(")");
        } else if (metaRight.type === "number") {
            compiledAdditionOperator.push("_addNum2(");
            compiledAdditionOperator.push(left);
            compiledAdditionOperator.push(",");
            compiledAdditionOperator.push(right);
            compiledAdditionOperator.push(")");
        } else {
            // Default case
            compiledAdditionOperator.push("_add(");
            compiledAdditionOperator.push(left);
            compiledAdditionOperator.push(",");
            compiledAdditionOperator.push(right);
            compiledAdditionOperator.push(")");
        }

        return compiledAdditionOperator.join("");
    }

    function compileComparisonOperator(left, right, operator, metaLeft, metaRight, meta) {
        var compiledComparisonOperator = [];

        // Raw comparison
        if ((metaLeft.type === "string" && metaRight.type === "string") || (metaLeft.type === "number" && metaRight.type === "number")) {
            compiledComparisonOperator.push(left);
            compiledComparisonOperator.push(operator);
            compiledComparisonOperator.push(right);
        } else {
            switch (operator) {
            case "<":
                compiledComparisonOperator.push("_lt(");
                break;
            case "<=":
                compiledComparisonOperator.push("_le(");
                break;
            case ">":
                compiledComparisonOperator.push("_gt(");
                break;
            case ">=":
                compiledComparisonOperator.push("_ge(");
                break;
            }
            compiledComparisonOperator.push(left);
            compiledComparisonOperator.push(",");
            compiledComparisonOperator.push(right);
            compiledComparisonOperator.push(")");
        }

        // Result of comparison is always a boolean
        if (meta) {
            meta.type = "boolean";
        }

        return compiledComparisonOperator.join("");
    }

    function compileBinaryExpression(expression, meta) {
        var compiledBinaryExpression = ["("];
        var metaLeft = {},
            metaRight = {};
        var left = compileExpression(expression.left, metaLeft),
            right = compileExpression(expression.right, metaRight);

        switch (expression.operator) {
            // Equality
        case "==":
            compiledBinaryExpression.push("_eq(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "boolean";
            }
            break;
        case "!=":
            compiledBinaryExpression.push("not _eq(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "boolean";
            }
            break;
        case "===":
            pushSimpleBinaryExpression(compiledBinaryExpression, " == ", left, right);
            if (meta) {
                meta.type = "boolean";
            }
            break;
        case "!==":
            pushSimpleBinaryExpression(compiledBinaryExpression, " ~= ", left, right);
            if (meta) {
                meta.type = "boolean";
            }
            break;
            // Comparison
        case "<":
        case "<=":
        case ">":
        case ">=":
            compiledBinaryExpression.push(compileComparisonOperator(left, right, expression.operator, metaLeft, metaRight, meta));
            break;
            // Bits shift
        case "<<":
            compiledBinaryExpression.push("_lshift(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case ">>":
            compiledBinaryExpression.push("_arshift(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case ">>>":
            compiledBinaryExpression.push("_rshift(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
            // Arithmetic
        case "+":
            compiledBinaryExpression.push(compileAdditionOperator(left, right, metaLeft, metaRight, meta));
            break;
        case "-":
            pushSimpleBinaryExpression(compiledBinaryExpression, " - ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "*":
            pushSimpleBinaryExpression(compiledBinaryExpression, " * ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "/":
            pushSimpleBinaryExpression(compiledBinaryExpression, " / ", left, right);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "%":
            compiledBinaryExpression.push("_mod(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
            // Bitwise operators
        case "|":
            compiledBinaryExpression.push("_bor(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case "^":
            compiledBinaryExpression.push("_bxor(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
        case "&":
            compiledBinaryExpression.push("_band(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "number";
            }
            break;
            // Other
        case "in":
            compiledBinaryExpression.push("_in(");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "boolean";
            }
            break;
        case "instanceof":
            compiledBinaryExpression.push("_instanceof(");
            compiledBinaryExpression.push(left);
            compiledBinaryExpression.push(",");
            compiledBinaryExpression.push(right);
            compiledBinaryExpression.push(")");
            if (meta) {
                meta.type = "boolean";
            }
            break;
        case "..":
            // E4X operator
            // doesn't worth to be implemented for now
            break;
        default:
            // @string
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
    function compileConditionalExpression(expression, meta) {
        var compiledConditionalExpression = ["(function() if "];
        var metaConsequent = {},
            metaAlternate = {};
        // (function() if boolean(a) then return b else return c end end)()
        compiledConditionalExpression.push(compileBooleanExpression(expression.test));
        compiledConditionalExpression.push(" then return ");
        compiledConditionalExpression.push(compileExpression(expression.consequent, metaConsequent));
        compiledConditionalExpression.push("; else return ");
        compiledConditionalExpression.push(compileExpression(expression.alternate, metaAlternate));
        compiledConditionalExpression.push("; end end)()");

        if (meta) {
            if (metaConsequent.type === metaAlternate.type && metaConsequent.type !== undefined) {
                meta.type = metaConsequent.type;
            }
        }

        return compiledConditionalExpression.join("");
    }

    function compileSequenceExpression(expression, meta) {
        var compiledSequenceExpression = ["_seq({"];

        var i, expressions = expression.expressions;
        var sequence = [];
        var metaLast = {};
        // @number
        for (i = 0; i < expressions.length; ++i) {
            sequence.push(compileExpression(expressions[i], metaLast));
        }

        compiledSequenceExpression.push(sequence.join(","));
        compiledSequenceExpression.push("})");

        // Type returned by sequence is the same as the type of the last expression in the sequence
        if (meta) {
            meta.type = metaLast.type;
        }

        return compiledSequenceExpression.join("");
    }

    function compileObjectExpression(expression, meta) {
        var compiledObjectExpression = ["_obj({"];

        var i, length = expression.properties.length;
        var property;
        var compiledProperty = [],
            compiledProperties = [];
        var compiledKey = "";

        // @number
        for (i = 0; i < length; ++i) {
            compiledProperty = ["["];
            property = expression.properties[i];

            if (property.key.type === "Literal") {
                compiledKey = compileLiteral(property.key);
            } else if (property.key.type === "Identifier") {
                compiledKey = '"';
                // compile the identifier as a string literal
                // @string
                compiledKey += sanitizeLiteralString(property.key.name);
                // @string
                compiledKey += '"';
            } else {
                // @string
                throw new Error("Unexpected property key type: " + property.key.type);
            }

            if (property.kind === "get") {
                // TODO: related to weak typing
                if (typeof (property.key.value) === "number") {
                    // @string
                    compiledKey = '"' + compiledKey + '"';
                }
                compiledKey = compiledKey.replace(/^"/, '"_g');
            } else if (property.kind === "set") {
                // TODO: related to weak typing
                if (typeof (property.key.value) === "number") {
                    // @string
                    compiledKey = '"' + compiledKey + '"';
                }
                compiledKey = compiledKey.replace(/^"/, '"_s');
            }

            compiledProperty.push(compiledKey);
            compiledProperty.push("] = ");
            compiledProperty.push(compileExpression(property.value));

            compiledProperties.push(compiledProperty.join(""));
        }

        // @number
        if (length > 0) {
            compiledObjectExpression.push("\n");
            compiledObjectExpression.push(compiledProperties.join(",\n"));
            compiledObjectExpression.push("\n");
        }
        compiledObjectExpression.push("})");

        if (meta) {
            meta.type = "object";
        }

        return compiledObjectExpression.join("");
    }

    function compileMemberExpression(expression, meta) {
        var compiledMemberExpression = [];
        var compiledObject = compileExpression(expression.object);

        if (expression.object.type === "Literal") {
            // @string
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

        if (options.annotation) {
            // if there is an annotation the line before
            if (annotations[expression.loc.start.line - 1] && meta) {
                meta.type = annotations[expression.loc.start.line - 1];
            }
        }

        return compiledMemberExpression.join("");
    }

    function compileNewExpression(expression) {
        var compiledNewExpression = ["_new("];

        var newArguments = [compileExpression(expression.callee)];
        var i, length = expression.arguments.length;
        // @number
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

    function compileArrayExpression(expression, meta) {
        var compiledArrayExpression = ["_arr({"];

        var compiledElements = [];
        var i, length = expression.elements.length;

        // @number
        if (length > 0) {
            compiledArrayExpression.push("[0]=");
        }

        // @number
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

        if (meta) {
            meta.type = "object";
        }

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
        compiledFunctionDeclaration.push(";");

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

            // @number
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

    function compilePattern(pattern, meta) {
        switch (pattern.type) {
        case "Identifier":
            return compileIdentifier(pattern, meta);
        default:
            // @string
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

        // Params
        var i;
        var params = fun.params;
        var compiledParams = ["this"];
        // @number
        for (i = 0; i < params.length; ++i) {
            compiledParams.push(compilePattern(params[i]));
        }

        // Get context information
        var context = localVarManager.popLocalContext();
        var locals = context[0];
        // Do not create Argument object if one of the parameters is called 'arguments'
        var useArguments = context[1] && (compiledParams.indexOf("arguments") === -1);

        if (useArguments) {
            compiledFunction.push("...)\n");
            // @string
            compiledFunction.push("local " + compiledParams.join(", ") + " = ...;\n");
            compiledFunction.push("local arguments = _args(...);\n");

            compiledParams.push("arguments");
        } else {
            compiledFunction.push(compiledParams.join(", "));
            compiledFunction.push(")\n");
        }

        // Locals
        // @number
        if (locals.length > 0) {
            // local that has the same identifier as one of the arguments will not be redefined
            var compiledLocalsDeclaration = buildLocalsDeclarationString(locals, compiledParams);
            compiledFunction.push(compiledLocalsDeclaration);
        }

        // Function declarations
        var functions = context[2];
        // @number
        if (functions.length > 0) {
            var compiledFunctionsDeclaration = [];

            // @number
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

    function buildLocalsDeclarationString(locals, ignore) {
        ignore = ignore || [];
        var namesSequence = [];

        var i, local, length = locals.length;
        // @number
        for (i = 0; i < length; ++i) {
            local = locals.pop();
            if (ignore.indexOf(local) === -1) {
                namesSequence.push(local);
            }
        }

        // @number
        if (namesSequence.length > 0) {
            var compiledLocalsDeclaration = ["local "];
            compiledLocalsDeclaration.push(namesSequence.join(","));
            compiledLocalsDeclaration.push(";\n");

            return compiledLocalsDeclaration.join("");
        }
        return "";
    }

    /*************************
     *
     * Identifier and Literal
     *
     * ***********************/

    function sanitizeIdentifier(id) {
        // Reserved lua keywords are guarded
        // @number
        if (luaKeywords.indexOf(id) > -1) {
            // @string
            return '_g_' + id;
        }

        return id
            .replace(/_/g, '__') // (one consequence: CASTL can internally safely use identifiers begining by exactly one undescore) 
            .replace(/\$/g, 'S') // variable name can contain a $ in JS, not in Lua
            .replace(/[\u0080-\uFFFF]/g, function (c) { // Latin-1 Supplement is allowed in JS var names, not yet in Lua
                // @string
                return '_' + c.charCodeAt(0);
            });
    }

    function compileIdentifier(identifier, meta) {
        if (identifier.name === "arguments") {
            localVarManager.useArguments();
        }

        if (options.annotation) {
            // if there is an annotation the line before
            if (annotations[identifier.loc.start.line - 1] && meta) {
                meta.type = annotations[identifier.loc.start.line - 1];
            }
        }

        return sanitizeIdentifier(identifier.name);
    }

    // http://en.wikipedia.org/wiki/UTF-8#Description
    // http://stackoverflow.com/a/18729931/1120148
    function toUTF8Array(str) {
        var utf8 = [];
        var i, charcode;
        // @number
        for (i = 0; i < str.length; ++i) {
            charcode = str.charCodeAt(i);
            // @number
            if (charcode < 0x80) {
                utf8.push(charcode);
                // @number
            } else if (charcode < 0x800) {
                utf8.push(0xc0 | (charcode >> 6),
                    0x80 | (charcode & 0x3f));
                // @number
            } else if (charcode < 0xd800 || charcode >= 0xe000) {
                utf8.push(0xe0 | (charcode >> 12),
                    0x80 | ((charcode >> 6) & 0x3f),
                    0x80 | (charcode & 0x3f));
            } else { // surrogate pair
                // @number
                i++;
                // UTF-16 encodes 0x10000-0x10FFFF by
                // subtracting 0x10000 and splitting the
                // 20 bits of 0x0-0xFFFFF into two halves
                // @number
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
            .replace(/\u00A0/g, " ") // no-break space replaced by regular space
            .replace(/[\0-\u001f\u007F-\uD7FF\uDC00-\uFFFF]|[\uD800-\uDBFF][\uDC00-\uDFFF]|[\uD800-\uDBFF]/g, // unicode handling
                function (str) {
                    var ut8bytes = toUTF8Array(str);
                    ut8bytes = ut8bytes.map(function (e) {
                        // @string
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
                    // @string
                    return "\\" + toUTF8Array(chars).join("\\");
                });
    }

    function compileLiteral(literal, meta) {
        var ret = literal.raw;

        if (literal.value instanceof RegExp) {
            var regexp = literal.value;
            var compiledRegExp = ["_regexp(\""];

            var source = sanitizeRegExpSource(regexp.source);
            compiledRegExp.push(source);
            compiledRegExp.push("\",\"");

            var flags = "";
            // @string
            flags += regexp.global ? "g" : "";
            // @string
            flags += regexp.ignoreCase ? "i" : "";
            // @string
            flags += regexp.multiline ? "m" : "";
            compiledRegExp.push(flags);
            compiledRegExp.push("\")");

            ret = compiledRegExp.join("");

            if (meta) {
                meta.type = "object";
            }

            return ret;
        }

        switch (typeof (literal.value)) {
        case "string":
            // @string
            ret = '"' + sanitizeLiteralString(literal.value) + '"';
            if (meta) {
                meta.type = "string";
            }
            break;
        case "number":
            // JSON.stringify write numbers in base 10
            // (Lua doesn't handle octal notation)
            ret = JSON.stringify(literal.value);
            if (meta) {
                meta.type = "number";
            }
            break;
        case "boolean":
            if (meta) {
                meta.type = "boolean";
            }

            break;
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
