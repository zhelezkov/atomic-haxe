package com.rsredsq.scripts;

import atomic.Atomic;

import com.rsredsq.components.Star;
import com.rsredsq.components.SuperStar;
import com.rsredsq.components.addit.MegaStar;
import com.rsredsq.components.Player;

@:AtomicScript
class Main {

	static inline function main() {
		untyped Atomic.player.loadScene("Scenes/Scene.scene");
	}

}
