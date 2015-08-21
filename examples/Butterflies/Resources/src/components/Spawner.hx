package components;

import atomic.Atomic;

@:AtomicComponent
class Spawner extends JSComponent {

    public function update(delta:Float) {
        if(Atomic.input.getMouseButtonDown(Atomic.MOUSEB_LEFT)) {
            var b:Node = scene.createChild("Butterfly");
            //mouse position
            var mPos = Atomic.input.getMousePosition();
            //node position
            var nPos = Atomic.renderer.getViewport(0).screenToWorldPoint(Std.int(mPos[0]), Std.int(mPos[1]), 0);
            b.position2D = [nPos[0], nPos[1]];
            b.createJSComponent("Components/Butterfly.js");
        } else if(Atomic.input.getMouseButtonPress(Atomic.MOUSEB_RIGHT)) {
            var p:Node = scene.createChild("ButterflyEmitter");
            //mouse position
            var mPos = Atomic.input.getMousePosition();
            //node position
            var nPos = Atomic.renderer.getViewport(0).screenToWorldPoint(Std.int(mPos[0]), Std.int(mPos[1]), 0);
            p.position2D = [nPos[0], nPos[1]];
            var pex:ParticleEmitter2D = cast p.createComponent("ParticleEmitter2D");
            pex.effect = cast Atomic.cache.getResource("ParticleEffect2D", "Particles/particle.pex");
        }
    }

}
