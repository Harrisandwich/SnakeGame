package entities;

import flash.geom.Point;
import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

//Custom Classes
import playArea.Grid;

import entities.Segment;

class Snake {

	private var xd:Float;
	private var yd:Float;
	private var body:Array<Segment>;

	//change direction of snake head
	private function changeDirection(dirX:Float, dirY:Float):Void{

		xd = dirX;
		yd = dirY;
		
	}

	public function up():Void{
		
		trace("Up Hit");
		
		changeDirection(0,-1);
		
		
	}
	public function down():Void{

		
		
		changeDirection(0,1);	
		

	}
	public function left():Void{

		
		changeDirection(-1,0);
		

	}
	public function right():Void{

		
		changeDirection(1,0);	
		

	}
	
	//move whole snake 
	private function move():Void{

		body[0].moveHead(xd,yd);
		//for each segment in the tail
		for(s in 0...body.length){

			//if the segment is the first, skip. It's following the head
			if(s == 0) continue;
				
			//get the segment before this one
			var previousSegment = s - 1;
			//move the segment using its position
			body[s].move(body[previousSegment].previousLocation);
			
			
		}

	}

	public function draw():Void{
		for(t in body){
			t.draw();
		}
	}

	public function animate() {
	
		move();
		draw();
	}

	public function new(color:UInt, headLocation:Point, orientation:String, startDirX:Float, startDirY:Float, grid:Grid){
		
		var startSize:UInt = 4;
		
		body = new Array<Segment>();
		xd = startDirX;
		yd = startDirY;


		//getting long...move to func?
		

		if(orientation == "hor"){

			

			if(startDirX == -1){

				
				for(s in 0...startSize){
				
					var seg:Float = headLocation.x + s;
					body.push(new Segment(color, seg, headLocation.y, grid.cellSize));
				}
				
			
			}else{
				
				for(s in 0...startSize){
				
					var seg:Float = headLocation.x - s;
					body.push(new Segment(color, seg, headLocation.y, grid.cellSize));
				}

			}
			
			
		}else{

			
			if(startDirY == -1){
				
				for(s in 0...startSize){
				
					var seg:Float = headLocation.y + s;
					body.push(new Segment(color, headLocation.x, seg, grid.cellSize));
				}
				
			
			}else{

				for(s in 0...startSize){
				
					var seg:Float = headLocation.y - s;
					body.push(new Segment(color, headLocation.x, seg, grid.cellSize));
				}
			}
		}

		for(s in body){
			grid.addChild(s);
		}
		
	}

}