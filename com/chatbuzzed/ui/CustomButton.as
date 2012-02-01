package com.chatbuzzed.ui {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import caurina.transitions.*;
	
	public class CustomButton extends MovieClip {
		
		public var rollOverMC:MovieClip;
		public var buttonMC:MovieClip;
		
		public function CustomButton():void {
			
		}
		
		public function setUpButton(responder:Function, _rollOverMC:MovieClip = null, _buttonMC:MovieClip = null):void {
			rollOverMC = _rollOverMC;
			if(_buttonMC == null) {buttonMC = this;}
			else {buttonMC = _buttonMC;}
			
			
			_buttonMC.buttonMode = true;
			_buttonMC.useHandCursor = true;
			setEventListeners(responder);
		}
		
		/**
		 * Sets the settings for the navigator movieclip to appear as selectable or nonselectable
		 */
		public function setButtonMode(bool:Boolean):void {
			this.buttonMode 	= bool;
			this.useHandCursor 	= bool;
		}
		
		/**
		 * Sets the event listeners for the navigator movieclip
		 */
		public function setEventListeners(clickedFunction:Function):void {
			buttonMC.addEventListener(MouseEvent.MOUSE_OVER, 	mouse_over);
			buttonMC.addEventListener(MouseEvent.MOUSE_OUT, 	mouse_out);
			buttonMC.addEventListener(MouseEvent.MOUSE_DOWN, 	mouse_down);
			buttonMC.addEventListener(MouseEvent.MOUSE_UP, 		mouse_up);
			buttonMC.addEventListener(MouseEvent.CLICK, 		clickedFunction);
		}
		/**
		 * Removes the event listeners for the navigator movieclip
		 */
		public function removeEventListeners(clickedFunction:Function):void {
			buttonMC.removeEventListener(MouseEvent.MOUSE_OVER,	mouse_over);
			buttonMC.removeEventListener(MouseEvent.MOUSE_OUT, 	mouse_out);
			buttonMC.removeEventListener(MouseEvent.MOUSE_DOWN,	mouse_down);
			buttonMC.removeEventListener(MouseEvent.MOUSE_UP, 	mouse_up);
			buttonMC.removeEventListener(MouseEvent.CLICK, 		clickedFunction);
		}
		
		/**
		 * These functions are triggered by the event listeners
		 */
		private function mouse_over(evt:MouseEvent):void {
			trace(evt.target);
			evt.target.gotoAndStop("over");
			trace(rollOverMC);
			if(rollOverMC != null) {
				Tweener.addTween(rollOverMC,{alpha: 1, time:1});
			}
		}
		private function mouse_out(evt:MouseEvent):void {
			evt.target.gotoAndStop("out");
			if(rollOverMC != null) {
				Tweener.addTween(rollOverMC,{alpha: 0, time:1});
			}
		}
		private function mouse_down(evt:MouseEvent):void {
			evt.target.gotoAndStop("down");
		}
		private function mouse_up(evt:MouseEvent):void {
			evt.target.gotoAndStop("selected");
			if(rollOverMC != null) {
				Tweener.addTween(rollOverMC,{alpha: 0, time:1});
			}
		}
	}
}