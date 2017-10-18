package playArea;

import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

import playArea.Cell;

class Grid extends Sprite{


	private var grid:Array<Array<Cell>>;
	public var cellSize:Float;

	private function initializeGrid(size:UInt, playAreaSize:Float):Array<Array<Cell>>{
		var newGrid:Array<Array<Cell>> = new Array();
		cellSize = playAreaSize/size;

		for(r in 0...size){
			var newRow:Array<Cell> = new Array();
			newGrid.push(newRow);
			for(c in 0...size){
				var newCell:Cell = new Cell(r,c);
				newCell.size = cellSize;
				newGrid[r].push(newCell);
			}
		}

		return newGrid;

	}
	public function new(gridSize:UInt, playAreaSize:Float){

		super();
		grid = initializeGrid(gridSize, playAreaSize);
	}
}