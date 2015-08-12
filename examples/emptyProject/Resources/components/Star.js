"atomic component";
var __extends = (this && this.__extends) || function (d, b) {for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];function __() { this.constructor = d; };__.prototype = b.prototype;d.prototype = new __();};
var Star = (function(_super) {
__extends(Star, _super);
function Star () {
	Atomic.JSComponent.call(this);
};
Star.prototype.start = function() {
	console.log("Start function");
};
Star.prototype.update = function(time) {
};
;
return Star;
})(Atomic.JSComponent);
module.exports = Star;
