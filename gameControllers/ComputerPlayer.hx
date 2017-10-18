package gameControllers;

import haxe.Timer;
import flash.geom.Point;
import flash.events.KeyboardEvent;
import flash.events.Event;

//custom classes
import inputUtilities.Input;
import inputUtilities.Keyboard;

import entities.Snake;
import entities.Collectable;


class ComputerPlayer{

	private var decisionTimer:Timer;
	private var currentItems:List<entities.Collectable>;
	public var controls:Map<String, String>;
	public var snake:Snake;
	public var isPlaying:Bool;



	private function outputCommand():Void{
		
		if(!snake.isDead){
			var headLocation:Point = snake.getHeadLocation();
			var direction:Point = snake.getDirection();
			var command:String;

			if(headLocation.x > currentItems.first().location.x && direction.x != 1 ){
				command = controls["left"];
			}else if(headLocation.x < currentItems.first().location.x && direction.x != -1){
				command = controls["right"];
			}else if(headLocation.y > currentItems.first().location.y && direction.y != 1){
				command = controls["up"];
			}else if(headLocation.y < currentItems.first().location.y && direction.y != -1){
				command = controls["down"];
			}else{
				command = controls["down"];
			}  
			
			var fakeKeyPress = new KeyboardEvent(KeyboardEvent.KEY_DOWN,true,false,Keyboard.keyMap[command].keyCode,Keyboard.keyMap[command].keyCode);
			Input.keyDown(fakeKeyPress);
		}
		
	}
	public function startPlaying(items:List<entities.Collectable>):Void{
		isPlaying = true;
		currentItems = items;
		decisionTimer = new Timer(50);
		decisionTimer.run = outputCommand;
	}
	public function stopPlaying():Void{
		isPlaying = false;
		decisionTimer.stop();
		//decisionTimer = null;
	}
	public function new(controls:Map<String, String>, snake:Snake){
		var self:ComputerPlayer = this;
		self.controls = controls;
		self.snake = snake;
	}
}