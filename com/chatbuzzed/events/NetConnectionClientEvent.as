package com.chatbuzzed.events {

	import flash.events.Event;
	
	public class NetConnectionClientEvent extends Event {
		
		public var infoObject:Object;
		
		public function NetConnectionClientEvent(type:String, infoObject:Object):void {
			super(type);
			this.infoObject = infoObject;
		}
	}
}
