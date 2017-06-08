package {
	import flash.display.Loader;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	/**
	 * The Cannon class contains all the behaviors that a
	 * cannon has in this game including shooting projectiles
	 * out to the player.
	 * @author James
	 */
	public class Cannon extends Loader {
		private var controller:Controller;
		private var gameTicks:Timer;
		private var cannonSpeed:Number = 1;
		private var addProjectileTimer:Timer;
		private var projectiles:Array = new Array();
		public function Cannon(gameTicks:Timer, controller:Controller) {
			this.gameTicks = gameTicks;
			this.load(new URLRequest("imgs/cannon.png"));
			this.x = generateRandomXPosition();
			this.addProjectileTimer = new Timer(2000);
			this.addProjectileTimer.addEventListener(TimerEvent.TIMER, addProjectile);
			this.addProjectileTimer.start();
			this.controller = controller;
		}
		
		/**
		 * Updates the cannon location on game tick.
		 * @param	event The timer event that triggered this function.
		 */
		public function updateOnTick(event:TimerEvent):void {
			// Move the cannon
			if (this.x < 0) {
				cannonSpeed = 1;
			} else if (this.x + this.width > stage.stageWidth) {
				cannonSpeed = -1;
			}
			this.x += cannonSpeed;
		}
		
		/**
		 * Adds a new projectile into the game.
		 */
		public function addProjectile(event:TimerEvent):void {
			var newProjectile:Projectile = new Projectile(this.x, this.height, 2);
			this.projectiles.push(newProjectile);
			stage.addChild(newProjectile);
			this.gameTicks.addEventListener(TimerEvent.TIMER, newProjectile.updateProjectile);
		}

		/**
		 * Checks if any of this cannon's projectile has hit the player.
		 * @param	player The player object.
		 * @return Return True a projectile has collided with the player.
		 */
		public function checkCollision(player:Player):Boolean {
			var i:int = 0;
			while (i < this.projectiles.length) {
				if (this.projectiles[i].hitTestObject(player)) {
					return true;
				} else if (this.projectiles[i].y > stage.stageHeight) {
					this.projectiles[i].removeEventListener(TimerEvent.TIMER, this.projectiles[i].updateProjectile);
					this.projectiles.splice(i, 1);
				} else {
					i++;
				}
			}
			return false;
		}
		
		/**
		 * Removes all the listeners from the projectiles.
		 */
		public function removeListeners():void {
			this.addProjectileTimer.removeEventListener(TimerEvent.TIMER, addProjectile);
			for (var i:int = 0; i < this.projectiles.length; i++) {
				this.projectiles[i].removeEventListener(TimerEvent.TIMER, this.projectiles[i].updateProjectile);
			}
		}
		
		/**
		 * Removes all projectiles from the stage that the
		 * cannon instance currently has.
		 */
		public function removeProjectiles():void {
			for each (var projectile:Projectile in this.projectiles) {
				stage.removeChild(projectile);
			}
		}

		/**
		 * Generates a random X position for the cannon.
		 * @return Return a random X number within range of stage width.
		 */
		private function generateRandomXPosition():Number {
			var randomPosition:Number = Math.floor(Math.random() * 800);
			return randomPosition;
		}
	}

}