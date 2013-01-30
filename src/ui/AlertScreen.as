package ui
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class AlertScreen extends Sprite
	{
		public static const GAMEOVER:uint=0xFF0000;
		public static const DEACTIVATED:uint=0xFF9912;
		public static const GAMESTART:uint =0xB3EE3A;
		public function AlertScreen ()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			
		}
		private function draw(c:uint):void
		{
			graphics.beginFill(c);
			graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			graphics.endFill();
		}
		public function pause():void
		{
			draw(DEACTIVATED);
			visible = true;
		}
		public function game_over():void
		{
			draw(GAMEOVER);
			visible = true;
		}
		public function game_start():void
		{
			draw(GAMESTART);
			visible = true;
		}
		public function hide():void
		{
			visible = false;
		}
	}
}