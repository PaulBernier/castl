// CHECK#1
var object = {valueOf: function() {return "1"}, toString: function() {return 0}};
if (Number(object) !== 1) {
  $ERROR('#1: var object = {valueOf: function() {return "1"}, toString: function() {return 0}}; Number(object) === 1. Actual: ' + (Number(object)));
}

// CHECK#2
var object = {valueOf: function() {return {}}, toString: function() {return "0"}};
if (Number(object) !== 0) {
  $ERROR('#2: var object = {valueOf: function() {return {}}, toString: function() {return "0"}}; Number(object) === 0. Actual: ' + (Number(object)));
}
