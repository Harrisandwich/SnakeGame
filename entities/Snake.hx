package entities;

import flash.display.DisplayObject;
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
	private var size:Float;
	private var color:UInt;
	private var addToGrid:DisplayObject->DisplayObject;
	public var isDead:Bool;
	public var isHit:Bool;
	public var body:Array<Segment>;

	//change direction of snake head
	private function changeDirection(dirX:Float, dirY:Float):Void{

		var headPos:Point = body[0].location;
		var neckPos:Point = body[1].location;
		var moveValid:Bool = true;
		if((headPos.x + dirX) == neckPos.x 
			&& (headPos.y + dirY) == neckPos.y){

			moveValid = false;

		}

		if(moveValid){
			xd = dirX;
			yd = dirY;
		}
		
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
	public function grow():Void{

		var last:Segment = body[(body.length - 1)];
		var newSegment:Segment = new Segment(color, last.previousLocation.x, last.previousLocation.y, size);
		body.push(newSegment);
		addToGrid(newSegment);


	}
	public function getHeadLocation():Point{
		return body[0].location;
	}

	public function up():Void{
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

	public function draw():Void{
		for(t in body){
			t.draw();
		}
	}

	public function flash():Void{
		
		for(b in body){
			if(b.isDead){
				b.flash();
			}	
		}
		
	}

	public function animate() {
		if(isDead || isHit){
			flash();
		}else{
			move();
			draw();
		}
		
	}

	public function new(color:UInt, headLocation:Point, orientation:String, startDirX:Float, startDirY:Float, grid:Grid){
		
		
		var self:Snake = this;
		//move to param
		var startSize:UInt = 4;
		self.size = grid.cellSize;
		self.body = new Array<Segment>();
		self.color = color;
		self.xd = startDirX;
		self.yd = startDirY;
		self.isDead = false;

		//getting long...move to func?
		//or change way this is laid out		

		if(orientation == "hor"){

			

			if(startDirX == -1){

				
				for(s in 0...startSize){
				
					var seg:Float = headLocation.x + s;
					self.body.push(new Segment(color, seg, headLocation.y, size));
				}
				
			
			}else{
				
				for(s in 0...startSize){
				
					var seg:Float = headLocation.x - s;
					self.body.push(new Segment(color, seg, headLocation.y, size));
				}

			}
			
			
		}else{

			
			if(startDirY == -1){
				
				for(s in 0...startSize){
				
					var seg:Float = headLocation.y + s;
					self.body.push(new Segment(color, headLocation.x, seg, size));
				}
				
			
			}else{

				for(s in 0...startSize){
				
					var seg:Float = headLocation.y - s;
					self.body.push(new Segment(color, headLocation.x, seg, size));
				}
			}
		}
		self.addToGrid = grid.addChild;
		for(s in self.body){
			self.addToGrid(s);
		}
		
	}

}