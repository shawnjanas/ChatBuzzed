package com.chatbuzzed.utils {
	
	public class Hashtable {
		
		private var keys:Array;
		private var elements:Array;
		
		public function Hashtable():void {
			keys = new Array();
			elements = new Array();
		}
		
		public function put(key:Object, element:Object):void {
			elements[size()] = element;
			keys[size()] = key;
		}
		
		public function get(key:*):Object {
			for(var i:int = 0; i < size(); i++) {
				if(keys[i] == key) {
					return elements[i];
				}
			}
			return null;
		}
		
		public function getIndex(index:int):Object {
			return elements[index];
		}
		
		public function getKey(element:*):Object {
			for(var i:int = 0; i < size(); i++) {
				if(elements[i] == element) {
					return keys[i];
				}
			}
			return null;
		}
		
		public function remove(key:*):void {
			var keys_:Array = new Array();
			var elements_:Array = new Array();
			for(var i:int = 0; i < size(); i++) {
				if(keys[i] != key) {
					keys_.push(keys[i]);
					elements_.push(elements[i]);
				}
			}
			keys = keys_;
			elements = elements_;
		}
		
		public function size():int {
			return keys.length;
		}
	}
}