package com.chatbuzzed.handlers.connection {

	import flash.events.EventDispatcher;
	
	import com.chatbuzzed.display.SchoolButton;
	import com.chatbuzzed.handlers.ClientHandler;
	import com.chatbuzzed.events.NetConnectionClientEvent;
	import com.chatbuzzed.interfaces.INetConnectionClient;
	
	public class NetConnectionClientClient extends EventDispatcher implements INetConnectionClient {
		
		public function NetConnectionClientClient():void {
			
		}
		
		public function close():void {
			
		}
		
		public function onTotalUsersOnline(totalUsers:int):void {
			trace("TotalUsers: " + totalUsers);
			ClientHandler._client._title.usersOnline.total.text = "" + totalUsers;
		}
		
		public function onUserID(_id:int):void {
			ClientHandler._id = _id;
		}
		
		public function onSpecUsersOnline(numUsers:Object):void {
			var schoolButton:SchoolButton = ClientHandler._schools[ClientHandler.selectedSchool] as SchoolButton;
			schoolButton._totalUsers = numUsers.totalUsers as Number;
			schoolButton._chatting = numUsers.chatting as Number;
			schoolButton._idle = numUsers.idle as Number;
			schoolButton.editMessageBoxInfo();
		}
	}
}
