package com.chatbuzzed.handlers.connection {
	
	import flash.net.NetConnection;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	
	import com.chatbuzzed.interfaces.INetConnectionClient;
	
	public class NetConnectionManager extends NetConnection {
		
		private var _type:int;
		
		public function NetConnectionManager(type:int):void {
			_type = type;
			this.addEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
		}
		
		public function init(address:String):void {
			this.connect(address,_type);
		}
		
		private function onNetStatus(evt:NetStatusEvent):void {
			trace(evt.info.code);
			switch (evt.info.code) {
				case "NetConnection.Connect.Success":
					dispatchEvent(new Event(Event.CONNECT));
					break;
             	case "NetConnection.Connect.Rejected":
                  	dispatchEvent(new Event(Event.CLOSE));
					this.close();
                 	break;
          	}
		}
	}
}