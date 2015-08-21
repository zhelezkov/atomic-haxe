package components;

import atomic.Atomic;

@:AtomicComponent
class Butterfly extends JSComponent {

    var pos:Vector2;

    var spr:AnimatedSprite2D;
    var time:Float;
    var desiredDirection:Float;
    var direction:Float = Math.random() * Math.PI * 2;
    var rotationSpeed:Float = 10;
    var speed:Float = 1 + 2 * Math.random();

    public static var halfWidth:Float = Atomic.graphics.width * Atomic.PIXEL_SIZE * 0.5;
    public static var halfHeight:Float = Atomic.graphics.height * Atomic.PIXEL_SIZE * 0.5;

    public function start() {
        pos = node.getPosition2D();
        spr = cast node.getComponent("AnimatedSprite2D");
    }

    public function update(delta:Float) {
        time += delta;
        if(time % 1000 / 1000 < 0.5) {
            desiredDirection = Math.random() * Math.PI * 2;
        }
        direction = circWrapTo(direction, desiredDirection, rotationSpeed * delta);
        pos[0] += Math.cos(direction) * speed * delta;
        pos[1] += Math.sin(direction) * speed * delta;
        node.position2D = pos;
        node.rotation2D = (direction + Math.PI * 3 / 2) * (180/Math.PI);
        if(pos[0] < -halfWidth || pos[1] < -halfHeight || pos[0] > halfWidth || pos[1] > halfHeight) {
            //kill butterfly :(
            scene.removeChild(node);
        }
    }
    //Just some math function
    function circWrapTo(value:Float, target:Float, step:Float):Float {
        if (value == target) return target;
        var max = Math.PI * 2;
        var result = value;
        var d = this.wrappedDistance(value, target, max);
        if (Math.abs(d) < step) return target;
        result += (d < 0 ? -1 : 1) * step;
        if (result > max) {
          result = result - max;
        } else if (result < 0) {
          result = max + result;
        }
        return result;
    }

    function wrappedDistance(a:Float, b:Float, max:Float):Float {
        if (a == b) return 0;
        var l:Float;
        var r:Float;
        if (a < b) {
          l = -a - max + b;
          r = b - a;
        } else {
          l = b - a;
          r = max - a + b;
        }

        if (Math.abs(l) > Math.abs(r)) return r;
        else return l;
    }
}
