/*
    Author: Harrison Hutcheon
    Date: October 14th, 2017
*/

package inputUtilities;
import inputUtilities.Key;



class Keyboard {

	public static var keyMap:Map<String, Key> =[
			"up_arrow" => new Key(38),
    		"down_arrow" => new Key(40),
    		"left_arrow" => new Key(37),
    		"right_arrow" => new Key(39)
    	];
    
    public static function setAction(key:String, action:Void->Void){
    	keyMap[key].action = action;
    }

    public static function getKeyByCode(keyCode:UInt):Key {
    	var key:Key = null;

    	for (value in keyMap) {
	      if(value.keyCode == keyCode){
	      	key = value;
	      	break;
	      }
	    }
	    return key;

    }
    	
}