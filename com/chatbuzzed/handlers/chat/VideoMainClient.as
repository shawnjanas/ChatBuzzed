package com.chatbuzzed.handlers.chat {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Video;
	import flash.net.NetStream;
	import flash.ui.Mouse;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.display.Sprite;
	
	import fl.controls.Button;
	
	import com.chatbuzzed.display.CustomVideo;
	import com.chatbuzzed.interfaces.IVideoClient;
	import com.chatbuzzed.utils.Hashtable;
	
	public class VideoMainClient implements IVideoClient {
		
		public var partnersCam:CustomVideo;
		public var yourCam:CustomVideo;
		
		private static var partnersCamWidth:int = 468;
		private static var partnersCamHeight:int = 352;
		
		private static var yourCamWidth:int = 139;
		private static var yourCamHeight:int = 100;
		
		public var playerContainer:Sprite;
		public var startBtn:Button;
		public var nextBtn:Button;
		public var statusBar:VidStatusBar;
		
		public function VideoMainClient(streamIn:NetStream,streamOut:NetStream):void {
			partnersCam = new CustomVideo(partnersCamWidth,partnersCamHeight,streamIn,false);
			partnersCam.x = 1;
			partnersCam.y = 1;
			
			yourCam = new CustomVideo(yourCamWidth,yourCamHeight,streamOut,true,ChatHandler.optionsContainer.tabContent.get("Setup").getCamera(),ChatHandler.optionsContainer.tabContent.get("Setup").getMicrophone());
			yourCam.x = 5;
			yourCam.y = partnersCamHeight - yourCamHeight - 5;
			
			ChatHandler.videoContainer.addChild(partnersCam);
			ChatHandler.videoContainer.addChild(yourCam);
			
			playerContainer = new Sprite();
			playerContainer.x = 355;
			playerContainer.y = 320;
			
			startBtn = new Button();
			nextBtn = new Button();
			
			startBtn.label = "Start";
			nextBtn.label = "Next";
			
			startBtn.width = 50;
			nextBtn.width = 50;
			
			startBtn.x = startBtn.width + 5;
			nextBtn.enabled = false;
			
			startBtn.addEventListener(MouseEvent.CLICK,onStart);
			nextBtn.addEventListener(MouseEvent.CLICK,onNext);
			
			playerContainer.addChild(nextBtn);
			playerContainer.addChild(startBtn);
			
			statusBar = new VidStatusBar();
			statusBar.y = 1;
			statusBar.x = 1;
			ChatHandler.videoContainer.addChild(statusBar);
			
			ChatHandler.videoContainer.addChild(playerContainer);
		}
		
		public function setNetStreams(streamOut:NetStream,streamIn:Array):void {
			partnersCam.setNetStream(streamIn[0]);
		}
		public function remove():void {
			ChatHandler.videoContainer.removeChild(partnersCam);
			ChatHandler.videoContainer.removeChild(yourCam);
		}
		
		
		private function onStart(evt:MouseEvent):void {
			if((evt.target as Button).label == "Start") {	//Start 
				ChatHandler.connectionHandler.onStart();
				(evt.target as Button).label = "Stop";
				ChatHandler.messageBoxHandler.addTextAreaLine("Searching for a partner. Please wait...");
				setStatus("Looking for a new partner, please wait...");
				yourCam.startVideo();
			} else {													//Stop
				ChatHandler.connectionHandler.onStop();
				(evt.target as Button).label = "Start";
			}
		}
		private function onNext(evt:MouseEvent):void {
			ChatHandler.connectionHandler.onNext();
		}
		
		public function getNextBtn():Button {
			return nextBtn;
		}
		public function getStartBtn():Button {
			return startBtn;
		}
		public function getPartnersCam():CustomVideo {
			return partnersCam;
		}
		public function getYourCam():CustomVideo {
			return yourCam;
		}
		public function getStatusBar():VidStatusBar {
			return statusBar;
		}
		public function setStatus(_status:String,via:String = "cb"):void {
			if(via != "cb") {
				getStatusBar()._status.width = 410;
			} else {
				getStatusBar()._status.width = 425;
			}
			getStatusBar()._via.gotoAndStop(via);
			getStatusBar()._status.text = _status;
		}
		
		
		
		/*private function onMove(evt:ResizableEvent):void {
			trace("#Client:onMove");
			var tempX:Number = evt._object.x - evt._object.xOffset;
			var tempY:Number = evt._object.y - evt._object.yOffset;
			if(tempX + yourCamWidth < partnersCamWidth && tempX > 0) {
				yourCam.x = tempX;
			}
			if(tempY + yourCamHeight < partnersCamHeight && tempY > 0) {
				yourCam.y = tempY;
			}
		}
		private function onResize(evt:ResizableEvent):void {
			var type:String = evt._object.type;
			var tempX:Number;
			var tempY:Number;
			var tempWidth:Number;
			var tempHeight:Number;
			if(type == "topLeft") {
				tempX = evt._object.x;
				tempY = evt._object.y;
				tempWidth = yourCamWidth + evt._object.xStart - evt._object.x;
				tempHeight = yourCamHeight + evt._object.yStart - evt._object.y;
			}
			yourCamWidth = tempWidth;
			yourCamHeight = yourCamHeight;
			trace(yourCamWidth,yourCamHeight);
			yourCam.setTheSize(yourCamWidth,yourCamHeight);
			/if(tempX + yourCamWidth < partnersCamWidth && tempX > 0) {
				yourCam.x = tempX;
			}
			if(tempY + yourCamHeight < partnersCamHeight && tempY > 0) {
				yourCam.y = tempY;
			}
		}*/
	}
}