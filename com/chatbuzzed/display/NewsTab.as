package com.chatbuzzed.display {
	
	import flash.display.MovieClip;
	import flash.text.TextFormat;
	
	public class NewsTab extends MovieClip {
		
		public function NewsTab():void {
			var textFormat:TextFormat = new TextFormat("Arial",16);
			_content.setStyle("textFormat",textFormat);
			_content.textField.multiline = true;
			_content.htmlText = "Recent news at Chatbuzzed.com<br><br><font color=\"#0000FF\"><b>ChatBuzzed Version 2 is now released!!!</b>  on June 29th, 2010 by CB-Shawn</font><br><br>Hello everybody and welcome. After months of hard work since the release of the first version back in April, version 2 is finally realeased.<br><br>New features would include:<br>  - information about yourself; nickname, faculty, residence<br>  - new interface<br><br>Thanks for stopping by and expect plenty of new exciting features to come in the near future.";
		}
	}
}