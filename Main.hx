import flash.geom.Point;
import flash.events.KeyboardEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

//Custom classes
import inputUtilities.Input;

import playArea.Grid;

import entities.Snake;

class Main extends Sprite {

    private var input:Input;

    private var background:Shape;
    private var playArea:Sprite;
    private var grid:Grid;

    private var snake:Snake;

    function init() 
    {
        
        playArea = new Sprite();

        // create a background to visualize the play area
        background = new Shape();
        background.graphics.beginFill(0x333333);
        background.graphics.drawRoundRect(0, 0, (stage.stageWidth/2), (stage.stageWidth/2), 10);
        background.x = 0;
        background.y = 0;

        playArea.addChild(background);

        playArea.width = stage.stageWidth/2;
        playArea.height = stage.stageWidth/2;
        playArea.x = (stage.stageWidth/2) - (playArea.width/3);
        playArea.y = (stage.stageHeight/2) - (playArea.height/2);

        stage.addChild(playArea);

        grid = new Grid(20,playArea.width);

        playArea.addChild(grid);

        snake = new Snake(0x009900,new Point(10,10),"hor","left",grid);

        /*Input.setAction('right_arrow', moveShapeRight);
        Input.setAction('left_arrow', moveShapeLeft);
        Input.setAction('up_arrow', moveShapeUp);
        Input.setAction('down_arrow', moveShapeDown);*/
        // Game loop
        stage.addEventListener(Event.ENTER_FRAME, everyFrame);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, Input.keyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, Input.keyUp);
    }

    /*function moveShapeRight():Void{
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
    }*/


    private function everyFrame(evt:Event):Void {
        
        /*
            complete player actions
            check potential collisions
            move snakes
        */
        //drawSquare();
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
