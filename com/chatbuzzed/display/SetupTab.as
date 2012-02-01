package com.chatbuzzed.display {
	
	import flash.display.MovieClip;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.media.Video;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.chatbuzzed.handlers.chat.ChatHandler;
	
	public class SetupTab extends MovieClip {
		
		private var webCam:Video;
		private var isTesting:Boolean;
		
		private var camera:Camera;
		private var mic:Microphone;
		
		public function SetupTab():void {
			for(var i:int = 0; i < Camera.names.length; i++) {
				cameraNames.addItem({label:Camera.names[i].toString(),index:i});
			}
			cameraNames.selectedIndex = 0;
			cameraNames.addEventListener(Event.CHANGE,onBoxChange);
			
			var mic:Microphone = Microphone.getMicrophone();
			for(var m:int = 0; m < Microphone.names.length; m++) {
				micNames.addItem({label:Microphone.names[m].toString(), index:m});
			}
			micNames.selectedIndex = 0;
			micNames.addEventListener(Event.CHANGE,onBoxChange);
			
			test.addEventListener(MouseEvent.CLICK, onTest);
			publishSettings.addEventListener(MouseEvent.CLICK, onPublishSettings);
			
			isTesting = false;
			camera = Camera.getCamera();
			mic = Microphone.getMicrophone();
		}
		
		private function setPublishingMedia():void {
			camera = Camera.getCamera(""+cameraNames.selectedIndex);
			publishingCam.text = cameraNames.selectedItem.label;
			
			mic = Microphone.getMicrophone(micNames.selectedIndex);
			publishingMic.text = micNames.selectedItem.label;
		}
		
		private function refreshVideo():void {
			if(webCam != null) {
				removeChild(webCam);
			}
			webCam = new Video(314,236);
			webCam.x = 0;
			webCam.y = 22;
			addChild(webCam);
		}
		
		private function onTest(evt:MouseEvent):void {
			if(isTesting) {		//Not Publishing
				refreshVideo();
				test.label = "Test";
				isTesting = false;
			} else {					//Publishing
				refreshVideo();
				viewMedia();
				test.label = "Stop";
				isTesting = true;
			}
		}
		
		private function viewMedia():void {
			var tempCam:Camera = Camera.getCamera(""+cameraNames.selectedIndex);
			tempCam.setMode(468,352,30);
			webCam.attachCamera(tempCam);
		}
		
		private function onPublishSettings(evt:MouseEvent):void {
			setPublishingMedia();
			if(ChatHandler.videoContainer.getVideoClient().getStartBtn().label == "Stop") {
				ChatHandler.videoContainer.getVideoClient().getYourCam().setCamera(camera);
				ChatHandler.videoContainer.getVideoClient().getYourCam().setMicrophone(mic);
			}
		}
		
		private function onBoxChange(evt:Event):void {
			if(isTesting) {
				viewMedia();
			}
		}
		
		
		public function getCamera():Camera {
			return camera;
		}
		public function getMicrophone():Microphone {
			return mic;
		}
	}
}