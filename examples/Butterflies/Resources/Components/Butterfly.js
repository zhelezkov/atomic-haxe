"atomic component";
var __extends = (this && this.__extends) || function (d, b) {for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];function __() { this.constructor = d; };__.prototype = b.prototype;d.prototype = new __();};
function $bind(n,u){if(null==u)return null;var e;return null==e&&(e=function(){return e.method.apply(e.scope,arguments)},e.scope=n,e.method=u),e};
var Butterfly = (function(_super) {
__extends(Butterfly, _super);
function Butterfly () {
	this.speed = 1 + 2 * Math.random();
	this.rotationSpeed = 10;
	this.direction = Math.random() * Math.PI * 2;
	Atomic.JSComponent.call(this);
};
Butterfly.halfWidth = Atomic.graphics.width * Atomic.PIXEL_SIZE * 0.5;
Butterfly.halfHeight = Atomic.graphics.height * Atomic.PIXEL_SIZE * 0.5;
Butterfly.prototype.pos = null;
Butterfly.prototype.spr = null;
Butterfly.prototype.time = null;
Butterfly.prototype.desiredDirection = null;
Butterfly.prototype.direction = null;
Butterfly.prototype.rotationSpeed = null;
Butterfly.prototype.speed = null;
Butterfly.prototype.start = function() {
	this.pos = this.node.getPosition2D();
	this.spr = this.node.getComponent("AnimatedSprite2D");
};
Butterfly.prototype.update = function(delta) {
	this.time += delta;
	if(this.time % 1000 / 1000 < 0.5) this.desiredDirection = Math.random() * Math.PI * 2;
	this.direction = this.circWrapTo(this.direction,this.desiredDirection,this.rotationSpeed * delta);
	this.pos[0] += Math.cos(this.direction) * this.speed * delta;
	this.pos[1] += Math.sin(this.direction) * this.speed * delta;
	this.node.position2D = this.pos;
	this.node.rotation2D = (this.direction + Math.PI * 3 / 2) * (180 / Math.PI);
	if(this.pos[0] < -Butterfly.halfWidth || this.pos[1] < -Butterfly.halfHeight || this.pos[0] > Butterfly.halfWidth || this.pos[1] > Butterfly.halfHeight) this.scene.removeChild(this.node);
};
Butterfly.prototype.circWrapTo = function(value,target,step) {
	if(value == target) return target;
	var max = Math.PI * 2;
	var result = value;
	var d = this.wrappedDistance(value,target,max);
	if(Math.abs(d) < step) return target;
	result += (d < 0?-1:1) * step;
	if(result > max) result = result - max; else if(result < 0) result = max + result;
	return result;
};
Butterfly.prototype.wrappedDistance = function(a,b,max) {
	if(a == b) return 0;
	var l;
	var r;
	if(a < b) {
		l = -a - max + b;
		r = b - a;
	} else {
		l = b - a;
		r = max - a + b;
	}
	if(Math.abs(l) > Math.abs(r)) return r; else return l;
};
var inspectorFields = {
    speed: null,
    rotationSpeed: 10,
    direction: null,
};
return Butterfly;
})(Atomic.JSComponent);
module.exports = Butterfly;
