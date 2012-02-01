package com.chatbuzzed.display {
	
	import flash.display.MovieClip;
	
	public class StaticTab extends Tab {
		
		public function StaticTab(_name:String):void {
			super(_name);
			
			this._title.text = _name;
		}
	}
}