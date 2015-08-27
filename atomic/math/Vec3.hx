package atomic.math;

abstract Vec3(Array<Float>) {

  public function new() {
    this = new Array<Float>();
  }

  public static function fromValues(x: Float, y: Float, z: Float) : Vec3 {
    var v = new Vec3();
    v.set(x, y, z);
    return v;
  }

  public static function clone(v: Vec3) : Vec3 {
    return v.cp();
  }

  public function copy(v: Vec3) : Vec3 {
    this[0] = v[0];
    this[1] = v[1];
    this[2] = v[2];
    return cast this;
  }

  public function cp() : Vec3 {
    var v = new Array<Float>();
    v[0] = this[0];
    v[1] = this[1];
    v[2] = this[2];
    return cast v;
  }

  public function set(x: Float, y: Float, z: Float) : Vec3 {
    this[0] = x;
    this[1] = y;
    this[2] = z;
    return cast this;
  }

  public function add(v: Vec3) : Vec3 {
    this[0] += v[0];
    this[1] += v[1];
    this[2] += v[2];
    return cast this;
  }

  public function sub(v: Vec3) : Vec3 {
    this[0] -= v[0];
    this[1] -= v[1];
    this[2] -= v[2];
    return cast this;
  }

  public function mul(v: Vec3) : Vec3 {
    this[0] *= v[0];
    this[1] *= v[1];
    this[2] *= v[2];
    return cast this;
  }

  public function div(v: Vec3) : Vec3 {
    this[0] /= v[0];
    this[1] /= v[1];
    this[2] /= v[2];
    return cast this;
  }

  public function min(v: Vec3) : Vec3 {
    this[0] = Math.min(this[0], v[0]);
    this[1] = Math.min(this[1], v[1]);
    this[2] = Math.min(this[2], v[2]);
    return cast this;
  }

  public function max(v: Vec3) : Vec3 {
    this[0] = Math.max(this[0], v[0]);
    this[1] = Math.max(this[1], v[1]);
    this[2] = Math.max(this[2], v[2]);
    return cast this;
  }

  public function scale(s: Float) : Vec3 {
    this[0] *= s;
    this[1] *= s;
    this[2] *= s;
    return cast this;
  }

  public function scaleAndAdd(s: Float, v: Vec3) : Vec3 {
    this[0] += s * v[0];
    this[1] += s * v[1];
    this[2] += s * v[2];
    return cast this;
  }

  public function manhDist(v: Vec3) : Float {
    var x = v[0] - this[0];
    var y = v[1] - this[1];
    var z = v[2] - this[2];

    x = if (x < 0) x * -1 else x;
    y = if (y < 0) y * -1 else y;
    z = if (z < 0) z * -1 else z;

    return x + y + z;
  }

  public function eucDist(v: Vec3) : Float {
    var x = v[0] - this[0];
    var y = v[1] - this[1];
    var z = v[2] - this[2];
    return Math.sqrt(x*x + y*y + z*z);
  }

  public function sqrDist(v: Vec3) : Float {
    var x = v[0] - this[0];
    var y = v[1] - this[1];
    var z = v[2] - this[2];
    return x*x + y*y + z*z;
  }

  public function len() : Float {
    var x = this[0];
    var y = this[1];
    var z = this[2];
    return Math.sqrt(x*x + y*y + z*z);
  }

  public function sqrLen() : Float {
    var x = this[0];
    var y = this[1];
    var z = this[2];
    return x*x + y*y + z*z;
  }

  public function neg() : Vec3 {
    this[0] = -this[0];
    this[1] = -this[1];
    this[2] = -this[2];
    return cast this;
  }

  public function norm() : Vec3 {
    var x = this[0];
    var y = this[1];
    var z = this[2];
    var len = x*x + y*y + z*z;
    if (len > 0) {
      len = 1 / Math.sqrt(len);
      this[0] = x * len;
      this[1] = y * len;
      this[2] = z * len;
    }
    return cast this;
  }

  public function dot(v: Vec3) : Float {
    return this[0] * v[0] + this[1] * v[1] + this[2] * v[2];
  }

  public function cross(v: Vec3) : Vec3 {
    var ax = this[0];
    var ay = this[1];
    var az = this[2];
    var bx = v[0];
    var by = v[1];
    var bz = v[2];

    this[0] = ay * bz - az * by;
    this[1] = az * bx - ax * bz;
    this[2] = ax * by - ay * bx;
    return cast this;
  }

  public function lerp(b: Vec3, t: Float) : Vec3 {
    var ax = this[0];
    var ay = this[1];
    var az = this[2];
    this[0] = ax + t * (b[0] - ax);
    this[1] = ay + t * (b[1] - ay);
    this[2] = az + t * (b[2] - az);
    return cast this;
  }

  @:op(A + B) static public function addop(l: Vec3, r: Vec3) : Vec3 {
    return l.cp().add(r);
  }

  @:op(A - B) static public function subop(l: Vec3, r: Vec3) : Vec3 {
    return l.cp().sub(r);
  }

  @:op(A / B) static public function divop(l: Vec3, r: Vec3) : Vec3 {
    return l.cp().div(r);
  }

  @:commutative @:op(A * B) static public function scaleop(l: Vec3, r: Float) : Vec3 {
    return l.cp().scale(r);
  }

  @:op(A * B) static public inline function mulop(l: Vec3, r: Vec3) : Vec3 {
    return l.cp().mul(r);
  }

  @to public inline function toFloatArray() : Array<Float> {
    return this;
  }

  @:arrayAccess public inline function arrayRead(i: Int) : Float {
    return this[i];
  }

  @:arrayAccess public inline function arrayWrite(i: Int, f: Float) : Float {
    return this[i] = f;
  }
}
