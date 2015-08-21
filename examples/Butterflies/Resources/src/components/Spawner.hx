package components;

import atomic.Atomic;

@:AtomicComponent
class Spawner extends JSComponent {

    public function update(delta:Float) {
        if(Atomic.input.getMouseButtonDown(Atomic.MOUSEB_LEFT)) {
            var b:Node = scene.createChild("Butterfly");
            var camera = scene.getMainCamera();
            var pos = Atomic.renderer.getViewport(0).screenToWorldPoint(Std.int(Atomic.input.getMousePosition()[0]), Std.int(Atomic.input.getMousePosition()[1]), 0);
            b.position2D = [pos[0], pos[1]];
            var spr:AnimatedSprite2D = cast b.createComponent("AnimatedSprite2D");
            spr.animationSet = cast Atomic.cache.getResource("AnimationSet2D", "Sprites/insects/butterfly.scml");
            spr.setAnimation("idle");
            spr.color = [.1 + Math.random() * .9, .1 + Math.random() * .9, .1 + Math.random() * .9, 1];
            spr.blendMode = BlendMode.BLEND_ALPHA;
            b.createJSComponent("Components/Butterfly.js");
        } else if(Atomic.input.getMouseButtonDown(Atomic.MOUSEB_RIGHT)) {
            var p:Node = scene.createChild("ButterflyEmitter");
            var pos = Atomic.renderer.getViewport(0).screenToWorldPoint(Std.int(Atomic.input.getMousePosition()[0]), Std.int(Atomic.input.getMousePosition()[1]), 0);
            p.position2D = [pos[0], pos[1]];
            var pex:ParticleEmitter2D = cast p.createComponent("ParticleEmitter2D");
            pex.effect = cast Atomic.cache.getResource("ParticleEffect2D", "Particles/particle.pex");
        }
    }

}
