package com.chatbuzzed.display {
	
	import flash.events.MouseEvent;
	
	import com.chatbuzzed.ui.CustomButton;
	import com.chatbuzzed.events.TabEvent;
	
	public class Tab extends CustomButton {
		
		private var _name:String;
		
		public function Tab(name:String):void {
			_name = name;
			this.mouseChildren = false;
			
			setUpButton(onClick,null,this);
		}
		
		public function select():void {
			gotoAndStop("selected");
			removeEventListeners(onClick);
			setButtonMode(false);
		}
		
		public function unselect():void {
			gotoAndStop("out");
			setEventListeners(onClick);
			setButtonMode(true);
		}
		
		public function onClick(evt:MouseEvent) {
			dispatchEvent(new TabEvent(TabEvent.SELECT,_name));
		}
	}
}