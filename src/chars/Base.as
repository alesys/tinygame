package chars
{
	import flash.display.Sprite;
	
	public class Base extends Sprite
	{
		public const MIN_Y:int = 2;
		public const MAX_Y:int = 8;
		public const MIN_X:int = 0;
		public const MAX_X:int = 8;
		
		public function Base()
		{
			super();
		}
		public function drawBody(c:uint):Base
		{
			graphics.beginFill(c);
			graphics.drawRect(0,0,1,1);
			graphics.endFill();
			return this;
		}
	}
}