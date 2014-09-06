var assert = require("assert");

var i, finallyCount = 0;
for (i = 0; i < 3; ++i) {
    try {

        try {
            break;
            assert(false);
        } catch (e) {
            assert(false);
        } finally {
            finallyCount++;
        }

    } catch (e) {
        assert(false);
    } finally {
        finallyCount++;
    }
}

assert(finallyCount === 2);
