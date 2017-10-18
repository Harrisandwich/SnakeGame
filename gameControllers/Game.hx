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

import gameUI.GameMenu;

import gameControllers.ItemSpawner;

class Game extends Sprite{

	//Data
	private var settings:Map<String, Dynamic>;
	private var state:String;
	private var isGameOver:Bool;
    private var playerColors:Array<UInt> = [0x009900,0x009999];
    private var playAreaSize:Float;


	//Mechanics
	private var input:Input;
	private var gameTimer:Timer;

	//UI
	private var gameOverText:TextField;
	private var gameMenu:GameMenu;

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

            	s.isDead = true;
            }
            for(os in snakes){
              
                for(seg in 0...os.body.length){
                
                    if(os == s){
                        if(seg == 0) continue;
                    }
                    

                    if(head.x == os.body[seg].location.x 
                        && head.y == os.body[seg].location.y){
                        
                        
                        
                        s.isDead = true;
                        

                    }
                }
                
            }
            
        }
    }

    private function gameLoop():Void{
        
        var deadSnakes:Int = 0;

        for(s in snakes){
            if(s.isDead){
                s.remove();
                snakes.remove(s);
                deadSnakes++;
            }else{
                if(s.body.length >= settings["gridSize"]){
                    gameOver();
                } 
            }
            
        }
        if(snakes.length == 0){
            gameOver();
        }

        if(!isGameOver){


	        if(currentItems.length < settings["maxItems"]){
	            var numberOfItemsMissing:UInt = settings["maxItems"] - currentItems.length;
	            for(i in 0...numberOfItemsMissing){


	                var newItem = ItemSpawner.spawnItem(0xFFFF00,grid.cellSize,settings["gridSize"],100);
                    var isItemOnSnake:Bool = true;
                    while(isItemOnSnake){
                        for(s in snakes){
                            for(seg in s.body){
                                if(newItem.location.x != seg.location.x 
                                    && newItem.location.y != seg.location.y){
                                    isItemOnSnake = false;
                                    break;
                                }
                            }
                            
                        }
                        newItem = ItemSpawner.spawnItem(0xFFFF00,grid.cellSize,settings["gridSize"],100);
                        
                    }
	                currentItems.add(newItem);
	                grid.addChild(newItem);
	            }
	            
	        }

	        
	        for(s in snakes){
	            s.animate();
	        }
	        
	        checkCollisions();
	    }

    }
    private function everyFrame(evt:Event):Void {
        
        //snake.draw();
    }

    public function init():Void{

    	settings = Settings.getSettings();
    	playArea = new Sprite();
    	snakes = new Array<Snake>();
    	grid = new Grid(settings["gridSize"],playAreaSize);
    	 // create a background to visualize the play area
        background = new Shape();
        background.graphics.beginFill(0x333333);
        background.graphics.drawRoundRect(0, 0, playAreaSize, playAreaSize, 10);
        background.x = 0;
        background.y = 0;
        playArea.addChild(background);

        playArea.width = playAreaSize;
        playArea.height = playAreaSize;
        playArea.x = playAreaSize - (playAreaSize/3);
        playArea.y = stage.stageHeight/2 - playAreaSize/2;
        stage.addChild(playArea); 

        //playArea.addChild(grid);

        var dir:Float = 1;
        var startLocation = new Point(10,10);
        for(s in 0...settings["numberOfPlayers"]){

        	dir *= -1;
        	trace(dir);
            //move later
            var playerColors:Array<UInt> = [0x009900,0x000099];

        	if(settings["startOrientation"] == "hor"){
        		snakes.push(new Snake(playerColors[s],new Point(startLocation.x,startLocation.y),settings["startOrientation"],dir,0,grid));
        		startLocation.y += 5;
        	}else{
        		snakes.push(new Snake(playerColors[s],new Point(startLocation.x,startLocation.y),settings["startOrientation"],0,dir,grid));
        		startLocation.x += 5;
        	}
        }

        

        gameMenu = new GameMenu(startGame, resetGame, stage.stageWidth, stage.stageHeight, playArea.x, playArea.y, playArea.height);
        stage.addChild(gameMenu);
    }
    public function setupGame():Void{

    	settings = Settings.getSettings();
        snakes = new Array<Snake>();
        currentItems = new List<Collectable>();
        grid = new Grid(settings["gridSize"],playAreaSize);
        gameOverText = new TextField();

         // create a background to visualize the play area
        background = new Shape();
        background.graphics.beginFill(0x333333);
        background.graphics.drawRoundRect(0, 0, playAreaSize, playAreaSize, 10);
        background.x = 0;
        background.y = 0;
        playArea.addChild(background);

        playArea.width = playAreaSize;
        playArea.height = playAreaSize;
        playArea.x = playAreaSize - (playAreaSize/3);
        playArea.y = stage.stageHeight/2 - playAreaSize/2;
        stage.addChild(playArea); 

        playArea.addChild(grid);
		

		gameOverText.text = "Game Over";
        gameOverText.setTextFormat(new TextFormat("Calibri",30,0x000000,true,false));
        gameOverText.autoSize = flash.text.TextFieldAutoSize.CENTER;
        gameOverText.x = playAreaSize;
        gameOverText.y = 10;
        gameOverText.alpha = 0;
        stage.addChild(gameOverText);

        var dir:Float = 1;
        var startLocation = new Point();
        startLocation.x = Math.round(settings["gridSize"]/3);
        startLocation.y = Math.round(settings["gridSize"]/2);
        for(s in 0...settings["numberOfPlayers"]){

        	dir *= -1;
        	trace(dir);

        	if(settings["startOrientation"] == "hor"){
        		snakes.push(new Snake(playerColors[s],new Point(startLocation.x,startLocation.y),settings["startOrientation"],dir,0,grid));
        		startLocation.y += 5;
        	}else{
        		snakes.push(new Snake(playerColors[s],new Point(startLocation.x,startLocation.y),settings["startOrientation"],0,dir,grid));
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
		
		//remove EVERYTHING
		for(s in snakes){
            if(!s.removed){
                s.remove();
            }
			
		}
		for(i in currentItems){
			grid.removeChild(i);
		}

		//delete EVERYTHING
        snakes = null;
        currentItems = null;
        
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

	public function startGame():Void{
		state = "starting";
		resetGame();
		play();
	}

	public function resetGame():Void{
		isGameOver = false;
		gameOverText.alpha = 0;
		clearGame();
		if(gameTimer != null){
			gameTimer.stop();
		}
		setupGame();
		

		
	}

	public function new(stageWidth:Float){
		
		super();  
		var self:Game = this;
		Settings.setDefaults();
		
		playAreaSize = stageWidth/2;
		

	}
}