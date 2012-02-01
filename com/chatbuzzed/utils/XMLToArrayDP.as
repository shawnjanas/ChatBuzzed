package com.chatbuzzed.utils {
	
	import com.chatbuzzed.handlers.IDataProcessor;
	
	public class XMLToArrayDP implements IDataProcessor {
		
		public function XMLToArrayDP():void {
			//Constructor
		}

		public function processData(data:*):* {
			var tempXML:XML = new XML(data as String);
			return XMLListToArray(tempXML.children());
		}
		
		private static function XMLListToArray(xmlList:XMLList):Object {
			var temp:Object = {};
			var tempObject:Object;
			var tempString:String;
			var tempNumber:Number;
			for each (var row:XML in xmlList) {
				tempObject = {};
				for each (var element:XML in row.*) {
					tempString = element.toString();
					tempObject[element.localName()] = tempString;
				}
				temp[row.localName()] = tempObject;
			}
			return temp;
		}
	}
}