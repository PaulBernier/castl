var assert = require("assert");

var o = {v: 11, get getV () {return this.v}};
assert(o.getV === 11);

var o2 = {v: 12, set setV (r) {return this.v = r}};
o2.setV = 42;
assert(o2.v === 42);

var o3 = {v: 11, get 1 () {return this.v}};
assert(o3["1"] === 11);

var o4 = {v: 12, set 1 (r) {return this.v = r}};
o4["1"] = 42;
assert(o4.v === 42);

var o5 = {v: 21};
Object.defineProperty(o5, "test", {get: function() {return this.v}});
assert(o5.test === 21);
Object.defineProperty(o5, "test2", {set: function(r) {this.v = r}});
o5.test2 = 33;
assert(o5.test === 33);
Object.defineProperty(o5, "test3", {get: function() {return this.v}, set: function(r){ this.v = r}});
assert(o5.test3 === 33);
o5.test3 = 14
assert(o5.test3 === 14);

//
var obj = {
  get latest () {
    if (this.log.length == 0) return undefined;
    return this.log[this.log.length - 1]
  },
  set current (str) {
    return this.log[this.log.length - 1] = str;
  },
  log: []
}

obj.log.push("pp")
assert(obj.latest === "pp");
obj.current = 7;
assert(obj.latest === 7);

// Mozilla example

function Archiver() {
  var temperature = null;
  var archive = [];

  Object.defineProperty(this, "temperature",{
    get: function() {
      return temperature; 
    },
    set: function(value) { 
      temperature = value; 
      archive.push({val: temperature}); 
    }
  });

  this.getArchive = function() {return archive;};
}

var arc = new Archiver();
arc.temperature;
arc.temperature = 11; 
arc.temperature = 13; 
var result = arc.getArchive(); // [{val: 11}, {val: 13}]

assert(result[0].val === 11);
assert(result[1].val === 13);
