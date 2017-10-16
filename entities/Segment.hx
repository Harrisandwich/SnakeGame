package entities;

import flash.geom.Point;
import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

//Custom classes
import gameBoard.Cell;

class Segment extends Sprite{

	private var color:UInt;
	private var square:Shape;
	public var location:Point; 
	public var previousLocation:Point; 


	public function move(newLocation:Point){

		previousLocation = new Point(location.x, location.y);
		location = new Point(newLocation.x, newLocation.y);
	}

	public function draw(color:UInt){

		//0x333333
		/*square.graphics.beginFill(color);
        square.graphics.drawRoundRect(0, 0, size, size, 10);
        square.x = 0;
        square.y = 0;*/
	}

	public function new(color:UInt, posX:Float, posY:Float){
		super();

		var self:Segment = this;
		self.square = new Shape();
		self.color = color;
		self.location = new Point(posX, posY);

		self.addChild(square);
		self.draw(color);

	}

}