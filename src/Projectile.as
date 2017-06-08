package {
	import flash.display.Loader;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.events.TimerEvent;
	import flash.display.Sprite;
	/**
	 * The Projectile class contains all the behaviors that
	 * a projectile inhibits in this game.
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
		 * @return Return True if projectile is outside of stage.
		 */
		public function updateProjectile(event:TimerEvent):void {
			this.y += this.projectileSpeed
		}
		
		/**
		 * Checks if this projectile has hit the object.
		 * @param	object The object to check collision with.
		 * @return Return True if projectile has hit the object.
		 */
		public function checkCollision(object:Sprite):Boolean {
			return this.hitTestObject(object);
		}
	}

}