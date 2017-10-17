package playArea;

import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

import playArea.Cell;

class Grid extends Sprite{
	/*
		cellSize
		gridSize
		cells
	*/
	public var cellSize:Float;
	private var grid:Array<Array<Cell>>;

	private function initializeGrid(size:UInt, playAreaSize:Float):Array<Array<Cell>>{
		var newGrid:Array<Array<Cell>> = new Array();
		cellSize = playAreaSize/size;
		/*
			I need:
			- height of play space 
			- width of play space 
		*/
		trace("cell size: " + cellSize);
		for(r in 0...size){
			var newRow:Array<Cell> = new Array();
			newGrid.push(newRow);
			for(c in 0...size){
				var newCell:Cell = new Cell(r,c);
				newCell.size = cellSize;
				newGrid[r].push(newCell);

				//drawing the grid for debug purposes
				/*var cellBack:Shape = new Shape();
		        cellBack.graphics.beginFill(0x993333);
		        cellBack.graphics.drawRoundRect(0, 0, cellSize, cellSize, 10);
		        cellBack.x = newCell.x * cellSize;
		        cellBack.y = newCell.y * cellSize;

		        this.addChild(cellBack);*/ 

			}
		}

		return newGrid;

	}
	public function new(gridSize:UInt, playAreaSize:Float){
		/*
			NOTE: Should I calculate cell size based on screen dimensions?
		*/
		super();
		grid = initializeGrid(gridSize, playAreaSize);
	}
}