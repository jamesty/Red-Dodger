package {
	import flash.text.TextFormat;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField
	/**
	 * The GameMenu class handles all the displayed items
	 * in screen while the game is in the main menu.
	 * @author James
	 */
	public class GameMenu {
		private var menuTitle:TextField
		private var playButton:TextField;
		public function GameMenu() {
			// Menu Title
			var titleText:TextField = new TextField();
			var titleTextFormat:TextFormat = new TextFormat();
			titleTextFormat.bold = true;
			titleTextFormat.color = "0xff0000";
			titleTextFormat.size = 50;
			titleText.mouseEnabled = false;
			titleText.defaultTextFormat = titleTextFormat;
			titleText.text = "Red Dodger";
			titleText.width = 300;
			titleText.x = 290;
			titleText.y = 100;
			this.menuTitle = titleText;
			
			// Play Button
			var playTextFormat:TextFormat = new TextFormat();
			playTextFormat.size = 30;
			playTextFormat.bold = true;
			playTextFormat.color = 0xff0000;
			playTextFormat.align = "center";
			var playText:TextField = new TextField();
			playText.defaultTextFormat = playTextFormat;
			playText.selectable = false;
			playText.text = "Play";
			playText.x = 310;
			playText.y = 275;
			playText.border = true;
			playText.borderColor = 0xff0000;
			playText.width = 200;
			playText.height = 50;
			this.playButton = playText;
		}
		
		public function getPlayButton():TextField {
			return this.playButton;
		}
		
		public function getMenuTitle():TextField {
			return this.menuTitle;
		}
	}

}