#!/bin/bash

# Set environment varialbe
export LUA_PATH=$LUA_PATH";lua/?.lua;"

success=0;
total=0;

rm test/*.lua 2>/dev/null 1>/dev/null

# Test all .js files
for f in test/*.js; do 
    ((total++));
    echo "********************************************";
    echo $f;

    
    # Execution of js script
    echo -n "Execute test $f... ";
    nodejs $f 2>/dev/null 1>/dev/null;
    
    if (($? > 0)); then
        echo "--> Execution of js code failed!";
        failed=("${failed[@]}" "${f:0:(${#f}-3)} - Code: 1");
        continue;
    else
        echo "*OK";
    fi
    
    # Compile js script to lua
    echo -n "Compile test $f... ";
    nodejs "compileTest.js" $f;
    
    if (($? > 0)); then
        echo "--> Compilation of js code failed!";
        failed=("${failed[@]}" "${f:0:(${#f}-3)} - Code: 2");
        continue;
    else
        echo "*OK";
    fi
    
    # Execute lua code compiled
    luaScript="${f:0:(${#f}-2)}lua";
    echo -n "Execute test $luaScript... ";
    lua $luaScript;
    
    if (($? > 0)); then
        echo "--> Execution of lua code failed!";
        failed=("${failed[@]}" "${f:0:(${#f}-3)} - Code: 3");
        continue;
    else
        echo "*OK";
    fi
    
    echo "--> Everything Is AWESOME!!!";
    ((success++));
done

echo "----------------------------------------------";
echo "Report:";
echo "Passed: $success / $total";

if (($success != $total)); then
    echo "Failed:";
    for name in "${failed[@]}"; do
        echo "-$name";
    done
fi
