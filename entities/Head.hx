package entities;

//Custom Classes
import entities.Segment;

class Head extends Segment{


	public function changeDirection(dir:String){
		
		if(dir == "left"){

		}else if(dir == "right"){

		}else if(dir == "up"){

		}else{

		}
	}

	public function new(color:UInt, newLocation:Point){
		super(color, newLocation);
	}

}