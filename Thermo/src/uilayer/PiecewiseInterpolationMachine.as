package uilayer {
	/**
	 * ...
	 * @author KJin
	 */	
	public class PiecewiseInterpolationMachine 
	{
		//n
		private var nodes:Vector.<PiecewiseInterpolationNode>;
		
		private var periodic:Boolean;
		private var time:uint;
		private var bracket:uint;
		private var completionCallback:Function;
		
		public function PiecewiseInterpolationMachine(periodic:Boolean, ... args)
		{
			this.periodic = periodic;
			this.time = 0;
			this.bracket = 0;
			completionCallback = null;
			nodes = new Vector.<PiecewiseInterpolationNode>();
			for (var i:uint; i < args.length; i++)
			{
				nodes.push(args[i]);
				// The last argument MUST have a null method of interpolation
				// Correct for this here.
				if (i == args.length - 1)
				{
					nodes[i].NullifyInterpolationMethod();
				}
			}
		}
		
		public function EvaluateAndUpdate() : Number
		{
			var result:Number = Evaluate();
			Update();
			return result;
		}
		
		public function Update() : void
		{
			if (bracket < nodes.length - 1)
			{
				time++;
				if (time == nodes[bracket+1].t)
				{
					bracket++;
				}
			}
			if (periodic && bracket == nodes.length - 1)
			{
				time = 0;
				bracket = 0;
			}
		}
		
		public function Evaluate() : Number
		{
			if (bracket == nodes.length - 1)
			{
				if (completionCallback != null)
				{
					completionCallback();
					completionCallback = null;
				}
				return PiecewiseInterpolationNode.Evaluate(nodes[bracket]);
			}
			return PiecewiseInterpolationNode.Evaluate(nodes[bracket], nodes[bracket + 1], time);
		}
		
		public function FastForward() : void
		{
			bracket = nodes.length - 1;
			time = nodes[bracket].t;
		}
		
		public function JumpToBracket(num:uint):void
		{
			bracket = num;
			if (bracket > nodes.length - 1)
			{
				bracket = nodes.length - 1;
			}
			time = nodes[bracket].t;
		}
		
		public function CallUponCompletion(callback:Function):void
		{
			completionCallback = callback;
		}
	}

}