package gameControllers;

import flash.geom.Point;

//Custom Classes
import entities.Collectable;

class ItemSpawner{


	//possibly extend to take specifics for item types 
	public static function spawnItem(color:UInt, size:Float, gridSize:UInt, value:UInt):Collectable{
		
		var location = new Point();
		location.x = (Math.round(Math.random() * (gridSize - 0 + 1)) + 0);
		location.y = (Math.round(Math.random() * (gridSize - 0 + 1)) + 0);
		var newCollectable = new Collectable(0xFFFF00,size,location,value);

		return newCollectable;
	}
}