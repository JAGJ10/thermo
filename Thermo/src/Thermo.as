package {
	
	import context.MenuState;
	
	import org.flixel.*;
	import Logging;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	//[SWF(width="2560", height="1920", backgroundColor="#000000")]
	
	public class Thermo extends FlxGame {
		public static const WIDTH:int = 640;
		public static const HEIGHT:int = 480;
		
		public function Thermo() {
			super(WIDTH, HEIGHT, MenuState, 1);
			
			// Optional debug tools
			// FlxG.debug = true;
			// FlxG.visualDebug = true;
		}
	}
}