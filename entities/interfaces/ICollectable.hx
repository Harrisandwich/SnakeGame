package entities.interfaces;

import flash.geom.Point;

interface ICollectable{

	private var color:UInt;
	private var size:Float;
	private var location:Point;
	public var value:UInt;

	public function draw():Void;

}