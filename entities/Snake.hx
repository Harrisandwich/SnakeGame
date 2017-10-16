package entities;

import flash.geom.Point;
import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

//Custom Classes
import playArea.Grid;

import entities.Segment;
import entities.Head;

typedef Action = { action:String->Void, param:String};

class Snake {

	private var direction:String;
	private var head:Head;
	private var neck:Segment;
	private var tail:Array<Segment>;

	private var actions:List<Action>;




	//change direction of snake head
	private function changeDirection(dir:String):Void{

		trace("Change direction: " + dir);
		direction = dir;
		head.changeDirection(dir, neck);
	}

	public function up():Void{
		
		trace("Up Hit");
		var newHeadPosY:Float = head.location.y - 1;
		if(newHeadPosY != neck.location.y){
			changeDirection("up");
		}
		
	}
	public function down():Void{

		var newHeadPosY:Float = head.location.y + 1;
		if(newHeadPosY != neck.location.y){
			changeDirection("down");	
		}

	}
	public function left():Void{

		var newHeadPosX:Float = head.location.x - 1;
		if(newHeadPosX != neck.location.x){
			changeDirection("left");
		}

	}
	public function right():Void{

		var newHeadPosX:Float = head.location.x + 1;
		if(newHeadPosX != neck.location.x){
			changeDirection("right");	
		}

	}

	public function getHeadLocation():Point{
		var headLocation:Point = head.location;
		return headLocation;
	}
	
	public function completeActions():Void{
		
		for(a in actions){
			a.action(a.param);
		}
	}
	//move whole snake 
	private function move():Void{

		//move head as it governs direction of the body
		head.moveHead(direction);
		neck.move(head.previousLocation);
		tail[0].move(neck.previousLocation);
		//move first segment based on head
		
		var loopMax:Int = tail.length;


		//for each segment in the tail
		for(s in 0...loopMax){

			//if the segment is the first, skip. It's following the head
			if(s == 0) continue;
				
			//get the segment before this one
			var previousSegment = s - 1;
			//move the segment using its position
			tail[s].move(tail[previousSegment].previousLocation);
			
			
		}

	}

	public function draw():Void{
		head.draw();
		neck.draw();
		for(t in tail){
			t.draw();
		}
	}

	public function animate() {
		
		completeActions();
		move();
		draw();
	}

	public function new(color:UInt, headLocation:Point, orientation:String, startDir:String, grid:Grid){
		
		actions = new List<Action>();

		tail = new Array<Segment>();
		head = new Head(color, headLocation.x, headLocation.y, grid.cellSize);
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
				for(s in 0...4){
				
					var seg:Float = tailPosX + s;
					tail.push(new Segment(color, seg, tailPosY, grid.cellSize));
				}
				
			
			}else{
				neckPosX = headLocation.x - 1;
				tailPosX = headLocation.x - 2;
				for(s in 0...4){
				
					var seg:Float = tailPosX - s;
					tail.push(new Segment(color, seg, tailPosY, grid.cellSize));
				}

			}
			
			
		}else{

			neckPosX = headLocation.x;
			tailPosX = headLocation.x;
			if(startDir == "up"){

				neckPosY = headLocation.y + 1;
				tailPosY = headLocation.y + 2;
				for(s in 0...4){
				
					var seg:Float = tailPosY + s;
					tail.push(new Segment(color, tailPosX, seg, grid.cellSize));
				}
				
			
			}else{
				neckPosY = headLocation.y - 1;
				tailPosY = headLocation.y - 2;

				for(s in 0...4){
				
					var seg:Float = tailPosY - s;
					tail.push(new Segment(color, tailPosX, seg, grid.cellSize));
				}
			}
		}

		neck = new Segment(color, neckPosX, neckPosY, grid.cellSize);

		
		
		

		//Add snake to grid
		grid.addChild(head);
		grid.addChild(neck);

		for(s in tail){
			grid.addChild(s);
		}
		
	}

}