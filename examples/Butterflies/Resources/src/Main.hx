import atomic.Atomic;

import components.Butterfly;
import components.Spawner;

@:AtomicScript
class Main {

    function new() {
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

        createInstructions();
    }

    function createInstructions() {

        var view = new UIView();

        // Create a layout, otherwise child widgets won't know how to size themselves
        // and would manually need to be sized
        var layout = new UILayout();

        // specify the layout region
        layout.rect = view.rect;

        view.addChild(layout);

        // we're laying out on the X axis so "position" controls top and bottom alignment
        layout.layoutPosition = UI_LAYOUT_POSITION.UI_LAYOUT_POSITION_RIGHT_BOTTOM;
        // while "distribution" handles the Y axis
        layout.layoutDistributionPosition = UI_LAYOUT_DISTRIBUTION_POSITION.UI_LAYOUT_DISTRIBUTION_POSITION_RIGHT_BOTTOM;

        var fd = new UIFontDescription();
        fd.id = "Vera";
        fd.size = 18;

        var scoreText = new UIEditField();
        scoreText.fontDescription = fd;
        scoreText.readOnly = true;
        scoreText.multiline = true;
        scoreText.adaptToContentSize = true;
        scoreText.text = "Atomic Butterflies\nLeft Mouse - Spawn Butterflies\nRight Click - Spawn Particles";
        layout.addChild(scoreText);
    }

    public static inline function main() {
        new Main();
    }
}
