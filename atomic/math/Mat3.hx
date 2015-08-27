package atomic.math;

abstract Mat3(Array<Float>) {
  public function new() {
    var m = new Array<Float>();
    m[0] = 0;
    m[1] = 0;
    m[2] = 0;
    m[3] = 0;
    m[4] = 0;
    m[5] = 0;
    m[6] = 0;
    m[7] = 0;
    m[8] = 0;

    this = m;
  }

  public static function clone(v: Mat3) : Mat3 {
    return v.cp();
  }

  public function cp() : Mat3 {
    var m = new Mat3();
    m[0] = this[0];
    m[1] = this[1];
    m[2] = this[2];
    m[3] = this[3];
    m[4] = this[4];
    m[5] = this[5];
    m[6] = this[6];
    m[7] = this[7];
    m[8] = this[8];

    return cast m;
  }

  public function copy(m: Mat3) : Mat3 {
    this[0] = m[0];
    this[1] = m[1];
    this[2] = m[2];
    this[3] = m[3];
    this[4] = m[4];
    this[5] = m[5];
    this[6] = m[6];
    this[7] = m[7];
    this[8] = m[8];

	return cast this;
  }


  public function fromMat4(m: Mat4) : Mat3 {
    this[0] = m[0];
    this[1] = m[1];
    this[2] = m[2];
    this[3] = m[3];
    this[4] = m[4];
    this[5] = m[5];
    this[6] = m[6];
    this[7] = m[7];
    this[8] = m[8];

	return cast this;
  }

  public function ident() : Mat3 {
    this[0] = 1;
    this[1] = 0;
    this[2] = 0;
    this[3] = 0;
    this[4] = 1;
    this[5] = 0;
    this[6] = 0;
    this[7] = 0;
    this[8] = 1;

    return cast this;
  }

  public function transpose() : Mat3 {
    var a01 = this[1];
    var a02 = this[2];
    var a12 = this[6];

    this[1] = this[3];
    this[2] = this[6];
    this[3] = a01;
    this[5] = this[7];
    this[6] = a02;
    this[7] = a12;

    return cast this;
  }

  public function invert() : Mat3 {
    var a00 = this[0]; var a01 = this[1]; var a02 = this[2];
    var a10 = this[3]; var a11 = this[4]; var a12 = this[5];
    var a20 = this[6]; var a21 = this[7]; var a22 = this[8];

    var b01 = a22 * a11 - a12 * a21;
    var b11 = -a22 * a10 + a12 * a20;
    var b21 = a21 * a10 - a11 * a20;

	// Calculate the determinant
	var det = a00 * b01 + a01 * b11 + a02 * b21;

    if (det == 0) {
        return null;
    }
    det = 1.0 / det;

    this[0] = b01 * det;
    this[1] = (-a22 * a01 + a02 * a21) * det;
    this[2] = (a12 * a01 - a02 * a11) * det;
    this[3] = b11 * det;
    this[4] = (a22 * a00 - a02 * a20) * det;
    this[5] = (-a12 * a00 + a02 * a10) * det;
    this[6] = b21 * det;
    this[7] = (-a21 * a00 + a01 * a20) * det;
    this[8] = (a11 * a00 - a01 * a10) * det;

    return cast this;
  }

  public function adjugate() : Mat3 {
    var a00 = this[0]; var a01 = this[1]; var a02 = this[2];
    var a10 = this[3]; var a11 = this[4]; var a12 = this[5];
    var a20 = this[6]; var a21 = this[7]; var a22 = this[8];

    this[0] = (a11 * a22 - a12 * a21);
    this[1] = (a02 * a21 - a01 * a22);
    this[2] = (a01 * a12 - a02 * a11);
    this[3] = (a12 * a20 - a10 * a22);
    this[4] = (a00 * a22 - a02 * a20);
    this[5] = (a02 * a10 - a00 * a12);
    this[6] = (a10 * a21 - a11 * a20);
    this[7] = (a01 * a20 - a00 * a21);
    this[8] = (a00 * a11 - a01 * a10);

    return cast this;
  }

  public function determinant() : Float {
    var a00 = this[0]; var a01 = this[1]; var a02 = this[2];
    var a10 = this[3]; var a11 = this[4]; var a12 = this[5];
    var a20 = this[6]; var a21 = this[7]; var a22 = this[8];

    return a00 * (a22 * a11 - a12 * a21) + a01 * (-a22 * a10 + a12 * a20) + a02 * (a21 * a10 - a11 * a20);
  }

  public function mul(b: Mat3) : Mat3 {
    var a00 = this[0]; var a01 = this[1]; var a02 = this[2];
    var a10 = this[3]; var a11 = this[4]; var a12 = this[5];
    var a20 = this[6]; var a21 = this[7]; var a22 = this[8];

    var b00 = b[0]; var b01 = b[1]; var b02 = b[2];
    var b10 = b[3]; var b11 = b[4]; var b12 = b[5];
    var b20 = b[6]; var b21 = b[7]; var b22 = b[8];

    this[0] = b00 * a00 + b01 * a10 + b02 * a20;
    this[1] = b00 * a01 + b01 * a11 + b02 * a21;
    this[2] = b00 * a02 + b01 * a12 + b02 * a22;

    this[3] = b10 * a00 + b11 * a10 + b12 * a20;
    this[4] = b10 * a01 + b11 * a11 + b12 * a21;
    this[5] = b10 * a02 + b11 * a12 + b12 * a22;

    this[6] = b20 * a00 + b21 * a10 + b22 * a20;
    this[7] = b20 * a01 + b21 * a11 + b22 * a21;
    this[8] = b20 * a02 + b21 * a12 + b22 * a22;

    return cast this;
  }

  public function trans(v: Vec2) : Mat3 {
    var a00 = this[0]; var a01 = this[1]; var a02 = this[2];
    var a10 = this[3]; var a11 = this[4]; var a12 = this[5];
    var a20 = this[6]; var a21 = this[7]; var a22 = this[8];
    var x = v[0]; var y = v[1];

    this[0] = a00;
    this[1] = a01;
    this[2] = a02;

    this[3] = a10;
    this[4] = a11;
    this[5] = a12;

    this[6] = x * a00 + y * a10 + a20;
    this[7] = x * a01 + y * a11 + a21;
    this[8] = x * a02 + y * a12 + a22;

	return cast this;
  }

  public function rot(rad: Float) : Mat3 {
    var a00 = this[0]; var a01 = this[1]; var a02 = this[2];
    var a10 = this[3]; var a11 = this[4]; var a12 = this[5];
    var a20 = this[6]; var a21 = this[7]; var a22 = this[8];

    var s = Math.sin(rad);
    var c = Math.cos(rad);

    this[0] = c * a00 + s * a10;
    this[1] = c * a01 + s * a11;
    this[2] = c * a02 + s * a12;

    this[3] = c * a10 - s * a00;
    this[4] = c * a11 - s * a01;
    this[5] = c * a12 - s * a02;

    this[6] = a20;
    this[7] = a21;
    this[8] = a22;

    return cast this;
  }

  public function scale(v: Vec3) : Mat4 {
    var x = v[0];
    var y = v[1];

    this[0]  *= x;
    this[1]  *= x;
    this[2]  *= x;
    this[3]  *= y;
    this[4]  *= y;
    this[5]  *= y;

    return cast this;
  }

  public function fromMat2d(m: Mat2d) : Mat3 {
    this[0] = m[0];
    this[1] = m[1];
    this[2] = 0;

    this[3] = m[2];
    this[4] = m[3];
    this[5] = 0;

    this[6] = m[4];
    this[7] = m[5];
    this[8] = 1;

    return cast this;
  }

  public function fromQuat(q: Quat) : Mat3 {
    var x = q[0]; var y = q[1]; var z = q[2]; var w = q[3];
    var x2 = x + x;
    var y2 = y + y;
    var z2 = z + z;

    var xx = x * x2;
    var xy = x * y2;
    var xz = x * z2;
    var yy = y * y2;
    var yz = y * z2;
    var zz = z * z2;
    var wx = w * x2;
    var wy = w * y2;
    var wz = w * z2;

    this[0] = 1 - (yy + zz);
    this[3] = xy + wz;
    this[6] = xz - wy;

    this[1] = xy - wz;
    this[4] = 1 - (xx + zz);
    this[7] = yz + wx;

    this[2] = xz + wy;
    this[5] = yz - wx;
    this[8] = 1 - (xx + yy);

	return cast this;
  }

  public function normalFromMat4(a: Mat4) : Mat3 {
    var a00 = a[0]; var a01 = a[1]; var a02 = a[2]; var a03 = a[3];
    var a10 = a[4]; var a11 = a[5]; var a12 = a[6]; var a13 = a[7];
    var a20 = a[8]; var a21 = a[9]; var a22 = a[10]; var a23 = a[11];
    var a30 = a[12]; var a31 = a[13]; var a32 = a[14]; var a33 = a[15];

    var b00 = a00 * a11 - a01 * a10;
    var b01 = a00 * a12 - a02 * a10;
    var b02 = a00 * a13 - a03 * a10;
    var b03 = a01 * a12 - a02 * a11;
    var b04 = a01 * a13 - a03 * a11;
    var b05 = a02 * a13 - a03 * a12;
    var b06 = a20 * a31 - a21 * a30;
    var b07 = a20 * a32 - a22 * a30;
    var b08 = a20 * a33 - a23 * a30;
    var b09 = a21 * a32 - a22 * a31;
    var b10 = a21 * a33 - a23 * a31;
    var b11 = a22 * a33 - a23 * a32;

	// Calculate the determinant
	var det = b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;

    if (det == 0) {
        return null;
    }
    det = 1.0 / det;

    this[0] = (a11 * b11 - a12 * b10 + a13 * b09) * det;
    this[1] = (a12 * b08 - a10 * b11 - a13 * b07) * det;
    this[2] = (a10 * b10 - a11 * b08 + a13 * b06) * det;

    this[3] = (a02 * b10 - a01 * b11 - a03 * b09) * det;
    this[4] = (a00 * b11 - a02 * b08 + a03 * b07) * det;
    this[5] = (a01 * b08 - a00 * b10 - a03 * b06) * det;

    this[6] = (a31 * b05 - a32 * b04 + a33 * b03) * det;
    this[7] = (a32 * b02 - a30 * b05 - a33 * b01) * det;
    this[8] = (a30 * b04 - a31 * b02 + a33 * b00) * det;

    return cast this;
  }

  @:op(A * B) static public inline function mulop(l: Mat3, r: Mat3) : Mat3 {
    return l.cp().mul(r);
  }

  @:arrayAccess public inline function arrayRead(i: Int) : Float {
    return this[i];
  }

  @:arrayAccess public inline function arrayWrite(i: Int, f: Float) : Float {
    return this[i] = f;
  }
}
