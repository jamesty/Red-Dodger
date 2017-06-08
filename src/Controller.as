package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent
	import flash.net.URLRequest;
	import flash.ui.Keyboard
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author James
	 */
	public class Controller extends Sprite {
		private var menuTitle:TextField;
		private var menuPlay:TextField;
		private var menuBackground:Loader;
		private var gameStats:GameStatistics;
		private var gameOver:GameOver;
		private var gameTicks:Timer;
		private var playTimer:Timer;
		private var player:Player;
		private var cannonTimer:Timer;
		private var cannonList:Array = new Array();
		public function Controller() {
			this.graphics.lineStyle(0, 0x555555, 0.5);
			this.graphics.drawRect(0, 0, 800, 600);
		}

		/**
		 * Prepare game menu
		 */
		public function menuInitialize():void {
			// Prepare game main menu
			// Load background image
			var backgroundLoader:Loader = new Loader();
			backgroundLoader.load(new URLRequest("imgs/menuBG.png"));
			this.menuBackground = backgroundLoader;
			stage.addChild(this.menuBackground);
			// Load game menu
			var menu:GameMenu = new GameMenu();
			this.menuPlay = menu.getPlayButton();
			this.menuTitle = menu.getMenuTitle();
			stage.addChild(this.menuPlay);
			stage.addChild(this.menuTitle);
			this.menuPlay.addEventListener(MouseEvent.CLICK, gameInitialize);
		}
		
		/**
		 * User clicked play - Start the game.
		 */
		private function gameInitialize(event:MouseEvent):void {
			// Remove game menu and proceed to the game.
			this.menuPlay.removeEventListener(MouseEvent.CLICK, gameInitialize);
			stage.removeChild(this.menuBackground);
			stage.removeChild(this.menuPlay);
			stage.removeChild(this.menuTitle);
			stage.color = 0x000000;
			stage.focus = stage;
			// Initialize player and player movement
			this.player = new Player();
			stage.addChild(this.player);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, player.keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, player.keyReleased);
			// Initialize game ticks
			this.gameTicks = new Timer(15);
			this.gameTicks.addEventListener(TimerEvent.TIMER, this.player.updateOnTick);
			this.gameTicks.addEventListener(TimerEvent.TIMER, checkCollision);
			this.gameTicks.start();
			// Initialize play time timer.
			this.gameStats = new GameStatistics();
			stage.addChild(this.gameStats.getTimer());
			this.playTimer = new Timer(1000);
			this.playTimer.addEventListener(TimerEvent.TIMER, this.gameStats.incrementTimer);
			this.playTimer.start();
			// Launch projectiles at the player by adding cannons	
			addCannon(null);
			this.cannonTimer = new Timer(10000);
			this.cannonTimer.addEventListener(TimerEvent.TIMER, addCannon);
			this.cannonTimer.start();
		}
		/**
		 * Adds a new cannon into the game.
		 */
		public function addCannon(event:TimerEvent):void {
			var newCannon:Cannon = new Cannon(this.gameTicks, this);
			stage.addChild(newCannon);
			this.gameTicks.addEventListener(TimerEvent.TIMER, newCannon.updateOnTick);
			this.cannonList.push(newCannon);
		}
		
		/**
		 * Check if any projectile has hit the player or a projectile
		 * is outside of stage.
		 */
		public function checkCollision(event:TimerEvent):void {
			for each (var cannon:Cannon in cannonList) {
				if (cannon.checkCollision(this.player)) {
					setGameOver();
					return;
				}
			}
		}
		
		public function setGameOver():void {
			for each (var cannon:Cannon in this.cannonList) {
				cannon.removeListeners();
			}
			this.gameTicks.stop();
			this.playTimer.stop();
			this.gameOver = new GameOver();
			stage.addChild(this.gameOver.getGameOverTitle());
			stage.addChild(this.gameOver.getGameOverButton());
			gameOver.getGameOverButton().addEventListener(MouseEvent.CLICK, backToMenu);
		}
		
		/**
		 * Remove all game components and game over menu.
		 * Then return to main menu.
		 */
		public function backToMenu(event:MouseEvent):void {
			for each (var cannon:Cannon in this.cannonList) {
				cannon.removeProjectiles();
				stage.removeChild(cannon);
			}
			this.cannonList.length = 0;
			stage.removeChild(this.player);
			stage.removeChild(this.gameStats.getTimer());
			stage.removeChild(this.gameOver.getGameOverTitle());
			stage.removeChild(this.gameOver.getGameOverButton());
			menuInitialize();
		}
		
	}

}