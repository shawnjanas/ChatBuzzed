package com.chatbuzzed.handlers {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class URLLoaderHandler extends EventDispatcher {
		
		private var urlInfoDictionary:Dictionary; 	// key: URLRequest passed into addURLRequest, value: URLInfo
		private var urlLoaders:Dictionary; 			// key: URLLoader, value: URLRequest (same as above)
		public var data:Object = {};
		
		public function URLLoaderHandler() {
			urlInfoDictionary = new Dictionary();
			urlLoaders = new Dictionary();
		}
		
		public function load():void {
			var tempURLRequest:URLRequest;
			for (var urlLoader:* in urlLoaders) {
				tempURLRequest = urlLoaders[urlLoader];
				urlLoader.load(tempURLRequest);
			}
		}
		
		public function abort():void {
			var tempURLRequest:URLRequest;
			for (var urlLoader:* in urlLoaders) {
				tempURLRequest = urlLoaders[urlLoader];
				if (! urlInfoDictionary[tempURLRequest].complete) {
					try {
						urlLoader.close();
					} catch(event:Event) {
						
					}
				}
			}
		}
		
		public function addURLRequest(name:String, urlRequest:URLRequest, dataProcessor:IDataProcessor = null, urlLoaderDataFormat:String = URLLoaderDataFormat.TEXT):void {
			var tempURLInfo:URLLoaderInfo = new URLLoaderInfo(name, dataProcessor);
			urlInfoDictionary[urlRequest] = tempURLInfo;
			var tempURLLoader:URLLoader = new URLLoader();
			tempURLLoader.dataFormat = urlLoaderDataFormat;
			tempURLLoader.addEventListener(Event.COMPLETE, onComplete);
			tempURLLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			urlLoaders[tempURLLoader] = urlRequest;
		}
		
		public function onIOError(event:Event):void {
			var tempURLRequest:URLRequest = urlLoaders[event.target]			
			var tempURLLoaderInfo:URLLoaderInfo = urlInfoDictionary[tempURLRequest];
			tempURLLoaderInfo.complete = true;
			tempURLLoaderInfo.happy = false;
			abort();
			dispatchEvent(new Event(IOErrorEvent.IO_ERROR));
		}
		
		public function onComplete(event:Event):void {
			var tempURLRequest:URLRequest = urlLoaders[event.target]
			var tempURLInfo:URLLoaderInfo = urlInfoDictionary[tempURLRequest];
			tempURLInfo.complete = true;
			tempURLInfo.happy = true;
			var done:Boolean = true;
			
			if (tempURLInfo.dataProcessor != null) {
				tempURLInfo.data = tempURLInfo.dataProcessor.processData(event.target.data)
				delete event.target.data
			} else {
				tempURLInfo.data = event.target.data  // If there is no dataProcessor, put the raw String into data
			}
			data[tempURLInfo.name] = tempURLInfo.data
					
			for each (var urlInfoValue:URLLoaderInfo in urlInfoDictionary) {
				if (! urlInfoValue.complete) {
					done = false;
				}
			}
			if (done) {
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}