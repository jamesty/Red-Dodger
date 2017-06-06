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
		public function Projectile() {
			this.load(new URLRequest("imgs/Projectile.png"));
			this.scaleX = 0.50;
			this.scaleY = 0.50;
			this.x = generateRandomPosition();
			this.y = 0;
			this.projectileSpeed = 2;
		}
		
		public function updateProjectile(event:TimerEvent):void {
			this.y += this.projectileSpeed
		}
		
		public function checkCollision(player:Sprite):Boolean {
			return this.hitTestObject(player);
		}
		
		public function generateRandomPosition():Number {
			var randomPosition:Number = Math.floor(Math.random() * 800);
			return randomPosition;
		}
	}

}