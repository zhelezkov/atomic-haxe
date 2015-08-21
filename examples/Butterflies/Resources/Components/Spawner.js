var Std = require("modules/Std");
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
		var camera = this.scene.getMainCamera();
		var pos = Atomic.renderer.getViewport(0).screenToWorldPoint(Std["int"](Atomic.input.getMousePosition()[0]),Std["int"](Atomic.input.getMousePosition()[1]),0);
		b.position2D = [pos[0],pos[1]];
		var spr = b.createComponent("AnimatedSprite2D");
		spr.animationSet = Atomic.cache.getResource("AnimationSet2D","Sprites/insects/butterfly.scml");
		spr.setAnimation("idle");
		spr.color = [.1 + Math.random() * .9,.1 + Math.random() * .9,.1 + Math.random() * .9,1];
		spr.blendMode = Atomic.BLEND_ALPHA;
		b.createJSComponent("Components/Butterfly.js");
	} else if(Atomic.input.getMouseButtonDown(Atomic.MOUSEB_RIGHT)) {
		var p = this.scene.createChild("ButterflyEmitter");
		var pos1 = Atomic.renderer.getViewport(0).screenToWorldPoint(Std["int"](Atomic.input.getMousePosition()[0]),Std["int"](Atomic.input.getMousePosition()[1]),0);
		p.position2D = [pos1[0],pos1[1]];
		var pex = p.createComponent("ParticleEmitter2D");
		pex.effect = Atomic.cache.getResource("ParticleEffect2D","Particles/particle.pex");
	}
};
var inspectorFields = {
};
return Spawner;
})(Atomic.JSComponent);
module.exports = Spawner;
