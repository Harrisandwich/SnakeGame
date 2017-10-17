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

    private var settings:Map<String, Dynamic>;
    private var game:Game;
    private function init():Void{

        /*
            settings["gridSize"]:UInt
            settings["numberOfPlayers"]:UInt
            settings["startOrientation"]:String
            settings["maxItems"]:UInt
            settings["speed"]
            settings["playAreaSize"]stage.stageWidth/2

            settings["controls"]:Array<Map<String, String/enum>>
                Input.setAction(settings["controls"][s]["right"], snakes[s].right);
                Input.setAction(settings["controls"][s]["left"], snakes[s].left);
                Input.setAction(settings["controls"][s]["up"], snakes[s].up);
                Input.setAction(settings["controls"][s]["down"], snakes[s].down);
        */
        //allow these things to be set somewhere
        settings = [
            "gridSize" => 30,
            "numberOfPlayers" => 2,
            "startOrientation" => "hor",
            "maxItems" => 1,
            "speed" => 500,
            "playAreaSize" => (stage.stageWidth/2),
            "controls" => [
                [
                    "left" => "left_arrow",
                    "right" => "right_arrow",
                    "down" => "down_arrow",
                    "up" => "up_arrow",
                ],
                [
                    "left" => "a",
                    "right" => "d",
                    "down" => "s",
                    "up" => "w",
                ],
            ]
        ];
        game = new Game(settings);
        stage.addChild(game);
        game.setupGame();
        game.play();

    }
    public function new() 
    {
        super();    
        addEventListener(Event.ADDED_TO_STAGE, added);
    }
    function added(e) 
    {
        removeEventListener(Event.ADDED_TO_STAGE, added);
        //stage.addEventListener(Event.RESIZE, resize);
        init();
    }
    
    static function main() {

        //stage.align = flash.display.StageAlign.TOP_LEFT;
        //stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
        Lib.current.addChild(new Main());
    	

        

    }

    
}
