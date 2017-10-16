package entities;

import flash.geom.Point;
import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

//Custom Classes
import entities.TailSegment;
import entities.Head;

class Snake {

	private var direction:String;
	private var head:Head;
	private var neck:TailSegment;
	private var tail:Array<TailSegment>;

	//change direction of snake head
	public function changeDirection(dir:String):Void{

		direction = dir;
		head.changeDirection(dir, neck);
	}

	public function getHeadLocation():Point{
		var headLocation:Point = head.location;
		return headLocation;
	}
	
	//move whole snake 
	public function move():Void{
		
		

		//move head as it governs direction of the body
		head.moveHead(direction);
		neck.move(head.previousLocation);
		//move first segment based on head
		
		var loopMax:Int = tail.length - 1;


		//for each segment in the tail
		for(s in 0...loopMax){

			//if the segment is the first, skip. It's following the head
			if(s == 0){
				tail[s].move(neck.previousLocation);
			}else{
				//get the segment before this one
				var previousSegment = s - 1;
				//move the segment using its position
				tail[s].move(tail[previousSegment].previousLocation);
			}
			
		}

	}

	public function new(color:UInt, headLocation:Point, orientation:String, startDir:String){
		
		tail = new Array<TailSegment>();
		head = new Head(color, headLocation.x, headLocation.y);
		direction = startDir;

		//getting long...move to func?
		var neckPosX:Float;
		var neckPosY:Float;

		var tailPosX:Float;
		var tailPosY:Float;

		if(orientation == "hor"){

			neckPosY = headLocation.y;
			tailPosY = headLocation.y;

			if(startDir == "left"){

				neckPosX = headLocation.x + 1;
				tailPosX = headLocation.x + 2;
				
			
			}else{
				neckPosX = headLocation.x - 1;
				tailPosX = headLocation.x - 2;
			}
			
			
		}else{

			neckPosX = headLocation.x;
			tailPosX = headLocation.x;
			if(startDir == "up"){

				neckPosY = headLocation.y + 1;
				tailPosY = headLocation.y + 2;
				
			
			}else{
				neckPosY = headLocation.y - 1;
				tailPosY = headLocation.y - 2;
			}
		}

		neck = new TailSegment(color, neckPosX, neckPosY);
		tail.push(new TailSegment(color, tailPosX, tailPosY));
		

		//Add snake to grid
	}

}