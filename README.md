CAST(L): compile JavaScript to Lua
==========
CASTL (Compile Abstract Syntax Tree to Lua) is a free and open source project that allows you to "compile" some JavaScript code to Lua 5.2 code and run it (works also with LuaJIT).

## Installation

In a terminal:

```
git clone https://github.com/PaulBernier/castl
cd castl
npm install
sudo npm link
```

CASTL has one dependency called [Lrexlib](http://rrthomas.github.io/lrexlib/) to handle regular expressions: you'll most likely need it, but if your JS code doesn't contain any regexp this dependency is not required.
The easy way to install this dependency is to use Luarocks package manager:

* if you want to execute on Lua 5.2:
```
sudo luarocks-5.2 install lrexlib-pcre
```
* if you want to execute on LuaJIT (see also LuaJIT entry of this README)
```
sudo luarocks-5.1 install lrexlib-pcre
```

Note that you'll need to have *libpcre* installed on your system (*lrexlib-pcre* is only a binding to the *libpcre* API).

And then you may want to test:
```
castl -e code.js
npm test
```

## Usage:

* Compile code in <file.js> (using Esprima to parse), print and execute the compiled code:
```
$ castl -e <file.js>
```

* Compile code in <file.js>, does not print anything but save the compiled code to "mycode.lua":
```
$ castl -q <file.js> -o "mycode.lua"
```

**The options of the command line are:**

Option  | Description
------------- | -------------
`<filename.js>`  | name of the file to compile.
-v  | verbose, print code to be run.
-o | output the plain text Lua code in a file. Specify the name of the file after this option, otherwise the file will be named _output.lua_.
-c | if -o option is active the outputted code is Lua bytecode (luac).
-h, --help | display help.
--cat | don't execute, just print code that would be run.
--acorn | use Acorn parser. If not specified Esprima is used.
--tolerant | make Esprima and Acorn error-tolerant.
--jit | compile for LuaJIT (and execute with LuaJIT instead of Lua 5.2 interpreter if -e option is active).
--node | add a very basic support of NodeJS 'require' system.

## CASTL components

CASTL is made of two parts:

* a JavaScript script (`castl.js`) which converts a SpiderMonkey AST to Lua code
* a Lua runtime library (located in `lua/castl/`) which allows the execution of the code compiled by `castl.js`

CASTL has one dependency, [Lrexlib](http://rrthomas.github.io/lrexlib/), which provides a binding of PCRE regular expression library API.

CASTL also needs a JavaScript parser able to produce an AST (Abstract Syntax Tree) compliant with the SpiderMonkey AST structure. You can use Esprima or Acorn for instance (if you installed CASTL as stated above Esprima and Acorn are automatically downloaded as dependencies, you don't need to do anything).

There is also a useful bash script `bin/castl.sh` to easily compile and execute JS files.

## Not Supported yet

* Weak typing of JS when accessing attribute of an object (o[1] is different from o["1"])
* Getters/setters
* Property descriptor (enumerable/writable/configurable)
* Other little things...

## LuaJIT

Good news, if you want to use CASTL with LuaJIT, you can!

The only point is that you'll have to compile LuaJIT with the -DLUAJIT\_ENABLE\_LUA52COMPAT option [http://luajit.org/extensions.html#lua52](http://luajit.org/extensions.html#lua52) (i.e. uncomment line 'XCFLAGS+= -DLUAJIT_ENABLE_LUA52COMPAT' in `src/Makefile`). Then you can use the `--jit` option of the castl command line:

```
castl -e --jit <file.js>
```

Note that by using LuaJIT instead of Lua 5.2 VM you'll unfortunately lose (for now):

* _with_ statement (not a big loss normally...)

## Q&A

### What could it be useful for?!

CASTL lets you execute JS scripts on Lua 5.2 VM. Lua VM is known to be fast and lightweight, and especially it is often used in embedded systems. Thus it could allow you to execute your JS scripts on micro-controllers for example.

The probably best known example is [Tessel](https://tessel.io/) which sells a board that "runs JavaScript". In fact they do the same as CASTL, the JS code is converted to Lua and then executed in a specific environment. They call it Colony.

Note that CASTL will always be slower than a native Lua script, so take time to learn Lua :).

### So what's the differences between CASTL and Tessel Colony?

I have definitively been inspired on many points by Colony. Nonetheless there is some important points of divergence: 

* CASTL is aimed to run on a native Lua 5.2 (unmodified VM) whereas Colony rely on a fork of Lua 5.1.
* CASTL can run on LuaJIT.
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
