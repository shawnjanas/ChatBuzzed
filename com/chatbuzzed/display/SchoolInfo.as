package com.chatbuzzed.display {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
	import com.chatbuzzed.handlers.ClientHandler;
	
	public class SchoolInfo extends MovieClip {
		
		public function SchoolInfo():void {
			
		}
		
		public function editInfo(star:SchoolButton):void {
			this.schoolName.text = star._name + " " + star._type;
			this.schoolLocation.text = star._location + ", " + star._province;
			this.schoolMirrors.text = star._mirrors + "";
			this.usersOnline.text = star._totalUsers + "";
			this.chattingUsers.text = star._chatting + "";
			this.idleUsers.text = star._idle + "";
			
			btnStart.addEventListener(MouseEvent.CLICK,onStart);
			btnRefresh.addEventListener(MouseEvent.CLICK,onRefresh);
		}
		public function updateUserInfo():void {
			if(this.schoolName.text != "") {
				ClientHandler.connectionHandler.setNumUsersOnline(this.schoolName.text);
			}
		}
		
		private function onStart(evt:MouseEvent):void {
			var myPattern:RegExp = /\//g;  
 			var str:String = this.nickname.text;
 			var nick:String = str.replace(myPattern, " ");
			
			if(this.schoolName.text != "") {
				if(this.nickname.text.length >= 4) {
					ClientHandler._client.onStartChat(ClientHandler.loaderHandler.data["Client"]);
					if(ClientHandler._mirror == "cb") {
						var param:SharedObject= SharedObject.getLocal("cb");
						param.data._nickname = nick;
						
						param.data._faculty = this.faculty.selectedLabel;
						param.data._residence = this.residence.selectedLabel;
					}
				} else {
					ClientHandler._client.preloader._status.text = "Invalid Nickname (4-12).";
				}
			} else {
				ClientHandler._client.preloader._status.text = "Invalid Nickname (4-12).";
			}
		}
		private function onRefresh(evt:MouseEvent):void {
			updateUserInfo();
		}
	}
}