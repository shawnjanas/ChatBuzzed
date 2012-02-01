package com.chatbuzzed.handlers.connection {

	import fl.controls.TextArea;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	
	import com.chatbuzzed.handlers.chat.ChatHandler;
	import com.chatbuzzed.events.NetConnectionClientEvent;
	import com.chatbuzzed.interfaces.INetConnectionClient;
	
	public class NetConnectionChatClient extends EventDispatcher implements INetConnectionClient {
		
		public function NetConnectionChatClient():void {
			
		}
		
		public function close():void {
			
		}
		
		public function onTotalUsersOnline(totalUsers:int):void {
			trace("TotalUsers: " + totalUsers);
			ChatHandler._client._title_.usersOnline.total.text = "" + totalUsers;
		}
		
		public function onSpecUsersOnline(numUsers:Object):void {
			ChatHandler._client.chatBox.total.text = numUsers.totalUsers + "";
			ChatHandler._client.chatBox.chatting.text = numUsers.chatting + "";
			ChatHandler._client.chatBox.idle.text = numUsers.idle + "";
		}
		public function onMessage(_message_:String,nickname:String = null):void {
			var _message:String
			if(nickname == null) {
				_message = "><font color=\"#000000\"><b> Server: </b>";
				ChatHandler.soundHandler.play("message");
			} else if(nickname == ChatHandler._client._nickname_) {
				_message = "><font color=\"#0000FF\"><b> "+nickname+": </b>";
			} else {
				_message = "><font color=\"#FF0000\"><b> "+nickname+": </b>";
				ChatHandler.messageBoxHandler.setAsNotTyping();
				ChatHandler.soundHandler.play("message");
			}
			ChatHandler.messageBoxHandler.addTextAreaLine(_message + _message_ +"</font>");
		}
		public function onStartChatting(partner:Object):void {
			var via:String = partner.mirror;
			var mirror:String = "";
			
			if(partner.mirror == "cba") {
				mirror = "ChatBuzzed Admin ";
			} else if(partner.mirror == "mi") {
				mirror = "MacInsider ";
			}
			
			ChatHandler.videoContainer.getVideoClient().getNextBtn().enabled = true;
			ChatHandler.videoContainer.getVideoClient().getPartnersCam().startVideo();
			ChatHandler.videoContainer.getVideoClient().getPartnersCam().publishVideo(partner.nickname);
			ChatHandler.videoContainer.getVideoClient().getYourCam().publishVideo(ChatHandler._client._nickname_);
			
			ChatHandler.videoContainer.getVideoClient().setStatus("Chatting with " + partner.nickname,via);
			ChatHandler.messageBoxHandler.addTextAreaLine("Partner found. You are now chatting with " + mirror + "<font color=\"#FF0000\"><b>" + partner.nickname + "</b></font>.");
			
			ChatHandler.messageBoxHandler.addTextAreaLine("<font color=\"#FF0000\"><b>" + partner.nickname + ":</b></font>");
			ChatHandler.messageBoxHandler.addTextAreaLine(" <b>- Faculty:</b> " + partner.faculty);
			ChatHandler.messageBoxHandler.addTextAreaLine(" <b>- Residence:</b> " + partner.residence);
			
			if(partner.admin) {
				ChatHandler.optionsContainer.tabContent.get("Admin").setCurrentPartner(partner);
			}
		}
		public function onStopChatting(disNickname:String):void {
			ChatHandler.videoContainer.getVideoClient().getYourCam().stopPublishing();
			ChatHandler.videoContainer.getVideoClient().getPartnersCam().stopVideo();
			ChatHandler.videoContainer.getVideoClient().getNextBtn().enabled = false;
			ChatHandler.videoContainer.getVideoClient().setStatus("Looking for a new partner, please wait...");
			if(disNickname == ChatHandler._client._nickname_) {
				ChatHandler.messageBoxHandler.addTextAreaLine("You disconnected. Looking for a new partner...");
			} else {
				ChatHandler.messageBoxHandler.addTextAreaLine("<font color=\"#FF0000\"><b>" + disNickname + "</b></font> disconnected. Looking for a new partner...");
			}
		}
		public function onStoppedChatting(_status:String):void {
			if(_status == "chatting") {
			  	ChatHandler.videoContainer.getVideoClient().getPartnersCam().stopVideo();
			}
			ChatHandler.videoContainer.getVideoClient().getYourCam().stopVideo();
			ChatHandler.videoContainer.getVideoClient().getNextBtn().enabled = false;
			
			ChatHandler.messageBoxHandler.resetTextArea();
			ChatHandler.messageBoxHandler.addTextAreaLine("You stopped chatting. Press start to start chatting again...");
			ChatHandler.videoContainer.getVideoClient().setStatus("Press \"Start\" to start chatting with a student.");
		}
		public function onPartnerTyping():void {
			ChatHandler.messageBoxHandler.setAsTyping();
		}
		public function onCameraRefresh(partnerNick:String):void {
			trace(133333333337);
			ChatHandler.videoContainer.getVideoClient().getPartnersCam().stopVideo();
			ChatHandler.videoContainer.getVideoClient().getPartnersCam().refreshVideo();
			ChatHandler.videoContainer.getVideoClient().getPartnersCam().publishVideo(partnerNick);
		}
		public function onNewNickname(nick:String, mirror:String):void {
			trace("new nickname");
			if(mirror == "cb") {
				ChatHandler._client._title_.chatbuzzed.nickname.text = "as " + nick;
			} else if(mirror == "cba") {
				ChatHandler._client._title_.chatbuzzed.nickname.text = "as " + nick + " via ChatBuzzed Admin";
			} else if(mirror == "mi") {
				ChatHandler._client._title_.chatbuzzed.nickname.text = "as " + nick + " via MacInsiders";
			}
			ChatHandler._client._nickname_ = nick;
		}
		
		public function onBanned():void {
			var param:SharedObject= SharedObject.getLocal("cb");
			param.data.b64 = 1;
		}
		public function onKicked():void {
			onMessage("You have been kicked from the server...");
		}
	}
}
