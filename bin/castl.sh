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

# Set environment varialbe
export LUA_PATH=$LUA_PATH";lua/?.lua;"

# Options
quiet=false
execute=false
output=false
compiled=false
tolerant=false
node=false
luajit=false
parser="esprima"
filename="code.js"

function help {
    echo "Usage: ./castl.sh [options] filename.js";
    echo "Options:"
    printf "\t%-15s %s\n" "-e" "execute the Lua code compiled"
    printf "\t%-15s %s\n" "-q" "quiet, does not print the compiled code"
    printf "\t%-15s %s\n" "-o" "output the plain text Lua code in a file named output.lua"
    printf "\t%-15s %s\n" "-c" "if -o option is active the outputted code is Lua bytecode (luac)"
    printf "\t%-15s %s\n" "-h, --help" "display this help"
    printf "\t%-15s %s\n" "--acorn" "use Acorn parser. If not specified Esprima is used"
    printf "\t%-15s %s\n" "--tolerant" "make Esprima and Acorn error-tolerant"
    printf "\t%-15s %s\n" "--jit" "use LuaJIT instead of Lua interpreter to execute compiled code"
    printf "\t%-15s %s\n" "--node" "add a very basic support of NodeJS 'require' system"
    exit 0
}

for arg in "$@"; do

    if [[ $arg == --* ]] ; then
        if [ $arg = "--acorn" ]; then
            parser="acorn"
        elif [ $arg = "--tolerant" ]; then
            tolerant=true
        elif [ $arg = "--node" ]; then
            node=true
        elif [ $arg = "--jit" ]; then
            luajit=true
        elif [ $arg = "--help" ]; then
            help
        else
            help
        fi
    elif [[ $arg == -* ]] ; then
        for i in `seq 1 ${#arg}` ; do
            c="${arg:$i:1}"
            
            if [ "$c" = "e" ]; then
                execute=true
            elif [ "$c" = "h" ]; then
                help
            elif [ "$c" = "o" ]; then
                output=true
            elif [ "$c" = "q" ]; then
                quiet=true
            elif [ "$c" = "c" ]; then
                compiled=true
            elif [ "$c" != "" ]; then
                help
            fi
        done
    else
        filename=$arg
    fi
done

code=$(nodejs compile.js $filename $parser $node $luajit $tolerant)

if [ "$quiet" = false ]; then
    echo "-- Lua code:"
    echo "--------------------------------------------------------------------"
    printf "%s" "$code"
    echo ""
    echo "--------------------------------------------------------------------"
fi

if [ "$output" = true ]; then    
    if [ "$compiled" = true ]; then
        printf "%s" "$code" > ".tmp.lua"
        luac -o "output.out" ".tmp.lua"
        rm ".tmp.lua"
    else
        printf "%s" "$code" > "output.lua"
    fi
fi

if [ "$execute" = true ]; then
    if [ "$luajit" = true ]; then
        echo "-- Execution output (LuaJIT):"
        luajit -e "$code";
    else
        echo "-- Execution output (Lua 5.2):"
        lua -e "$code";
    fi
fi
echo ""
