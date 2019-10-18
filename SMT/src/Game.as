package
{
 import flash.display.*;
 import flash.geom.*;
 import flash.text.*;
 import org.flixel.*;
	
	public class Game extends FlxState
	{
		public static var me:Game;
		public static var buttons:Array;
		public static var buttons_name:Array;
		public static var pause:Button;
		public static var timer:Button;
		public static var time:Number;
		public static var act:Number;
		public static var fail:Boolean;
		public static var play:Boolean;
		public static var rest:Boolean;
		
		override public function create():void
		{
			super.create();
			me = this;
			play = false;
			rest = false;
			fail = false;
			buttons = new Array(null, null, null, null, null, null, null);
			buttons_name = new Array("ZERO", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX");
			var x1:Number = 0.5 * main.cell;
			var x2:Number = 15.5 * main.cell;
			var x3:Number = 0.25 * main.cell;
			var y0:Number = 0.5 * main.cell;
			var y1:Number = 17.5 * main.cell;
			var y2:Number = 20 * main.cell;
			var y3:Number = 22.5 * main.cell;
			var y4:Number = 3 * main.cell;
			add(buttons[1] = new Button(x1, y1));
			add(buttons[2] = new Button(x1, y2));
			add(buttons[3] = new Button(x1, y3));
			add(buttons[4] = new Button(x2, y1));
			add(buttons[5] = new Button(x2, y2));
			add(buttons[6] = new Button(x2, y3));
			add(timer = new Button(x1, y0));
			add(pause = new Button(x2, y0));
			var b:Button;
			for (var i:Number = 1; i <= 6; i++)
			{
				b = (buttons[i] as Button);
				b.key1 = buttons_name[i];
				b.key2 = "NUMPAD" + buttons_name[i];
				b.I = i;
			}
			timer.color = 0;
			timer.label.setFormat("Tahoma", 36, main.color.w, "center");
			timer.labelOffset.y = -5;
			var tf:TextFormat = new TextFormat(null, null, null, true);
			tf.letterSpacing = 6;
			timer.label._textField.defaultTextFormat = (tf);
			pause.label.text = "Spyro3 Memory Test v1.2!";
			pause.color = 0;
			pause.label.setFormat("Tahoma", 20, main.color.m, "center");
			add(new Screen(x3, y4));
			main.me.toggle();
			timer.label.width = timer.label.frameWidth = 14.5 * main.cell;
		}
		
		public static function buttonsclear(w:Boolean = true):void
		{
			var b:Button;
			var a:Array;
			if (w)
				a = ["", "", "", "", "", "", ""];
			else
			{
				a = ["C", "^ ^", "< >", "B", "v v", "< >", "A"];
				Screen.sound = "s_35";
			}
			for (var i:uint = 1; i <= 6; i++)
			{
				b = (buttons[i] as Button);
				b.label.text = b.label.mask.label.text = a[i];
				b.label._colorTransform = new ColorTransform;
				b.alpha = b.label._alpha = 1;
			}
		}
		
		override public function update():void
		{
			super.update();
			if (FlxG.keys.justPressed("SPACE"))
				main.me.toggle();
			if (play)
			{
				time -= FlxG.elapsed * ((time / 45) + 1);
				if (time < 0)
					time = 0;
				if (time > 60)
					time = 60;
				if (act > 0)
				{
					act -= FlxG.elapsed;
				}
				else
				{
					timer.label.color = main.color.w;
					if (time <= 10)
						timer.label.color = main.color.y;
					if (time >= 50)
						timer.label.color = main.color.c;
				}
				timer.label.text = FlxU.round(time).toString();
				if ((time == 0) && (!fail))
				{
					fail = true;
					Screen.way = 1;
				}
			}
		}
	
	}
}
