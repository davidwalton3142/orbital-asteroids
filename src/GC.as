package
{
	import net.flashpunk.Entity;
	public class GC
	{
		public static const gravity:Number = 0.1;
		
		public static const worldWidth:int = 1000;
		public static const worldHeight:int = 700;
		
		public static const shipAcn:Number = 0.1;
		public static const turnSpeed:Number = 0.03;
		public static const shipSize:int = 40;
		
		public static const laserSize:int = 10;
		public static const laserSpeed:Number = 4;
		public static const fireInterval:int = 30;
		
		public static const asteroidSpeed:Number = 1;
		public static const asteroidSpawnInterval:int = 200;
		public static const asteroidSpawnRadius:Number = 200;
		
		public static const maxAsteroidSize:int = 3;
		public static const asteroidSizes:Array = [[], [20, 20], [40, 40], [80, 80]];
		
		public static const asteroidScore:int = 10;
		
		public static function radiansToDegrees(rad:Number):Number
		{
			rad %= (2 * Math.PI);
			rad /= (2 * Math.PI);
			rad *= 360;
			return rad;
		}
		
		public static function wrap(e:Entity):void
		{
			if (e.x < 0) e.x += worldWidth;
			else if (e.x > worldWidth) e.x -= worldWidth;
			if (e.y < 0) e.y += worldHeight;
			else if (e.y > worldHeight) e.y -= worldHeight;
		}
	}
}