package com.chatbuzzed.display {
	
	import flash.display.MovieClip;
	
	public class EditableTab extends Tab {
		
		private var tab:Tab;
		
		public function EditableTab(_name:String):void {
			super(_name);
			
			this._title.text = _name;
		}
	}
}