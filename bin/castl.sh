#!/bin/bash

#    Copyright (c) 2014, Paul Bernier
#
#    CASTL is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#    CASTL is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#    You should have received a copy of the GNU Lesser General Public License
#    along with CASTL. If not, see <http://www.gnu.org/licenses/>.

# Set environment variable
export LUA_PATH=$LUA_PATH";/usr/local/lib/node_modules/castl/lua/?.lua;"

# Options
verbose=false
execute=true
output=false
compiled=false
tolerant=true
node=false
heuristic=false
eval=false
debug=false
annotation=false
mini=false
linenumers=false
luajit=false
outputname="output.lua"
parser="esprima"
filename="code.js"

function help {
    echo "Usage: ./castl.sh [options] filename.js";
    echo "Options:"
    printf "\t%-15s %s\n" "-v" "verbose, print code to be run"
    printf "\t%-15s %s\n" "-o" "output the plain text Lua code in a file. Specify the name of the file after this option, otherwise the file will be named output.lua"
    printf "\t%-15s %s\n" "-c" "if -o option is active the outputted code is Lua/LuaJIT bytecode"
    printf "\t%-15s %s\n" "-n" "print line numbers if -v or --cat options are active"
    printf "\t%-15s %s\n" "-h, --help" "display this help"
    printf "\t%-15s %s\n" "--cat" "don't execute, just print code that would be run"
    printf "\t%-15s %s\n" "--jit" "compile for LuaJIT (and execute with LuaJIT instead of Lua 5.2 interpreter if -e option is active)"
    printf "\t%-15s %s\n" "--heuristic" "enable heuristic compilation"
    printf "\t%-15s %s\n" "--annotation" "use annotations to optimize generated code"
    printf "\t%-15s %s\n" "--mini" "minify AST using Esprima before compiling. Size of outputted file is shrunk"
    printf "\t%-15s %s\n" "--debug" "add comments in the Lua code referring to the line number of the original statement in the JS file"
    printf "\t%-15s %s\n" "--acorn" "use Acorn parser. If not specified Esprima is used"
    printf "\t%-15s %s\n" "--strict" "make Esprima and Acorn not error-tolerant"
    printf "\t%-15s %s\n" "--node" "add a very basic support of NodeJS 'require' system"
    exit 0
}

waitname=false
for arg in "$@"; do

    if [[ $arg == --* ]] ; then
        waitname=false
        if [ $arg = "--acorn" ]; then
            parser="acorn"
        elif [ $arg = "--strict" ]; then
            tolerant=false
        elif [ $arg = "--node" ]; then
            node=true
        elif [ $arg = "--jit" ]; then
            luajit=true
        elif [ $arg = "--debug" ]; then
            debug=true
        elif [ $arg = "--eval" ]; then
            eval=true
        elif [ $arg = "--mini" ]; then
            mini=true
        elif [ $arg = "--heuristic" ]; then
            heuristic=true
        elif [ $arg = "--annotation" ]; then
            annotation=true
        elif [ $arg = "--cat" ]; then
            execute=false
            verbose=true
        elif [ $arg = "--help" ]; then
            help
        else
            help
        fi
    elif [[ $arg == -* ]] ; then
        waitname=false
        for i in `seq 1 ${#arg}` ; do
            c="${arg:$i:1}"
            
            if [ "$c" = "h" ]; then
                help
            elif [ "$c" = "o" ]; then
                output=true
                execute=false
                waitname=true
                continue;
            elif [ "$c" = "v" ]; then
                verbose=true
            elif [ "$c" = "n" ]; then
                linenumers=true
            elif [ "$c" = "c" ]; then
                compiled=true
            elif [ "$c" != "" ]; then
                help
            fi
        done
    else
        if [ "$waitname" = true ]; then
            outputname=$arg
        else
            filename=$arg
        fi
        waitname=false
    fi
done

castl-compiler $filename $parser $node $luajit $tolerant $debug $eval $mini $annotation $heuristic > ".tmp.lua"
compileStatus=$?

# compilation failed
if (($compileStatus > 0)); then
    rm ".tmp.lua"
    exit $compileStatus;
fi

if [ "$verbose" = true ]; then
    if [ "$luajit" = true ]; then
        echo "-- Lua code (LuaJIT):"
    else
        echo "-- Lua code (Lua 5.2):"
    fi
    
    echo "--------------------------------------------------------------------"
    if [ "$linenumers" = true ]; then   
        cat -n ".tmp.lua"
    else
        cat ".tmp.lua"
    fi
    echo ""
    echo "--------------------------------------------------------------------"
fi

if [ "$output" = true ]; then    
    if [ "$compiled" = true ]; then
        if [ "$luajit" = true ]; then
            luajit -b ".tmp.lua" $outputname
        else
            luac -o $outputname ".tmp.lua"
        fi
    else
        cp ".tmp.lua" $outputname
    fi
fi

if [ "$execute" = true ]; then
    if [ "$luajit" = true ]; then
        if [ "$verbose" = true ]; then
            echo "-- Execution output (LuaJIT):"
        fi
        luajit ".tmp.lua";
    else
        if [ "$verbose" = true ]; then
            echo "-- Execution output (Lua 5.2):"
        fi
        lua5.2 ".tmp.lua";
    fi
    execStatus=$?
fi
rm ".tmp.lua"
echo ""

exit $execStatus;
