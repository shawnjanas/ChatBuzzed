package com.chatbuzzed.display {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import com.chatbuzzed.handlers.ClientHandler;
	import com.chatbuzzed.ui.CustomButton;
	
	public class SchoolButton extends CustomButton {
		
		//School properties
		public var _name:String;
		public var _type:String;
		public var _location:String;
		public var _province:String;
		public var _mirrors:String;
		public var _totalUsers:int;
		public var _chatting:int;
		public var _idle:int;
		
		/**
		 * Constructor. Sets up the properties for the school
		 *
		 * @param param The object containing all the school properties
		 */
		public function SchoolButton(param:Object):void {
			//Sets the MovieClip as a button
			setUpButton(onSelected,this.schoolInfo,this.star);
			//Set school properties
			this.x = param["xPos"];
			this.y = param["yPos"];
			this._name = param["name"];
			this._type = param["type"];
			this._location = param["location"];
			this._province = param["province"];
			this._mirrors = "MacInsiders";
			
			this.schoolInfo.schoolInfoLabel.text = _name + " " + _type + "\n" + _location + ", " + _province;
			
			ClientHandler._client.messageBox.editInfo(this);
		}
		public function setSchoolSelected():void {
			trace("School: " + _name +" clicked.");
			buttonMC.gotoAndStop("selected");
			editMessageBoxInfo();
			this.removeEventListeners(onSelected);
			setButtonMode(false);
		}
		public function setSchoolUnselected():void {
			trace("School: " + _name +" clicked.");
			this.setEventListeners(onSelected);
			buttonMC.gotoAndStop("out");
		}
		public function editMessageBoxInfo():void {
			ClientHandler._client.messageBox.editInfo(this);
		}
		/**
		 * Called when the button is clicked. 
		 * Sets up the selected school info with the school properties
		 */
		private function onSelected(evt:MouseEvent):void {
			setSchoolSelected();
		}
	}
}