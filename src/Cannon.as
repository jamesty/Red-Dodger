package {
	import flash.display.Loader;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	/**
	 * ...
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
			this.x = 0;
			this.addProjectileTimer = new Timer(2000);
			this.addProjectileTimer.addEventListener(TimerEvent.TIMER, addProjectile);
			this.addProjectileTimer.start();
			this.controller = controller;
		}
		
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
		 * Removes all projectiles froms stage.
		 */
		public function removeProjectiles():void {
			for each (var projectile:Projectile in this.projectiles) {
				stage.removeChild(projectile);
			}
		}
	}

}