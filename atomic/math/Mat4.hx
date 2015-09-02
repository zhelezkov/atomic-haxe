package atomic.math;

abstract Mat4(Array<Float>) {

  static inline var EPSILON = 0.000001;

  public function new() {
    var v = new Array<Float>();
    v[0] = 0;
    v[1] = 0;
    v[2] = 0;
    v[3] = 0;
    v[4] = 0;
    v[5] = 0;
    v[6] = 0;
    v[7] = 0;
    v[8] = 0;
    v[9] = 0;
    v[10] = 0;
    v[11] = 0;
    v[12] = 0;
    v[13] = 0;
    v[14] = 0;
    v[15] = 0;
    this = v;
  }

  public static function newIdent() : Mat4 {
    var v = new Array<Float>();

    v[0] = 1;
    v[1] = 0;
    v[2] = 0;
    v[3] = 0;
    v[4] = 0;
    v[5] = 1;
    v[6] = 0;
    v[7] = 0;
    v[8] = 0;
    v[9] = 0;
    v[10] = 1;
    v[11] = 0;
    v[12] = 0;
    v[13] = 0;
    v[14] = 0;
    v[15] = 1;

    return cast v;
  }

  public static function clone(m: Mat4) : Mat4 {
    return m.cp();
  }

  public function copy(m: Mat4) : Mat4 {
    this[0] = m[0];
    this[1] = m[1];
    this[2] = m[2];
    this[3] = m[3];
    this[4] = m[4];
    this[5] = m[5];
    this[6] = m[6];
    this[7] = m[7];
    this[8] = m[8];
    this[9] = m[9];
    this[10] = m[10];
    this[11] = m[11];
    this[12] = m[12];
    this[13] = m[13];
    this[14] = m[14];
    this[15] = m[15];

	return cast this;
  }

  public function cp() : Mat4 {
    var v = new Mat4();
    v[0] = this[0];
    v[1] = this[1];
    v[2] = this[2];
    v[3] = this[3];
    v[4] = this[4];
    v[5] = this[5];
    v[6] = this[6];
    v[7] = this[7];
    v[8] = this[8];
    v[9] = this[9];
    v[10] = this[10];
    v[11] = this[11];
    v[12] = this[12];
    v[13] = this[13];
    v[14] = this[14];
    v[15] = this[15];

    return cast v;
  }

  public function ident() : Mat4 {
    this[0] = 1;
    this[1] = 0;
    this[2] = 0;
    this[3] = 0;
    this[4] = 0;
    this[5] = 1;
    this[6] = 0;
    this[7] = 0;
    this[8] = 0;
    this[9] = 0;
    this[10] = 1;
    this[11] = 0;
    this[12] = 0;
    this[13] = 0;
    this[14] = 0;
    this[15] = 1;

    return cast this;
  }

  public function transpose() : Mat4 {
    var a01 = this[1];
    var a02 = this[2];
    var a03 = this[3];
    var a12 = this[6];
    var a13 = this[7];
    var a23 = this[11];

    this[1] =  this[4];
    this[2] =  this[8];
    this[3] =  this[12];
    this[4] =  a01;
    this[6] =  this[9];
    this[7] =  this[13];
    this[8] =  a02;
    this[9] =  a12;
    this[11] = this[14];
    this[12] = a03;
    this[13] = a13;
    this[14] = a23;

    return cast this;
  }

  public function invert() : Mat4 {
    var a00 = this[0];  var a01 = this[1];  var a02 = this[2];  var a03 = this[3];
    var a10 = this[4];  var a11 = this[5];  var a12 = this[6];  var a13 = this[7];
    var a20 = this[8];  var a21 = this[9];  var a22 = this[10]; var a23 = this[11];
    var a30 = this[12]; var a31 = this[13]; var a32 = this[14]; var a33 = this[15];

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

    if (det == 0.0000) {
        return null;
    }
    det = 1.0 / det;

    this[0] =  (a11 * b11 - a12 * b10 + a13 * b09) * det;
    this[1] =  (a02 * b10 - a01 * b11 - a03 * b09) * det;
    this[2] =  (a31 * b05 - a32 * b04 + a33 * b03) * det;
    this[3] =  (a22 * b04 - a21 * b05 - a23 * b03) * det;
    this[4] =  (a12 * b08 - a10 * b11 - a13 * b07) * det;
    this[5] =  (a00 * b11 - a02 * b08 + a03 * b07) * det;
    this[6] =  (a32 * b02 - a30 * b05 - a33 * b01) * det;
    this[7] =  (a20 * b05 - a22 * b02 + a23 * b01) * det;
    this[8] =  (a10 * b10 - a11 * b08 + a13 * b06) * det;
    this[9] =  (a01 * b08 - a00 * b10 - a03 * b06) * det;
    this[10] = (a30 * b04 - a31 * b02 + a33 * b00) * det;
    this[11] = (a21 * b02 - a20 * b04 - a23 * b00) * det;
    this[12] = (a11 * b07 - a10 * b09 - a12 * b06) * det;
    this[13] = (a00 * b09 - a01 * b07 + a02 * b06) * det;
    this[14] = (a31 * b01 - a30 * b03 - a32 * b00) * det;
    this[15] = (a20 * b03 - a21 * b01 + a22 * b00) * det;

    return cast this;
  }

  public function adjugate() : Mat4 {
    var a00 = this[0];  var a01 = this[1];  var a02 = this[2];  var a03 = this[3];
    var a10 = this[4];  var a11 = this[5];  var a12 = this[6];  var a13 = this[7];
    var a20 = this[8];  var a21 = this[9];  var a22 = this[10]; var a23 = this[11];
    var a30 = this[12]; var a31 = this[13]; var a32 = this[14]; var a33 = this[15];

    this[0]  =  (a11 * (a22 * a33 - a23 * a32) - a21 * (a12 * a33 - a13 * a32) + a31 * (a12 * a23 - a13 * a22));
    this[1]  = -(a01 * (a22 * a33 - a23 * a32) - a21 * (a02 * a33 - a03 * a32) + a31 * (a02 * a23 - a03 * a22));
    this[2]  =  (a01 * (a12 * a33 - a13 * a32) - a11 * (a02 * a33 - a03 * a32) + a31 * (a02 * a13 - a03 * a12));
    this[3]  = -(a01 * (a12 * a23 - a13 * a22) - a11 * (a02 * a23 - a03 * a22) + a21 * (a02 * a13 - a03 * a12));
    this[4]  = -(a10 * (a22 * a33 - a23 * a32) - a20 * (a12 * a33 - a13 * a32) + a30 * (a12 * a23 - a13 * a22));
    this[5]  =  (a00 * (a22 * a33 - a23 * a32) - a20 * (a02 * a33 - a03 * a32) + a30 * (a02 * a23 - a03 * a22));
    this[6]  = -(a00 * (a12 * a33 - a13 * a32) - a10 * (a02 * a33 - a03 * a32) + a30 * (a02 * a13 - a03 * a12));
    this[7]  =  (a00 * (a12 * a23 - a13 * a22) - a10 * (a02 * a23 - a03 * a22) + a20 * (a02 * a13 - a03 * a12));
    this[8]  =  (a10 * (a21 * a33 - a23 * a31) - a20 * (a11 * a33 - a13 * a31) + a30 * (a11 * a23 - a13 * a21));
    this[9]  = -(a00 * (a21 * a33 - a23 * a31) - a20 * (a01 * a33 - a03 * a31) + a30 * (a01 * a23 - a03 * a21));
    this[10] =  (a00 * (a11 * a33 - a13 * a31) - a10 * (a01 * a33 - a03 * a31) + a30 * (a01 * a13 - a03 * a11));
    this[11] = -(a00 * (a11 * a23 - a13 * a21) - a10 * (a01 * a23 - a03 * a21) + a20 * (a01 * a13 - a03 * a11));
    this[12] = -(a10 * (a21 * a32 - a22 * a31) - a20 * (a11 * a32 - a12 * a31) + a30 * (a11 * a22 - a12 * a21));
    this[13] =  (a00 * (a21 * a32 - a22 * a31) - a20 * (a01 * a32 - a02 * a31) + a30 * (a01 * a22 - a02 * a21));
    this[14] = -(a00 * (a11 * a32 - a12 * a31) - a10 * (a01 * a32 - a02 * a31) + a30 * (a01 * a12 - a02 * a11));
    this[15] =  (a00 * (a11 * a22 - a12 * a21) - a10 * (a01 * a22 - a02 * a21) + a20 * (a01 * a12 - a02 * a11));

    return cast this;
  }

  public function determinant() : Float {
    var a00 = this[0];  var a01 = this[1];  var a02 = this[2];  var a03 = this[3];
    var a10 = this[4];  var a11 = this[5];  var a12 = this[6];  var a13 = this[7];
    var a20 = this[8];  var a21 = this[9];  var a22 = this[10]; var a23 = this[11];
    var a30 = this[12]; var a31 = this[13]; var a32 = this[14]; var a33 = this[15];

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
    return b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;
  }

  public function mul(b: Mat4) : Mat4 {
    var a00 = this[0];  var a01 = this[1];  var a02 = this[2];  var a03 = this[3];
    var a10 = this[4];  var a11 = this[5];  var a12 = this[6];  var a13 = this[7];
    var a20 = this[8];  var a21 = this[9];  var a22 = this[10]; var a23 = this[11];
    var a30 = this[12]; var a31 = this[13]; var a32 = this[14]; var a33 = this[15];

    // Cache only the current line of the second matrix
    var b0  = b[0], b1 = b[1], b2 = b[2], b3 = b[3];
    this[0] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
    this[1] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
    this[2] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
    this[3] = b0*a03 + b1*a13 + b2*a23 + b3*a33;

    b0 = b[4]; b1 = b[5]; b2 = b[6]; b3 = b[7];
    this[4] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
    this[5] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
    this[6] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
    this[7] = b0*a03 + b1*a13 + b2*a23 + b3*a33;

    b0 = b[8]; b1 = b[9]; b2 = b[10]; b3 = b[11];
    this[8] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
    this[9] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
    this[10] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
    this[11] = b0*a03 + b1*a13 + b2*a23 + b3*a33;

    b0 = b[12]; b1 = b[13]; b2 = b[14]; b3 = b[15];
    this[12] = b0*a00 + b1*a10 + b2*a20 + b3*a30;
    this[13] = b0*a01 + b1*a11 + b2*a21 + b3*a31;
    this[14] = b0*a02 + b1*a12 + b2*a22 + b3*a32;
    this[15] = b0*a03 + b1*a13 + b2*a23 + b3*a33;
    return cast this;
  }

  public function trans(v: Vec3) : Mat4 {
    var x = v[0];
    var y = v[1];
    var z = v[2];

    this[12] = this[0] * x + this[4] * y + this[8] * z +  this[12];
    this[13] = this[1] * x + this[5] * y + this[9] * z +  this[13];
    this[14] = this[2] * x + this[6] * y + this[10] * z + this[14];
    this[15] = this[3] * x + this[7] * y + this[11] * z + this[15];

    return cast this;
  }

  public function scale(v: Vec3) : Mat4 {
    var x = v[0];
    var y = v[1];
    var z = v[2];

    this[0]  *= x;
    this[1]  *= x;
    this[2]  *= x;
    this[3]  *= x;
    this[4]  *= y;
    this[5]  *= y;
    this[6]  *= y;
    this[7]  *= y;
    this[8]  *= z;
    this[9]  *= z;
    this[10] *= z;
    this[11] *= z;
    return cast this;
  }

  public function rot(rad: Float, axis: Vec3) : Mat4 {
    var x = axis[0];
    var y = axis[1];
    var z = axis[2];
    var len = Math.sqrt(x * x + y * y + z * z);

    if (Math.abs(len) < Mat4.EPSILON) {
      return null;
    }

    var len = 1 / len;
    x *= len;
    y *= len;
    z *= len;

    var s = Math.sin(rad);
    var c = Math.cos(rad);
    var t = 1 - c;

    var a00 = this[0]; var a01 = this[1]; var a02 = this[2];  var a03 = this[3];
    var a10 = this[4]; var a11 = this[5]; var a12 = this[6];  var a13 = this[7];
    var a20 = this[8]; var a21 = this[9]; var a22 = this[10]; var a23 = this[11];

    // Construct the elements of the rotation matrix
    var b00 = x * x * t + c;     var b01 = y * x * t + z * s; var b02 = z * x * t - y * s;
    var b10 = x * y * t - z * s; var b11 = y * y * t + c;     var b12 = z * y * t + x * s;
    var b20 = x * z * t + y * s; var b21 = y * z * t - x * s; var b22 = z * z * t + c;

    // Perform rotation-specific matrix multiplication
    this[0] = a00 * b00 + a10 * b01 + a20 * b02;
    this[1] = a01 * b00 + a11 * b01 + a21 * b02;
    this[2] = a02 * b00 + a12 * b01 + a22 * b02;
    this[3] = a03 * b00 + a13 * b01 + a23 * b02;
    this[4] = a00 * b10 + a10 * b11 + a20 * b12;
    this[5] = a01 * b10 + a11 * b11 + a21 * b12;
    this[6] = a02 * b10 + a12 * b11 + a22 * b12;
    this[7] = a03 * b10 + a13 * b11 + a23 * b12;
    this[8] = a00 * b20 + a10 * b21 + a20 * b22;
    this[9] = a01 * b20 + a11 * b21 + a21 * b22;
    this[10] = a02 * b20 + a12 * b21 + a22 * b22;
    this[11] = a03 * b20 + a13 * b21 + a23 * b22;

    return cast this;
  }

  public function rotX(rad: Float) : Mat4 {
    var s = Math.sin(rad);
    var c = Math.cos(rad);
    var a10 = this[4];
    var a11 = this[5];
    var a12 = this[6];
    var a13 = this[7];
    var a20 = this[8];
    var a21 = this[9];
    var a22 = this[10];
    var a23 = this[11];

    // Perform axis-specific matrix multiplication
    this[4] = a10 * c + a20 * s;
    this[5] = a11 * c + a21 * s;
    this[6] = a12 * c + a22 * s;
    this[7] = a13 * c + a23 * s;
    this[8] = a20 * c - a10 * s;
    this[9] = a21 * c - a11 * s;
    this[10] = a22 * c - a12 * s;
    this[11] = a23 * c - a13 * s;

    return cast this;
  }

  public function rotY(rad: Float) : Mat4 {
    var s = Math.sin(rad);
    var c = Math.cos(rad);
    var a00 = this[0];
    var a01 = this[1];
    var a02 = this[2];
    var a03 = this[3];
    var a20 = this[8];
    var a21 = this[9];
    var a22 = this[10];
    var a23 = this[11];

    // Perform axis-specific matrix multiplication
    this[0] = a00 * c - a20 * s;
    this[1] = a01 * c - a21 * s;
    this[2] = a02 * c - a22 * s;
    this[3] = a03 * c - a23 * s;
    this[8] = a00 * s + a20 * c;
    this[9] = a01 * s + a21 * c;
    this[10] = a02 * s + a22 * c;
    this[11] = a03 * s + a23 * c;

    return cast this;
  }

  public function rotZ(rad: Float) : Mat4 {
    var s = Math.sin(rad);
    var c = Math.cos(rad);
    var a00 = this[0];
    var a01 = this[1];
    var a02 = this[2];
    var a03 = this[3];
    var a10 = this[4];
    var a11 = this[5];
    var a12 = this[6];
    var a13 = this[7];

    // Perform axis-specific matrix multiplication
    this[0] = a00 * c + a10 * s;
    this[1] = a01 * c + a11 * s;
    this[2] = a02 * c + a12 * s;
    this[3] = a03 * c + a13 * s;
    this[4] = a10 * c - a00 * s;
    this[5] = a11 * c - a01 * s;
    this[6] = a12 * c - a02 * s;
    this[7] = a13 * c - a03 * s;

    return cast this;
  }

  public function fromRotTrans(q: Quat, v: Vec3) : Mat4 {
    // Quaternion math
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
    this[1] = xy + wz;
    this[2] = xz - wy;
    this[3] = 0;
    this[4] = xy - wz;
    this[5] = 1 - (xx + zz);
    this[6] = yz + wx;
    this[7] = 0;
    this[8] = xz + wy;
    this[9] = yz - wx;
    this[10] = 1 - (xx + yy);
    this[11] = 0;
    this[12] = v[0];
    this[13] = v[1];
    this[14] = v[2];
    this[15] = 1;

    return cast this;
  }

  public function fromQuat(q: Quat) : Mat4 {
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
    this[1] = xy + wz;
    this[2] = xz - wy;
    this[3] = 0;

    this[4] = xy - wz;
    this[5] = 1 - (xx + zz);
    this[6] = yz + wx;
    this[7] = 0;

    this[8] = xz + wy;
    this[9] = yz - wx;
    this[10] = 1 - (xx + yy);
    this[11] = 0;

    this[12] = 0;
    this[13] = 0;
    this[14] = 0;
    this[15] = 1;

	return cast this;
  }

  public function frustrum(left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) : Mat4 {
    var rl = 1 / (right - left);
    var tb = 1 / (top - bottom);
    var nf = 1 / (near - far);

    this[0] = (near * 2) * rl;
    this[1] = 0;
    this[2] = 0;
    this[3] = 0;
    this[4] = 0;
    this[5] = (near * 2) * tb;
    this[6] = 0;
    this[7] = 0;
    this[8] = (right + left) * rl;
    this[9] = (top + bottom) * tb;
    this[10] = (far + near) * nf;
    this[11] = -1;
    this[12] = 0;
    this[13] = 0;
    this[14] = (far * near * 2) * nf;
    this[15] = 0;

    return cast this;
  }

  public function perspective(fovy: Float, aspect: Float, near: Float, far: Float) : Mat4 {
    var f = 1.0 / Math.tan(fovy / 2);
    var nf = 1 / (near - far);

    this[0] = f / aspect;
    this[1] = 0;
    this[2] = 0;
    this[3] = 0;
    this[4] = 0;
    this[5] = f;
    this[6] = 0;
    this[7] = 0;
    this[8] = 0;
    this[9] = 0;
    this[10] = (far + near) * nf;
    this[11] = -1;
    this[12] = 0;
    this[13] = 0;
    this[14] = (2 * far * near) * nf;
    this[15] = 0;
    return cast this;
  }

  public function ortho(left: Float, right: Float, bottom: Float, top: Float, near: Float, far: Float) : Mat4 {
    var lr = 1 / (left - right);
    var bt = 1 / (bottom - top);
    var nf = 1 / (near - far);

    this[0] = -2 * lr;
    this[1] = 0;
    this[2] = 0;
    this[3] = 0;
    this[4] = 0;
    this[5] = -2 * bt;
    this[6] = 0;
    this[7] = 0;
    this[8] = 0;
    this[9] = 0;
    this[10] = 2 * nf;
    this[11] = 0;
    this[12] = (left + right) * lr;
    this[13] = (top + bottom) * bt;
    this[14] = (far + near) * nf;
    this[15] = 1;

    return cast this;
  }

  public function lookAt(eye: Vec3, center: Vec3, up: Vec3) : Mat4 {
    var x0; var x1; var x2; var y0; var y1; var y2; var z0; var z1; var z2;
    var len;
    var eyex = eye[0];
    var eyey = eye[1];
    var eyez = eye[2];
    var upx = up[0];
    var upy = up[1];
    var upz = up[2];
    var centerx = center[0];
    var centery = center[1];
    var centerz = center[2];

    if (Math.abs(eyex - centerx) < Mat4.EPSILON &&
        Math.abs(eyey - centery) < Mat4.EPSILON &&
        Math.abs(eyez - centerz) < Mat4.EPSILON) {
        return new Mat4().ident();
    }

    z0 = eyex - centerx;
    z1 = eyey - centery;
    z2 = eyez - centerz;

    len = 1 / Math.sqrt(z0 * z0 + z1 * z1 + z2 * z2);
    z0 *= len;
    z1 *= len;
    z2 *= len;

    x0 = upy * z2 - upz * z1;
    x1 = upz * z0 - upx * z2;
    x2 = upx * z1 - upy * z0;
    len = Math.sqrt(x0 * x0 + x1 * x1 + x2 * x2);
    if (len == Math.NaN) {
        x0 = 0;
        x1 = 0;
        x2 = 0;
    } else {
        len = 1 / len;
        x0 *= len;
        x1 *= len;
        x2 *= len;
    }

    y0 = z1 * x2 - z2 * x1;
    y1 = z2 * x0 - z0 * x2;
    y2 = z0 * x1 - z1 * x0;

    len = Math.sqrt(y0 * y0 + y1 * y1 + y2 * y2);
    if (len == Math.NaN) {
        y0 = 0;
        y1 = 0;
        y2 = 0;
    } else {
        len = 1 / len;
        y0 *= len;
        y1 *= len;
        y2 *= len;
    }

    this[0] = x0;
    this[1] = y0;
    this[2] = z0;
    this[3] = 0;
    this[4] = x1;
    this[5] = y1;
    this[6] = z1;
    this[7] = 0;
    this[8] = x2;
    this[9] = y2;
    this[10] = z2;
    this[11] = 0;
    this[12] = -(x0 * eyex + x1 * eyey + x2 * eyez);
    this[13] = -(y0 * eyex + y1 * eyey + y2 * eyez);
    this[14] = -(z0 * eyex + z1 * eyey + z2 * eyez);
    this[15] = 1;

    return cast this;
  }

  @:op(A * B) static public inline function mulop(l: Mat4, r: Mat4) : Mat4 {
    return l.cp().mul(r);
  }

  @:arrayAccess public inline function arrayRead(i: Int) : Float {
    return this[i];
  }

  @:arrayAccess public inline function arrayWrite(i: Int, f: Float) : Float {
    return this[i] = f;
  }
}
