package {
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * The GameOver class handles all the items
	 * displayed in screen during the game over state.
	 * @author James
	 */
	public class GameOver {
		private var gameOverTitle:TextField;
		private var gameOverButton:TextField;
		public function GameOver() {
			// Game over title
			var gameOverFormat:TextFormat = new TextFormat();
			var gameOver:TextField = new TextField();
			gameOverFormat.bold = true;
			gameOverFormat.color = "0xff0000";
			gameOverFormat.size = 50;
			gameOver.mouseEnabled = false;
			gameOver.defaultTextFormat = gameOverFormat;
			gameOver.text = "Game Over";
			gameOver.width = 300;
			gameOver.x = 290;
			gameOver.y = 100;
			this.gameOverTitle = gameOver;

			// Back to menu button
			var gameOverButtonFormat:TextFormat = new TextFormat();
			gameOverButtonFormat.size = 30;
			gameOverButtonFormat.bold = true;
			gameOverButtonFormat.color = 0xff0000;
			gameOverButtonFormat.align = "center";
			var gameOverButton:TextField = new TextField();
			gameOverButton.defaultTextFormat = gameOverButtonFormat;
			gameOverButton.selectable = false;
			gameOverButton.text = "Back to Menu";
			gameOverButton.x = 310;
			gameOverButton.y = 275;
			gameOverButton.border = true;
			gameOverButton.borderColor = 0xff0000;
			gameOverButton.width = 200;
			gameOverButton.height = 50;
			this.gameOverButton = gameOverButton;
		}
		
		public function getGameOverTitle():TextField {
			return this.gameOverTitle;
		}
		
		public function getGameOverButton():TextField {
			return this.gameOverButton;
		}
	}

}