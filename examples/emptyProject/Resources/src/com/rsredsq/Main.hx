package com.rsredsq;

import com.rsredsq.components.Star;

//Don't forget to add @:AtomicScript metadata before each script
//Scripts, that don't have an @:AtomicScript or @:AtomicComponent metadata will be automatically exported to modules folder
//Modules folder is mostly for haxe's classes and enums
@:AtomicScript
class Main {
    public static inline function main():Void {
        //We are using untyped here, because for now I haven't created a definitions for Atomic.player variable.
        untyped Atomic.player.loadScene("Scenes/Scene.scene");
    }
}
