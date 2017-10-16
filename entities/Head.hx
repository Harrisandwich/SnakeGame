package entities;

//Custom Classes
import entities.Segment;

class Head extends Segment{

	public function changeDirection(dir:String){
		
		if(dir == "left"){
			this.location.x -= 1;
			this.location.y = neck.location.y;
		}else if(dir == "right"){
			this.location.x += 1;
			this.location.y = neck.location.y;
		}else if(dir == "up"){	
			this.location.y -= 1;
			this.location.x = neck.location.x;
		}else{
			//down
			this.location.y += 1;
			this.location.x = neck.location.x;
		}
	}

	public function move(dir:String){
		this.previousLocation = this.location;

		if(dir == "left"){
			this.location.x -= 1;
		}else if(dir == "right"){
			this.location.x += 1;
		}else if(dir == "up"){	
			this.location.y -= 1;
		}else{
			//down
			this.location.y += 1;
		}
	}
	public function new(color:UInt, x:Float, y:Float){
		super(color, x, y);
	}

}