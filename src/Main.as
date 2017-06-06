package {
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author James Ty
	 */
	public class Main extends Sprite {
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			/* entry point */
			var gameController:Controller = new Controller();
			stage.addChild(gameController);
			gameController.menuInitialize();
		}
	}
	
}