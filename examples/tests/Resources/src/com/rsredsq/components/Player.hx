package com.rsredsq.components;

import atomic.Atomic;

@:AtomicComponent
class Player extends JSComponent {
	
	var pos:Vector2;
	var speed:Float = 0.05;
	var time:Float;
	
	function start() {
		pos = node.position2D;
	}
	
	function update(time:Float) {
		this.time += time;
        onKeyDown();
		node.position2D = pos;
    }

    function onKeyDown():Void {
        if (Atomic.input.getKeyDown(Atomic.KEY_LEFT)) {
			//pos.x -= speed
			pos[0] -= speed;
        }
    }
	
}