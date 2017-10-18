/*
    Author: Harrison Hutcheon
    Date: October 14th, 2017
*/

package inputUtilities;

import flash.events.KeyboardEvent;
import flash.events.Event;
import inputUtilities.Keyboard;

class Input{

    public static function setAction(id:String, action:Void->Void){
    	Keyboard.setAction(id, action);
    	
    }
    
    public static function keyDown(event:KeyboardEvent){
        
    	var key:Key = Keyboard.getKeyByCode(event.keyCode);
        if(key != null){
            key.pressed = true;
            key.action();
        }   
    }

    public static function keyUp(event:KeyboardEvent){
    	
    	var key:Key = Keyboard.getKeyByCode(event.keyCode);
        if(key != null){
            key.pressed = false;
        } 
    }
}