package com.rsredsq.components;

import atomic.Atomic;

//Don't forget to add @:AtomicComponent metadata, otherwise compiler will output your files in modules folder
@:AtomicComponent
class Star extends JSComponent {

    //called after constructor, when component is ready to work
    public function start():Void {
        //trace is the same as console.log
        trace("Start function");
    }

    //called each frame
    public function update(time:Float):Void {

    }

}
