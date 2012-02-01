package com.chatbuzzed.handlers.connection {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.NetStream;
	import flash.display.MovieClip;
	import flash.net.SharedObject;
	
	import com.chatbuzzed.events.NetConnectionClientEvent;
	import com.chatbuzzed.interfaces.INetConnectionClient;
	
	public class ConnectionHandler extends EventDispatcher {
		
		private var serverNC:NetConnectionManager;
		
		/*public var stream_in:NetStream;
		public var stream_out:NetStream;*/
		
		public function ConnectionHandler():void {
			
		}
		
		public function init(type:int):void {
			if(!isB64()) {
				serverNC = new NetConnectionManager(type);
				serverNC.addEventListener(Event.CONNECT, onServerConnect);
				serverNC.addEventListener(Event.CLOSE, onServerReject);
				serverNC.init("rtmp://74.208.7.133/chatbuzzed/");
			} else {
				dispatchEvent(new Event(Event.CANCEL));
			}
		}
		
		public function onServerConnect(evt:Event):void {
			trace("Server Connected");
			dispatchEvent(new Event(Event.CONNECT));
			//stream_in = new NetStream(serverNC);
			//stream_out = new NetStream(serverNC);
		}
		public function onServerReject(evt:Event):void {
			trace("Server Reject");
			//ClientHandler._client.preloader._status.text = "You have been banned.";
			//stream_in = new NetStream(serverNC);
			//stream_out = new NetStream(serverNC);
		}
		public function isB64():Boolean {
			var param:SharedObject= SharedObject.getLocal("cb");
			if(param.data.b64 == 1) {
				return true;
			}
			return false;
		}
		/*public function onPHPConnect(evt:Event):void {
			trace("PHP Connected");
		}*/
		public function getServerNC():NetConnectionManager {
			return serverNC;
		}
		public function setServerClient(client:INetConnectionClient):void {
			getServerNC().client = client;
		}
		
		public function setProperties(client:Object):void {
			serverNC.call("setProperties",null,client);
		}
		
		public function setNumUsersOnline(schoolName:String):void {
			serverNC.call("getSchoolInfo",null,schoolName);
		}
		
		public function getTotalUsers():void {
			serverNC.call("getTotalUsers",null);
		}
		
		public function startChatting(param:Object):void {
			serverNC.call("startChatting",null,param);
		}
		
		public function onStart():void {
			serverNC.call("onStart",null);
		}
		public function onStop():void {
			serverNC.call("onStop",null);
		}
		public function onNext():void {
			serverNC.call("onNext",null);
		}
		
		public function onMessage(_message:String):void {
			serverNC.call("onMessage",null,_message);
		}
		
		public function onTyping():void {
			serverNC.call("onTyping",null);
		}
		
		public function onCameraRefresh():void {
			serverNC.call("onCameraRefresh",null);
		}
		
		public function onBanned(partner:Object):void {
			serverNC.call("onBanned",null,partner);
		}
		public function onKicked(partner:Object):void {
			serverNC.call("onKicked",null,partner);
		}
	}
}