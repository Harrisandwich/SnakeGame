/*
	Author: Harrison Hutcheon
	Date: October 2017
*/

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
	private var removeFromGrid:DisplayObject->DisplayObject;
	public var isDead:Bool;
	public var removed:Bool;
	public var body:Array<Segment>;

	//change direction of snake head
	private function changeDirection(dirX:Float, dirY:Float):Void{

		var headPos:Point = body[0].location;
		var neckPos:Point = body[1].location;
		var moveValid:Bool = true;

		//make sure the snake can't turn into its own body
		if((headPos.x + dirX) == neckPos.x 
			&& (headPos.y + dirY) == neckPos.y){

			moveValid = false;

		}
		//if move is valid than change direction
		if(moveValid){
			xd = dirX;
			yd = dirY;
		}
		
	}

	//move whole snake 
	private function move():Void{

		
		var newLocation = new Point(body[0].location.x, body[0].location.y);
		newLocation.x += xd;
		newLocation.y += yd;
		body[0].move(newLocation);
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

	private function setSnakeStartProperties(color:UInt, 
		startSize:UInt, 
		headLocation:Point, 
		orientation:String, 
		startDirX:Float, 
		startDirY:Float):Void{
		
		var self:Snake = this;
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
	}

	//grow a new segment
	public function grow():Void{

		var last:Segment = body[(body.length - 1)];
		var newSegment:Segment = new Segment(color, last.previousLocation.x, last.previousLocation.y, size);
		body.push(newSegment);
		addToGrid(newSegment);


	}
	//getter for head location
	public function getHeadLocation():Point{
		return body[0].location;
	}

	//getter for direction of movement
	public function getDirection():Point{
		return new Point(xd,yd);
	}

	//control functions---------------
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
	//--------------------------------

	//draw each segment
	public function draw():Void{
		for(t in body){
			t.draw();
		}
	}

	//animate moves and draws segments if snake is alive
	public function animate():Void {
		
		if(!isDead){
			move();
			draw();
		}
		
		
		
	}

	//remove function for snake
	public function remove():Void{
		for(b in body){
			removeFromGrid(b);
		}
		removed = true;
	}
	public function new(color:UInt, 
		startSize:UInt, 
		headLocation:Point, 
		orientation:String, 
		startDirX:Float, 
		startDirY:Float, 
		grid:Grid){
		
		
		var self:Snake = this;
		self.size = grid.cellSize;
		self.body = new Array<Segment>();
		self.color = color;
		self.xd = startDirX;
		self.yd = startDirY;
		self.isDead = false;


		setSnakeStartProperties(color, startSize, headLocation, orientation, startDirX, startDirY);

		//grab the add and remove child functions for later so 
		//sneks can do it themselves 
		self.addToGrid = grid.addChild;
		self.removeFromGrid = grid.removeChild;
		
		for(s in self.body){
			self.addToGrid(s);
		}
		
	}

}