package gameBoard;

class Grid extends Sprite{
	/*
		cellSize
		gridSize
		cells

		
	*/
	private var grid:Array;

	private function initializeGrid(size:UInt):Array{
		var newGrid:Array;

		/*for(i in 0...size){

		}*/

	}
	public function new(gridSize:UInt){
		/*
			NOTE: Should I calculate cell size based on screen dimensions?
		*/

		grid = initializeGrid(gridSize);
	}
}