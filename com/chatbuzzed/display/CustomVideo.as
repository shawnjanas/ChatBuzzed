package com.chatbuzzed.display {
	
	import flash.display.Sprite;
	import flash.media.Video;
	import flash.media.Camera;
	import flash.media.Microphone;
	import flash.net.NetStream;
	
	import com.chatbuzzed.handlers.chat.ChatHandler;
	
	public class CustomVideo extends Sprite {
		
		//Video Properties
		private var netStream:NetStream;
		private var camera:Camera;
		private var microphone:Microphone;
		private var video:Video;
		
		private var vidWidth:int;
		private var vidHeight:int;
		
		private var vidPublishing:Boolean;
		private var streamName:String;
		private var isPublishing:Boolean;
		
		/**
		 *  Constructor.
		 */
		public function CustomVideo(_width:int,_height:int,ns:NetStream,isPublishing:Boolean,cam:Camera = null,mic:Microphone = null):void {
			vidWidth = _width;
			vidHeight = _height;
			video = null;
			
			netStream = ns;
			camera = cam;
			if(camera != null) {
				camera.setMode(468, 352, 15, true);
				camera.setQuality(0,73);
			}
			microphone = mic;
			if(microphone != null) {
				microphone.rate = 11;
				microphone.setUseEchoSuppression(true);
			}
			
			vidPublishing = isPublishing;
			isPublishing = false;
		}
		
		/**
		 *  @return The connected NetStream
		 */
		public function getNetStream():NetStream {
			
			return netStream;
		}
		
		/**
		 *  Sets the camera instance
		 */
		public function refreshVideo():void {
			trace("#refreshVideo");
			trace("Video: " + video);
			if(video != null) {
				removeChild(video);
			}
			
			var tempVideo:Video = new Video(vidWidth,vidHeight);
			
			if(vidPublishing) {
				tempVideo.attachCamera(camera);
			} else {
				tempVideo.attachNetStream(netStream);
			}
			
			video = tempVideo;
			addChild(tempVideo);
		}
		
		/**
		  *  Starts the camera instance
		  */
		public function startVideo():void {
			video = new Video(vidWidth,vidHeight);
			if(vidPublishing) {
				video.attachCamera(camera);
			} else {
				video.attachNetStream(netStream);
			}
			addChild(video);
		}
		
		public function stopVideo():void {
			if(!vidPublishing) {
				netStream.close();
			}
			removeChild(video);
			video = null;
		}
		
		 /**
		  *  Starts the camera instance
		  */
		 public function publishVideo(_streamName:String):void {
			 if(vidPublishing) {
				 if(camera != null) {
				   	netStream.attachCamera(camera);
				 }
				 if(microphone != null) {
				   	netStream.attachAudio(microphone);
				 }
				netStream.publish(_streamName, "publish");
				isPublishing = true;
			} else {
				netStream.play(_streamName);
			}
			streamName = _streamName;
		 }
		 
		 /**
		  *  Starts the camera instance
		  */
		 public function stopPublishing():void {
			if(vidPublishing) {
				netStream.close();
				isPublishing = false;
			}
		 }
		
		/**
		 *  Sets the camera instance
		 */
		public function setCamera(cam:Camera):void {
			camera = cam;
			refreshVideo();
			if(isPublishing) {
				publishVideo(streamName);
			}
		}
		
		/**
		 *  Sets the microphone instance
		 */
		public function setMicrophone(mic:Microphone):void {
			microphone = mic;
			refreshVideo();
			if(isPublishing) {
				publishVideo(streamName);
			}
		}
		
		/**
		 *  Sets the camera instance
		 */
		public function muteCamera(mute:Boolean):void {
			if(vidPublishing) {
				if(mute) {
					camera = null;
					stopPublishing();
					refreshVideo();
					netStream.attachCamera(null);
					publishVideo(streamName);
					ChatHandler.connectionHandler.onCameraRefresh();
				} else {
					camera = ChatHandler.optionsContainer.tabContent.get("Setup").getCamera();
					refreshVideo();
					publishVideo(streamName);
				}
			} else {
				if(mute) {
					netStream.receiveVideo(!mute);
					refreshVideo();
				} else {
					netStream.receiveVideo(!mute);
					publishVideo(streamName);
				}
			}
		}
		
		/**
		 *  Sets the microphone instance
		 */
		public function muteMicrophone(mute:Boolean):void {
			if(vidPublishing) {
				if(mute) {
					microphone = null;
					netStream.attachAudio(null);
					publishVideo(streamName);
				} else {
					microphone = ChatHandler.optionsContainer.tabContent.get("Setup").getMicrophone();
					publishVideo(streamName);
				}
			} else {
				netStream.receiveAudio(!mute);
			}
		}
		
		/**
		 *  Sets the connected NetStream instance
		 */
		public function setNetStream(ns:NetStream):void {
			netStream = ns;
			refreshVideo();
			publishVideo(streamName);
		}
	}
}