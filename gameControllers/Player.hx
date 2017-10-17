class Player{

	public var controls:Map<String, String>;
	public var snake:Snake;

	public function new(controls:Map<String, String>, snake:Snake){
		var self:Player = this;
		self.controls = controls;
		self.snake = snake;
	}
}