var __extends = (this && this.__extends) || function (d, b) {for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];function __() { this.constructor = d; };__.prototype = b.prototype;d.prototype = new __();};
function $bind(n,u){if(null==u)return null;var e;return null==e&&(e=function(){return e.method.apply(e.scope,arguments)},e.scope=n,e.method=u),e};
var Main = (function(_super) {
__extends(Main, _super);
function Main () {
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
	this.createInstructions();
};
Main.prototype.createInstructions = function() {
	var view = new Atomic.UIView();
	var layout = new Atomic.UILayout();
	layout.rect = view.rect;
	view.addChild(layout);
	layout.layoutPosition = Atomic.UI_LAYOUT_POSITION_RIGHT_BOTTOM;
	layout.layoutDistributionPosition = Atomic.UI_LAYOUT_DISTRIBUTION_POSITION_RIGHT_BOTTOM;
	var fd = new Atomic.UIFontDescription();
	fd.id = "Vera";
	fd.size = 18;
	var scoreText = new Atomic.UIEditField();
	scoreText.fontDescription = fd;
	scoreText.readOnly = true;
	scoreText.multiline = true;
	scoreText.adaptToContentSize = true;
	scoreText.text = "Atomic Butterflies\nLeft Mouse - Spawn Butterflies\nRight Click - Spawn Particles";
	layout.addChild(scoreText);
};
Main.main = function() {
	new Main();
};
Main.main();
return Main;
})(Object);
module.exports = Main;
