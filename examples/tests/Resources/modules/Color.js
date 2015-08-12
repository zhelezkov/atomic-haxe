var Color;
(function (Color) {
Color.Rgb = function(r,g,b) { var $me = ["Rgb",3,r,g,b]; return $me; };
Color.Blue = ["Blue",2];
Color.Green = ["Green",1];
Color.Red = ["Red",0];
})(Color || (Color = {}));
module.exports = Color;
