#!/bin/bash

# Set environment varialbe
export LUA_PATH=$LUA_PATH";lua/?.lua;"

parser=esprima
luajit=false;
success=0;
total=0;

rm test/*.lua 2>/dev/null 1>/dev/null

function testFile {
    f=$1
    
    ((total++));
    testString="$total. $f: "
    echo -n $testString;
    
    # Execution of js script
    nodejs $f;
    
    if (($? > 0)); then
        echo "--> Execution of js code failed!";
        failed=("${failed[@]}" "${f:0:(${#f}-3)} - Code: 1");
        continue;
    fi
    
    # Compile js script to lua
    nodejs "compileTest.js" $f $luajit $parser;
    
    if (($? > 0)); then
        echo "--> Compilation of js code failed!";
        failed=("${failed[@]}" "${f:0:(${#f}-3)} - Code: 2");
        continue;
    fi
    
    # Execute lua code compiled
    luaScript="${f:0:(${#f}-2)}lua";
    if [ "$luajit" = true ]; then
        luajit $luaScript;
    else
        lua5.2 $luaScript;
    fi
    
    
    if (($? > 0)); then
        echo "--> Execution of lua code failed!";
        failed=("${failed[@]}" "${f:0:(${#f}-3)} - Code: 3");
        continue;
    fi
    
    offset=$((60 - ${#testString}))
    printf "%-"$offset"s %s\n" "" "--> Everything Is AWESOME!!!";
    ((success++));
}

files=()
# handle arguments
if [ "$#" -ne 0 ]; then
    for arg in "$@"; do
        if [[ $arg == --* ]] ; then
            if [ $arg = "--jit" ]; then
                luajit=true
            elif [ $arg = "--acorn" ]; then
                parser="acorn"
            fi
        else
            files+=("$arg")
        fi
    done
fi

# if some files were specified test them
if [ "${#files[@]}" -ne 0 ]; then
    for f in "${files[@]}"; do
        testFile $f
    done
else
    # Else test all .js files
    for f in test/*.js; do 
        testFile $f
    done
fi

echo "----------------------------------------------";
if [ "$luajit" = true ]; then
    echo "Report (LuaJIT):"
else
    echo "Report (Lua 5.2):"
fi
echo "Passed: $success / $total";

if (($success != $total)); then
    echo "Failed: ${#failed[@]} ";
    for name in "${failed[@]}"; do
        echo "-$name";
    done
fi
