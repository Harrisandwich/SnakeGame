/*
    Author: Harrison Hutcheon
    Date: October 2017
*/

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
import gameControllers.ComputerPlayer;

import utilities.Constants;

class Game extends Sprite{

	//Data
	private var settings:Map<String, Dynamic>;
	private var state:String;
	private var isGameOver:Bool;
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
	private var computerPlayer:ComputerPlayer;
	private var snakes:Array<Snake>;
	private var currentItems:List<Collectable>;

	private function checkCollisions():Void{
       
        for(s in snakes){

            var head:Point = s.getHeadLocation();
            //check if collide with collectable
            for(i in currentItems){
                if(head.x == i.location.x 
                && head.y == i.location.y){
                    grid.removeChild(i);
                    currentItems.remove(i);
                    s.grow();

                }
            }

            //check if collide with wall
            if(head.x < 0 
                || head.x >= settings["gridSize"]
                || head.y < 0
                || head.y >= settings["gridSize"]){

            	s.isDead = true;
            }

            //check if collide with self or other snake
            for(os in snakes){
              
                for(seg in 0...os.body.length){
                
                    //if its checking itself, ignore head collision check or it will always die
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

        //sweep up dead snakes
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

        //end game if all snakes are dead
        if(snakes.length == 0){
            gameOver();
        }
        //if game not over
        if(!isGameOver){

            //check if items should spawn
	        if(currentItems.length < settings["maxItems"]){
	            var numberOfItemsMissing:UInt = settings["maxItems"] - currentItems.length;
	            for(i in 0...numberOfItemsMissing){


	                var newItem = ItemSpawner.spawnItem(Constants.ITEM_COLOR,grid.cellSize,settings["gridSize"],Constants.ITEM_VALUE);
                    var isItemOnSnake:Bool = true;

                    //get a new item until a valid item is created (no contact with snakes)
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
                        newItem = ItemSpawner.spawnItem(Constants.ITEM_COLOR,grid.cellSize,settings["gridSize"],Constants.ITEM_VALUE);
                        
                    }
	                currentItems.add(newItem);
	                grid.addChild(newItem);
	            }
	            
	        }
            //animate snakes
	        for(s in snakes){
	            s.animate();
	        }
	        
	        checkCollisions();
	    }

    }
    //draw background for play area   
    private function drawBackground(){
        background = new Shape();
        background.graphics.beginFill(Constants.BACKGROUND_COLOR);
        background.graphics.drawRoundRect(0, 0, playAreaSize, playAreaSize, 10);
        background.x = 0;
        background.y = 0;
    }
    //set up play area
    private function setPlayAreaDimensions(){
        playArea.width = playAreaSize;
        playArea.height = playAreaSize;
        playArea.x = playAreaSize - (playAreaSize/3);
        playArea.y = stage.stageHeight/2 - playAreaSize/2;
    }

    //generate snakes
    private function createSnakes(){
        var dir:Float = 1;
        var startLocation = new Point();
        startLocation.x = Math.round(settings["gridSize"]/2) - Constants.SNAKE_START_SIZE/2;
        startLocation.y = Math.round(settings["gridSize"]/3);
        for(s in 0...settings["numberOfPlayers"]){

            dir *= -1;
            
            var newSnake:Snake;
            //set snake positions
            if(settings["startOrientation"] == "hor"){
                newSnake = new Snake(Constants.PLAYER_COLORS[s], Constants.SNAKE_START_SIZE,new Point(startLocation.x,startLocation.y),settings["startOrientation"],dir,0,grid);
                snakes.push(newSnake);
                startLocation.y += 10;
            }else{
                newSnake = new Snake(Constants.PLAYER_COLORS[s], Constants.SNAKE_START_SIZE,new Point(startLocation.x,startLocation.y),settings["startOrientation"],0,dir,grid);
                snakes.push(newSnake);
                startLocation.x += 10;
            }
            //set up computer player if enabled
            if(settings["vsComputer"] && s == 1){

                computerPlayer = new ComputerPlayer(settings["controls"][s],newSnake);

            }
            //map controls to input controller
            var playerControls:Map<String, String> = settings["controls"][s];
            Input.setAction(playerControls["right"], newSnake.right);
            Input.setAction(playerControls["left"], newSnake.left);
            Input.setAction(playerControls["up"], newSnake.up);
            Input.setAction(playerControls["down"], newSnake.down);
            
            
        }
    }
    public function init():Void{

    	settings = Settings.getSettings();
    	playArea = new Sprite();
    	snakes = new Array<Snake>();
    	grid = new Grid(settings["gridSize"],playAreaSize);
    	 // create a background to visualize the play area
        drawBackground();
        playArea.addChild(background);

        setPlayAreaDimensions();
        stage.addChild(playArea); 

        createSnakes();

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
        drawBackground();
        playArea.addChild(background);

        setPlayAreaDimensions();
        stage.addChild(playArea); 

        playArea.addChild(grid);
		

		gameOverText.text = "Game Over";
        gameOverText.setTextFormat(new TextFormat("Calibri",30,0x000000,true,false));
        gameOverText.autoSize = flash.text.TextFieldAutoSize.CENTER;
        gameOverText.x = playAreaSize;
        gameOverText.y = 10;
        gameOverText.alpha = 0;
        stage.addChild(gameOverText);
        createSnakes();

        // Game loop
        stage.addEventListener(KeyboardEvent.KEY_DOWN, Input.keyDown);
        stage.addEventListener(KeyboardEvent.KEY_UP, Input.keyUp);

        state = "set";

	}

	public function clearGame():Void{
		
        if(settings["vsComputer"] && computerPlayer != null && computerPlayer.isPlaying){
            
            computerPlayer.stopPlaying();

        }
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

        if(settings["vsComputer"]){
            computerPlayer.startPlaying(currentItems);
        }

	}

	public function pause():Void{
		state = "pause";
		gameTimer.stop();
	}

	public function gameOver():Void{
		isGameOver = true;
		gameOverText.alpha = 1;
        if(settings["vsComputer"]){
            computerPlayer.stopPlaying();
        }
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