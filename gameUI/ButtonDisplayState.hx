package gameUI;

import flash.display.DisplayObject;
import flash.display.Shape;

class ButtonDisplayState extends Shape {
    private var bgColor:UInt;
    private var border:Bool;
    private var displayWidth:UInt;
    private var displayHeight:UInt;

    public function new(bgColor:UInt, width:UInt, height:UInt, ?border:Bool) {
        super();
        this.bgColor = bgColor;
        this.border = border;
        this.displayWidth    = width;
        this.displayHeight    = height;
        draw();
    }

    private function draw():Void {
        if(border){
            graphics.lineStyle(2,0xFFFF00);

        }
        graphics.beginFill(bgColor);
        graphics.drawRect(0, 0, displayWidth, displayHeight);
        graphics.endFill();
    }
}