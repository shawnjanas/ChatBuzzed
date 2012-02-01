package com.chatbuzzed.handlers {
	
	public class LoadInfo {
		public var name:String;
		public var data:*;  // This is where we stick the processed data (or if no IDataProcessor is provided, it'll copy the output of the URLLoader into here)
		public var size:int;
		public var percentLoaded:Number;
		public var complete:Boolean = false;
		public var happy:Boolean = true;  // true if the request is either pending or completed successfully
		public var dataProcessor:IDataProcessor;
		
		public function LoadInfo(name:String, size:int) {
			this.name = name;
			this.dataProcessor = dataProcessor;
			this.size = size;
			percentLoaded = 0;
		}
	}
}