var __extends = (this && this.__extends) || function (d, b) {for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];function __() { this.constructor = d; };__.prototype = b.prototype;d.prototype = new __();};
function $bind(n,u){if(null==u)return null;var e;return null==e&&(e=function(){return e.method.apply(e.scope,arguments)},e.scope=n,e.method=u),e};
var Main = (function(_super) {
__extends(Main, _super);
function Main (){};
Main.main = function() {
	var pixelSize = Atomic.PIXEL_SIZE / 2;
	var scene = new Atomic.Scene();
	scene.createComponent("Octree");
	var cameraNode = scene.createChild("Camera");
	var camera = cameraNode.createComponent("Camera");
	cameraNode.position = [0,0,-10];
	camera.setOrthographic(true);
	camera.setOrthoSize(Atomic.graphics.height * pixelSize);
	var viewport = new Atomic.Viewport(scene,camera);
	Atomic.renderer.setViewport(0,viewport);
	scene.createJSComponent("Components/Spawner.js");
};
Main.main();
var inspectorFields = {
};
return Main;
})(Object);
module.exports = Main;
