package com.chatbuzzed.interfaces {
	
	import flash.net.NetStream;
	
	import fl.controls.Button;
	
	import com.chatbuzzed.display.CustomVideo;
	import com.chatbuzzed.handlers.chat.VidStatusBar;
	
	public interface IVideoClient {
		
		function remove():void;
		function setNetStreams(streamOut:NetStream,streamIn:Array):void;
		function getNextBtn():Button;
		function getStartBtn():Button;
		function getPartnersCam():CustomVideo;
		function getYourCam():CustomVideo;
		function getStatusBar():VidStatusBar;
		function setStatus(_status:String,via:String = "cb"):void;
		//function addNetStreams():void;
	}
}