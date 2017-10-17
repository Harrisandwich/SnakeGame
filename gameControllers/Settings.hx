package gameControllers;

class Settings{

	private static var settings:Map<String, Dynamic>;

	public static function setDefaults():Map<String, Dynamic>{
		settings = [
            "gridSize" => 40,
            "numberOfPlayers" => 1,
            "startOrientation" => "hor",
            "maxItems" => 1,
            "speed" => 500,
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