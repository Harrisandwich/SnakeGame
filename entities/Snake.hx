package entities;

import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

//Custom Classes
import entities.TailSegment;
import entities.Head;

class Snake extends Sprite{


	private var head:Head;
	private var tail:Array<TailSegment>;

	//change direction of snake head
	public function changeDirection(dir:String):Void{

		//TODO: validate direction change to prevent turning into oneself
		head.changeDirection(dir);
	}
	
	//move whole snake 
	public function move():Void{
		
		//move head as it governs direction of the body
		head.move();
		//move first segment based on head
		tail[0].move(head);
		var loopMax:Int = tail.length - 1;


		//for each segment in the tail
		for(s in 0...loopMax){

			//if the segment is the first, skip. It's following the head
			if(s == 0) continue;
			//get the segment before this one
			var previousSegment = s - 1;
			//move the segment using its position
			s.move(tail[previousSegment]);
		}

	}

}