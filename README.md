CAST(L): compile JavaScript to Lua
==========
CASTL (Compile Abstract Syntax Tree to Lua) is a free and open source project that allows you to "compile" some JavaScript code to Lua 5.2 code and run it.

In order to do so you'll need a JavaScript parser able to produce an AST (Abstract Syntax Tree) compliant with the SpiderMonkey AST structure. You can use Esprima or Acorn for instance (if you install CASTL via npm Esprima and Acorn are automatically downloaded as dependencies but feel free to use any other parser).

## Installation

In a terminal:

    git clone https://github.com/PaulBernier/castl
    cd castl
    npm install
    sudo npm link
    
And then you may want to try:

    castl -e code.js
    npm test

#### Dependencies

If the JS script you want to compile uses regular expressions you'll have to install [Lrexlib](http://rrthomas.github.io/lrexlib/) with the PCRE flavor. CASTL uses this library to deal with RegExps.

## Example:

*Compile code in "file.js" (using Esprima to parse), print and execute the compiled code:*

    $ castl -e <file.js>
    
*Compile code in "file.js", does not print anything but save the compiled code to "output.lua"*

    $ castl -qo <file.js>

**The options of the command line are:**

* *filename*: name of the file to compile.
* -q: quiet, does not print the compiled code.
* -o: output the plain text Lua code in a file named output.lua.
* -c: if -o option is active the outputted code is Lua bytecode (luac).
* -e: execute the Lua code compiled.
* -h, --help: display help.
* --acorn: use Acorn parser. If not specified Esprima is used.
* --tolerant: make Esprima and Acorn error-tolerant.
* --jit: use LuaJIT instead of Lua interpreter to execute compiled code.
* --node: add a very basic support of NodeJS 'require' system.

## CASTL components

CASTL is made of two parts:

* a JavaScript script (`castl.js`) which converts a SpiderMonkey AST to lua code
* a Lua runtime library (located in `lua/castl/`) which allows the execution of the code compiled by `castl.js`

There is also a useful bash script `bin/castl.sh` to easily compile and execute JS files.

## Not Supported yet

* Weak typing of JS when accessing attribute of an object (o[1] is different from o["1"])
* Getters/setters
* Eval() and Function constructor
* Error classes
* Property descriptor (enumerable/writable/configurable)
* Other little things...

## LuaJIT

If you want to use LuaJIT to execute code compiled with CASTL you can, but with some little drawbacks. 

First of all you'll have to compile LuaJIT with the -DLUAJIT\_ENABLE\_LUA52COMPAT option [http://luajit.org/extensions.html#lua52](http://luajit.org/extensions.html#lua52). Then you can use the `--jit` option of the castl command line:

     castl -qe --jit <file.js>

Note that by using LuaJIT instead of Lua 5.2 VM you'll unfortunately lose:

* regular expressions since [Lrexlib](http://rrthomas.github.io/lrexlib/) does not support LuaJIT for now
* _with_ statement (not a big loss normally...)
* eval() global function and Function() constructor

## Q&A

### What could it be useful for?!

CASTL lets you execute JS scripts on Lua 5.2 VM. Lua VM is known to be fast and lightweight, and especially it is often used in embedded systems. Thus it could allow you to execute your JS scripts on micro-controllers for example.

The probably best known example is [Tessel](https://tessel.io/) which sells a board that "runs JavaScript". In fact they do the same as CASTL, the JS code is converted to Lua and then executed in a specific environment. They call it Colony.

Note that CASTL will always be slower than a native Lua script, so take time to learn Lua :).

### So what's the differences between CASTL and Tessel Colony?

I have definitively been inspired on many points by Colony. Nonetheless there is some important points of divergence: 

* CASTL is aimed to run on a native Lua 5.2 (unmodified VM) whereas Colony rely on a fork of Lua 5.1.
* CASTL may run to a certain extent on LuaJIT.
* CASTL support eval() function and Function() constructor :) (yes, it uses a Lua version of CASTL and Esprima...)
* `castl.js` is not bound to any parser whereas Colony is bound to an old modified version of Acorn.
* `castl.js` is NodeJS independent, it can be executed in Node as well as in a web browser.
* Colony has a good support of NodeJS (objects, libraries...) whereas it's almost nonexistent in CASTL.
* License is different (CASTL is under LGPLv3 and Colony is under MIT/Apache).

### I'd prefer a version of CASTL written in Lua

Easy, just compile CASTL by itself (and also Esprima for the parsing)! By the way you can find a version already compiled in folder `lua/castl/jscompile/` which is used for the eval() function.

## Info

Developed and maintained by [Paul Bernier](http://www.paulbernier.fr).

Released under the LGPLv3 license.
