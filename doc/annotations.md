CASTL Annotations
==========

Annotations are specific comments you put in your code to provide CASTL compiler with meta information.

# Goal
The goal of annotations is to optimize the generated Lua code. The compiler leverage the meta information contained in annotations to write better code.

# Use

An annotation is a string beginning with a '@' placed in a (block or line) comment.
``` // @number``` or ``` /* @number */``` are valid annotations. **An annotation concerns only the line of code directly below**.

Note that you'll need to explicitly run castl with ```--annotation``` option so that the compiler takes annotations into account.

## Available annotations

For now only *type* annotations are available:

* ```// @number```
* ```// @string```
* ```// @boolean```

If you specify a type annotation, the compiler will take it into account for the following elements (in the code line directly below the annotation):

* variables. E.g. ```myVariable```
* member expression. E.g. ```myObject.member```
* call expression. E.g. ```f()``` or ```myObject.method()```

## When to use it

Type annotations are useful to optimize 4 things currently:

* + operator
* ++ and -- operators
* Comparisons operators <, <=, >, >=
* Tests (if, while, ternary condition...)

In the general case CASTL compiles + operation as a call to ```_add``` function which can be heavy. In the same way the general comparison operators are compiled as calls to ```_lt```,  ```_le```, ```_gt```, ```_ge``` functions. The call to these functions is useless if operands are both strings or both numbers for instance. That's where annotations come into play.

### + operator

```Javascript
// @number
a = a + b
// @string
a = a + b
```
will directly be compiled to 
```Lua
a = a + b
a = a .. b
-- instead of
-- a = _add(a, b)
-- a = _add(a, b)
```

### ++ and -- operators
```Javascript
// @number
++a
// @number
--a
```
will directly be compiled to 
```Lua
a = a + 1
a = a -1
-- instead of
-- a = inc(a)
-- a = dec(a)
```

### Comparisons

```Javascript
// @number
a < b
```
will directly be compiled to 
```Lua
a < b
-- instead of
-- _lt(a, b)

```


### Tests

```Javascript
// @boolean
if(o.isEnabled()){}
```
will directly be compiled to 
```Lua
if(o.isEnabled())

end
-- instead of
-- if(_bool(o.isEnabled()))
-- end

```

# Tips and warnings

## Quick optimization: loops
If you had to optimize only one thing it should be loops. The most common and easy pattern to optimize is numerical loop.
A numerical loop typically looks like that:
```JavaScript
for(i = 0 ; i<arr.length ; ++i) {
}
```
By specifying ``` // @number ``` annotation before this loop statement, comparison and increment operations will be both optimized. Try also to optimize what's inside the loop as it will be executed many times.


## Warning

Misusing annotations may break your code! Without annotations, CASTL will use the most ECMAScript compliant option so it's the safest way to compile your code. But when you use annotations you're overriding default CASTL behavior, and telling that you know what you're doing. If you add a wrong annotation your program may produce strange behaviors, always double check your annotations. Thus if compiled code with annotations crashes try first to disable annotations. If it still crashes it may be a bug in CASTL (otherwise check your annotations).

When you put a type annotation you must be sure that in every cases the elements in the line below are of this type. For instance if a variable is supposed to be 99% of time a number but can be ```undefined``` the remaining 1% **do not** use annoan tation.

You also have to always keep in mind that one annotation concerns the whole line below. You can simply break the line to solve this issue.

E.g. this wont' work:
```
var a = 4, b = 1, c = "h", d = "ello";

// @number
if(a < b || c + d === "hello") {
    console.log("ok");
}
```

Instead just break lines and put different annotations:
```
var a = 4, b = 1, c = "h", d = "ello";

if(
// @number
a < b ||
// @string
c + d === "hello") {
    console.log("ok");
}
```

## Types inferred

You may have noticed that if you compile ```var a = 1 + 2 ``` you'll get ```local a = 1 + 2 ``` without using any annotation. When types can be inferred, CASTL will optimize accordingly. 

## Example

```castl.js``` has been annotated you can have a look at it to get an example.
