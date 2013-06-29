package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	
	[SWF(width = '1000', height = '700')]
	public class Main extends Engine
	{		
		public static var devMode:Boolean = false;
		
		public function Main()
		{
			super(GC.worldWidth, GC.worldHeight, 60, true);
			FP.world = new Level(0);
			
			if ( devMode )
			{
				FP.console.enable();
			}
			FP.console.toggleKey = Key.F1;
		}
	}
}