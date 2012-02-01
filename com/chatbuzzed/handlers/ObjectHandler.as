package com.chatbuzzed.handlers {
	
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class ObjectHandler {
		
		public var objects:Array;
		public var objectParam:Array;
		
		public var stageWidth:Number;
		public var stageHeight:Number;
		
		public var _stage:Stage;
		
		public function ObjectHandler(stage:Stage,_width:int,_height:int):void {
			stageWidth = _width;
			stageHeight = _height;
			
			objects = new Array();
			objectParam = new Array();
			
			_stage = stage;
			
			start();
		}
		
		public function addObject(object:Sprite,param:Object):void {
			objects.push(object);
			objectParam.push(param);
		}
		
		public function start():void {
			_stage.addEventListener(Event.RESIZE,onStageResize);
		}
		
		public function stop():void {
			_stage.removeEventListener(Event.RESIZE,onStageResize);
		}
		
		private function onStageResize(evt:Event):void {
			trace("onresize");
			for(var i:int = 0; i < objects.length; i++) {
				var object:Sprite = objects[i];
				var param:Object = objectParam[i];
				//Changed window parameters
				var xPos:Number = _stage.stageWidth - stageWidth;
				var yPos:Number = _stage.stageHeight - stageHeight;
				
				if(param.xPos as Boolean) {
					object.x = object.x + xPos;
				} else if(param.xPosMid as Boolean) {
					object.x = object.x + xPos/2;
				} else if(param.xScale as Boolean) {
					object.width = object.width + xPos;
				}
				if(param.yPos as Boolean) {
					object.y = object.y + yPos;
				} else if(param.yPosMid as Boolean) {
					object.y = object.y + yPos/2;
				} else if(param.yScale as Boolean) {
					object.height = object.height + yPos;
				}
			}
			stageWidth = _stage.stageWidth;
			stageHeight = _stage.stageHeight;
		}
	}
}