package com.chatbuzzed.display {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.chatbuzzed.handlers.chat.ChatHandler;
	
	public class AdminTab extends MovieClip {
		
		private var currentPartner:Object;
		
		public function AdminTab():void {
			currentPartner = new Object();
			
			ban.addEventListener(MouseEvent.CLICK, onBanned);
			kick.addEventListener(MouseEvent.CLICK, onKicked);
		}
		
		public function setCurrentPartner(partner:Object):void {
			this._nickname.text = partner.nickname;
			this._ip.text = partner.ip;
			this._flagged.text = partner.flagged;
			
			currentPartner = partner;
		}
		
		private function onBanned(evt:MouseEvent):void {
			if(currentPartner.nickname != null) {
				ChatHandler.connectionHandler.onBanned(currentPartner);
			}
		}
		private function onKicked(evt:MouseEvent):void {
			if(currentPartner.nickname != null) {
				ChatHandler.connectionHandler.onKicked(currentPartner);
			}
		}
	}
}