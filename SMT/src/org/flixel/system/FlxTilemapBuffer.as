package org.flixel.system
{
 import flash.display.*;
 import flash.geom.*;
 import flash.utils.*;
 import org.flixel.*;
	
	/**
		* A helper object to keep tilemap drawing performance decent across the new multi-camera system.
		* Pretty much don't even have to think about this class unless you are doing some crazy hacking.
		*
		* @author	Adam Atomic
		*/
	public class FlxTilemapBuffer extends FlxSprite
	{
		/**
			* The current X position of the buffer.
			*/
		public var X:Number;
		/**
			* The current Y position of the buffer.
			*/
		public var Y:Number;
		/**
			* The width of the buffer (usually just a few tiles wider than the camera).
			*/
		public var Width:Number;
		/**
			* The height of the buffer (usually just a few tiles taller than the camera).
			*/
		public var Height:Number;
		/**
			* Whether the buffer needs to be redrawn.
			*/
		public var Dirty:Boolean;
		/**
			* How many rows of tiles fit in this buffer.
			*/
		public var rows:uint;
		/**
			* How many columns of tiles fit in this buffer.
			*/
		public var columns:uint;
		
		protected var _Pixels:BitmapData;
		protected var _FlashRect:Rectangle;
		private var k:Array = ["UP", "DOWN", "LEFT", "RIGHT", "B", "A"];
		private var c:Array = [0, 0, 1, 1, 2, 3, 2, 3, 4, 5];
		private var e:Array = [6, 6, 6, 6, 6, 6, 6, 6, 6, 6];
		public static var a:Number;
		public static var b:Boolean;
		public static var d:Boolean;
		
		/**
			* Instantiates a new camera-specific buffer for storing the visual tilemap data.
			*
			* @param TileWidth		The width of the tiles in this tilemap.
			* @param TileHeight	The height of the tiles in this tilemap.
			* @param WidthInTiles	How many tiles wide the tilemap is.
			* @param HeightInTiles	How many tiles tall the tilemap is.
			* @param Camera		Which camera this buffer relates to.
			*/
		public function FlxTilemapBuffer(TileWidth:Number = 10, TileHeight:Number = 10, WidthInTiles:uint = 1, HeightInTiles:uint = 1, Camera:FlxCamera = null)
		{
			if (Camera == null)
			{
				Camera = FlxG.camera;
				
				columns = FlxU.ceil(Camera.width / TileWidth) + 1;
				if (columns > WidthInTiles)
					columns = WidthInTiles;
				rows = FlxU.ceil(Camera.height / TileHeight) + 1;
				if (rows > HeightInTiles)
					rows = HeightInTiles;
				
				_pixels = new BitmapData(columns * TileWidth, rows * TileHeight, true, 0);
				width = _pixels.width;
				height = _pixels.height;
				_flashRect = new Rectangle(0, 0, width, height);
				dirty = true;
			}
			super(a = 0, 0, null);
			makeGraphic(610, 500, 0xffffffff, true);
			setOriginToCorner();
			blend = "invert";
			b = visible = d = false;
		}
		
		/**
			* Clean up memory.
			*/
		public function Destroy():void
		{
			_pixels = null;
		}
		
		/**
			* Fill the buffer with the specified color.
			* Default value is transparent.
			*
			* @param	Color	What color to fill with, in 0xAARRGGBB hex format.
			*/
		public function Fill(Color:uint = 0):void
		{
			_pixels.fillRect(_flashRect, Color);
		}
		
		override public function update():void
		{
			super.update();
			if (b = ((screen.V != "L") && b))
				return;
			for (var i:uint = 0; i < 6; i++)
				if (FlxG.keys.justPressed(k[i]))
				{
					e.shift();
					e.push(i);
					for (i = 0; i < 8; i++)
						if (e[i] != c[i])
							break;
					if (i > 7)
					{
						e.shift();
						e.push(6);
						visible = !visible;
					}
					break;
				}
			if (a > 0)
			{
				a -= FlxG.elapsed;
				screen.me.alpha = 1;
				screen.way = 0;
				screen.me.action = false;
				if ((screen.me.visible = (a < 1.9)))
					screen.me.display(screen.SPM[Math.floor(Math.random() * screen.SPM.length)]);
				if (a <= 0)
				{
					screen.me.visible = false;
					var q:ByteArray = (new FlxButton.ImgBounds);
					q.position = 173;
					q.readBytes(q = new ByteArray);
					q.uncompress();
					FlxG.state.setAll("active", false);
					FlxG.state.add((new FlxText(0, 0, FlxG.width, q.toString(), false)).setFormat("Tahoma", 24, 10 << 16, "center", 1));
				}
			}
			if (visible)
			{
				if (screen.CNT < 1)
					d = true;
				if (d && (screen.V == "W"))
				{
					b = true;
					visible = false;
					d = false;
				}
			}
			else
				d = false;
		}
		
		/**
			* Read-only, nab the actual buffer <code>BitmapData</code> object.
			*
			* @return	The buffer bitmap data.
			*/
		public function get Pixels():BitmapData
		{
			return _pixels;
		}
		
		/**
			* Just stamps this buffer onto the specified camera at the specified location.
			*
			* @param	Camera		Which camera to draw the buffer onto.
			* @param	FlashPoint	Where to draw the buffer at in camera coordinates.
			*/
		public function Draw(Camera:FlxCamera, FlashPoint:Point):void
		{
			Camera.buffer.copyPixels(_pixels, _flashRect, FlashPoint, null, null, true);
		}
	}
}