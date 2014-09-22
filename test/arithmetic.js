var assert = require("assert");

var result = [[0,NaN,0,0,0,NaN,0,0,0,0,-11,11,0,Infinity,11,11,0,NaN,0,'00',0,NaN,0,'00',0,0,-41,'041',0,Infinity,41,'410',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,0,NaN,0,0,0,NaN,0,0,0,0,-1,1,0,Infinity,1,1,0,NaN,0,0,0,NaN,0,0,NaN,NaN,NaN,'0str',NaN,NaN,NaN,'str0',0,0,-1,1,0,Infinity,1,1,0,0,-1,'01',0,Infinity,1,'10',0,0,-7,7,0,Infinity,7,7,0,0,-9,'09',0,Infinity,9,'90',NaN,NaN,NaN,'0yo',NaN,NaN,NaN,'yo0',0,0,-1,1,0,Infinity,1,1],[0,Infinity,11,11,0,0,-11,11,121,1,0,22,121,1,0,22,0,Infinity,11,'110',0,0,-11,'011',451,0.2682926829268293,-30,'1141',451,3.727272727272727,30,'4111',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,0,Infinity,11,11,0,0,-11,11,11,11,10,12,11,0.09090909090909091,-10,12,0,Infinity,11,11,0,0,-11,11,NaN,NaN,NaN,'11str',NaN,NaN,NaN,'str11',11,11,10,12,11,0.09090909090909091,-10,12,11,11,10,'111',11,0.09090909090909091,-10,'111',77,1.5714285714285714,4,18,77,0.6363636363636364,-4,18,99,1.2222222222222223,2,'119',99,0.8181818181818182,-2,'911',NaN,NaN,NaN,'11yo',NaN,NaN,NaN,'yo11',11,11,10,12,11,0.09090909090909091,-10,12],[0,NaN,0,'00',0,NaN,0,'00',0,0,-11,'011',0,Infinity,11,'110',0,NaN,0,'00',0,NaN,0,'00',0,0,-41,'041',0,Infinity,41,'410',NaN,NaN,NaN,'0NaN',NaN,NaN,NaN,'NaN0',NaN,NaN,NaN,'0undefined',NaN,NaN,NaN,'undefined0',0,NaN,0,'0null',0,NaN,0,'null0',0,0,-1,'0true',0,Infinity,1,'true0',0,NaN,0,'0false',0,NaN,0,'false0',NaN,NaN,NaN,'0str',NaN,NaN,NaN,'str0',0,0,-1,'01',0,Infinity,1,'10',0,0,-1,'01',0,Infinity,1,'10',0,0,-7,'07',0,Infinity,7,'70',0,0,-9,'09',0,Infinity,9,'90',NaN,NaN,NaN,'0yo',NaN,NaN,NaN,'yo0',0,0,-1,'0true',0,Infinity,1,'true0'],[0,Infinity,41,'410',0,0,-41,'041',451,3.727272727272727,30,'4111',451,0.2682926829268293,-30,'1141',0,Infinity,41,'410',0,0,-41,'041',1681,1,0,'4141',1681,1,0,'4141',NaN,NaN,NaN,'41NaN',NaN,NaN,NaN,'NaN41',NaN,NaN,NaN,'41undefined',NaN,NaN,NaN,'undefined41',0,Infinity,41,'41null',0,0,-41,'null41',41,41,40,'41true',41,0.024390243902439025,-40,'true41',0,Infinity,41,'41false',0,0,-41,'false41',NaN,NaN,NaN,'41str',NaN,NaN,NaN,'str41',41,41,40,'411',41,0.024390243902439025,-40,'141',41,41,40,'411',41,0.024390243902439025,-40,'141',287,5.857142857142857,34,'417',287,0.17073170731707318,-34,'741',369,4.555555555555555,32,'419',369,0.21951219512195122,-32,'941',NaN,NaN,NaN,'41yo',NaN,NaN,NaN,'yo41',41,41,40,'41true',41,0.024390243902439025,-40,'true41'],[NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,'NaN0',NaN,NaN,NaN,'0NaN',NaN,NaN,NaN,'NaN41',NaN,NaN,NaN,'41NaN',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,'NaNstr',NaN,NaN,NaN,'strNaN',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,'NaN1',NaN,NaN,NaN,'1NaN',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,'NaN9',NaN,NaN,NaN,'9NaN',NaN,NaN,NaN,'NaNyo',NaN,NaN,NaN,'yoNaN',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN],[NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,'undefined0',NaN,NaN,NaN,'0undefined',NaN,NaN,NaN,'undefined41',NaN,NaN,NaN,'41undefined',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,'undefinedstr',NaN,NaN,NaN,'strundefined',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,'undefined1',NaN,NaN,NaN,'1undefined',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,'undefined9',NaN,NaN,NaN,'9undefined',NaN,NaN,NaN,'undefinedyo',NaN,NaN,NaN,'youndefined',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN],[0,NaN,0,0,0,NaN,0,0,0,0,-11,11,0,Infinity,11,11,0,NaN,0,'null0',0,NaN,0,'0null',0,0,-41,'null41',0,Infinity,41,'41null',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,0,NaN,0,0,0,NaN,0,0,0,0,-1,1,0,Infinity,1,1,0,NaN,0,0,0,NaN,0,0,NaN,NaN,NaN,'nullstr',NaN,NaN,NaN,'strnull',0,0,-1,1,0,Infinity,1,1,0,0,-1,'null1',0,Infinity,1,'1null',0,0,-7,7,0,Infinity,7,7,0,0,-9,'null9',0,Infinity,9,'9null',NaN,NaN,NaN,'nullyo',NaN,NaN,NaN,'yonull',0,0,-1,1,0,Infinity,1,1],[0,Infinity,1,1,0,0,-1,1,11,0.09090909090909091,-10,12,11,11,10,12,0,Infinity,1,'true0',0,0,-1,'0true',41,0.024390243902439025,-40,'true41',41,41,40,'41true',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,0,Infinity,1,1,0,0,-1,1,1,1,0,2,1,1,0,2,0,Infinity,1,1,0,0,-1,1,NaN,NaN,NaN,'truestr',NaN,NaN,NaN,'strtrue',1,1,0,2,1,1,0,2,1,1,0,'true1',1,1,0,'1true',7,0.14285714285714285,-6,8,7,7,6,8,9,0.1111111111111111,-8,'true9',9,9,8,'9true',NaN,NaN,NaN,'trueyo',NaN,NaN,NaN,'yotrue',1,1,0,2,1,1,0,2],[0,NaN,0,0,0,NaN,0,0,0,0,-11,11,0,Infinity,11,11,0,NaN,0,'false0',0,NaN,0,'0false',0,0,-41,'false41',0,Infinity,41,'41false',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,0,NaN,0,0,0,NaN,0,0,0,0,-1,1,0,Infinity,1,1,0,NaN,0,0,0,NaN,0,0,NaN,NaN,NaN,'falsestr',NaN,NaN,NaN,'strfalse',0,0,-1,1,0,Infinity,1,1,0,0,-1,'false1',0,Infinity,1,'1false',0,0,-7,7,0,Infinity,7,7,0,0,-9,'false9',0,Infinity,9,'9false',NaN,NaN,NaN,'falseyo',NaN,NaN,NaN,'yofalse',0,0,-1,1,0,Infinity,1,1],[NaN,NaN,NaN,'str0',NaN,NaN,NaN,'0str',NaN,NaN,NaN,'str11',NaN,NaN,NaN,'11str',NaN,NaN,NaN,'str0',NaN,NaN,NaN,'0str',NaN,NaN,NaN,'str41',NaN,NaN,NaN,'41str',NaN,NaN,NaN,'strNaN',NaN,NaN,NaN,'NaNstr',NaN,NaN,NaN,'strundefined',NaN,NaN,NaN,'undefinedstr',NaN,NaN,NaN,'strnull',NaN,NaN,NaN,'nullstr',NaN,NaN,NaN,'strtrue',NaN,NaN,NaN,'truestr',NaN,NaN,NaN,'strfalse',NaN,NaN,NaN,'falsestr',NaN,NaN,NaN,'strstr',NaN,NaN,NaN,'strstr',NaN,NaN,NaN,'str1',NaN,NaN,NaN,'1str',NaN,NaN,NaN,'str1',NaN,NaN,NaN,'1str',NaN,NaN,NaN,'str7',NaN,NaN,NaN,'7str',NaN,NaN,NaN,'str9',NaN,NaN,NaN,'9str',NaN,NaN,NaN,'stryo',NaN,NaN,NaN,'yostr',NaN,NaN,NaN,'strtrue',NaN,NaN,NaN,'truestr'],[0,Infinity,1,1,0,0,-1,1,11,0.09090909090909091,-10,12,11,11,10,12,0,Infinity,1,'10',0,0,-1,'01',41,0.024390243902439025,-40,'141',41,41,40,'411',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,0,Infinity,1,1,0,0,-1,1,1,1,0,2,1,1,0,2,0,Infinity,1,1,0,0,-1,1,NaN,NaN,NaN,'1str',NaN,NaN,NaN,'str1',1,1,0,2,1,1,0,2,1,1,0,'11',1,1,0,'11',7,0.14285714285714285,-6,8,7,7,6,8,9,0.1111111111111111,-8,'19',9,9,8,'91',NaN,NaN,NaN,'1yo',NaN,NaN,NaN,'yo1',1,1,0,2,1,1,0,2],[0,Infinity,1,'10',0,0,-1,'01',11,0.09090909090909091,-10,'111',11,11,10,'111',0,Infinity,1,'10',0,0,-1,'01',41,0.024390243902439025,-40,'141',41,41,40,'411',NaN,NaN,NaN,'1NaN',NaN,NaN,NaN,'NaN1',NaN,NaN,NaN,'1undefined',NaN,NaN,NaN,'undefined1',0,Infinity,1,'1null',0,0,-1,'null1',1,1,0,'1true',1,1,0,'true1',0,Infinity,1,'1false',0,0,-1,'false1',NaN,NaN,NaN,'1str',NaN,NaN,NaN,'str1',1,1,0,'11',1,1,0,'11',1,1,0,'11',1,1,0,'11',7,0.14285714285714285,-6,'17',7,7,6,'71',9,0.1111111111111111,-8,'19',9,9,8,'91',NaN,NaN,NaN,'1yo',NaN,NaN,NaN,'yo1',1,1,0,'1true',1,1,0,'true1'],[0,Infinity,7,7,0,0,-7,7,77,0.6363636363636364,-4,18,77,1.5714285714285714,4,18,0,Infinity,7,'70',0,0,-7,'07',287,0.17073170731707318,-34,'741',287,5.857142857142857,34,'417',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,0,Infinity,7,7,0,0,-7,7,7,7,6,8,7,0.14285714285714285,-6,8,0,Infinity,7,7,0,0,-7,7,NaN,NaN,NaN,'7str',NaN,NaN,NaN,'str7',7,7,6,8,7,0.14285714285714285,-6,8,7,7,6,'71',7,0.14285714285714285,-6,'17',49,1,0,14,49,1,0,14,63,0.7777777777777778,-2,'79',63,1.2857142857142858,2,'97',NaN,NaN,NaN,'7yo',NaN,NaN,NaN,'yo7',7,7,6,8,7,0.14285714285714285,-6,8],[0,Infinity,9,'90',0,0,-9,'09',99,0.8181818181818182,-2,'911',99,1.2222222222222223,2,'119',0,Infinity,9,'90',0,0,-9,'09',369,0.21951219512195122,-32,'941',369,4.555555555555555,32,'419',NaN,NaN,NaN,'9NaN',NaN,NaN,NaN,'NaN9',NaN,NaN,NaN,'9undefined',NaN,NaN,NaN,'undefined9',0,Infinity,9,'9null',0,0,-9,'null9',9,9,8,'9true',9,0.1111111111111111,-8,'true9',0,Infinity,9,'9false',0,0,-9,'false9',NaN,NaN,NaN,'9str',NaN,NaN,NaN,'str9',9,9,8,'91',9,0.1111111111111111,-8,'19',9,9,8,'91',9,0.1111111111111111,-8,'19',63,1.2857142857142858,2,'97',63,0.7777777777777778,-2,'79',81,1,0,'99',81,1,0,'99',NaN,NaN,NaN,'9yo',NaN,NaN,NaN,'yo9',9,9,8,'9true',9,0.1111111111111111,-8,'true9'],[NaN,NaN,NaN,'yo0',NaN,NaN,NaN,'0yo',NaN,NaN,NaN,'yo11',NaN,NaN,NaN,'11yo',NaN,NaN,NaN,'yo0',NaN,NaN,NaN,'0yo',NaN,NaN,NaN,'yo41',NaN,NaN,NaN,'41yo',NaN,NaN,NaN,'yoNaN',NaN,NaN,NaN,'NaNyo',NaN,NaN,NaN,'youndefined',NaN,NaN,NaN,'undefinedyo',NaN,NaN,NaN,'yonull',NaN,NaN,NaN,'nullyo',NaN,NaN,NaN,'yotrue',NaN,NaN,NaN,'trueyo',NaN,NaN,NaN,'yofalse',NaN,NaN,NaN,'falseyo',NaN,NaN,NaN,'yostr',NaN,NaN,NaN,'stryo',NaN,NaN,NaN,'yo1',NaN,NaN,NaN,'1yo',NaN,NaN,NaN,'yo1',NaN,NaN,NaN,'1yo',NaN,NaN,NaN,'yo7',NaN,NaN,NaN,'7yo',NaN,NaN,NaN,'yo9',NaN,NaN,NaN,'9yo',NaN,NaN,NaN,'yoyo',NaN,NaN,NaN,'yoyo',NaN,NaN,NaN,'yotrue',NaN,NaN,NaN,'trueyo'],[0,Infinity,1,1,0,0,-1,1,11,0.09090909090909091,-10,12,11,11,10,12,0,Infinity,1,'true0',0,0,-1,'0true',41,0.024390243902439025,-40,'true41',41,41,40,'41true',NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,0,Infinity,1,1,0,0,-1,1,1,1,0,2,1,1,0,2,0,Infinity,1,1,0,0,-1,1,NaN,NaN,NaN,'truestr',NaN,NaN,NaN,'strtrue',1,1,0,2,1,1,0,2,1,1,0,'true1',1,1,0,'1true',7,0.14285714285714285,-6,8,7,7,6,8,9,0.1111111111111111,-8,'true9',9,9,8,'9true',NaN,NaN,NaN,'trueyo',NaN,NaN,NaN,'yotrue',1,1,0,2,1,1,0,2]];

var a = new Number(7);
var b = new String("9");
var c = new String("yo");
var d = new Boolean(true);
var e = new Boolean(false);
var array = [0,11, "0", "41", NaN, undefined,null,true, false, "str", {valueOf: function(){return 1}}, {toString: function(){return "1"}}, a,b,c,d];

var v;
for(var i = 0 ; i<array.length ; ++i) {
    for(var j = 0 ; j<array.length ; ++j) {
        v = array[i] * array[j];
        assert(v === result[i][j * 8] || Number.isNaN(v));
        v = array[i] / array[j];
        assert(v === result[i][j * 8 + 1] || Number.isNaN(v));
        v = array[i] - array[j];
        assert(v === result[i][j * 8 + 2] || Number.isNaN(v));

        if(!Number.isNaN(array[i]) && !Number.isNaN(array[j])) {
            v = array[i] + array[j];
            assert((v === result[i][j * 8 + 3]) || Number.isNaN(v));
        }
        
        v = array[j] * array[i];
        assert(v === result[i][j * 8 + 4] || Number.isNaN(v));
        v = array[j] / array[i];
        assert(v === result[i][j * 8 + 5] || Number.isNaN(v));
        v = array[j] - array[i];
        assert(v === result[i][j * 8 + 6] || Number.isNaN(v));
        
        if(!Number.isNaN(array[i]) && !Number.isNaN(array[j])) {
            v = array[j] + array[i];
            assert(v === result[i][j * 8 + 7] || Number.isNaN(v));
        }
    }
}

//~ var a = new Number(7);
//~ var b = new String("9");
//~ var c = new String("yo");
//~ var d = new Boolean(true);
//~ var e = new Boolean(false);
//~ var array = [0,11, "0", "41", NaN, undefined,null,true, false, "str", {valueOf: function(){return 1}}, {toString: function(){return "1"}}, a,b,c,d]
//~ 
//~ var res = [];
//~ for(var i = 0 ; i<array.length ; ++i) {
    //~ res.push([]);
    //~ for(var j = 0 ; j<array.length ; ++j) {
        //~ res[i].push(array[i] * array[j]);
        //~ res[i].push(array[i] / array[j]);
        //~ res[i].push(array[i] - array[j]);
        //~ res[i].push(array[i] + array[j]);
        //~ res[i].push(array[j] * array[i]);
        //~ res[i].push(array[j] / array[i]);
        //~ res[i].push(array[j] - array[i]);
        //~ res[i].push(array[j] + array[i]);
    //~ }
//~ }
//~ 
//~ console.log(res);
