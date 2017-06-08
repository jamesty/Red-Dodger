package {
	import flash.display.Loader;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author James
	 */
	public class Projectile extends Loader {
		private var projectileSpeed:Number;
		public function Projectile(xLoc:Number, yLoc:Number, speed:Number) {
			this.load(new URLRequest("imgs/Projectile.png"));
			this.x = xLoc;
			this.y = yLoc;
			this.projectileSpeed = speed;
		}
		
		/**
		 * Update the projectile location and check if it
		 * has reached outside the stage.
		 * @return True if projectile is outside of stage.
		 */
		public function updateProjectile(event:TimerEvent):void {
			this.y += this.projectileSpeed
		}
		
		public function checkCollision(player:Sprite):Boolean {
			return this.hitTestObject(player);
		}
		
		private function generateRandomPosition():Number {
			var randomPosition:Number = Math.floor(Math.random() * 800);
			return randomPosition;
		}
	}

}