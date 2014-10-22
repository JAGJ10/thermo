package Menu 
{
	/**
	 * ...
	 * @author KJin
	 */
	public class MenuComponentCollection 
	{
		protected var menuItems:Vector.<MenuComponent>;
		protected var selectedID;
		protected var isActive;
		protected var X;
		protected var Y;
		private var width:Number;
		private var height:Number;
		
		public function MenuComponentCollection(X:Number=0, Y:Number=0) 
		{
			menuItems = new Vector.<MenuComponent>();
			selectedID = 0;
			isActive = false;
			this.X = X;
			this.Y = Y;
			width = 0;
			height = 0;
		}
		
		public function AddComponent(component:MenuComponent) : void
		{
			component.SetCollection(this, menuItems.length);
			menuItems.push(component);
		}
		
		public function Register(state:FlxState) : void
		{
			for (var i:uint = 0; i < menuItems; i++)
			{
				menuItems[i].Register(state);
			}
		}
		
		// Do NOT override
		public function Update() : void
		{
			Preprocess();
			for (var i:uint = 0; i < menuItems; i++)
			{
				menuItems[i].Update(i == selectedID);
			}
			Postprocess();
		}
		
		public function GetSelectedId() : uint
		{
			return selectedID;
		}
		
		public function SetIsActive(isActive:Boolean) : void
		{
			this.isActive = isActive;
		}
		
		public function GetNumComponents() : void
		{
			return menuItems.length;
		}
		
		public function Preprocess() : void
		{
			// Implement in child functions
		}
		
		public function Postprocess() : void
		{
			// Implement in child functions
		}
	}

}