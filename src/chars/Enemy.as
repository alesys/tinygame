package chars
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	[Event(name="complete", type="flash.events.Event")]
	public class Enemy extends Base
	{
		private var timer:Timer;
		public function Enemy()
		{
			super();
			drawBody(0xFF0000);
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var speed:int = Math.floor(Math.random()*750)+250;
			activate(speed);
			parent.addEventListener('pause',onPause);
			parent.addEventListener('unpause',onUnpause);
			parent.addEventListener('gameover',onGameOver);
		}
		private function onPause(e:Event):void
		{
			timer.stop();
		}
		private function onUnpause(e:Event):void
		{
			timer.start();
		}
		private function onGameOver(e:Event):void
		{
			timer.stop();
			if ( parent ) parent.removeChild(this);
		}
		private function activate(speed:int):void
		{
			
			x = stage.stageHeight;
			y = Math.floor(Math.random()*(MAX_Y-MIN_Y)) + MIN_Y;
			timer = new Timer(speed,9);
			timer.addEventListener(TimerEvent.TIMER, tick,false,0,true);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, done,false,0,true);
			timer.start();
		}
		private function tick(e:TimerEvent):void
		{
			x--;
			Model.game.isColliding(this);
		}
		private function done(e:TimerEvent):void
		{
			parent.removeEventListener('pause',onPause);
			parent.removeEventListener('unpause',onUnpause);
			parent.removeEventListener('gameover',onGameOver);
			dispatchEvent(new Event(Event.COMPLETE));
			if ( parent ) parent.removeChild(this);
			
		}
		
	}
}