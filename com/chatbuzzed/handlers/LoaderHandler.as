package com.chatbuzzed.handlers {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import com.chatbuzzed.events.LoaderProgressEvent;
	
	public class LoaderHandler extends EventDispatcher {
		
		private var infoDictionary:Dictionary; 	// key: URLRequest passed into addRequest, value: URLInfo
		private var loaders:Dictionary; 			// key: Loader, value: URLRequest (same as above)
		public var data:Object = {};
		
		public function LoaderHandler() {
			infoDictionary = new Dictionary();
			loaders = new Dictionary();
		}
		
		public function load():void {
			var tempURLRequest:URLRequest;
			for(var loader:* in loaders) {
				tempURLRequest = loaders[loader];
				loader.load(tempURLRequest);
			}
		}
		
		public function abort():void {
			var tempURLRequest:URLRequest;
			for (var loader:* in loaders) {
				tempURLRequest = loaders[loader];
				if (!infoDictionary[tempURLRequest].complete) {
					try {
						loader.close();
					} catch(event:Event) {
						
					}
				}
			}
		}
		
		public function addRequest(name:String,urlRequest:URLRequest,size:int):void {
			var tempLoaderInfo:LoadInfo = new LoadInfo(name,size);
			infoDictionary[urlRequest] = tempLoaderInfo;
			var tempLoader:Loader = new Loader();
			tempLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			tempLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderLoop);
			tempLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loaders[tempLoader] = urlRequest;
		}
		
		private function onIOError(event:Event):void {
			var tempURLRequest:URLRequest = loaders[event.target.loader];
			var tempLoaderInfo:LoadInfo = infoDictionary[tempURLRequest];
			tempLoaderInfo.complete = true;
			tempLoaderInfo.happy = false;
			abort();
			dispatchEvent(new Event(IOErrorEvent.IO_ERROR));
		}
		
		private function loaderLoop(evt:ProgressEvent):void {
			var loadInfo:LoadInfo = infoDictionary[loaders[evt.target.loader]];
			var newPercent:Number = evt.target.bytesLoaded / evt.target.bytesTotal
			var per:Number = (totalPercentLoaded() + newPercent - loadInfo.percentLoaded) / loaderSize();
			loadInfo.percentLoaded = newPercent;
			
			dispatchEvent(new LoaderProgressEvent(per));
		}
		
		private function onComplete(event:Event):void {
			var tempURLRequest:URLRequest = loaders[event.target.loader];
			var tempLoaderInfo:LoadInfo = infoDictionary[tempURLRequest];
			tempLoaderInfo.complete = true;
			tempLoaderInfo.happy = true;
			var done:Boolean = true;
			
			tempLoaderInfo.data = event.target.loader;
			data[tempLoaderInfo.name] = tempLoaderInfo.data;
					
			for each (var urlLoaderInfo:LoadInfo in infoDictionary) {
				if (!urlLoaderInfo.complete) {
					done = false;
				}
			}
			if (done) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function totalPercentLoaded():Number {
			var per:Number = 0;
			for(var i in infoDictionary) {
				per += infoDictionary[i].percentLoaded;
			}
			return per;
		}
		public function loaderSize():int {
			var count:int = 0;
			for(var i in infoDictionary) {
				count++;
			}
			return count;
		}
	}
}