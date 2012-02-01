package com.chatbuzzed.display {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	import com.chatbuzzed.utils.Hashtable;
	
	public class MainMenuContent extends MovieClip {
		
		//private var optionsContent:Sprite;
		//private var options:Hashtable;
		
		public function MainMenuContent():void {
			var textFormat:TextFormat = new TextFormat("Arial",16);
			_content.setStyle("textFormat",textFormat);
			_content.textField.multiline = true;
			_content.htmlText = "Welcome to Chatbuzzed.com at McMaster University.<br><br><font color=\"#0000FF\"><b>Instructions</b></font><br>Before you start chatting with other classmates, be sure to configure your webcam and microphone under the Setup tab.<br>To start chatting, press the start button located on the video screen.<br>To skip to the next person, press the next button located on the video screen.<br>To stop chatting, press the stop button located on the video screen.<br><br><font color=\"#0000FF\"><b>Advertise</b></font><br>If you are interested in advertising on chatbuzzed.com, we have ad space located in the video screen and costs $30 a month to have your banner in rotation.<br>Contact advertise@chatbuzzed.com for more information.<br><br><font color=\"#0000FF\"><b>Contact</b></font><br>To contact the chatbuzzed staff, send an email to support@chatbuzzed.com<br>If you experience a bug within the website, send an email to bugs@chatbuzzed.com<br><br>Have fun!!!";
			
			/*options = new Hashtable();
			
			optionsContent = new Sprite();
			addChild(optionsContent);
			
			createOption("Setup Cam & Mic", new MovieClip());
			createOption("Users", new MovieClip());
			createOption("Advertise", new MovieClip());
			createOption("Contact", new MovieClip());
			createOption("Terms of Service", new MovieClip());*/
		}
		
		/*public function createOption(_name:String, content:MovieClip):void {
			var evenOdd:int = options.size() % 2;
			var option:Option = new Option(_name,content);
			if(evenOdd == 0) {
				option.x = 10;
				option.y = ((options.size() / 2) + 1) * 10 + option.height * (options.size() / 2) + 20;
			} else {
				option.x = 10 * 2 + option.width;
				option.y = (Math.floor(options.size() / 2) + 1) * 10 + option.height * Math.floor(options.size() / 2) + 20;
			}
			optionsContent.addChild(option);
			options.put(_name, option);
		}
		
		public function getOptionsContent():Sprite {
			return optionsContent;
		}*/
		
	}
	
}