package com.chatbuzzed.handlers {
	
	public class URLLoaderInfo {
		public var name:String;
		public var data:*;  // This is where we stick the processed data (or if no IDataProcessor is provided, it'll copy the output of the URLLoader into here)
		public var complete:Boolean = false;
		public var happy:Boolean = true;  // true if the request is either pending or completed successfully
		public var dataProcessor:IDataProcessor;
		
		public function URLLoaderInfo(name:String, dataProcessor:IDataProcessor) {
			this.name = name;
			this.dataProcessor = dataProcessor;
		}
	}
}