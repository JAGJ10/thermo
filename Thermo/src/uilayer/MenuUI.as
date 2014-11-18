package uilayer {
	import context.MenuUtils;
	
	import io.ThermoSaves;
	
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	import uilayer.Utils;
	
	/**
	 * ...
	 * @author KJin
	 */
	public class MenuUI extends FlxGroup 
	{
		public static const levelSelectWidth:uint = 5;
		public static const levelSelectHeight:uint = 5;
		public static const NUM_OPEN_LEVELS:uint = 3;
		private static var levelAdvanceRate:uint = 10;
		
		private var dimmer:FlxSprite;
		private var titleText:FlxText;
		private var promptText:FlxText;
		private var levelSelectText:FlxText;
		private var levelSelectItems:Array;
		
		private var dimmer_alpha1:PiecewiseInterpolationMachine;
		private var titleText_y01:PiecewiseInterpolationMachine;
		private var titleText_y1:PiecewiseInterpolationMachine;
		private var levelSelectText_y1:PiecewiseInterpolationMachine;
		private var levelSelectText_y12:PiecewiseInterpolationMachine;
		private var promptText_y01:PiecewiseInterpolationMachine;
		private var promptText_y1:PiecewiseInterpolationMachine;
		
		private var state:uint;
		private var callback:Function;
		
		//Robyn
		public var initialLevel:uint;
		public var logger:Logging;
		
		public function MenuUI(initialState:uint, initialLevel:uint, callback:Function, logger:Logging)
		{
			super(0);
			state = initialState;
			this.callback = callback;
			this.initialLevel = initialLevel;
			this.logger = logger;
			
			var dimensions:FlxPoint = new FlxPoint(FlxG.width, FlxG.height);
			
			// Title Text
			titleText = new FlxText(0, 0, FlxG.width, "Thermo");
			titleText.setFormat(Assets.font_name, 80, 0xff0099ff, "center", 0xff003399);
			add(titleText);
			
			promptText = new FlxText(0, 0, FlxG.width, "Press ENTER");
			promptText.setFormat(Assets.font_name, 40, 0xff0099ff, "center", 0xff003399);
			add(promptText);
			
			levelSelectText = new FlxText(0, 0, FlxG.width, "Level Select");
			levelSelectText.setFormat(Assets.font_name, 80, 0xff0099ff, "center", 0xff003399);
			add(levelSelectText);
			
			levelSelectItems = new Array(levelSelectWidth);
			for (var i:uint = 0; i < levelSelectWidth; i++)
			{
				levelSelectItems[i] = new Array(levelSelectHeight);
				for (var j:uint = 0; j < levelSelectHeight; j++)
				{
					levelSelectItems[i][j] = new LevelSelectItem(i, j);
					levelSelectItems[i][j].completed = ThermoSaves.GetLevelCleared(levelSelectItems[i][j].levelNum + 1);
					levelSelectItems[i][j].locked = ThermoSaves.GetNumLevelsCleared() + NUM_OPEN_LEVELS <= levelSelectItems[i][j].levelNum;
					add(levelSelectItems[i][j]);
				}
			}
			
			selectedLevel = initialLevel;
			selectedSquare = new FlxPoint(selectedLevel % levelSelectWidth, int(selectedLevel / levelSelectWidth));
			
			keyFramesDown = 0;
			
			// Something that helps darken the level when important UI is up
			// This should come up last so it covers everything.
			dimmer = MenuUtils.CreateSolid(new FlxPoint(dimensions.x + 1, dimensions.y), 0x000000);
			add(dimmer);
			
			dimmer.alpha = 0;
			dimmer_alpha1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.Lerp, 0, 0),
				new PiecewiseInterpolationNode(null, 20, 1));
			
			titleText_y01 = Utils.CreatePeriodic(0.2 * dimensions.y, 20, 400);
			promptText_y01 = Utils.CreatePeriodic(0.7 * dimensions.y, 10, 200);
			titleText_y1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.SmoothStep, 0, 0),
				new PiecewiseInterpolationNode(null, 100, -500));
			promptText_y1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.SmoothStep, 0, 0),
				new PiecewiseInterpolationNode(null, 100, 400));
			levelSelectText_y1 = new PiecewiseInterpolationMachine(false,
				new PiecewiseInterpolationNode(Utils.SmoothStep, 0, -500),
				new PiecewiseInterpolationNode(null, 40, 0));
			levelSelectText_y12 = Utils.CreatePeriodic(0.05 * dimensions.y, 10, 400);
		}
		
		override public function update():void 
		{
			super.update();
			// Adjust values depending on time.
			for (var i:uint = 0; i < levelSelectWidth; i++)
			{
				for (var j:uint = 0; j < levelSelectHeight; j++)
				{
					levelSelectItems[i][j].selected = this.selectedLevel == levelSelectItems[i][j].levelNum;
					levelSelectItems[i][j].state = state;
				}
			}
			// TITLE SCREEN
			if (state == 0)
			{
				titleText.y = titleText_y01.EvaluateAndAdvance();
				promptText.y = promptText_y01.EvaluateAndAdvance();
				levelSelectText.alpha = 0;
				if (FlxG.keys.ENTER)
				{
					state = 1;
				}
			}
			// TITLE SCREEN OUT, LEVEL SELECT IN
			else if (state == 1)
			{
				titleText.y = titleText_y01.EvaluateAndAdvance() + titleText_y1.EvaluateAndAdvance();
				promptText.y = promptText_y01.EvaluateAndAdvance() + promptText_y1.EvaluateAndAdvance();
				levelSelectText.y = levelSelectText_y1.EvaluateAndAdvance() + levelSelectText_y12.EvaluateAndAdvance();
				levelSelectText.alpha = 1;
				if (titleText_y1.complete)
				{
					state = 2;
				}
			}
			// LEVEL SELECT
			else if (state == 2)
			{
				titleText.alpha = 0;
				promptText.alpha = 0;
				levelSelectText.y = levelSelectText_y12.EvaluateAndAdvance();
				// choose yer level
				chooseLevel();
				selectedLevel = selectedSquare.y * MenuUI.levelSelectWidth + selectedSquare.x;
				if (FlxG.keys.ENTER)
				{
					if(selectedLevel != initialLevel+1){
						// THIS PERSON SKIPPED A LEVEL
						logger.recordEvent(initialLevel+1, 8, "v2 $ $ $ $ " + initialLevel+1);
					}
					state = 3;
				}
			}
			// LEVEL SELECT OUT, FADE OUT
			else if (state == 3)
			{
				dimmer.alpha = dimmer_alpha1.EvaluateAndAdvance();
				dimmer_alpha1.CallUponCompletion(callback);
			}
		}
		
		private var selectedSquare:FlxPoint;
		private var selectedSquarePrev:FlxPoint = new FlxPoint();
		public var selectedLevel:uint;
		private var keyFramesDown:uint;
		
		private function chooseLevel():void
		{
			var selectedSquareTemp:FlxPoint = new FlxPoint();
			var keyDirectionTemp:uint = 0;
			if (FlxG.keys.LEFT)
			{
				selectedSquareTemp.x--;
			}
			if (FlxG.keys.RIGHT)
			{
				selectedSquareTemp.x++;
			}
			if (FlxG.keys.UP)
			{
				selectedSquareTemp.y--;
			}
			if (FlxG.keys.DOWN)
			{
				selectedSquareTemp.y++;
			}
			if (selectedSquareTemp.x != 0 || selectedSquareTemp.y != 0)
			{
				if (selectedSquarePrev.x == selectedSquareTemp.x && selectedSquarePrev.y == selectedSquareTemp.y)
				{
					keyFramesDown++;
				}
				else
				{
					keyFramesDown = 0;
				}
				if (keyFramesDown % levelAdvanceRate == 0)
				{
					selectedSquare.x += selectedSquareTemp.x;
					selectedSquare.y += selectedSquareTemp.y;
					FlxG.play(Assets.sfx_option_cycle);
				}
				if (selectedSquare.x < 0)
				{
					selectedSquare.x += MenuUI.levelSelectWidth;
				}
				if (selectedSquare.x >= MenuUI.levelSelectWidth)
				{
					selectedSquare.x -= MenuUI.levelSelectWidth;
				}
				if (selectedSquare.y < 0)
				{
					selectedSquare.y += MenuUI.levelSelectHeight;
				}
				if (selectedSquare.y >= MenuUI.levelSelectHeight)
				{
					selectedSquare.y -= MenuUI.levelSelectHeight;
				}
				selectedSquarePrev.x = selectedSquareTemp.x;
				selectedSquarePrev.y = selectedSquareTemp.y;
			}
			else
			{
				keyFramesDown = 0;
				selectedSquarePrev.x = selectedSquarePrev.y = 0;
			}
		}
	}

}