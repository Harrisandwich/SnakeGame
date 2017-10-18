/*
	Author: Harrison Hutcheon
	Date: October 2017
*/

package entities.interfaces;

import flash.display.Shape;
import flash.geom.Point;

interface ICollectable{

	private var color:UInt;
	private var size:Float;
	private var location:Point;
	public var value:UInt;
	private var shape:Shape;

	public function draw():Void;

}