package
{
	
 import flash.display.*;
 import flash.system.*;
 import flash.text.*;
 import flash.utils.*;
 import img.*;
 import org.flixel.*;
 import org.flixel.system.input.*;
 import snd.*;
	
	public class Screen extends FlxButton
	{
		public static var SPP:Array = ["SPC", "SPW"];
		public static var SPC:Array = ["c", "An Evil Plot Unfolds...", "A Powerful Villain Emerges...", "A Desperate Rescue Begins...", "No Hard Feelings", "The Second Warning", "Bianca Strikes Back", "Byrd, James Byrd", "Hunter's Tussle", "Spike Is Born", "A Duplicitous, Larcenous Ursine", "An Apology, And Lunch", "A Monster To End All Monsters", "The Dancing Bear", "The Escape!", "Deja Vu?", "A Familiar Face", "Billy In the Wall", "One Less Noble Warrior", "The End"];
		public static var SPW:Array = ["w", "Sunrise Spring", "Sunny Villa", "Cloud Spires", "Molten Crater", "Seashell Shore", "Sheila's Alp", "Buzz's Dungeon", "Midday Gardens", "Icy Peak", "Enchanted Towers", "Spooky Swamp", "Bamboo Terrace", "Sgt. Byrd's Base", "Spike's Arena", "Evening Lake", "Frozen Altars", "Lost Fleet", "Fireworks Factory", "Charmed Ridge", "Desert Ruins", "Bentley's Outpost", "Scorch's Pit", "Midnight Mountain", "Crystal Islands", "Sorceress's Lair", "Haunted Tomb", "Dino Mines", "Super Bonus Round", "Agent 9's Lab", "Crawdad Farm", "Spider Town", "Starfish Reef", "Bugbot Factory", "Mushroom Speedway", "Country Speedway", "Honey Speedway", "Harbor Speedway"];
		public static var SPCS:Array = ["f", "012", "054", "057", "060", "015", "018", "063", "021", "024", "066", "027", "030", "069", "033", "036", "039", "042", "048", "051"];
		public static var SPWS:Array = ["s", "25", "11", "13", "18", "4", "14", "22", "26", "9", "20_1", "29", "15", "20_2", "31", "30", "27", "16", "1", "2", "24", "28", "32", "19", "7", "33", "3", "5", "0", "8", "6_1", "6_2", "6_3", "6_4", "12", "10", "17", "23"];
  
		public static var W:Array;
		public static var SPA:Array;
		public static var SPM:Array
		public static var I:Number;
		public static var N:Number;
		public static var K:Number;
		public static var L:Array;
		public static var V:String;
		public static var me:Screen;
		public static var SCL:Number;
		public static var way:Number;
		public static var wrong:Boolean;
		public static var fame:Boolean;
		public static var CNT:int;
		public static var TIM:int;
		public static var SND:FlxSound;
		public static var sound:String;
		public var action:Boolean;
		public var key:String;
  
		public function Screen(x:Number, y:Number)
		{
			super(x, y);
			onDown = click;
			key = "ENTER";
			label = new FlxText(0, 0, 600, " ", false);
			label.setFormat("Arial", 40, 0xFFFFFFFF, "center", 0xFF000000);
			labelOffset = new FlxPoint(0, 4);
			var tf:TextFormat = new TextFormat(null, null, null, true);
			label._textField.defaultTextFormat = (tf);
			display(Jpg["c_0_1"]);
			me = this;
			SND = new FlxSound;
			start();
		}
		
		public function start():void
		{
			CNT = 0;
			V = "S";
			Game.fail = false;
			Game.rest = false;
			Game.play = false;
			wrong = false;
			fame = false;
			Game.time = 30;
			Game.timer.label.color = main.color.w;
			Game.timer.label.text = '0';
			FlxG.camera.color = 0xffffff;
			FlxG.volume = 0.5;
			Game.act = 0;
			way = 2;
			alpha = 0;
			action = false;
			SPA = [];
			SPM = [];
			var t:Array;
			var i:uint;
			var j:uint;
			var s:String;
			var p:String;
			var SPX:String;
			var b:Button;
			Game.buttonsclear();
			for each (SPX in SPP)
			{
				p = Screen[SPX][0] + "_";
				for (i = 1; i < Screen[SPX].length; i++)
				{
					t = [];
					s = p + i.toString() + "_";
					for (j = 1; Jpg[s + j.toString()] != undefined; j++)
					{
						SPM.push(Jpg[s + j.toString()]);
						t.push(s + j.toString());
					}
					if (t.length < 1)
						throw new Error("SMT: Invalid image index: " + i.toString() + " in " + SPX + " !");
					sound = String(Screen[SPX + "S"][0]) + "_" + String(Screen[SPX + "S"][i]);
					if (!Mp3[sound])
						throw new Error("SMT: Invalid sound index: " + i.toString() + " in " + SPX + " !");
					FlxU.shuffle(t, 8 * t.length);
					SPA.push([t, SPX, i, t.concat(), sound]);
				}
			}
			FlxU.shuffle(SPA, 8 * SPA.length);
			display(Jpg["c_0_0"]);
			N = 0;
			K = 0;
			label.color = main.color.y;
			label.text = "\n\n Click to start \n\n\n";
			sound = "s_21";
		}
		
		override public function update():void
		{
			super.update();
			if (FlxG.keys.justPressed(key))
				click();
			if (way <= 0)
				return;
			if (way != 1)
			{
				alpha += FlxG.elapsed * 2;
				if (alpha >= 1)
				{
					alpha = 1;
					way = 0;
					SND.loadEmbedded(Mp3[sound], false, true);
					SND.volume = 1;
					SND.play();
				}
				return;
			}
			alpha -= FlxG.elapsed * 2;
			if (alpha > 0)
				return;
			alpha = 0;
			way = 2;
			label.text = "";
			if (Game.rest)
			{
				score();
				return;
			}
			if (Game.fail)
			{
				lose();
				return;
			}
			if (Game.play)
			{
				rеburn();
				return;
			}
		}
		
		public static function restore():void
		{
			wrong = true;
			if (L[0].length < 1)
			{
				L[0] = (L[3] as Array).concat();
				FlxU.shuffle(L[0], 8 * (L[0] as Array).length);
			}
			SPA.splice(Math.floor(Math.random() * (SPA.length - 1)), 0, L);
		}
		
		public function display(C:Class):void
		{
			loadGraphic(C, false, false);
			if (width == 600)
			{
				offset.make(0, 0);
				SCL = 1;
			}
			else
			{
				if (width == 300)
				{
					offset.make(-150, -70)
					SCL = 2;
				}
				else
					throw new Error("SMT: Invalid width in " + C + " (must be 600 or 300)");
			}
			scale.make(SCL, SCL);
			frameWidth = label.frameWidth = label.width = width = 600;
			frameHeight = label.frameHeight = label.height = height = 280;
		}
		
		public static function D2(v:uint):String
		{
			return v > 9 ? v.toString() : "0" + v.toString();
		}
		
		public function score():void
		{
			if (CNT <= 0)
			{
				start();
				return;
			}
			sound = "s_34";
			display(Jpg["c_0_1"]);
			label.color = main.color.w;
			fame = true;
			action = false;
			var s:FlxSave = FlxG.saves[FlxG.save];
			s.name = "SMT_HiScore_S3";
			if (!s.bind(s.name))
				return;
			var h:Array = s.data[s.name] as Array;
			var e:String = "--/--";
			var z:uint = 6;
			var t:String = "";
			var r:String;
			var n:Number;
			var d:Date = new Date();
			var i:uint;
			var j:uint;
			r = d.getDate() + "." + D2(d.getMonth() + 1) + "." + (d.getFullYear() - 2000) + ", " + d.getHours() + ":" + D2(d.getMinutes());
			r = Math.floor(TIM / 60).toString() + ":" + D2(TIM % 60) + " (" + r + ")";
			r = V + "=" + CNT.toString() + ", " + r;
			n = CNT * 10000 - TIM;
			if ((h == null) || (h.length != z))
				h = new Array([0, e], [0, e], [0, e], [0, e], [0, e], [0, e]);
			for (i = 0; i < z; i++)
			{
				if (h[i][0] < n)
				{
					h.splice(i, 0, [n, r]);
					h.length = z;
					break;
				}
			}
			s.data[s.name] = h;
			s.close();
			for (j = 0; j < z; j++)
			{
				if (i == j)
					t += "* " + h[j][1] + "\n";
				else
					t += h[j][1] + "\n";
			}
			label.text = t;
		}
		
		public function win():void
		{
			V = "W";
			sound = "s_36";
			Game.fail = true;
			TIM = Math.round((getTimer() - TIM) / 1000);
			fame = false;
			Game.buttonsclear(wrong);
			label.color = main.color.r;
			label.text = "\n Game Completed \n\n\n\n";
			display(Jpg["c_0_3"]);
			Game.play = false;
			action = false;
			Game.time = 60;
			Game.act = 0;
			Game.timer.label.color = main.color.c;
			Game.timer.label.text = "60";
		}
		
		public function lose():void
		{
			V = "L";
			sound = "s_24";
			Game.fail = true;
			TIM = Math.round((getTimer() - TIM) / 1000);
			fame = false;
			Game.buttonsclear();
			label.color = main.color.g;
			label.text = "\n\n\n\n Game Over! \n";
			display(Jpg["c_0_2"]);
			Game.play = false;
			action = false;
			Game.time = 0;
			Game.act = 0;
			Game.timer.label.color = main.color.r;
			Game.timer.label.text = "0";
		}
		
		public function reburn():void
		{
			if (SPA.length < 1)
			{
				win();
				return;
			}
			var a:Array = SPA.pop();
			var SPX:Array = Screen[a[1]];
			var i:Number = a[2];
			var t:Array = a[0];
			var e:String = t.pop();
			a[0] = t;
			L = a;
			var r:Array = [];
			var q:Array = [];
			var c:String = SPX[i];
			sound = a[4];
			r.push(c);
			q.push(i);
			var j:uint;
			var n:Number;
			for (j = 0; j < 5; )
			{
				n = 1 + Math.floor(Math.random() * (SPX.length - 1));
				if (q.indexOf(n) >= 0)
					continue;
				r.push(SPX[n]);
				q.push(n);
				j++;
			}
			FlxU.shuffle(r, 8 * r.length);
			for (j = 1; j <= 6; j++)
			{
				(Game.buttons[j] as Button).label.text = r[j - 1];
				if (r[j - 1] == c)
					K = j;
			}
			display(Jpg[e] as Class);
		}
		
		public function rxburn():void
		{
			if (SCL == 2)
			{
				SCL = 1;
				reburn();
				SCL = 2;
			}
			else
			{
				reburn();
			}
		}
		
		public function click():void
		{
			status = NORMAL;
			if (action)
				return;
			if (alpha < 1)
				return;
			action = true;
			if (fame)
			{
				start();
				return;
			}
			if (Game.fail)
			{
				way = 1;
				Game.rest = true;
				return;
			}
			Game.play = true;
			way = 1;
		}
	
	}
}
