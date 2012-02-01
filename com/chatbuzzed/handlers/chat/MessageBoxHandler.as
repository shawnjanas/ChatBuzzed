package com.chatbuzzed.handlers.chat {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	import fl.controls.Button;
	
	import com.chatbuzzed.handlers.chat.ChatHandler;
	
	public class MessageBoxHandler {
		
		public var _messageBox:MovieClip;
		public var _textBox:TextArea;
		public var _textField:TextInput;
		public var _send:Button;
		public var _refresh:Button;
		public var _typing:MovieClip;
		
		public var typingTimer:Timer;
		public var isTyping:Boolean;
		
		public function MessageBoxHandler(messageBox:MovieClip):void {
			_messageBox = messageBox;
			_textBox = _messageBox.box;
			_textField = _messageBox.field;
			_send = _messageBox.send;
			_refresh = _messageBox._refresh;
			_typing = _messageBox.typing;
			
			var textFormat:TextFormat = new TextFormat("Arial",12);
			_textBox.setStyle("textFormat",textFormat);
			_textField.setStyle("textFormat",textFormat);
			
			_send.addEventListener(MouseEvent.CLICK, onSendMessage);
			_refresh.addEventListener(MouseEvent.CLICK, onRefresh);
			_textField.addEventListener(KeyboardEvent.KEY_UP, onKeySendMessage);
			
			typingTimer = new Timer(3000);
			typingTimer.addEventListener(TimerEvent.TIMER, onTimer);
			isTyping = false;
		}
		
		public function sendMessage():void {
			if(_textField.text.length > 0) {
				ChatHandler.connectionHandler.onMessage(_textField.text);
				_textField.text = "";
			}
		}
		
		private function onSendMessage(evt:MouseEvent):void {
			sendMessage();
		}
		private function onKeySendMessage(evt:KeyboardEvent):void {
			if(evt.keyCode == Keyboard.ENTER) {
				ChatHandler.connectionHandler.onMessage(_textField.text);
				_textField.text = "";
			} else {
				ChatHandler.connectionHandler.onTyping();
			}
		}
		
		public function addTextAreaLine(_message:String):void {
			if(_textBox.htmlText == "") {
				_textBox.htmlText +=  _message;
			} else {
				_textBox.htmlText +=  _message;
			}
			_textBox.verticalScrollPosition = _textBox.htmlText.length * _textBox.width;
		}
		public function resetTextArea():void {
			_textBox.htmlText = "";
		}
		
		public function setAsTyping():void {
			_typing.alpha = 1;
			typingTimer.reset();
			typingTimer.start();
			isTyping = true;
		}
		public function setAsNotTyping():void {
			_typing.alpha = 0;
			typingTimer.reset();
			isTyping = false;
		}
		private function onTimer(evt:TimerEvent):void {
			setAsNotTyping();
		}
		
		private function onRefresh(evt:MouseEvent):void {
			ChatHandler.connectionHandler.setNumUsersOnline("McMaster University");
		}
	}
}