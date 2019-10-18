package
{
	
	import flash.display.*;
	import org.flixel.*;
	import org.flixel.system.input.*;
	
	public class Button extends FlxButton
	{
		public var key1:String;
		public var key2:String;
		public static var action:Boolean;
		public var act:Number;
		public var way:Boolean;
		public var I:Number;
		public static var snd:FlxSound;
  
		public function Button(x:Number, y:Number, f:Boolean = true)
		{
			super(x, y);
			label = new FlxText(0, 0, 14.5 * main.cell, " ", false);
			makeGraphic(14.5 * main.cell, 2 * main.cell, 0xffffffff, false, "button");
			label.setFormat("Arial", 20, 255, "center");
			labelOffset = new FlxPoint(0, 6);
			key1 = "";
			key2 = "";
			action = false;
			act = 0;
			alpha = 1;
			frameWidth = label.frameWidth = label.width = width = 14.5 * main.cell;
			if (f)
			{
				onDown = click;
				Game.me.add(label.mask = new Button(x, y, false));
				label.mask.label.mask = this;
			}
		}
		
		override public function update():void
		{
			super.update();
			if (key1 == "")
				return;
			if (FlxG.keys.justPressed(key1))
				click();
			if (FlxG.keys.justPressed(key2))
				click();
			if (act > 0)
			{
				act -= FlxG.elapsed;
				
				if (act < 0)
				{
					act = 0;
					action = false;
					Screen.me.alpha = 1;
					color = main.color.w;
				}
			}
		}
		
		public function click():void
		{
			if (key1 == "")
				return;
			status = NORMAL;
			if (action)
				return;
			if (Game.fail)
				return;
			if (!Game.play)
				return;
			Screen.way = 1;
			act = 1;
			action = true;
			{
				Screen.I = 0;
				Game.act = 1;
				if ((I == Screen.K) || (Screen.K == 0))
				{
					color = main.color.g;
					Game.time += 10;
					Screen.CNT++;
				}
				else
				{
					color = main.color.r;
					Game.time -= 10;
					Screen.CNT--;
					Screen.restore();
				}
				Game.timer.label.color = color;
			}
		}

	}
}
