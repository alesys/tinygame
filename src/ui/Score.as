package ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import chars.Base;
	
	import utils.Util;
	
	public class Score extends Sprite
	{
		private static const background:uint = 0x000000;
		private static const one:uint = 0xFFFFFF;
		private var cells:Vector.<Base>;
		public function Score()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		private function init(e:Event):void
		{
			draw();
			createCells();
		}
		private function draw():void
		{
			graphics.beginFill(background);
			graphics.drawRect(0,0,stage.stageWidth,1);
			graphics.endFill();
		}
		private function createCells():void
		{
			cells = new Vector.<Base>();
			for ( var i:int=0; i<stage.stageWidth;i++)
			{
				var cell:Base = new Base();
				cell.drawBody(background);
				addChild(cell);
				cells.push(cell);
				cell.x=i;
			}
		}
		public function setScore(score:int):void
		{
			var bin:Array = Util.dec2bin(score,8);
			var val:int;
			trace(bin);
			for ( var i:int=0;i<cells.length;i++)
			{
				val = bin[i];
				cells[i].drawBody(val==1?one:background);
			}
		}
	}
}