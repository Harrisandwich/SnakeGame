/*
    Author: Harrison Hutcheon
    Date: October 14th, 2017
*/
package inputUtilities;


class Key {

	public var keyCode:UInt;
	public var pressed:Bool;
	public var action:Void->Void;

	public function new(code:UInt) 
    {
           keyCode = code;
           pressed = false;
    }
}