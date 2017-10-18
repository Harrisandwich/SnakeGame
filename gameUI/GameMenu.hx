package gameUI;

import flash.events.MouseEvent;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.display.Shape;
import flash.display.SimpleButton;

import gameUI.CustomSimpleButton;

import gameControllers.Settings;

import utilities.Constants;

class GameMenu extends Sprite{
	
	private var background:Shape;

	//labels
	private var onePlayerControlsLabel:TextField;
	private var twoPlayerControlsLabel:TextField;

	//buttons
	private var play_Button:CustomSimpleButton;
	private var setPlayersToOne_Button:CustomSimpleButton;
	private var setPlayersToTwo_Button:CustomSimpleButton;
	private var setVsComputer_Button:CustomSimpleButton;
	private var setPlayAreaToSmall_Button:CustomSimpleButton;
	private var setPlayAreaToMedium_Button:CustomSimpleButton;
	private var setPlayAreaToLarge_Button:CustomSimpleButton;
	private var setSpeedToSlow_Button:CustomSimpleButton;
	private var setSpeedToNormal_Button:CustomSimpleButton;
	private var setSpeedToFast_Button:CustomSimpleButton;


	

	private function setPlayers(players:UInt):Void{
		Settings.setProperty("numberOfPlayers", players);
	}

	private function setVsComputer(vsComputer:Bool):Void{
		Settings.setProperty("vsComputer", vsComputer);
	}

	private function setArea(size:UInt):Void{
		Settings.setProperty("gridSize", size);
	}

	private function setSpeed(speed:UInt):Void{
		Settings.setProperty("speed", speed);
	}

	public function new(startGame:Void->Void, resetGame:Void->Void, stageWidth:Float, stageHeight:Float, playAreaX:Float, playAreaY:Float, playAreaHeight:Float){

		super();
		//MASSIVE MENU SETUP ------------------------------------------------------------------------------------------
		background = new Shape();
        background.graphics.beginFill(0x333333);
        background.graphics.drawRoundRect(0, 0, (stageWidth/4), playAreaHeight, 10);
        
        this.addChild(background);

        onePlayerControlsLabel = new TextField();
        onePlayerControlsLabel.text = "1P: Up, Down, Left, Right";
        onePlayerControlsLabel.setTextFormat(new TextFormat("Calibri",20,0xFFFFFF,true,false));
        onePlayerControlsLabel.autoSize = flash.text.TextFieldAutoSize.CENTER;
        onePlayerControlsLabel.x = this.width/2 - onePlayerControlsLabel.width/2;
        onePlayerControlsLabel.y = 400;

		twoPlayerControlsLabel = new TextField();
        twoPlayerControlsLabel.text = "2P: W, S, A, D";
        twoPlayerControlsLabel.setTextFormat(new TextFormat("Calibri",20,0xFFFFFF,true,false));
        twoPlayerControlsLabel.autoSize = flash.text.TextFieldAutoSize.CENTER;
        twoPlayerControlsLabel.x = this.width/2 - twoPlayerControlsLabel.width/2;
        twoPlayerControlsLabel.y = 450;

        play_Button = new CustomSimpleButton("Play", false);
        play_Button.x = this.width/2 - play_Button.width/2;
        play_Button.y = 10;
        
		setPlayersToOne_Button = new CustomSimpleButton("1P", true);
		setPlayersToOne_Button.x = 0;
        setPlayersToOne_Button.y = 100;
        setPlayersToOne_Button.buttonToggle(setPlayersToOne_Button.button);

		setPlayersToTwo_Button = new CustomSimpleButton("2P", true);
		setPlayersToTwo_Button.x = this.width/2 - setPlayersToTwo_Button.width/2;
        setPlayersToTwo_Button.y = 100;

        setVsComputer_Button = new CustomSimpleButton("vsCPU", true);
		setVsComputer_Button.x = this.width/2 + setVsComputer_Button.width/2;
        setVsComputer_Button.y = 100;
        

		setPlayAreaToSmall_Button = new CustomSimpleButton("Small", true);
		setPlayAreaToSmall_Button.x = 0;
        setPlayAreaToSmall_Button.y = 200;

		setPlayAreaToMedium_Button = new CustomSimpleButton("Med", true);
		setPlayAreaToMedium_Button.x = this.width/2 - setPlayAreaToMedium_Button.width/2;
        setPlayAreaToMedium_Button.y = 200;
        setPlayAreaToMedium_Button.buttonToggle(setPlayAreaToMedium_Button.button);

		setPlayAreaToLarge_Button = new CustomSimpleButton("Large", true);
		setPlayAreaToLarge_Button.x = this.width/2 + setPlayAreaToLarge_Button.width/2;
        setPlayAreaToLarge_Button.y = 200;

		setSpeedToSlow_Button = new CustomSimpleButton("Slow", true);
		setSpeedToSlow_Button.x = 0;
        setSpeedToSlow_Button.y = 300;

		setSpeedToNormal_Button = new CustomSimpleButton("Normal", true);
		setSpeedToNormal_Button.x = this.width/2 - setSpeedToNormal_Button.width/2;
        setSpeedToNormal_Button.y = 300;
        setSpeedToNormal_Button.buttonToggle(setSpeedToNormal_Button.button);

		setSpeedToFast_Button = new CustomSimpleButton("Fast", true);
		setSpeedToFast_Button.x = this.width/2 + setSpeedToFast_Button.width/2;
        setSpeedToFast_Button.y = 300;


        this.addChild(onePlayerControlsLabel);
        this.addChild(twoPlayerControlsLabel);

        this.addChild(play_Button);
        this.addChild(setPlayersToOne_Button);
        this.addChild(setPlayersToTwo_Button);
        this.addChild(setVsComputer_Button);

        this.addChild(setPlayAreaToSmall_Button);
        this.addChild(setPlayAreaToMedium_Button);
        this.addChild(setPlayAreaToLarge_Button);

        this.addChild(setSpeedToSlow_Button);
        this.addChild(setSpeedToNormal_Button);
        this.addChild(setSpeedToFast_Button);

        this.x = playAreaX - background.width - 40;
        this.y = playAreaY;
        //END OF MASSIVE MENU SETUP ------------------------------------------------------------------------------------------


        //map buttons to actions
        play_Button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent){
        	startGame(); 
        });

        setPlayersToOne_Button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent){
        	if(setPlayersToTwo_Button.buttonState == true){
				setPlayersToTwo_Button.buttonToggle(setPlayersToTwo_Button.button);
			}else if(setVsComputer_Button.buttonState == true){
				setVsComputer_Button.buttonToggle(setVsComputer_Button.button);
			}
        	setPlayers(1);
        	setVsComputer(false);
        	resetGame();
        });
        setPlayersToTwo_Button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent){
        	
        	if(setPlayersToOne_Button.buttonState == true){
				setPlayersToOne_Button.buttonToggle(setPlayersToOne_Button.button);
			}else if(setVsComputer_Button.buttonState == true){
				setVsComputer_Button.buttonToggle(setVsComputer_Button.button);
			}
        	setPlayers(2);
        	setVsComputer(false);
        	resetGame();
        });

         setVsComputer_Button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent){
        	
        	if(setPlayersToOne_Button.buttonState == true){
				setPlayersToOne_Button.buttonToggle(setPlayersToOne_Button.button);
			}else if(setPlayersToTwo_Button.buttonState == true){
				setPlayersToTwo_Button.buttonToggle(setPlayersToTwo_Button.button);
			}
        	setPlayers(2);
        	setVsComputer(true);
        	resetGame();
        });

        setPlayAreaToSmall_Button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent){
        	
        	if(setPlayAreaToMedium_Button.buttonState == true){
				setPlayAreaToMedium_Button.buttonToggle(setPlayAreaToMedium_Button.button);
			}else if(setPlayAreaToLarge_Button.buttonState == true){
				setPlayAreaToLarge_Button.buttonToggle(setPlayAreaToLarge_Button.button);
			}
        	setArea(Constants.AREA_SMALL);
        	resetGame();
        });
        setPlayAreaToMedium_Button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent){
        	if(setPlayAreaToSmall_Button.buttonState == true){
				setPlayAreaToSmall_Button.buttonToggle(setPlayAreaToSmall_Button.button);
			}else if(setPlayAreaToLarge_Button.buttonState == true){
				setPlayAreaToLarge_Button.buttonToggle(setPlayAreaToLarge_Button.button);
			}
        	setArea(Constants.AREA_MED);
        	resetGame();
        });
        setPlayAreaToLarge_Button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent){
        	if(setPlayAreaToSmall_Button.buttonState == true){
				setPlayAreaToSmall_Button.buttonToggle(setPlayAreaToSmall_Button.button);
			}else if(setPlayAreaToMedium_Button.buttonState == true){
				setPlayAreaToMedium_Button.buttonToggle(setPlayAreaToMedium_Button.button);
			}
        	setArea(Constants.AREA_LARGE);
        	resetGame();
        });

        setSpeedToSlow_Button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent){
        	
        	if(setSpeedToNormal_Button.buttonState == true){
				setSpeedToNormal_Button.buttonToggle(setSpeedToNormal_Button.button);
			}else if(setSpeedToFast_Button.buttonState == true){
				setSpeedToFast_Button.buttonToggle(setSpeedToFast_Button.button);
			}
        	setSpeed(Constants.SPEED_SLOW);
        	resetGame();
        });
        setSpeedToNormal_Button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent){
        	if(setSpeedToSlow_Button.buttonState == true){
				setSpeedToSlow_Button.buttonToggle(setSpeedToSlow_Button.button);
			}else if(setSpeedToFast_Button.buttonState == true){
				setSpeedToFast_Button.buttonToggle(setSpeedToFast_Button.button);
			}
        	setSpeed(Constants.SPEED_NORMAL);
        	resetGame();
        });
        setSpeedToFast_Button.addEventListener(MouseEvent.CLICK, function(event:MouseEvent){
        	
        	if(setSpeedToSlow_Button.buttonState == true){
				setSpeedToSlow_Button.buttonToggle(setSpeedToSlow_Button.button);
			}else if(setSpeedToNormal_Button.buttonState == true){
				setSpeedToNormal_Button.buttonToggle(setSpeedToNormal_Button.button);
			}
        	setSpeed(Constants.SPEED_FAST);
        	resetGame();
        });
        

	}


}