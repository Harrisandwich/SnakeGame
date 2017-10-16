import flash.display.BitmapData;
import flash.display.Sprite;
import flash.Lib;
import flash.display.Shape;
import flash.events.KeyboardEvent;
import flash.events.Event;
import inputUtilities.Input;

class Main extends Sprite {

    private var input:Input;
    private var shape:Shape;
    private var keyPressed:Bool;
    private var inited:Bool;

    function init() 
    {
        shape = new Shape();
       // create a center aligned rounded gray square
        shape.graphics.beginFill(0x333333);
        shape.graphics.drawRoundRect(0, 0, 100, 100, 10);
        shape.x = (stage.stageWidth - 100) / 2;
        shape.y = (stage.stageHeight - 100) / 2;
        stage.addChild(shape);
        

        Input.setAction('right_arrow', moveShapeRight);
        Input.setAction('left_arrow', moveShapeLeft);
        Input.setAction('up_arrow', moveShapeUp);
        Input.setAction('down_arrow', moveShapeDown);
        // Game loop
        stage.addEventListener(Event.ENTER_FRAME, everyFrame);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, Input.keyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, Input.keyUp);
    }

    function moveShapeRight():Void{
        shape.x += 1;
    }
    function moveShapeLeft():Void{
        shape.x -= 1;
    }
    function moveShapeUp():Void{
        shape.y -= 1;
    }
    function moveShapeDown():Void{
        shape.y += 1;
    }


    private function drawSquare():Void{
        shape.graphics.beginFill(0x333333);
        shape.graphics.drawRoundRect(0, 0, 100, 100, 10);
        stage.addChild(shape);
    }
    private function everyFrame(evt:Event):Void {
        
        drawSquare();
    }

    public function new() 
    {
        super();    
        addEventListener(Event.ADDED_TO_STAGE, added);
    }
    function added(e) 
    {
        removeEventListener(Event.ADDED_TO_STAGE, added);
        //stage.addEventListener(Event.RESIZE, resize);
        init();
    }
    
    static function main() {

        //stage.align = flash.display.StageAlign.TOP_LEFT;
        //stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
        Lib.current.addChild(new Main());
    	

        

    }

    
}
