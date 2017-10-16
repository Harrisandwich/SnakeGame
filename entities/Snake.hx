package entities;

import flash.geom.Point;
import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

//Custom Classes
import entities.TailSegment;
import entities.Head;

class Snake {


	private var head:Head;
	private var neck:TailSegment;
	private var tail:List<TailSegment>;

	//change direction of snake head
	public function changeDirection(dir:String):Void{

		head.changeDirection(dir, tail[0]);
	}
	
	//move whole snake 
	public function move():Void{
		
		//TODO: Check collisions before move

		//move head as it governs direction of the body
		head.move();
		neck.move(head);
		//move first segment based on head
		
		var loopMax:Int = tail.length - 1;


		//for each segment in the tail
		for(s in 0...loopMax){

			//if the segment is the first, skip. It's following the head
			if(s == 0){
				tail[s].move(neck);
			}else{
				//get the segment before this one
				var previousSegment = s - 1;
				//move the segment using its position
				s.move(tail[previousSegment]);
			}
			
		}

	}

	public function new(color:UInt, headLocation:Point, orientation:String, startDir:String){
		
		tail = new List<TailSegment>();
		head = new Head(color, headLocation.x, headLocation.y);


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
		tail.add(new TailSegment(color, tailPosX, tailPosY));
		
		
	}

}