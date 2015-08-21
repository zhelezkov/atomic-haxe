import atomic.Atomic;

import components.Butterfly;
import components.Spawner;

@:AtomicScript
class Main {
    public static inline function main() {
        var pixelSize:Float = Atomic.PIXEL_SIZE / 2;
        var scene = new Scene();
        scene.createComponent("Octree");
        var cameraNode = scene.createChild("Camera");
        var camera:Camera = cast cameraNode.createComponent("Camera");
        cameraNode.position = [0, 0, -10];
        camera.setOrthographic(true);
        camera.setOrthoSize(Atomic.graphics.height * pixelSize);
        var viewport = new Viewport(scene, camera);
        Atomic.renderer.setViewport(0, viewport);
        //script to create butterflies!
        scene.createJSComponent("Components/Spawner.js");
    }
}
