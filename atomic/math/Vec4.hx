package atomic.math;

abstract Vec4(Array<Float>) {

  public function new() {
    this = new Array<Float>();
  }

  public static function fromValues(x: Float, y: Float, z: Float, w: Float) : Vec4 {
    var v = new Vec4();
    v.set(x, y, z, w);
    return v;
  }

  public static function clone(v: Vec4) : Vec4 {
    return v.cp();
  }

  public function cp() : Vec4 {
    var v = new Array<Float>();
    v[0] = this[0];
    v[1] = this[1];
    v[2] = this[2];
    v[3] = this[3];
    return cast v;
  }

  public function set(x: Float, y: Float, z: Float, w: Float) : Vec4 {
    this[0] = x;
    this[1] = y;
    this[2] = z;
    this[3] = w;
    return cast this;
  }

  public function add(v: Vec4) : Vec4 {
    this[0] += v[0];
    this[1] += v[1];
    this[2] += v[2];
    this[3] += v[3];
    return cast this;
  }

  public function sub(v: Vec4) : Vec4 {
    this[0] -= v[0];
    this[1] -= v[1];
    this[2] -= v[2];
    this[3] -= v[3];
    return cast this;
  }

  public function mul(v: Vec4) : Vec4 {
    this[0] *= v[0];
    this[1] *= v[1];
    this[2] *= v[2];
    this[3] *= v[3];
    return cast this;
  }

  public function div(v: Vec4) : Vec4 {
    this[0] /= v[0];
    this[1] /= v[1];
    this[2] /= v[2];
    this[3] /= v[3];
    return cast this;
  }

  public function min(v: Vec4) : Vec4 {
    this[0] = Math.min(this[0], v[0]);
    this[1] = Math.min(this[1], v[1]);
    this[2] = Math.min(this[2], v[2]);
    this[3] = Math.min(this[3], v[3]);
    return cast this;
  }

  public function max(v: Vec4) : Vec4 {
    this[0] = Math.max(this[0], v[0]);
    this[1] = Math.max(this[1], v[1]);
    this[2] = Math.max(this[2], v[2]);
    this[3] = Math.max(this[3], v[3]);
    return cast this;
  }

  public function scale(s: Float) : Vec4 {
    this[0] *= s;
    this[1] *= s;
    this[2] *= s;
    this[3] *= s;
    return cast this;
  }

  public function scaleAndAdd(s: Float, v: Vec4) : Vec4 {
    this[0] += s * v[0];
    this[1] += s * v[1];
    this[2] += s * v[2];
    this[3] += s * v[3];
    return cast this;
  }

  public function manhDist(v: Vec4) : Float {
    var x = v[0] - this[0];
    var y = v[1] - this[1];
    var z = v[2] - this[2];
    var w = v[3] - this[3];

    x = if (x < 0) x * -1 else x;
    y = if (y < 0) y * -1 else y;
    z = if (z < 0) z * -1 else z;
    w = if (w < 0) w * -1 else w;

    return x + y + z + w;
  }

  public function eucDist(v: Vec4) : Float {
    var x = v[0] - this[0];
    var y = v[1] - this[1];
    var z = v[2] - this[2];
    var w = v[3] - this[3];
    return Math.sqrt(x*x + y*y + z*z + w*w);
  }

  public function sqrDist(v: Vec4) : Float {
    var x = v[0] - this[0];
    var y = v[1] - this[1];
    var z = v[2] - this[2];
    var w = v[3] - this[3];
    return x*x + y*y + z*z + w*w;
  }

  public function len() : Float {
    var x = this[0];
    var y = this[1];
    var z = this[2];
    var w = this[3];
    return Math.sqrt(x*x + y*y + z*z + w*w);
  }

  public function sqrLen() : Float {
    var x = this[0];
    var y = this[1];
    var z = this[2];
    var w = this[3];
    return x*x + y*y + z*z + w*w;
  }

  public function neg() : Vec4 {
    this[0] = -this[0];
    this[1] = -this[1];
    this[2] = -this[2];
    this[3] = -this[3];
    return cast this;
  }

  public function norm() : Vec4 {
    var x = this[0];
    var y = this[1];
    var z = this[2];
    var w = this[3];
    var len = x*x + y*y + z*z + w*w;
    if (len > 0) {
      len = 1 / Math.sqrt(len);
      this[0] = x * len;
      this[1] = y * len;
      this[2] = z * len;
      this[3] = w * len;
    }
    return cast this;
  }

  public function dot(v: Vec4) : Float {
    return this[0] * v[0] + this[1] * v[1] + this[2] * v[2] + this[3] * v[3];
  }

  public function lerp(b: Vec4, t: Float) : Vec4 {
    var ax = this[0];
    var ay = this[1];
    var az = this[2];
    this[0] = ax + t * (b[0] - ax);
    this[1] = ay + t * (b[1] - ay);
    this[2] = az + t * (b[2] - az);
    return cast this;
  }

  public function transMat4(m: Mat4) : Vec4 {
    var x = this[0]; var y = this[1]; var z = this[2]; var w = this[3];

    this[0] = m[0] * x + m[4] * y + m[8] * z + m[12] * w;
    this[1] = m[1] * x + m[5] * y + m[9] * z + m[13] * w;
    this[2] = m[2] * x + m[6] * y + m[10] * z + m[14] * w;
    this[3] = m[3] * x + m[7] * y + m[11] * z + m[15] * w;

    return cast this;
  }

  public function transQuat(q: Quat) : Mat4 {
    var x = this[0] ; var y = this[1]; var z = this[2];
    var qx = q[0]; var qy = q[1]; var qz = q[2]; var qw = q[3];

	// calculate quat * vec
	var ix = qw * x + qy * z - qz * y;
	var iy = qw * y + qz * x - qx * z;
	var iz = qw * z + qx * y - qy * x;
	var iw = -qx * x - qy * y - qz * z;

    // calculate result * inverse quat
    this[0] = ix * qw + iw * -qx + iy * -qz - iz * -qy;
    this[1] = iy * qw + iw * -qy + iz * -qx - ix * -qz;
    this[2] = iz * qw + iw * -qz + ix * -qy - iy * -qx;

    return cast this;
  }

  @:op(A + B) static public function addop(l: Vec4, r: Vec4) : Vec4 {
    return l.cp().add(r);
  }

  @:op(A - B) static public function subop(l: Vec4, r: Vec4) : Vec4 {
    return l.cp().sub(r);
  }

  @:op(A / B) static public function divop(l: Vec4, r: Vec4) : Vec4 {
    return l.cp().div(r);
  }

  @:commutative @:op(A * B) static public function scaleop(l: Vec4, r: Float) : Vec4 {
    return l.cp().scale(r);
  }

  @:op(A * B) static public inline function mulop(l: Vec4, r: Vec4) : Vec4 {
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
