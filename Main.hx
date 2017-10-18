import haxe.Timer;
import flash.geom.Point;
import flash.events.KeyboardEvent;
import flash.events.Event;
import flash.display.Sprite;
import flash.display.Shape;
import flash.Lib;

//Custom classes
import inputUtilities.Input;

import playArea.Grid;

import entities.Snake;
import entities.Collectable;

import gameControllers.ItemSpawner;
import gameControllers.Game;

class Main extends Sprite {

    private var game:Game;
    private function init():Void{
        
        game = new Game(stage.stageWidth);
        stage.addChild(game);
        game.init();
        game.setupGame();

    }
    public function new() 
    {
        super();    
        addEventListener(Event.ADDED_TO_STAGE, added);
    }
    function added(e) 
    {
        removeEventListener(Event.ADDED_TO_STAGE, added);
        init();
    }
    
    static function main() {

        Lib.current.addChild(new Main());
    }

    
}
