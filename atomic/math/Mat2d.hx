package atomic.math;

abstract Mat2d(Array<Float>) {
  public function new() {
    var m = new Array<Float>();
    m[0] = 0;
    m[1] = 0;
    m[2] = 0;
    m[3] = 0;
    m[4] = 0;
    m[5] = 0;

    this = m;
  }

  public static function clone(m: Mat2d) : Mat2d {
    return m.cp();
  }

  public function cp() : Mat2d {
    var m = new Mat2d();
    m[0] = this[0];
    m[1] = this[1];
    m[2] = this[2];
    m[3] = this[3];
    m[4] = this[4];
    m[5] = this[5];

    return cast m;
  }

  public function copy(m: Mat2d) : Mat2d {
    this[0] = m[0];
    this[1] = m[1];
    this[2] = m[2];
    this[3] = m[3];
    this[4] = m[4];
    this[5] = m[5];

	return cast this;
  }

  public function ident() : Mat2d {
    this[0] = 1;
    this[1] = 0;
    this[2] = 0;
    this[3] = 0;
    this[4] = 1;
    this[5] = 0;

    return cast this;
  }

  public function invert() : Mat2d {
    var aa = this[0]; var ab = this[1]; var ac = this[2]; var ad = this[3];
    var atx = this[4]; var aty = this[5];

    var det = aa * ad - ab * ac;
    if(det == 0){
        return null;
    }
    det = 1.0 / det;

    this[0] = ad * det;
    this[1] = -ab * det;
    this[2] = -ac * det;
    this[3] = aa * det;
    this[4] = (ac * aty - ad * atx) * det;
    this[5] = (ab * atx - aa * aty) * det;

    return cast this;
  }

  public function determinant() : Float {
    return this[0] * this[3] - this[1] * this[2];
  }

  public function mul(b: Mat2d) : Mat2d {
    var aa  = this[0]; var ab  = this[1]; var ac = this[2]; var ad = this[3];
    var atx = this[4]; var aty = this[5];
    var ba  = b[0]; var bb  = b[1]; var bc = b[2]; var bd = b[3];
    var btx = b[4]; var bty = b[5];

    this[0] = aa*ba + ab*bc;
    this[1] = aa*bb + ab*bd;
    this[2] = ac*ba + ad*bc;
    this[3] = ac*bb + ad*bd;
    this[4] = ba*atx + bc*aty + btx;
    this[5] = bb*atx + bd*aty + bty;

    return cast this;
  }

  public function rot(rad: Float) : Mat2d {
    var aa = this[0];
    var ab = this[1];
    var ac = this[2];
    var ad = this[3];
    var atx = this[4];
    var aty = this[5];
    var st = Math.sin(rad);
    var ct = Math.cos(rad);

    this[0] = aa*ct + ab*st;
    this[1] = -aa*st + ab*ct;
    this[2] = ac*ct + ad*st;
    this[3] = -ac*st + ct*ad;
    this[4] = ct*atx + st*aty;
    this[5] = ct*aty - st*atx;

    return cast this;
  }

  public function scale(v: Vec2) : Mat2d {
    var vx = v[0]; var vy = v[1];
    this[0] *= vx;
    this[1] *= vy;
    this[2] *= vx;
    this[3] *= vy;
    this[4] *= vx;
    this[5] *= vy;

    return cast this;
  }

  public function trans(v: Vec2) : Mat2d {
    this[4] += v[0];
    this[5] += v[1];
    return cast this;
  }

  @:op(A * B) static public inline function mulop(l: Mat2d, r: Mat2d) : Mat2d {
    return l.cp().mul(r);
  }

  @:arrayAccess public inline function arrayRead(i: Int) : Float {
    return this[i];
  }

  @:arrayAccess public inline function arrayWrite(i: Int, f: Float) : Float {
    return this[i] = f;
  }
}
