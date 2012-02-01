package com.chatbuzzed.events {

	import flash.events.Event;
	
	public class TabEvent extends Event {
		
		public static var SELECT:String = "onSelect";
		
		public var _name:String;
		
		public function TabEvent(type:String, name:String):void {
			super(type);
			this._name = name;
		}
	}
}