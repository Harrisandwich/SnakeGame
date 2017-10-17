package gameControllers;

import haxe.Timer;
import flash.geom.Point;
import flash.events.KeyboardEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.Shape;
import flash.Lib;

//Custom classes
import inputUtilities.Input;

import playArea.Grid;

import entities.Snake;
import entities.Collectable;

import gameControllers.ItemSpawner;

class Game extends Sprite{

	//Data
	private var settings:Map<String, Dynamic>;
	private var state:String;
	private var isGameOver:Bool;

	//move these to settings soon
	private var gridSize:UInt;
    private var maxItems:Int;


	//Mechanics
	private var input:Input;
	private var gameTimer:Timer;

	//UI
	private var gameOverText:TextField;

	//Entities
	private var playArea:Sprite;
	private var background:Shape;
	private var grid:Grid;
	//private var players:Array<Player>;
	private var snakes:Array<Snake>;
	private var currentItems:List<Collectable>;

	private function checkCollisions():Void{
        for(s in snakes){
            var head:Point = s.getHeadLocation();
            

            for(i in currentItems){
                if(head.x == i.location.x 
                && head.y == i.location.y){
                    grid.removeChild(i);
                    currentItems.remove(i);
                    s.grow();

                }
            }

            if(head.x < 0 
                || head.x >= settings["gridSize"]
                || head.y < 0
                || head.y >= settings["gridSize"]){

                //move to game over func
            	s.isDead = true;
                gameOver();
                
            }
            for(os in snakes){
              
                for(seg in 0...os.body.length){
                
                    if(os == s){
                        if(seg == 0) continue;
                    }
                    

                    if(head.x == os.body[seg].location.x 
                        && head.y == os.body[seg].location.y){
                        
                        //move to game over func
                    	s.isDead = true;
                    	os.isHit = true;
                    	os.body[seg].isDead = true;
                        gameOver();

                    }
                }
                
            }
            
        }
    }

    private function gameLoop():Void{
        
        


        if(!isGameOver){


	        if(currentItems.length < settings["maxItems"]){
	            var numberOfItemsMissing:UInt = settings["maxItems"] - currentItems.length;
	            for(i in 0...numberOfItemsMissing){
	                var newItem = ItemSpawner.spawnItem(0xFFFF00,grid.cellSize,settings["gridSize"],100);
	                currentItems.add(newItem);
	                grid.addChild(newItem);
	            }
	            
	        }

	        
	        for(s in snakes){
	            s.animate();
	        }
	        
	        checkCollisions();
	    }else{
	    	for(s in snakes){
	            s.animate();
	        }
	    }

    }
    private function everyFrame(evt:Event):Void {
        
        //snake.draw();
    }

    public function setupGame():Void{

        playArea = new Sprite();
        snakes = new Array<Snake>();
        currentItems = new List<Collectable>();
        grid = new Grid(settings["gridSize"],settings["playAreaSize"]);
        gameOverText = new TextField();

        // create a background to visualize the play area
        background = new Shape();
        background.graphics.beginFill(0x333333);
        background.graphics.drawRoundRect(0, 0, (stage.stageWidth/2), (stage.stageWidth/2), 10);
        background.x = 0;
        background.y = 0;
        playArea.addChild(background);

        playArea.width = settings["playAreaSize"];
        playArea.height = settings["playAreaSize"];
        playArea.x = (stage.stageWidth/2) - (settings["playAreaSize"]/3);
        playArea.y = (stage.stageHeight/2) - (settings["playAreaSize"]/2);
        stage.addChild(playArea); 

        playArea.addChild(grid);

        gameOverText.text = "Game Over";
        gameOverText.setTextFormat(new TextFormat("Calibri",30,0x000000,true,false));
        gameOverText.autoSize = flash.text.TextFieldAutoSize.CENTER;
        gameOverText.x = (stage.stageWidth/2);
        gameOverText.y = 10;
        gameOverText.alpha = 0;
        stage.addChild(gameOverText);

        var dir:Float = 1;
        var startLocation = new Point(10,10);
        for(s in 0...settings["numberOfPlayers"]){

        	dir *= -1;
        	trace(dir);

        	if(settings["startOrientation"] == "hor"){
        		snakes.push(new Snake(0x009900,new Point(startLocation.x,startLocation.y),settings["startOrientation"],dir,0,grid));
        		startLocation.y += 5;
        	}else{
        		snakes.push(new Snake(0x009900,new Point(startLocation.x,startLocation.y),settings["startOrientation"],0,dir,grid));
        		startLocation.x += 5;
        	}
        	
        	var playerControls:Map<String, String> = settings["controls"][s];
        	Input.setAction(playerControls["right"], snakes[s].right);
	        Input.setAction(playerControls["left"], snakes[s].left);
	        Input.setAction(playerControls["up"], snakes[s].up);
	        Input.setAction(playerControls["down"], snakes[s].down);
        }

        // Game loop
        //stage.addEventListener(Event.ENTER_FRAME, everyFrame); //Do I need?
        stage.addEventListener(KeyboardEvent.KEY_DOWN, Input.keyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, Input.keyUp);

        state = "set";

	}

	public function clearGame():Void{
		
		/*//remove EVERYTHING
		playArea.removeChild(background);
		playArea.removeChild(grid);

		for(s in snakes){
			s.remove();
		}
		playArea.removeChild(grid);
		//delete EVERYTHING
		gameTimer = null;
		playArea = null;
        snakes = null;
        currentItems = null;
        grid = null;
        background = null;*/
	}

	public function resetGame():Void{

	}

	public function play():Void{
		state = "play";
		gameTimer = new Timer(settings["speed"]);
        gameTimer.run = gameLoop;
	}

	public function pause():Void{
		state = "pause";
		gameTimer.stop();
	}

	public function gameOver():Void{
		isGameOver = true;
		gameOverText.alpha = 1;

		stage.removeEventListener(KeyboardEvent.KEY_DOWN, Input.keyDown);
        stage.removeEventListener(KeyboardEvent.KEY_UP, Input.keyUp);

	}

	public function new(settings:Map<String, Dynamic>){
		
		super();  
		var self:Game = this;
		//self.players = players;
		self.settings = settings;

	}
}