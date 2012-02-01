package com.chatbuzzed.handlers {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.SharedObject;
	import flash.net.URLLoaderDataFormat;
	import fl.data.DataProvider;
	
	import com.chatbuzzed.display.SchoolButton;
	import com.chatbuzzed.events.LoaderProgressEvent;
	import com.chatbuzzed.handlers.connection.ConnectionHandler;
	import com.chatbuzzed.handlers.connection.NetConnectionClientClient;
	import com.chatbuzzed.utils.XMLToArrayDP;
	
	import com.chatbuzzed.handlers.ObjectHandler;
	
	/**
	 * The Heart of the Program. Controls every aspect of the movie
	 */
	public class ClientHandler {
		
		public static var loaderHandler:LoaderHandler;
		public static var urlLoaderHandler:URLLoaderHandler;
		public static var connectionHandler:ConnectionHandler;
		public static var objectHandler:ObjectHandler;
		
		public static var _client:ClientLoader;
		public static var _conf:Object;
		public static var selectedSchool:String;
		public static var _schools:Object;
		
		public static var _mirror:String;
		public static var _admin:Boolean;
		
		public static var _id:int;
		
		
		/**
		 * Constructor. Creates and starts all the handlers
		 *
		 * @param client The main movie instance
		 */
		public function ClientHandler(client:ClientLoader):void {
			_client = client;	//Set the main movie instance
			_schools = new Object();
			_admin = false;
			
			//Creates and adds the objects that will be affected when the window resizes
			objectHandler = new ObjectHandler(_client.stage,1000,600);
			objectHandler.addObject(_client.preloader,{xPosMid:true,yPosMid:true});
			objectHandler.addObject(_client.messageBox,{xPosMid:true,yPosMid:true});
			objectHandler.addObject(_client._title.titleBar,{xScale:true});
			objectHandler.addObject(_client._title.usersOnline,{xPos:true});
		}
		
		public function init():void {
			connectionHandler = new ConnectionHandler();
			connectionHandler.init(1);
			connectionHandler.setServerClient(new NetConnectionClientClient());
			connectionHandler.addEventListener(Event.CONNECT,onServerConnect);
			connectionHandler.addEventListener(Event.CANCEL,onBanned);
		}
		/**
		 * Client is connected to the server and is varified
		 * Load the configuration file
		 */
		private function onServerConnect(evt:Event):void {
			_client.preloader._status.text = "Loading please wait...";
			
			urlLoaderHandler = new URLLoaderHandler();
			var request:URLRequest = new URLRequest("http://www.chatbuzzed.com/conf.xml");
			var request2:URLRequest = new URLRequest("vars.php");
			var dataProcessor:IDataProcessor = new XMLToArrayDP();
			urlLoaderHandler.addURLRequest("conf", request, dataProcessor);
			urlLoaderHandler.addURLRequest("vars", request2, null, URLLoaderDataFormat.VARIABLES);
			urlLoaderHandler.addEventListener(Event.COMPLETE, onLoadedConf);
			urlLoaderHandler.load();
		}
		
		private function onBanned(evt:Event):void {
			_client.preloader._status.text = "You have been Banned.";
		}
		
		/**
		 * Called when the configuration file is finished loading and formating.
		 * Sets up the movie using the configuration file
		 *
		 * @param evt Event class the holds the urlLoaderHandler instance used to load the configuration file
		 */
		private function onLoadedConf(evt:Event):void {
			//The conf file is parced as an object array
			var conf:Object = evt.target.data["conf"];
			var file:Object = conf["file"];
			
			//Load the files specified in the conf file
			loaderHandler = new LoaderHandler();
			var request:URLRequest = new URLRequest("http://www.chatbuzzed.com/" + file["name"] + "." + file["type"]);
			loaderHandler.addRequest(file["name"], request, file["size"]);
			loaderHandler.addEventListener(Event.COMPLETE,onPreloaderComplete);
			loaderHandler.addEventListener(LoaderProgressEvent.PROGRESS_CHANGED,onLoaderProgress);
			loaderHandler.load();
			
			var faculties:Object = conf["faculties"];
			for(var faculty:String in faculties) {
				_client.messageBox.faculty.addItem({label:faculties[faculty],data:faculties[faculty]});
			}
			
			var residences:Object = conf["residences"];
			for(var residence:String in residences) {
				_client.messageBox.residence.addItem({label:residences[residence],data:residences[residence]});
			}
			
			var message:Object = conf["message"];
			var mirror:Object = conf["mirrors"];
			
			
			//Loaded vars
			
			var vars:Object = evt.target.data["vars"];
			
			_mirror = vars.mirror;
			if(vars.admin == "1") {
				_admin = true;
			} else {
				_admin = false;
			}
			
			if(_mirror != "cb") {
				_client.messageBox.nickname.text = vars.nickname;
			}
			if(_mirror == "mi") {
				var flag:Boolean = false;
				var dataP:DataProvider = _client.messageBox.faculty.dataProvider;
				for(var i:uint = 0; i < dataP.length; i++) {
					if(dataP.getItemAt(i).data == vars.faculty) {
						_client.messageBox.faculty.selectedIndex = i;
						flag = true;
					}
				}
				if(!flag) {
					_client.messageBox.faculty.addItem({label:vars.faculty, data:vars.faculty});
					_client.messageBox.faculty.selectedIndex = i;
				}
				var flag2:Boolean = false;
				var dataP2:DataProvider = _client.messageBox.residence.dataProvider;
				for(var n:uint = 0; n < dataP2.length; n++) {
					if(dataP2.getItemAt(n).data == vars.residence) {
						_client.messageBox.residence.selectedIndex = n;
						flag2 = true;
					}
				}
				if(!flag2) {
					_client.messageBox.residence.addItem({label:vars.residence, data:vars.residence});
					_client.messageBox.residence.selectedIndex = i;
				}
			}

			if(_admin) {
				_client.messageBox.nickname.enabled = false;
			}
			
			var param:SharedObject= SharedObject.getLocal("cb");
			if(_mirror == "cb") {
				if(param.data._nickname != null) {
					_client.messageBox.nickname.text = param.data._nickname;
				}
			}
			if(param.data._nickname != null && param.data._faculty != null && param.data._residence != null && _mirror == "cb") {
				
				
				var dataP_1:DataProvider = _client.messageBox.faculty.dataProvider;
				for(var m:uint = 0; m < dataP_1.length; m++) {
					if(dataP_1.getItemAt(m).data == param.data._faculty) {
						_client.messageBox.faculty.selectedIndex = m;
					}
				}
				
				var dataP2_1:DataProvider = _client.messageBox.residence.dataProvider;
				for(var j:uint = 0; j < dataP2_1.length; j++) {
					if(dataP2_1.getItemAt(j).data == param.data._residence) {
						_client.messageBox.residence.selectedIndex = j;
					}
				}
			}
			connectionHandler.setProperties({mirror:_mirror, admin:_admin});
			
			_conf = conf;
		}
		/**
		 * Called when the loading files are updated.
		 * Updates the preloader percent using the LoaderProgressEvent
		 */
		private function onLoaderProgress(evt:LoaderProgressEvent):void {
			_client.preloader.masker.width = _client.preloader.width * evt.loaderPercent;
		}
		
		/**
		 * Called when the files are finished loading.
		 * Sets up the school buttons on the preloader
		 */
		private function onPreloaderComplete(evt:Event):void {
			var school:Object = _conf["schools"];
			var schoolButton:SchoolButton = new SchoolButton(school);
			selectedSchool = school["name"] + " " + school["type"];
			_schools[selectedSchool] = schoolButton;
			schoolButton.setSchoolSelected();
			_client.messageBox.updateUserInfo();
			
			_client.preloader.addChild(schoolButton);
			_client.preloader._status.text = "Select a school";
			
			_client._title.usersOnline.refresh.addEventListener(MouseEvent.CLICK,onRefresh);
		}
		
		private function onRefresh(evt:MouseEvent):void {
			connectionHandler.getTotalUsers();
		}
	}
}