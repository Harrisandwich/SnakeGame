package entities;

import flash.geom.Point;
import flash.display.Shape;
import flash.display.Sprite;

//Custom Classes
import entities.interfaces.ICollectable;

class Collectable extends Sprite implements ICollectable{

	private var color:UInt;
	private var size:Float;
	public var value:UInt;

	public var location:Point;
	private var shape:Shape;
	

	public function draw():Void{

		var self:Collectable = this;
		shape.graphics.beginFill(self.color);
        shape.graphics.drawRoundRect(0, 0, self.size, self.size, 10);
        shape.x = 0;
        shape.y = 0;
	}

	public function new(color,size,location,value):Void{
		super();
		var self:Collectable = this;
		self.shape = new Shape();
		self.color = color;
		self.size = size;
		self.location = location;
		self.value = value;
		self.addChild(shape);
		draw();
	}

}