/*
    Author: Harrison Hutcheon
    Date: October 14th, 2017
*/

package inputUtilities;

import flash.events.KeyboardEvent;
import flash.events.Event;
import inputUtilities.Keyboard;

class Input{

    //map action to key
    public static function setAction(id:String, action:Void->Void){
    	Keyboard.setAction(id, action);
    	
    }
    
    //get key down event
    public static function keyDown(event:KeyboardEvent){
        
    	var key:Key = Keyboard.getKeyByCode(event.keyCode);
        if(key != null){
            key.pressed = true;
            key.action();
        }   
    }
    //get key up event
    public static function keyUp(event:KeyboardEvent){
    	
    	var key:Key = Keyboard.getKeyByCode(event.keyCode);
        if(key != null){
            key.pressed = false;
        } 
    }
}