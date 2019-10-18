package
{
	import flash.display.*;
	import flash.events.*;
	import org.flixel.*;
	import org.flixel.system.*;
	
	[SWF(width="610",height="500",backgroundColor="#7f7f7f7f")]
	[Frame(factoryClass="Preloader")]
	
	public class main extends FlxGame
	{
		public static var s_9:Class;
		public static var color:Object = {r: 0xFFFF0000, g: 0xFF00FF00, b: 0xFF0000FF, w: 0xFFFFFFFF, c: 0xFF00FFFF, m: 0xFFFF00FF, y: 0xFFFFFF00, k: 0xFF000000};
		public static var cell:Number = 20;
		static public var me:main;
		static public var tog:uint;
		
		public function toggle():void
		{
			switch (tog++)
			{
				case 0: 
					FlxG.stage.removeEventListener(Event.DEACTIVATE, onFocusLost);
					useSoundHotKeys = false;
					FlxBasic.game = Game;
					FlxBasic.screen = Screen;
					FlxG.camera.antialiasing = true;
					FlxG.useBufferLocking = true;
					FlxG.state.add(new FlxTilemapBuffer);
					FlxG.saves = [new FlxSave];
					FlxG.save = 0;
				default: 
					tog = 2;
				case 1: 
					FlxG.stage.align = StageAlign.TOP;
					FlxG.stage.scaleMode = StageScaleMode.SHOW_ALL;
					break;
				case 2: 
					FlxG.stage.scaleMode = StageScaleMode.NO_SCALE;
					FlxG.stage.align = StageAlign.TOP_LEFT;
					break;
			}
		}
		
		public function main()
		{
			super(610, 500, Game, 1, 40, 20, true);
			me = this;
			forceDebugger = false;
			FlxG.debug = false;
		}
	
	}
}
