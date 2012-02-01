package com.chatbuzzed.handlers {
	
	import flash.media.Sound;
	
	public class SoundHandler {
		
		public var soundClips:Object;
		
		public function SoundHandler():void {
			soundClips = new Object();
			soundClips["message"] = new Message();
		}
		
		public function play(_name:String):void {
			(soundClips[_name] as Sound).play()
		}
	}
} 