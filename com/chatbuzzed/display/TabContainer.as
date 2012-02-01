package com.chatbuzzed.display{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import com.chatbuzzed.events.TabEvent;
	import com.chatbuzzed.utils.Hashtable;
	
	public class TabContainer extends MovieClip {
		
		public var tabs:Hashtable;
		public var tabContent:Hashtable;
		
		private var selectedTab:String;
		
		public function TabContainer():void {
			tabs = new Hashtable();
			tabContent = new Hashtable();
		}
		
		public function addTab(name:String,content:Sprite,isEditable:Boolean = false):void {
			var tempTab:Tab;
			if(isEditable) {
				tempTab = new EditableTab(name);
			} else {
				tempTab = new StaticTab(name);
			}
			tempTab.addEventListener(TabEvent.SELECT,onTabSelect);
			tempTab.x = getNextTabX();
			tabs.put(name,tempTab);
			this.addChild(tempTab);
			tabContent.put(name,content);
			if(tabs.size() == 1) {
				setTabSelected(name);
			}
		}
		
		public function removeTab(tab:Tab):void {
			
		}
		
		public function setTabSelected(tabName:String):void {
			trace(selectedTab);
			if(selectedTab != null) {
				tabs.get(selectedTab).unselect();
				this.removeChild(tabContent.get(selectedTab) as MovieClip);
			}
			
			tabs.get(tabName).select();
			tabContent.get(tabName).y = 30;
			this.addChild(tabContent.get(tabName) as MovieClip);
			
			selectedTab = tabName;
		}
		
		public function getNextTabX():int {
			var xSize:int;
			for(var i:int = 0; i < tabs.size(); i++) {
				xSize += tabs.getIndex(i).width - 1;
			}
			return xSize;
		}
		
		private function onTabSelect(evt:TabEvent):void {
			trace("name: "+evt._name);
			setTabSelected(evt._name);
		}
	}
}