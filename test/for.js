var assert = require("assert");

for (var i = 0; i < 5; i++) {

}

for (var i = 0;;) {
    break;
}

for (; false;) {

}

for (;; i = 3) {
    break;
}

for (;;) {
    break;
}

for ((function () {
    return "t"
})();;) {
    break;
}

for (var j = 0; j < 2;
    (function () {
        return "t"
    })()) {
    j++;
}
