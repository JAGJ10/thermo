package {
	import org.flixel.FlxSprite;
	
	public class Door extends FlxSprite {
		
		public function Door(sprite:FlxSprite) {
			super();			
			//angle = sprite.angle;
			//scale.x = sprite.scale.x;
			//scale.y = sprite.scale.y
			//scrollFactor.x = sprite.scrollFactor.x;
			//scrollFactor.y = sprite.scrollFactor.y;
			
			//addAnimation("closed", [1]);
			//addAnimation("open", [1, 4, 7, 10], Assets.FRAME_RATE, false);
			loadGraphic(Assets.doorSprite, false, false, Assets.doorSpriteX, Assets.doorSpriteY);
			
			//setOriginToCorner();
			x = sprite.x - width / 2;
			y = sprite.y - height / 2;
			scale.x = 20 / Assets.doorSpriteX;
			scale.y = 20 / Assets.doorSpriteY;
			width = 20;
			height = 20;
			
			//play("closed");
		}
		
		override public function update():void {
			this.angle += 5;
		}
		
		public function open():void {
			this.loadGraphic(Assets.door1Sprite, false, false, Assets.door1SpriteX, Assets.door1SpriteY)
		}
	}
}