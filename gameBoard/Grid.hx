package gameBoard;

class Grid extends Sprite{
	/*
		cellSize
		gridSize
		cells

		init()
	*/
	private var grid:Array;

	private function initializeGrid(size:UInt):Array{
		var newGrid:Array;

	}
	public function new(gridSize:UInt){
		/*
			NOTE: Should I calculate cell size based on screen dimensions?
		*/

		grid = initializeGrid(gridSize);
	}
}