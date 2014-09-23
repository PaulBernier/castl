var assert = require("assert");

(function () {
    var z = arguments;
    assert(!(z instanceof Array));
    assert(z instanceof Object);
    assert(typeof (z) === "object");
    assert(z.toString() === "[object Arguments]");
})();

(function (arguments) {
    assert(arguments === 4);
})(4);

(function () {
    assert(arguments[0] === 7);
    var arguments = 11;
    assert(arguments === 11);
})(7);

(function () {
    assert(arguments[0] === 99);
    var arguments = function () {
        assert(77)
    };
    arguments();
})(99);

(function () {
    arguments = 3;
    assert(arguments === 3);
})();

(function () {
    arguments.z = 3;
    assert(arguments.z === 3);
})();
