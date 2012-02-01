package com.chatbuzzed.handlers.chat {
	
	import flash.display.MovieClip;
	import com.chatbuzzed.interfaces.IVideoClient;
	
	public class VideoContainer extends MovieClip {
		
		private var videoClient:IVideoClient;
		
		public function VideoContainer():void {
			videoClient = null;
		}
		
		public function setClient(client:IVideoClient):void {
			if(videoClient != null) {
				videoClient.remove();
			}
			videoClient = client;
		}
		
		public function getVideoClient():IVideoClient {
			return videoClient;
		}
	}
}