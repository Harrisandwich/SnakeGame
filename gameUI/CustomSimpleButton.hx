/*
    Author: Harrison Hutcheon
    Date: October 2017
*/

package gameUI;

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;

import gameUI.ButtonDisplayState;

class CustomSimpleButton extends Sprite {

    private var upColor:UInt   = 0xFFCC00;
    private var overColor:UInt = 0xCCFF00;
    private var downColor:UInt = 0x00CCFF;
    private var buttonWidth:UInt      = 80;
    private var buttonHeight:UInt      = 40;
    private var buttonText:TextField;
    public var button:SimpleButton;
    public var buttonState:Bool;



    public function new(text:String, toggle:Bool) {
        super();
        
        //button
        button = new SimpleButton();
        button.downState      = new ButtonDisplayState(downColor, buttonWidth, buttonHeight,true);
        button.overState      = new ButtonDisplayState(overColor, buttonWidth, buttonHeight);
        button.upState        = new ButtonDisplayState(upColor, buttonWidth, buttonHeight);
        button.hitTestState   = new ButtonDisplayState(upColor, buttonWidth * 2, buttonHeight * 2);
        button.hitTestState.x = -(buttonWidth / 4);
        button.hitTestState.y = button.hitTestState.x;
        button.useHandCursor  = true;

        buttonText = new TextField();
        buttonText.text = text;
        buttonText.setTextFormat(new TextFormat("Calibri",24,0x000000,false,false));
        buttonText.x = button.width/2 - buttonText.width/2;
        buttonText.y = (button.height/2) - 10;
        buttonText.autoSize = flash.text.TextFieldAutoSize.CENTER;
        buttonText.selectable = false;
        buttonText.mouseEnabled = false;
        buttonState = false;
        addChild(button);
        addChild(buttonText);

        if(toggle){
            button.addEventListener(MouseEvent.CLICK,clickEvent);
        }
        
    }

    public function setText(text:String){
        buttonText.text = text;
    }



    public function buttonToggle(button:SimpleButton){
        var currDown:DisplayObject = button.downState;
        button.downState = button.upState;
        button.upState = currDown;
        buttonState = !buttonState;
    }

    private function clickEvent(e:MouseEvent){
        
        buttonToggle(e.target);
    }
}

