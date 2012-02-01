package com.chatbuzzed.handlers.chat {
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.net.NetStream;
	import flash.events.Event;
	
	import com.chatbuzzed.handlers.connection.ConnectionHandler;
	import com.chatbuzzed.handlers.connection.NetConnectionChatClient;
	import com.chatbuzzed.handlers.ObjectHandler;
	import com.chatbuzzed.handlers.ClientHandler;
	import com.chatbuzzed.handlers.SoundHandler;
	import com.chatbuzzed.display.TabContainer;
	import com.chatbuzzed.display.MainMenuContent;
	import com.chatbuzzed.display.SetupTab;
	import com.chatbuzzed.display.AdminTab;
	import com.chatbuzzed.display.NewsTab;
	
	public class ChatHandler {
		
		public static var videoContainer:VideoContainer;
		public static var optionsContainer:TabContainer;
		public static var chatContainer:TabContainer;
		public static var connectionHandler:ConnectionHandler
		public static var objectHandler:ObjectHandler;
		public static var messageBoxHandler:MessageBoxHandler;
		public static var soundHandler:SoundHandler;
		
		public static var _client:Client;
		
		public function ChatHandler(client:Client):void {
			_client = client;
			
			objectHandler = new ObjectHandler(_client.stage,1000,750);
			objectHandler.addObject(_client.chatBox.bg,{yScale:true});
			objectHandler.addObject(_client.chatBox.box,{yScale:true});
			objectHandler.addObject(_client.chatBox.field,{yPos:true});
			objectHandler.addObject(_client.chatBox.send,{yPos:true});
			objectHandler.addObject(_client.chatBox.typing,{yPos:true});
			
			var mmContent:MainMenuContent = new MainMenuContent();
			objectHandler.addObject(mmContent._content,{xScale:true, yScale:true});
			
			var newsContent:NewsTab = new NewsTab();
			objectHandler.addObject(newsContent._content,{xScale:true, yScale:true});
			
			var setUpContent:SetupTab = new SetupTab();
			objectHandler.addObject(setUpContent,{xPosMid:true});
			
			var adminPanel:AdminTab;
			if(_client._admin) {
				adminPanel = new AdminTab();
				objectHandler.addObject(adminPanel,{xPosMid:true});
			}
			
			optionsContainer = new TabContainer();
			optionsContainer.x = 663;
			optionsContainer.y = 20;
			optionsContainer.addTab("Main Menu",mmContent);
			optionsContainer.addTab("News",newsContent);
			optionsContainer.addTab("Setup",setUpContent);
			if(_client._admin) {
				optionsContainer.addTab("Admin",adminPanel);
			}
			objectHandler.addObject(optionsContainer.tabContentBG,{xScale:true, yScale:true});
			_client.addChild(optionsContainer);
			
			videoContainer = new VideoContainer();
			videoContainer.x = 175;
			videoContainer.y = 20;
			_client.addChild(videoContainer);
			
			soundHandler = new SoundHandler();
			
			messageBoxHandler = new MessageBoxHandler(_client.chatBox);
		}
		
		public static function setUpConnectionHandler():void {
			connectionHandler = new ConnectionHandler();
			connectionHandler.init(2);
			connectionHandler.setServerClient(new NetConnectionChatClient());
			connectionHandler.addEventListener(Event.CONNECT,connection2Con);
		}
		
		public static function connection2Con(evt:Event):void {
			videoContainer.setClient(new VideoMainClient(new NetStream(connectionHandler.getServerNC()),new NetStream(connectionHandler.getServerNC())));
			_client.init2();
		}
	}
}