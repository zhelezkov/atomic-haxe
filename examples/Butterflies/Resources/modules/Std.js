var __extends = (this && this.__extends) || function (d, b) {for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];function __() { this.constructor = d; };__.prototype = b.prototype;d.prototype = new __();};
function $bind(n,u){if(null==u)return null;var e;return null==e&&(e=function(){return e.method.apply(e.scope,arguments)},e.scope=n,e.method=u),e};
var Std = (function(_super) {
__extends(Std, _super);
function Std (){};
Std.int = function(x) {
	return x | 0;
};
var inspectorFields = {
};
return Std;
})(Object);
module.exports = Std;
