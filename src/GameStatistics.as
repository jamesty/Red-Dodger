package {
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author James
	 */
	public class GameStatistics {
		private var gameTimerLabel:TextField;
		private var currentTime:int;
		public function GameStatistics() {
			this.currentTime = 0;
			var gameTimerFormat:TextFormat = new TextFormat();
			gameTimerFormat.size = 30;
			gameTimerFormat.bold = true;
			this.gameTimerLabel = new TextField();
			this.gameTimerLabel.defaultTextFormat = gameTimerFormat;
			this.gameTimerLabel.text = String(this.currentTime);
			this.gameTimerLabel.textColor = 0xffffff;
		}
		
		public function incrementTimer(event:TimerEvent):void {
			this.currentTime += 1;
			this.gameTimerLabel.text = String(this.currentTime);
		}
		
		public function getTimer():TextField {
			return this.gameTimerLabel;
		}
		
		public function getTime():int {
			return this.currentTime;
		}
		
	}

}