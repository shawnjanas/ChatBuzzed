package com.chatbuzzed.display {
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import com.chatbuzzed.handlers.chat.ChatHandler;
	import com.chatbuzzed.ui.CustomButton;
	import caurina.transitions.*;
	
	public class CameraButton extends CustomButton {
		
		private var isSelected:Boolean;
		
		public function CameraButton():void {
			isSelected = false;
			
			this._content.par_mute_cam.addEventListener(Event.CHANGE, onParCamChange);
			this._content.par_mute_mic.addEventListener(Event.CHANGE, onParMicChange);
			this._content.you_mute_cam.addEventListener(Event.CHANGE, onYouCamChange);
			this._content.you_mute_mic.addEventListener(Event.CHANGE, onYouMicChange);
			
			setUpButton(onClick, null, this._button);
		}
		
		public function onClick(evt:MouseEvent):void {
			if(isSelected) {
				Tweener.addTween(_content,{alpha:0, time:1, onComplete:function(){_content.visible = false;}});
				isSelected = false;
			} else {
				_content.visible = true;
				Tweener.addTween(_content,{alpha:1, time:1});
				isSelected = true;
			}
		}
		
		private function onParCamChange(evt:Event):void {
			if(evt.target.selected) {
				ChatHandler.videoContainer.getVideoClient().getPartnersCam().muteCamera(true);
			} else {
				ChatHandler.videoContainer.getVideoClient().getPartnersCam().muteCamera(false);
			}
		}
		private function onParMicChange(evt:Event):void {
			if(evt.target.selected) {
				ChatHandler.videoContainer.getVideoClient().getPartnersCam().muteMicrophone(true);
			} else {
				ChatHandler.videoContainer.getVideoClient().getPartnersCam().muteMicrophone(false);
			}
		}
		private function onYouCamChange(evt:Event):void {
			if(evt.target.selected) {
				ChatHandler.videoContainer.getVideoClient().getYourCam().muteCamera(true);
			} else {
				ChatHandler.videoContainer.getVideoClient().getYourCam().muteCamera(false);
			}
		}
		private function onYouMicChange(evt:Event):void {
			if(evt.target.selected) {
				ChatHandler.videoContainer.getVideoClient().getYourCam().muteMicrophone(true);
			} else {
				ChatHandler.videoContainer.getVideoClient().getYourCam().muteMicrophone(false);
			}
		}
	}
}