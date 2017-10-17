import haxe.Timer;
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
import entities.Collectable;

import gameControllers.ItemSpawner;

class Main extends Sprite {

    private var gameTimer:Timer;
    private var input:Input;
    private var background:Shape;
    private var playArea:Sprite;
    private var grid:Grid;
    private var snakes:Array<Snake>;
    private var currentItems:List<Collectable>;

    private var gridSize:UInt;
    private var maxItems:Int;

    function init() 
    {
        gridSize = 30;
        maxItems = 1;
        playArea = new Sprite();
        snakes = new Array<Snake>();
        currentItems = new List<Collectable>();

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

        grid = new Grid(gridSize,playArea.width);

        playArea.addChild(grid);

        snakes.push(new Snake(0x009900,new Point(10,10),"hor",-1,0,grid));

        gameTimer = new Timer(500);
        gameTimer.run = gameLoop;

        Input.setAction('right_arrow', snakes[0].right);
        Input.setAction('left_arrow', snakes[0].left);
        Input.setAction('up_arrow', snakes[0].up);
        Input.setAction('down_arrow', snakes[0].down);
        // Game loop
        //stage.addEventListener(Event.ENTER_FRAME, everyFrame);
        stage.addEventListener(KeyboardEvent.KEY_DOWN, Input.keyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, Input.keyUp);
    }

    private function checkCollisions():Void{
        for(s in snakes){
            var head:Point = s.getHeadLocation();
            if(head.x < 0 
                || head.x >= gridSize
                || head.y < 0
                || head.y >= gridSize){

                //move to game over func
                gameTimer.stop();
            }

            for(i in currentItems){
                if(head.x == i.location.x 
                && head.y == i.location.y){
                    grid.removeChild(i);
                    currentItems.remove(i);
                    s.grow();

                }
            }

            for(seg in 0...s.body.length){
                
                if(seg == 0) continue;

                if(head.x == s.body[seg].location.x 
                    && head.y == s.body[seg].location.y){
                    
                    //move to game over func
                    gameTimer.stop();

                }
            }
            
        }
    }

    private function gameLoop():Void{
        
        if(currentItems.length < maxItems){
            var numberOfItemsMissing:UInt = maxItems - currentItems.length;
            for(i in 0...numberOfItemsMissing){
                var newItem = ItemSpawner.spawnItem(0xFFFF00,grid.cellSize,gridSize,100);
                currentItems.add(newItem);
                grid.addChild(newItem);
            }
            
        }

        
        for(s in snakes){
            s.animate();
        }
        
        checkCollisions();

    }
    private function everyFrame(evt:Event):Void {
        
        //snake.draw();
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
