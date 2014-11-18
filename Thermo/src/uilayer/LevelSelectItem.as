package uilayer 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class LevelSelectItem extends FlxGroup
	{
		private static var xMin:Number = 0.2 * FlxG.width;
		private static var xMax:Number = 0.8 * FlxG.width;
		private static var yMin:Number = 0.4 * FlxG.height;
		private static var yMax:Number = 0.8 * FlxG.height;
		
		private var itemText:FlxText;
		//private var lock:FlxSprite;
		
		private var itemText_x12:PiecewiseInterpolationMachine;
		private var itemText_y2:PiecewiseInterpolationMachine;
		
		public var levelNum:uint;
		public var levelName:String;
		public var completed:Boolean;
		public var locked:Boolean;
		
		public var selected:Boolean;
		public var state:uint;
		
		public function LevelSelectItem(x:uint, y:uint) 
		{
			super();
			levelNum = MenuUI.levelSelectWidth * y + x;
			levelName = LevelNameTranslator.Translate(levelNum);
			itemText = new FlxText(Utils.Lerp(xMin, xMax, x / (MenuUI.levelSelectWidth - 1)),
								   Utils.Lerp(yMin, yMax, y / (MenuUI.levelSelectHeight - 1)),
								   50, levelName);
			itemText.setFormat(Assets.font_name, 15, 0xffffffff, "center");
			
			itemText_x12 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Hermite, 0, 2 * FlxG.width, 0, 0),
				new PiecewiseInterpolationNode(null, 80, itemText.x));
			itemText_y2 = Utils.CreatePeriodic(itemText.y, 5, 100);
			
			add(itemText);
		}
		
		override public function update():void 
		{
			super.update();
			if (selected)
			{
				itemText.size = Utils.Lerp(itemText.size, 25, 0.2);
				itemText.color = 0xff0000;
			}
			else
			{
				itemText.size = Utils.Lerp(itemText.size, 15, 0.2);
				if (locked)
				{
					itemText.color = 0x000000;
				}
				else if (completed)
				{
					itemText.color = 0x00ff00;
				}
				else
				{
					itemText.color = 0xffffff;
				}
			}
			if (state == 0)
			{
				itemText.x = itemText_x12.Evaluate();
			}
			else if (state == 1)
			{
				itemText.x = itemText_x12.EvaluateAndAdvance();
				itemText.y = itemText_y2.EvaluateAndAdvance();
			}
			else if (state == 2)
			{
				itemText_x12.FastForward();
				itemText.x = itemText_x12.Evaluate();
				itemText.y = itemText_y2.EvaluateAndAdvance();
			}
		}
	}

}