var assert = require("assert");

var result = [[false,true,false,true,true,true,true,false,false,false,false,true,false,true,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,true,false,true,true,false,false,false,false,true,false,true,true,false,false,false,false,false,false,false,false,false,false,true,true,false,false,false,true,true,false,false,false],[false,false,true,true,false,false,true,false,true,true,false,false,true,true,false,false,true,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,true,false,false,true,false,true,true,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,false,true,true,false,true,false,true,true],[false,true,false,true,true,true,true,false,false,false,false,true,false,true,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,true,false,true,true,false,false,false,false,true,false,true,true,true,true,false,false,false,true,true,false,false,false,true,true,false,false,false,true,true,false,false,false],[false,false,true,true,false,false,true,false,true,true,false,false,true,true,false,false,true,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,true,false,false,true,false,true,true,false,false,true,true,false,true,true,false,false,false,true,true,false,false,false,false,true,false,true,true,false,true,false,true,true],[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],[false,true,false,true,false,true,true,false,false,false,false,true,false,true,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,false,true,false,true,true,true,true,false,false,false,false,true,false,true,false,false,false,false,false,false,false,false,false,false,false,true,true,false,false,false,true,true,false,false,false],[false,false,true,true,false,false,true,false,true,true,false,false,true,true,false,false,true,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,true,false,false,true,false,true,true,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,false,true,true,false,true,false,true,true],[false,true,false,true,true,true,true,false,false,false,false,true,false,true,true,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,true,false,true,true,false,false,false,false,true,false,true,true,false,false,false,false,false,false,false,false,false,false,true,true,false,false,false,true,true,false,false,false],[false,false,false,false,false,false,false,false,false,false,false,false,true,true,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,true,true,false,false,true,true,false,false,false,false,false,false,false,false,true,true,false],[false,false,false,false,false,false,false,false,false,false,false,false,true,true,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,true,false,false,false,false,true,false,true,true,false,false,false,false,false,false,false,true,true,false],[false,false,true,true,false,false,true,false,true,true,false,false,true,true,false,false,true,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,true,false,false,true,false,true,true,false,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,false,true,true,false,true,false,true,false],[false,false,true,true,false,false,true,false,true,true,false,false,true,true,false,false,true,false,true,true,false,false,false,false,false,false,false,false,false,false,false,false,true,true,false,false,true,false,true,true,false,false,true,true,false,true,true,false,false,false,true,true,false,false,false,false,true,false,true,false,false,true,false,true,true]];

var array = [0,1, "0", "1", NaN, undefined,null,true, false, "str", function(){}, {valueOf: function(){return 1}}, {toString: function(){return "1"}}];

for(var i = 0 ; i<array.length ; ++i) {
    for(var j = 0 ; j<array.length ; ++j) {
        assert((array[i] < array[j]) === result[i][j * 5]);
        assert((array[i] <= array[j]) === result[i][j * 5 + 1]);
        assert((array[i] > array[j]) === result[i][j * 5 + 2]);
        assert((array[i] >= array[j]) === result[i][j * 5 + 3]);
        assert((array[i] == array[j]) === result[i][j * 5 + 4]);
    }
}

// Generator
//
//~ var array = [0,1, "0", "1", NaN, undefined,null,true, false, "str", function(){}, {valueOf: function(){return 1}}, {toString: function(){return "1"}}]
//~ 
//~ var res = [];
//~ for(var i = 0 ; i<array.length ; ++i) {
    //~ res.push([]);
    //~ for(var j = 0 ; j<array.length ; ++j) {
        //~ res[i].push(array[i] < array[j]);
        //~ res[i].push(array[i] <= array[j]);
        //~ res[i].push(array[i] > array[j]);
        //~ res[i].push(array[i] >= array[j]);
        //~ res[i].push(array[i] == array[j]);
    //~ }
//~ }
//~ 
//~ console.log(res);
