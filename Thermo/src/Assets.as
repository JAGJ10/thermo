package {
	/**
	 * Utility class for importing sprites and sounds
	 */
	public class Assets {
		
		/* Framerate for animations */
		public static const FRAME_RATE:int = 25;
		
		/* Sprites */
		
		/* Character sprite sheet */
		[Embed(source = "../assets/character/player.png")]
		public static var playerSprite:Class;
		public static var playerSpriteX:int = 40;
		public static var playerSpriteY:int = 44;
		
		/* Door and key sprite sheet */
		[Embed(source = "../assets/tilesheets/door.png")]
		public static var doorSprite:Class;
		public static var doorSpriteX:int = 32;
		public static var doorSpriteY:int = 32;
		
		/* Gate sprite sheet */
		[Embed(source = "../assets/tilesheets/gates.png")]
		public static var gateSprite:Class;
		public static var gateSpriteX:int = 16;
		public static var gateSpriteY:int = 64;
		
		[Embed(source = "../assets/tilesheets/door.png")]
		public static var exitSprite:Class;
		public static var exitSpriteX:int = 32;
		public static var exitSpriteY:int = 32;
		
		/* Ice platform sprites */
		[Embed(source = "../assets/objects/ice_platform.png")]
		public static var iceSprite:Class;
		[Embed(source = "../assets/objects/flash_platform.png")]
		public static var flashSprite:Class;
		
		/* Other stuff */
		[Embed(source = "../assets/objects/spikes.png")]
		public static var spikeSprite:Class;
		[Embed(source = "../assets/objects/upspikes.png")]
		public static var upspikeSprite:Class;
		
		[Embed(source = "../assets/objects/button.png")]
		public static var buttonSprite:Class;
		public static var buttonSpriteX:int = 32;
		public static var buttonSpriteY:int = 32;
		
		[Embed(source = "../assets/objects/trapdoor.png")]
		public static var trapdoorSprite:Class;
		public static var trapdoorSpriteX:int = 20;
		public static var trapdoorSpriteY:int = 10;
		
		[Embed(source = "../assets/objects/movingplatform.png")]
		public static var movingSprite:Class;
		
		
		/* Background sprites */
		/* Background sprites */
		[Embed(source = "../assets/backgrounds/background.png")]
		private static var b_1:Class;
		[Embed(source = "../assets/backgrounds/bkgd3.png")]
		private static var b_2:Class;
		[Embed(source = "../assets/backgrounds/bkgd4.png")]
		private static var b_3:Class;
		[Embed(source = "../assets/backgrounds/bkgd5.png")]
		private static var b_4:Class;
		[Embed(source = "../assets/backgrounds/bkgd4_1.png")]
		private static var b_5:Class;
		[Embed(source = "../assets/backgrounds/bkgd5_1.png")]
		private static var b_6:Class;
		[Embed(source = "../assets/backgrounds/bkgd6.png")]
		private static var b_7:Class;
		[Embed(source = "../assets/backgrounds/bkgd7.png")]
		private static var b_8:Class;
		[Embed(source = "../assets/backgrounds/bkgd9.png")]
		private static var b_9:Class;
		[Embed(source = "../assets/backgrounds/blueclouds.jpg")]
		private static var b_10:Class;
		[Embed(source = "../assets/backgrounds/moon1.jpg")]
		private static var b_11:Class;
		[Embed(source = "../assets/backgrounds/moon2.jpg")]
		private static var b_12:Class;
		[Embed(source = "../assets/backgrounds/moon3.jpg")]
		private static var b_13:Class;
		[Embed(source = "../assets/backgrounds/morecloudz.jpg")]
		private static var b_14:Class;
		[Embed(source = "../assets/backgrounds/starstuff.jpg")]
		private static var b_15:Class;
		[Embed(source = "../assets/backgrounds/sunsetcloud.jpg")]
		private static var b_16:Class;
		
		
		/**
		 * List of backgrounds in the order that they appear in the game.
		 */
		public static var b_list:Array = [b_1, b_9, b_3, b_16, b_6, b_15, b_8, b_9, b_10, b_11, b_12, b_13, b_14, b_15, b_16];
		
		/* Sounds */
	}
}