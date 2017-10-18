/*
	Author: Harrison Hutcheon
	Date: October 2017
*/

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
		//if snake is not dead
		if(!snake.isDead){
			var headLocation:Point = snake.getHeadLocation();
			var direction:Point = snake.getDirection();
			var command:String;
			//set next movement based on item position
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
			
			//send fake key press to input controller with next move
			var fakeKeyPress = new KeyboardEvent(KeyboardEvent.KEY_DOWN,true,false,Keyboard.keyMap[command].keyCode,Keyboard.keyMap[command].keyCode);
			Input.keyDown(fakeKeyPress);
		}
		
	}

	//start decision timer and set computer player state
	public function startPlaying(items:List<entities.Collectable>):Void{
		isPlaying = true;
		currentItems = items;
		decisionTimer = new Timer(50);
		decisionTimer.run = outputCommand;
	}
	public function stopPlaying():Void{
		isPlaying = false;
		decisionTimer.stop();
	}
	public function new(controls:Map<String, String>, snake:Snake){
		var self:ComputerPlayer = this;
		self.controls = controls;
		self.snake = snake;
	}
}