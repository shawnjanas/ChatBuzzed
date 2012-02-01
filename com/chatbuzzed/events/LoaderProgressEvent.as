package com.chatbuzzed.events {
	
	import flash.events.Event;
	
	public class LoaderProgressEvent extends Event {
		
		public static const PROGRESS_CHANGED = "progressChanged";
		public var loaderPercent:Number;
		
		public function LoaderProgressEvent(lp:Number):void {
			super(PROGRESS_CHANGED);
			loaderPercent = lp;
		}
	}
}