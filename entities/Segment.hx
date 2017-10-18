/*
	Author: Harrison Hutcheon
	Date: October 2017
*/

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
	public var size:Float;
	public var location:Point; 
	public var previousLocation:Point; 
	public var isDead:Bool;

	//take the grid position and translate it to a position within flash
	private function setWorldPos():Void{
		var self:Segment = this;
		self.x = self.location.x * size;
		self.y = self.location.y * size;
	}
	
	//move the segment to a new location
	public function move(newLocation:Point){

		var self:Segment = this;

		previousLocation = new Point(location.x, location.y);
		location = new Point(newLocation.x, newLocation.y);

		setWorldPos();
	}
	//draw the graphical representation of the segment
	public function draw(){

		square.graphics.beginFill(color);
        square.graphics.drawRoundRect(0, 0, size, size, 10);
        square.x = 0;
        square.y = 0;
	}
	//set the properties of the segment
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