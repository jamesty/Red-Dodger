package {
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard
	/**
	 * ...
	 * @author James
	 */
	public class Player extends Sprite {
		private var gravity:Number = 1.50;
		private var friction:Number = 0.90;
		private var playerSpeedY:Number = 0;
		private var playerSpeedX:Number = 0;
		private var keyDown:Object = {};
		public function Player() {
			this.graphics.beginFill(0xff0000);
			this.graphics.drawRect(0, 550, 30, 50);
			this.graphics.endFill();
		}
		
		public function keyPressed(event:KeyboardEvent):void {
			keyDown[event.keyCode] = true;
		}
		
		public function keyReleased(event:KeyboardEvent):void {
			keyDown[event.keyCode] = false;
		}
		
		public function movePlayer():void {
			if ((keyDown[Keyboard.W] || keyDown[Keyboard.UP]) && playerSpeedY == 0) {
				playerSpeedY -= 50;
			}
			if (keyDown[Keyboard.S] || keyDown[Keyboard.DOWN]) {
				playerSpeedY += 2;
			}
			if (keyDown[Keyboard.D] || keyDown[Keyboard.RIGHT]) {
				playerSpeedX += 2;
			}
			if (keyDown[Keyboard.A] || keyDown[Keyboard.LEFT]) {
				playerSpeedX -= 2;
			}
		}
		
		public function updateOnTick(event:TimerEvent):void {
			movePlayer();
			// Apply gravity and friction on player.
			playerSpeedY *= 0.90;
			playerSpeedY += gravity;
			this.y += playerSpeedY;
			this.x += playerSpeedX;
			playerSpeedX *= friction;
			// Prevent player from going outside the box
			if (this.y >= 0) {
				this.y = 0;
				playerSpeedY = 0;
			}
			if (this.x + this.width > stage.stageWidth) {
				this.x = stage.stageWidth - this.width;
				playerSpeedX = 0;
			}
			if (this.x < stage.x) {
				this.x = stage.x;
				playerSpeedX = 0;
			}
		}
	}
}