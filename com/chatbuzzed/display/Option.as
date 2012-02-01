package com.chatbuzzed.display {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import com.chatbuzzed.ui.CustomButton;
	import com.chatbuzzed.handlers.chat.ChatHandler;
	
	public class Option extends CustomButton {
		
		private var _name:String;
		private var content:MovieClip;
		
		public function Option(_name:String,_content:MovieClip):void {
			this._title.text = _name;
			
			this._name = _name;
			this.content = _content;
			
			this.mouseChildren = false;
			
			setUpButton(onClick);
		}
		
		public function onClick(evt:MouseEvent):void {
			ChatHandler.optionsContainer.addTab(_name,content,true);
		}
		
	}
	
}