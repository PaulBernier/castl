// This is an example to compile
function renderCurve() {
    for (var a = 1, b = 10; a * b; a++, b--)
        console.log(new Array(a * b).join('*'));
}
renderCurve();
