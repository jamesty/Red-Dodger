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
		private var projectileTimer:Timer;
		private var player:Player;
		private var projectiles:Array = new Array();
		private var projectileSpeed:Number;
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
			// Launch projectiles at the player
			this.projectileTimer = new Timer(2000);
			this.projectileTimer.addEventListener(TimerEvent.TIMER, addProjectile);
			this.projectileTimer.start();
			this.projectileSpeed = 2;
		}
		
		/**
		 * Adds a new projectile into the game.
		 */
		public function addProjectile(event:TimerEvent):void {
			this.projectileSpeed = this.projectileSpeed + (this.gameStats.getTime() / 100);
			var newProjectile:Projectile = new Projectile(this.projectileSpeed);
			this.projectiles.push(newProjectile);
			stage.addChild(newProjectile);
			this.gameTicks.addEventListener(TimerEvent.TIMER, newProjectile.updateProjectile);
		}
		
		/**
		 * Checks the collision between a projectile and the player.
		 */
		public function checkCollision(event:TimerEvent):void {
			for (var i:int = 0; i < this.projectiles.length; i++) {
				// Check if any projectile has reached off screen
				if (this.projectiles[i].hitTestObject(this.player)) {
					// Player collided with a projectile - set and display game over.
					this.gameOver = new GameOver();
					stage.addChild(this.gameOver.getGameOverTitle());
					stage.addChild(this.gameOver.getGameOverButton());
					gameOver.getGameOverButton().addEventListener(MouseEvent.CLICK, backToMenu);
					// Stop all game timers and remove the player and projectiles from stage
					this.gameTicks.stop();
					this.projectileTimer.stop();
					this.playTimer.stop();
					stage.removeChild(this.player);
					for (var j:int = 0; j < this.projectiles.length; j++) {
						stage.removeChild(this.projectiles[j]);
						this.gameTicks.removeEventListener(TimerEvent.TIMER, this.projectiles[j].updateProjectile);
					}
					this.projectiles.length = 0;
					stage.removeChild(this.gameStats.getTimer());
					return;
				} else if (this.projectiles[i].y > 650) {
					stage.removeChild(this.projectiles[i]);
					this.projectiles.splice(i, 1);
					return;
				}
			}
		}
		
		public function backToMenu(event:MouseEvent):void {
			stage.removeChild(this.gameOver.getGameOverTitle());
			stage.removeChild(this.gameOver.getGameOverButton());
			menuInitialize();
		}
		
	}

}