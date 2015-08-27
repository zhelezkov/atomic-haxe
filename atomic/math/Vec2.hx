package atomic.math;

abstract Vec2(Array<Float>) {
  public function new() {
    this = new Array<Float>();
  }

  public static function fromValues(x: Float, y: Float) : Vec2 {
    var v = new Vec2();
    v.set(x, y);
    return v;
  }

  public static function clone(v: Vec2) : Vec2 {
    return v.cp();
  }

  public function copy(v: Vec2) : Vec2 {
    this[0] = v[0];
    this[1] = v[1];
    return cast this;
  }

  public function cp() : Vec2 {
    var v = new Array<Float>();
    v[0] = this[0];
    v[1] = this[1];
    return cast v;
  }

  public function set(x: Float, y: Float) : Vec2 {
    this[0] = x;
    this[1] = y;
    return cast this;
  }

  public function add(v: Vec2) : Vec2 {
    this[0] += v[0];
    this[1] += v[1];
    return cast this;
  }

  public function sub(v: Vec2) : Vec2 {
    this[0] -= v[0];
    this[1] -= v[1];
    return cast this;
  }

  public function mul(v: Vec2) : Vec2 {
    this[0] *= v[0];
    this[1] *= v[1];
    return cast this;
  }

  public function div(v: Vec2) : Vec2 {
    this[0] /= v[0];
    this[1] /= v[1];
    return cast this;
  }

  public function min(v: Vec2) : Vec2 {
    this[0] = Math.min(this[0], v[0]);
    this[1] = Math.min(this[1], v[1]);
    return cast this;
  }

  public function max(v: Vec2) : Vec2 {
    this[0] = Math.max(this[0], v[0]);
    this[1] = Math.max(this[1], v[1]);
    return cast this;
  }

  public function scale(s: Float) : Vec2 {
    this[0] *= s;
    this[1] *= s;
    return cast this;
  }

  public function scaleAndAdd(s: Float, v: Vec2) : Vec2 {
    this[0] += s * v[0];
    this[1] += s * v[1];
    return cast this;
  }

  public function manhDist(v: Vec2) : Float {
    var x = v[0] - this[0];
    var y = v[1] - this[1];

    x = if (x < 0) x * -1 else x;
    y = if (y < 0) y * -1 else y;

    return x + y;
  }

  public function eucDist(v: Vec2) : Float {
    var x = v[0] - this[0];
    var y = v[1] - this[1];

    return Math.sqrt(x*x + y*y);
  }

  public function sqrDist(v: Vec2) : Float {
    var x = v[0] - this[0];
    var y = v[1] - this[1];

    return x*x + y*y;
  }

  public function len() : Float {
    var x = this[0];
    var y = this[1];

    return Math.sqrt(x*x + y*y);
  }

  public function sqrLen() : Float {
    var x = this[0];
    var y = this[1];
    return x*x + y*y;
  }

  public function neg() : Vec2 {
    this[0] = -this[0];
    this[1] = -this[1];

    return cast this;
  }

  public function norm() : Vec2 {
    var x = this[0];
    var y = this[1];
    var len = x*x + y*y;
    if (len > 0) {
      len = 1 / Math.sqrt(len);
      this[0] = x * len;
      this[1] = y * len;
    }
    return cast this;
  }

  public function dot(v: Vec2) : Float {
    return this[0] * v[0] + this[1] * v[1];
  }

  public function cross(b: Vec2) : Vec2 {
    var z = this[0] * b[1] - this[1] * b[0];
	this[0] = this[1];
	this[1] = 0;

    return cast this;
  }

  public function lerp(b: Vec2, t: Float) : Vec2 {
    var ax = this[0];
    var ay = this[1];
    this[0] = ax + t * (b[0] - ax);
    this[1] = ay + t * (b[1] - ay);

    return cast this;
  }

  public function transMat2(m: Mat2) : Vec2 {
    var x = this[0];
    var y = this[1];
    this[0] = m[0] * x + m[2] * y;
    this[1] = m[1] * x + m[3] * y;

    return cast this;
  }

  public function transMat2d(m: Mat2d) : Vec2 {
    var x = this[0];
    var y = this[1];
    this[0] = m[0] * x + m[2] * y + m[4];
    this[1] = m[1] * x + m[3] * y + m[5];

    return cast this;
  }

  public function transMat3(m: Mat3) : Vec2 {
    var x = this[0];
    var y = this[1];
    this[0] = m[0] * x + m[3] * y + m[6];
    this[1] = m[1] * x + m[4] * y + m[7];

    return cast this;
  }

  public function transMat4(m: Mat4) : Vec2 {
    var x = this[0];
    var y = this[1];
    this[0] = m[0] * x + m[4] * y + m[12];
    this[1] = m[1] * x + m[5] * y + m[13];

    return cast this;
  }

  @:op(A + B) static public function addop(l: Vec2, r: Vec2) : Vec2 {
    return l.cp().add(r);
  }

  @:op(A - B) static public function subop(l: Vec2, r: Vec2) : Vec2 {
    return l.cp().sub(r);
  }

  @:op(A / B) static public function divop(l: Vec2, r: Vec2) : Vec2 {
    return l.cp().div(r);
  }

  @:commutative @:op(A * B) static public function scaleop(l: Vec2, r: Float) : Vec2 {
    return l.cp().scale(r);
  }

  @:op(A * B) static public inline function mulop(l: Vec2, r: Vec2) : Vec2 {
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
