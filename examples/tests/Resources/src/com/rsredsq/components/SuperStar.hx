package com.rsredsq.components;

import com.rsredsq.components.Star;

@:AtomicComponent
class SuperStar extends Star {
	
	function new(a:Int) {
		super();
		trace(a);
	}
	
	override function start():Void {
		node.scale2D = [2, 2];
	}
	
}