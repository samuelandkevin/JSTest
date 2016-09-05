(function() {


 
//计算阶乘
var factorial = function(n) {
    if (n < 0)
        return;
    if (n === 0)
        return 1;
    return n * factorial(n - 1)
};
 
 var euclideanDistance = function(p1, p2) {
     var xDelta = p2.x - p1.x;
     var yDelta = p2.y - p1.y;
 
     return Math.sqrt(xDelta * xDelta + yDelta * yDelta);
 };
 
 
 var midpoint = function(p1, p2) {
     var xDelta = (p2.x - p1.x) / 2;
     var yDelta = (p2.y - p1.y) / 2;
 
     return MyPoint.makePointWithXY(p1.x + xDelta, p1.y + yDelta);
 };
 
 globalVariable = "global object string";
 
 globalObject = {
 "red":      {"red": 255, "green": 0,   "blue": 0},
 "orange":   {"red": 255, "green": 153, "blue": 0}
 };
 
 
 function ClickHandler(button, callback) {
     this.button = button;
     this.button.onClickHandler = this;
     this.handleEvent = callback;
 };
 
})()


 