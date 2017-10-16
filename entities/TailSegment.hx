package entities;

import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

//Custom classes
import entities.Segment;

class TailSegment extends Segment{
	
	public function new(color:UInt, x:Float, y:Float, size:Float){
		super(color, x, y, size);
	}
}