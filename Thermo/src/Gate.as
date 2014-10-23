package {
	import org.flixel.FlxSprite;
	
	public class Gate extends FlxSprite {
		
		public static const FREEZE:int = 1;
		public static const HEAT:int = 2;
		public static const FLASH:int = 3;
		public static const NEUTRAL:int = 4;
		
		/* Gate types
		 * 1 - Freeze
		 * 2 - Heat
		 * 3 - Flash
		 * 4 - Neutral
		 */
		private var type:int;
		
		private var triggered:Boolean = false;
		
		public function Gate(sprite:FlxSprite, type:int) {
			super(sprite.x, sprite.y);
			
			angle = sprite.angle;
			scale.x = sprite.scale.x;
			scale.y = sprite.scale.y
			scrollFactor.x = sprite.scrollFactor.x;
			scrollFactor.y = sprite.scrollFactor.y;
		
			this.type = type;
			
			if (type == FLASH) {
				addAnimation("normal", [type, 5], Assets.FRAME_RATE / 2, true);
				addAnimation("trigger", [type+5, type], Assets.FRAME_RATE, false);
			} else {
				addAnimation("normal", [type]);
				addAnimation("trigger", [type+5, type, 5, type], Assets.FRAME_RATE, false);
			}
			
			loadGraphic(Assets.gateSprite, true, false, 16, 64);
			
			play("normal");
		}
		
		public function trigger():void {
			// Play triggered animation
			triggered = true;
			//play("trigger");
		}
		
		override public function update():void {
			// Play standard animation (needed in update?)
			if (triggered)
				play("trigger");
			else
				play("normal");
		}
		
		public function untrigger():void {
			// Play triggered animation
			triggered = false;
			//play("normal");
		}
	}
}