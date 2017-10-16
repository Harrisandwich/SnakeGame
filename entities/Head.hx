package entities;

//Custom Classes
import flash.geom.Point;
import entities.Segment;

class Head extends Segment{

	public function changeDirection(dir:String, neck:Segment){
		var self:Head = this;
		var newLocation = new Point();

		if(dir == "left"){
			newLocation.x = neck.location.x - 1;
			newLocation.y = neck.location.y;
		}else if(dir == "right"){
			newLocation.x = neck.location.x + 1;
			newLocation.y = neck.location.y;
		}else if(dir == "up"){	
			newLocation.x = neck.location.x;
			newLocation.y = neck.location.y - 1;
		}else{
			//down
			newLocation.x = neck.location.x;
			newLocation.y = neck.location.y + 1;
		}

		self.location = newLocation;
		setWorldPos();
	}

	public function moveHead(dir:String):Void{

		var self:Head = this;
		var newLocation = new Point(self.location.x,self.location.y);

		if(dir == "left"){
			newLocation.x -= 1;
		}else if(dir == "right"){
			newLocation.x += 1;
		}else if(dir == "up"){	
			newLocation.y -= 1;
		}else{
			//down
			newLocation.y += 1;
		}
		self.previousLocation = new Point(self.location.x, self.location.y);
		self.location = new Point(newLocation.x, newLocation.y);
		self.x = self.location.x * size;
		self.y = self.location.y * size;
	}
	public function new(color:UInt, x:Float, y:Float, size:Float){
		super(color, x, y, size);
	}

}