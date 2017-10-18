/*
    Author: Harrison Hutcheon
    Date: October 2017
*/

package gameControllers;

/*
    game settings live here
*/  

import utilities.Constants;
class Settings{

	private static var settings:Map<String, Dynamic>;

	public static function setDefaults():Map<String, Dynamic>{
		settings = [
            "gridSize" => Constants.AREA_MED,
            "numberOfPlayers" => 1,
            "startOrientation" => "hor",
            "maxItems" => 1,
            "speed" => Constants.SPEED_NORMAL,
            "vsComputer" => false,
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
		return settings;
	}

	public static function setProperty(prop:String, value:Dynamic){
		if(settings[prop] != null){
			settings[prop] = value;
		}
	}

	public static function getSettings(){
		return settings;
	}
}