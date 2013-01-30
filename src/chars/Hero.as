package chars
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class Hero extends Base
	{
		public function Hero()
		{
			super();
			drawBody(0x00FF00);
			addEventListener(Event.ADDED_TO_STAGE, init);
			x = MIN_X;
			y = MIN_Y;
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handle_key);
		}
		private function handle_key(e:KeyboardEvent):void
		{
			// 38 up  40 down
			//trace ( e.keyCode );
			switch( e.keyCode )
			{
				case 37:
					x--;
					if ( x < MIN_X ) x = MIN_X;
					break;
				case 38:
					y--;
					if ( y < MIN_Y ) y = MIN_Y;
					break;
				case 39:
					x++;
					if ( x > MAX_X ) x = MAX_X;
					break;
				case 40:
					y++;
					if ( y > MAX_Y-1 ) y = MAX_Y-1;
					break;
			}
		}
	}
}