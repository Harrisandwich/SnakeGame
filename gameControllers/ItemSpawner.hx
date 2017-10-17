package gameControllers;

import flash.geom.Point;

//Custom Classes
import entities.Collectable;

class ItemSpawner{


	//possibly extend to take specifics for item types 
	public static function spawnItem(color:UInt, size:Float, gridSize:UInt, value:UInt):Collectable{
		
		var location = new Point();
		location.x = (Math.round(Math.random() * (gridSize - 1)));
		location.y = (Math.round(Math.random() * (gridSize - 1)));

		trace(location.x + " " + location.y);
		var newCollectable = new Collectable(0xFFFF00,size,location,value);

		return newCollectable;
	}
}