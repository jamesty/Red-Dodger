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
		private var gameOver:GameOver;
		private var gameTicks:Timer;
		private var projectileTimer:Timer;
		private var player:Player;
		private var projectiles:Array = new Array();
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
		 * Handle play request.
		 */
		private function gameInitialize(event:MouseEvent):void {
			// Remove game menu and proceed to the game.
			this.menuPlay.removeEventListener(MouseEvent.CLICK, gameInitialize);
			stage.removeChild(this.menuBackground);
			stage.removeChild(this.menuPlay);
			stage.removeChild(this.menuTitle);
			stage.focus = stage;
			stage.color = 0x000000;
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
			// Launch projectiles at the player
			this.projectileTimer = new Timer(2000);
			this.projectileTimer.addEventListener(TimerEvent.TIMER, addProjectile);
			this.projectileTimer.start();
		}
		
		/**
		 * Adds a new projectile into the game.
		 */
		public function addProjectile(event:TimerEvent):void {
			var newProjectile:Projectile = new Projectile();
			this.projectiles.push(newProjectile);
			stage.addChild(newProjectile);
			this.gameTicks.addEventListener(TimerEvent.TIMER, newProjectile.updateProjectile);
			trace("Projectile Spawned");
		}
		
		/**
		 * Checks the collision between a projectile and the player.
		 */
		public function checkCollision(event:TimerEvent):void {
			trace(this.projectiles.length);
			for (var i:int = 0; i < this.projectiles.length; i++) {
				// Check if any projectile has reached off screen
				if (this.projectiles[i].hitTestObject(this.player)) {
					// Player collided with a projectile - set and display game over.
					this.gameOver = new GameOver();
					stage.addChild(this.gameOver.getGameOverTitle());
					stage.addChild(this.gameOver.getGameOverButton());
					gameOver.getGameOverButton().addEventListener(MouseEvent.CLICK, setGameOver);
					// Stop all game timers and remove the player and projectiles from stage
					this.gameTicks.stop();
					this.projectileTimer.stop();
					stage.removeChild(this.player);
					for (var j:int = 0; j < this.projectiles.length; j++) {
						stage.removeChild(this.projectiles[j]);
						this.gameTicks.removeEventListener(TimerEvent.TIMER, this.projectiles[j].updateProjectile);
					}
					this.projectiles.length = 0;
					return;
				} else if (this.projectiles[i].y > 650) {
					stage.removeChild(this.projectiles[i]);
					this.projectiles.splice(i, 1);
					return;
				}
			}
		}
		
		public function setGameOver(event:MouseEvent):void {
			stage.removeChild(this.gameOver.getGameOverTitle());
			stage.removeChild(this.gameOver.getGameOverButton());
			menuInitialize();
		}
		
	}

}