/*
	Author: Harrison Hutcheon
	Date: October 2017
*/

package gameControllers;

import flash.geom.Point;

//Custom Classes
import entities.Collectable;

class ItemSpawner{


	//generate a new item in a random location
	public static function spawnItem(color:UInt, size:Float, gridSize:UInt, value:UInt):Collectable{
		
		var location = new Point();
		location.x = (Math.round(Math.random() * (gridSize - 1)));
		location.y = (Math.round(Math.random() * (gridSize - 1)));

		var newCollectable = new Collectable(color,size,location,value);

		return newCollectable;
	}
}