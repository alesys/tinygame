package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.utils.Timer;
	
	import chars.Enemy;
	import chars.Hero;
	
	import ui.AlertScreen;
	import ui.Score;
	
	import utils.Util;

	[SWF(frameRate="30", backgroundColor="0x000000", width="8", height="8")]
	public class TinyGame extends Sprite
	{
		private var timer:Timer;
		private var score:Score;
		private var pauseScreen:Sprite;
		private var alertScreen:AlertScreen;
		private var hero:Hero;
		
		public function TinyGame()
		{
			alertScreen 	= new AlertScreen();
			hero 			= new Hero();
			score			= new Score();
			
			Model.score		= 0;
			Model.game 		= this;
			addChild(alertScreen);
			addChild(hero);
			addChild(score);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ACTIVATE, handle_activate);
			addEventListener(Event.DEACTIVATE, handle_deactivate);
			
		}
		private function init(e:Event):void
		{
			alertScreen.game_start();
			listenStart();
		}
		private function listenStart():void
		{
			stage.addEventListener(MouseEvent.CLICK, handleStart);
			
			function handleStart(e:MouseEvent):void
			{
				stage.removeEventListener(MouseEvent.CLICK, handleStart);
				spawnEnemies();
				alertScreen.hide();
				Model.isRunning = true;
			}
		}
		
		private function pauseScreenHide():void
		{
			alertScreen.hide();
		}
		private function pauseScreenShow():void
		{
			alertScreen.pause();
		}
		
		private function spawnEnemies():void
		{
			if (timer) timer.stop();
			timer = new Timer(Model.SPAWN_RATE);
			timer.addEventListener(TimerEvent.TIMER,spawnEnemy);
			timer.start();
		}
		private function handle_activate(e:Event):void
		{
			if ( Model.isRunning )
			{
				dispatchEvent(new Event('unpause'));
				if(timer)timer.start();
				pauseScreenHide();
			}
		}
		private function handle_deactivate(e:Event):void
		{
			dispatchEvent(new Event('pause'));
			if (timer)timer.stop();
			pauseScreenShow();
		}
		private function spawnEnemy(e:TimerEvent):void
		{
			var enemy:Enemy = new Enemy();
			enemy.addEventListener(Event.COMPLETE, scoreit);
			addChild(enemy);
			function scoreit(e:Event):void
			{
				score.setScore(++Model.score);
				(e.target as Enemy).removeEventListener(Event.COMPLETE, scoreit);
			}
		}
		public function isColliding(enemy:Enemy):Boolean
		{
			if (hero.x==enemy.x&&hero.y==enemy.y)
			{
				Model.isRunning = false;
				alertScreen.game_over();
				if ( timer ) timer.stop();
				ExternalInterface.call('showScore',"0b"+Util.dec2bin(Model.score,8).join(''));
				listenStart();
				dispatchEvent(new Event('gameover'));
				return true;
			}
			return false;
		}
	}
}