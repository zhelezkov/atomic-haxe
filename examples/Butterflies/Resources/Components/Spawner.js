"atomic component";
var __extends = (this && this.__extends) || function (d, b) {for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];function __() { this.constructor = d; };__.prototype = b.prototype;d.prototype = new __();};
function $bind(n,u){if(null==u)return null;var e;return null==e&&(e=function(){return e.method.apply(e.scope,arguments)},e.scope=n,e.method=u),e};
var Spawner = (function(_super) {
__extends(Spawner, _super);
function Spawner () {
	Atomic.JSComponent.call(this);
};
Spawner.prototype.update = function(delta) {
	if(Atomic.input.getMouseButtonDown(Atomic.MOUSEB_LEFT)) {
		var b = this.scene.createChild("Butterfly");
		var mPos = Atomic.input.getMousePosition();
		var nPos = Atomic.renderer.getViewport(0).screenToWorldPoint(mPos[0] | 0,mPos[1] | 0,0);
		b.position2D = [nPos[0],nPos[1]];
		b.createJSComponent("Components/Butterfly.js");
	} else if(Atomic.input.getMouseButtonPress(Atomic.MOUSEB_RIGHT)) {
		var p = this.scene.createChild("ButterflyEmitter");
		var mPos1 = Atomic.input.getMousePosition();
		var nPos1 = Atomic.renderer.getViewport(0).screenToWorldPoint(mPos1[0] | 0,mPos1[1] | 0,0);
		p.position2D = [nPos1[0],nPos1[1]];
		var pex = p.createComponent("ParticleEmitter2D");
		pex.effect = Atomic.cache.getResource("ParticleEffect2D","Particles/particle.pex");
	}
};
return Spawner;
})(Atomic.JSComponent);
module.exports = Spawner;
