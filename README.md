CAST(L): compile JavaScript to Lua
==========
CASTL (Compile Abstract Syntax Tree to Lua) is a free and open source project that allows you to "compile" some JavaScript (ES5 and ES6 through Babel transformation) code to Lua 5.2 or LuaJIT 2 code and run it. (I never tested on Lua 5.3 VM)

## Installation

In a terminal:

```
git clone https://github.com/PaulBernier/castl
cd castl
npm install
sudo npm link
```

CASTL has one dependency called [Lrexlib](http://rrthomas.github.io/lrexlib/) to handle regular expressions: you'll most likely need it, but if your JS code doesn't contain any regexp this dependency is not required.
The easy way to install this dependency is to use [Luarocks](https://luarocks.org/) package manager:

* if you want to execute on Lua 5.2:
```
sudo luarocks-5.2 install lrexlib-pcre
```
* if you want to execute on LuaJIT
```
sudo luarocks-5.1 install lrexlib-pcre
```

You'll need to have *libpcre* installed on your system (*lrexlib-pcre* is only a binding to the *libpcre* API).
On an Ubuntu system for instance you could do: sudo apt-get install libpcre3 libpcre3-dev

And then you may want to test:
```
castl code.js
npm test
```

Note that you can also directly install CASTL globally via npm repository:
```
sudo npm install castl -g
```

## Usage:

* Compile code in `<file.js>`, print and execute the compiled code:
```
$ castl -v <file.js>
```

* Compile code in `file.js`, does not print anything but save the compiled code to `file.js.lua`:
```
$ castl file.js -o
```

* If your JS code contains some ES6 flavor you should use --babel option:
```
$ castl file.js --babel
```

**The options of the command line are:**

Option  | Description
------------- | -------------
-h, --help           |output usage information
-v, --verbose        |Verbose, print the compiled code to be run
-o, --output [name]  |Output the generated Lua code in a file. The default output name is _filename_.lua
-b, --bytecode       |If -o option is active the outputted code is in Lua/LuaJIT bytecode
-n, --linenumber     |Print line numbers if -v or --cat options are active
-a, --annotation     |Use annotations to optimize generated code
-g, --heuristic      |Enable heuristic compilation
--babel              |Run Babel on the code to transform ES6 code to ES5 code compatible with castl transpiler
--cat                |Don't execute, just print the code that would be run
--jit                |Compile for LuaJIT (and execute with LuaJIT instead of Lua 5.2 interpreter)
--mini               |Minify AST using Esmangle before compiling. Size of outputted file is shrunk
--debug              |Add comments in the Lua code referring to the line number of the original statement in the JS file
--acorn              |use Acorn parser. If not specified Esprima is used
--strict             |Make Esprima and Acorn not error-tolerant
--node               |Add a very basic support of NodeJS 'require' system

## Annotations

Annotations are useful to optimize the generated code. Please refer to the file ```doc/annotations.md``` for more information.

## Heuristic

Heuristic compilation is an attempt to optimize the generated code by guessing program behavior at execution time.
Thus this option may increase the speed of execution of your program ; but as it is based on guessing it may also be wrong sometimes and break you program in some weird cases.

For now heuristic only applies to numeric for loops. It tries to identify and optimize the following pattern:
```JavaScript
for(i = 0; i<length ; ++i) {
}
```
You should try to enable heuristic if you have a lot of numeric for loops. If it breaks you code you may want to consider annotations instead.

## CASTL components

CASTL is made of two parts:

* a JavaScript script (`castl.js`) which converts a SpiderMonkey AST to Lua code
* a Lua runtime library (located in `lua/castl/`) which allows the execution of the code compiled by `castl.js`

There is also a useful command line tool `bin/castl.js` to easily both compile and execute JS files.

CASTL has one dependency, [Lrexlib](http://rrthomas.github.io/lrexlib/), which provides a binding of PCRE regular expression library API.

CASTL also needs a JavaScript parser able to produce an AST (Abstract Syntax Tree) compliant with the SpiderMonkey AST structure. You can use Esprima or Acorn for instance (if you installed CASTL as stated above Esprima and Acorn are automatically downloaded as dependencies, you don't need to do anything).

## ES6

CASTL transpiler is not able to parse ES6 code. If you try to do so you'll get a SyntaxError like 'Error: let instruction is not supported yet'. Luckily thanks to the great  [Babel](https://babeljs.io/) library you can transform your code from ES6 to ES5 that will be understood by CASTL transpiler. As a convenience I added an option --babel to the command line tool that'll invoke Babel transform for you before transpiling to Lua.

## Not Supported yet

* Weak typing of JS when accessing attribute of an object (o[1] is different from o["1"])
* Property descriptor (enumerable/writable/configurable)
* Many new ES6 features. And if you use new objects like Map/Set your script will fail only at runtime as those objects are not defined in the runtime library. See ES6 section of this README for a workaround.

## Q&A

### What could it be useful for?!

CASTL lets you execute JS scripts on Lua 5.2 VM. Lua VM is known to be fast and lightweight, and especially it is often used in embedded systems. Thus it could allow you to execute your JS scripts on micro-controllers for example.

The probably best known example is [Tessel](https://tessel.io/) which sells a board that "runs JavaScript". In fact they do the same as CASTL, the JS code is converted to Lua and then executed in a specific environment. They call it Colony.

Note that CASTL will always be slower than a native Lua script, so take time to learn Lua :).

### So what's the differences between CASTL and Tessel Colony?

I have definitively been inspired on many points by Colony. Nonetheless there is some important points of divergence:

* CASTL is aimed to run on a native Lua 5.2 (unmodified VM) whereas Colony rely on a fork of Lua 5.1.
* CASTL can run on LuaJIT.
* CASTL supports eval() function and Function() constructor :) (yes, it uses a Lua version of CASTL and Esprima...)
* `castl.js` is not bound to any parser whereas Colony is bound to an old modified version of Acorn.
* `castl.js` is NodeJS independent, it can be executed in Node as well as in a web browser.
* Colony has a good support of NodeJS (objects, libraries...) whereas it's almost nonexistent in CASTL.
* License is different (CASTL is under LGPLv3 and Colony is under MIT/Apache).

### I'd prefer a version of CASTL written in Lua

Easy, just compile CASTL by itself (and also Esprima for the parsing)! By the way you can find a version already compiled in folder `lua/castl/jscompile/` which is used for the eval() function.

## Info

Developed and maintained by [Paul Bernier](http://www.paulbernier.fr).

Released under the LGPLv3 license.
