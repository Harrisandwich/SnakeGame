package playArea;

class Grid extends Sprite{
	/*
		cellSize
		gridSize
		cells

		
	*/
	private var grid:Array;

	private function initializeGrid(size:UInt):Array{
		var newGrid:Array;

		/*
			I need:
			- height of play space 
			- width of play space 
		*/

	}
	public function new(gridSize:UInt){
		/*
			NOTE: Should I calculate cell size based on screen dimensions?
		*/

		grid = initializeGrid(gridSize);
	}
}