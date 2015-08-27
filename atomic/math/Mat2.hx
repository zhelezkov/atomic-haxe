package atomic.math;

abstract Mat2(Array<Float>) {
  public function new() {
    var m = new Array<Float>();
    m[0] = 0;
    m[1] = 0;
    m[2] = 0;
    m[3] = 0;

    this = m;
  }

  public static function clone(v: Mat2) : Mat2 {
    return v.cp();
  }

  public function cp() : Mat2 {
    var m = new Mat2();
    m[0] = this[0];
    m[1] = this[1];
    m[2] = this[2];
    m[3] = this[3];

    return cast m;
  }

  public function copy(m: Mat2) : Mat2 {
    this[0] = m[0];
    this[1] = m[1];
    this[2] = m[2];
    this[3] = m[3];

	return cast this;
  }

  public function ident() : Mat2 {
    this[0] = 1;
    this[1] = 0;
    this[2] = 0;
    this[3] = 1;

    return cast this;
  }

  public function transpose() : Mat2 {
    var a01 = this[1];

    this[1] = this[2];
    this[2] = a01;

    return cast this;
  }

  public function invert() : Mat2 {
    var a0 = this[0];
	var a1 = this[1];
	var a2 = this[2];
	var a3 = this[3];

	// Calculate the determinant
	var det = a0 * a3 - a2 * a1;

    if (det == 0) {
        return null;
    }
    det = 1.0 / det;

    this[0] = a3 * det;
    this[1] = -a1 * det;
    this[2] = -a2 * det;
    this[3] = a0 * det;

    return cast this;
  }

  public function adjugate() : Mat2 {
	var a0 = this[0];
    this[0] = this[3];
    this[1] = -this[1];
    this[2] = -this[2];
    this[3] = a0;

    return cast this;
  }

  public function determinant() : Float {
    return this[0] * this[3] - this[2] * this[1];
  }

  public function mul(b: Mat2) : Mat2 {
    var a0 = this[0]; var a1 = this[1]; var a2 = this[2]; var a3 = this[3];
    var b0 = b[0]; var b1 = b[1]; var b2 = b[2]; var b3 = b[3];

    this[0] = a0 * b0 + a1 * b2;
    this[1] = a0 * b1 + a1 * b3;
    this[2] = a2 * b0 + a3 * b2;
    this[3] = a2 * b1 + a3 * b3;

    return cast this;
  }

  public function rot(rad: Float) : Mat2 {
    var a0 = this[0]; var a1 = this[1]; var a2 = this[2]; var a3 = this[3];
    var s = Math.sin(rad);
    var c = Math.cos(rad);

    this[0] = a0 * c + a1 * s;
    this[1] = a0 * -s + a1 * c;
    this[2] = a2 * c + a3 * s;
    this[3] = a2 * -s + a3 * c;

    return cast this;
  }

  public function scale(v: Vec2) : Mat2 {
    var a0 = this[0]; var a1 = this[1]; var a2 = this[2]; var a3 = this[3];
    var v0 = v[0]; var v1 = v[1];

    this[0] = a0 * v0;
    this[1] = a1 * v1;
    this[2] = a2 * v0;
    this[3] = a3 * v1;

    return cast this;
  }

  @:op(A * B) static public inline function mulop(l: Mat2, r: Mat2) : Mat2 {
    return l.cp().mul(r);
  }

  @:arrayAccess public inline function arrayRead(i: Int) : Float {
    return this[i];
  }

  @:arrayAccess public inline function arrayWrite(i: Int, f: Float) : Float {
    return this[i] = f;
  }
}
