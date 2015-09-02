package atomic.math;

abstract Quat(Array<Float>) {
  static var tmpVec3 = new Vec3();
  static var xUnitVec3 = Vec3.fromValues(1,0,0);
  static var yUnitVec3 = Vec3.fromValues(0,1,0);

  public function new() {
    this = new Array<Float>();
    this[3] = 1;
  }

  public function rotTo(a: Vec3, b: Vec3) : Quat {
    var dot = a.dot(b);
	var me: Quat = cast this;

    if (dot < -0.999999) {
        Quat.tmpVec3.copy(xUnitVec3).cross(a);

        if (Quat.tmpVec3.len() < 0.000001) {
          Quat.tmpVec3.copy(Quat.yUnitVec3).cross(a);
        }
        Quat.tmpVec3.norm();
        me.setAxisAngle(Quat.tmpVec3, Math.PI);
        return cast this;
    } else if (dot > 0.999999) {
        this[0] = 0;
        this[1] = 0;
        this[2] = 0;
        this[3] = 1;
        return cast this;
    } else {
        Quat.tmpVec3.copy(a).cross(b);
        this[0] = Quat.tmpVec3[0];
        this[1] = Quat.tmpVec3[1];
        this[2] = Quat.tmpVec3[2];
        this[3] = 1 + dot;
        return cast me.norm();
    }
  }

  public function copy(q: Quat) : Quat {
    this[0] = q[0];
    this[1] = q[1];
    this[2] = q[2];
    this[3] = q[3];
    return cast this;
  }

  public static function clone(q: Quat) : Quat {
    return q.cp();
  }

  public function cp() : Quat {
    var v = new Array<Float>();
    v[0] = this[0];
    v[1] = this[1];
    v[2] = this[2];
    v[3] = this[3];
    return cast v;
  }

  public static inline function fromValues(x: Float, y: Float, z: Float, w: Float) : Quat {
	  return cast Vec4.fromValues(x, y, z, w);
  }

  public function ident() : Quat {
    this[0] = 0;
    this[1] = 0;
    this[2] = 0;
    this[3] = 1;
    return cast this;
  }

  public function setAxisAngle(axis: Vec3, rad: Float) : Quat {
    rad = rad * 0.5;
    var s = Math.sin(rad);
    this[0] = s * axis[0];
    this[1] = s * axis[1];
    this[2] = s * axis[2];
    this[3] = Math.cos(rad);
    return cast this;
  }

  public function add(v: Quat) : Quat {
    this[0] += v[0];
    this[1] += v[1];
    this[2] += v[2];
    this[3] += v[3];
    return cast this;
  }

  public function mul(b: Quat) : Quat {
    var ax = this[0]; var ay = this[1]; var az = this[2]; var aw = this[3];
    var bx = b[0]; var by = b[1]; var bz = b[2]; var bw = b[3];

    this[0] = ax * bw + aw * bx + ay * bz - az * by;
    this[1] = ay * bw + aw * by + az * bx - ax * bz;
    this[2] = az * bw + aw * bz + ax * by - ay * bx;
    this[3] = aw * bw - ax * bx - ay * by - az * bz;
    return cast this;
  }

  public function scale(s: Float) : Vec4 {
    this[0] *= s;
    this[1] *= s;
    this[2] *= s;
    this[3] *= s;
    return cast this;
  }

  public function rotX(rad: Float) : Quat {
    rad *= 0.5;

    var ax = this[0]; var ay = this[1]; var az = this[2]; var aw = this[3];
    var bx = Math.sin(rad); var bw = Math.cos(rad);

    this[0] = ax * bw + aw * bx;
    this[1] = ay * bw + az * bx;
    this[2] = az * bw - ay * bx;
    this[3] = aw * bw - ax * bx;

    return cast this;
  }

  public function rotY(rad: Float) : Quat {
    rad *= 0.5;

    var ax = this[0]; var ay = this[1]; var az = this[2]; var aw = this[3];
    var by = Math.sin(rad); var bw = Math.cos(rad);

    this[0] = ax * bw - az * by;
    this[1] = ay * bw + aw * by;
    this[2] = az * bw + ax * by;
    this[3] = aw * bw - ay * by;
    return cast this;
  }

  public function rotZ(rad: Float) : Quat {
    rad *= 0.5;

    var ax = this[0]; var ay = this[1]; var az = this[2]; var aw = this[3];
    var bz = Math.sin(rad); var bw = Math.cos(rad);

    this[0] = ax * bw + ay * bz;
    this[1] = ay * bw - ax * bz;
    this[2] = az * bw + aw * bz;
    this[3] = aw * bw - az * bz;

    return cast this;
  }

  public function calcW() : Float {
	var x = this[0]; var y = this[1]; var z = this[2];
    return -Math.sqrt(Math.abs(1.0 - x * x - y * y - z * z));
  }

  public function dot(q: Quat) : Float {
    return this[0] * q[0] + this[1] * q[1] + this[2] * q[2] + this[3] * q[3];
  }

  public function lerp(b: Quat, t: Float) : Quat {
    var ax = this[0];
    var ay = this[1];
    var az = this[2];
    this[0] = ax + t * (b[0] - ax);
    this[1] = ay + t * (b[1] - ay);
    this[2] = az + t * (b[2] - az);
    return cast this;
  }

  public function slerp(b: Quat, t: Float) : Quat {
    var ax = this[0]; var ay = this[1]; var az = this[2]; var aw = this[3];
    var bx = b[0]; var by = b[1]; var bz = b[2]; var bw = b[3];

    var omega; var cosom; var sinom; var scale0; var scale1;

    // calc cosine
    cosom = ax * bx + ay * by + az * bz + aw * bw;
    // adjust signs (if necessary)
    if ( cosom < 0.0 ) {
        cosom = -cosom;
        bx = - bx;
        by = - by;
        bz = - bz;
        bw = - bw;
    }
    // calculate coefficients
    if ( (1.0 - cosom) > 0.000001 ) {
        // standard case (slerp)
        omega = Math.acos(cosom);
        sinom = Math.sin(omega);
        scale0 = Math.sin((1.0 - t) * omega) / sinom;
        scale1 = Math.sin(t * omega) / sinom;
    } else {
        // "from" and "to" quaternions are very close
        // ... so we can do a linear interpolation
        scale0 = 1.0 - t;
        scale1 = t;
    }
    // calculate final values
    this[0] = scale0 * ax + scale1 * bx;
    this[1] = scale0 * ay + scale1 * by;
    this[2] = scale0 * az + scale1 * bz;
    this[3] = scale0 * aw + scale1 * bw;

    return cast this;
  }

  public function invert() : Quat {
    var a0 = this[0]; var a1 = this[1]; var a2 = this[2]; var a3 = this[3];
    var dot = a0*a0 + a1*a1 + a2*a2 + a3*a3;
    var invDot = (dot != 0) ? 1.0/dot : 0;

    // TODO: Would be faster to return [0,0,0,0] immediately if dot == 0

    this[0] = -a0*invDot;
    this[1] = -a1*invDot;
    this[2] = -a2*invDot;
    this[3] = a3*invDot;
    return cast this;
  }

  public function conjugate() : Quat {
    this[0] = -this[0];
    this[1] = -this[1];
    this[2] = -this[2];
    return cast this;
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

  public function norm() : Quat {
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

  public function fromMat3(m: Mat3) : Quat {
    // Algorithm in Ken Shoemake's article in 1987 SIGGRAPH course notes
    // article "Quaternion Calculus and Fast Animation".
    var fTrace = m[0] + m[4] + m[8];
    var fRoot;

    if ( fTrace > 0.0 ) {
        // |w| > 1/2, may as well choose w > 1/2
        fRoot = Math.sqrt(fTrace + 1.0); // 2w
        this[3] = 0.5 * fRoot;
        fRoot = 0.5/fRoot; // 1/(4w)
        this[0] = (m[7]-m[5])*fRoot;
        this[1] = (m[2]-m[6])*fRoot;
        this[2] = (m[3]-m[1])*fRoot;
    } else {
        // |w| <= 1/2
        var i = 0;
        if ( m[4] > m[0] ) {
          i = 1;
		}
        if ( m[8] > m[i*3+i] ) {
          i = 2;
		}
        var j = (i+1)%3;
        var k = (i+2)%3;

        fRoot = Math.sqrt(m[i*3+i]-m[j*3+j]-m[k*3+k] + 1.0);
        this[i] = 0.5 * fRoot;
        fRoot = 0.5 / fRoot;
        this[3] = (m[k*3+j] - m[j*3+k]) * fRoot;
        this[j] = (m[j*3+i] + m[i*3+j]) * fRoot;
        this[k] = (m[k*3+i] + m[i*3+k]) * fRoot;
    }

    return cast this;
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
