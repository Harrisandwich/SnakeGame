package entities;

import flash.geom.Point;
import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

//Custom classes
import playArea.Cell;

class Segment extends Sprite{

	private var color:UInt;
	private var square:Shape;
	private var size:Float;
	public var location:Point; 
	public var previousLocation:Point; 

	private function setWorldPos():Void{
		var self:Segment = this;
		self.x = self.location.x * size;
		self.y = self.location.y * size;
	}
	public function moveHead(xd:Float, yd:Float){

		var self:Segment = this;
		var newLocation = new Point(location.x, location.y);
		newLocation.x += xd;
		newLocation.y += yd;

		previousLocation = new Point(location.x, location.y);
		location = new Point(newLocation.x, newLocation.y);

		self.x = self.location.x * size;
		self.y = self.location.y * size;
	}

	public function move(newLocation:Point){

		var self:Segment = this;

		previousLocation = new Point(location.x, location.y);
		location = new Point(newLocation.x, newLocation.y);

		self.x = self.location.x * size;
		self.y = self.location.y * size;
	}

	public function draw(){

		square.graphics.beginFill(color);
        square.graphics.drawRoundRect(0, 0, size, size, 10);
        square.x = 0;
        square.y = 0;
	}

	public function new(color:UInt, posX:Float, posY:Float, size:Float){
		super();

		var self:Segment = this;
		self.square = new Shape();
		self.size = size;
		self.color = color;
		self.location = new Point(posX, posY);
		self.addChild(square);
		self.draw();

		setWorldPos();

	}

}