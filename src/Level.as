package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	public class Level extends World
	{
		[Embed(source = '../assets/planet.png')] private const PLANET:Class;
		
		private var asteroidSpawnCount:int;
		
		private var ship:Ship;
		
		private var planet:Entity;
		
		public var score:ScoreText;
		public var hiScore:ScoreText;
		public var scoreI:int;
		public var HiScoreI:int;
		
		public function Level(currHiScore:int)
		{
			asteroidSpawnCount = GC.asteroidSpawnInterval;
			
			ship = new Ship(GC.worldWidth / 2, GC.worldHeight / 2 - 100)
			
			add(ship);
			
			score = new ScoreText(10, 10, 0, "Score: ");
			scoreI = 0;
			HiScoreI = currHiScore;
			hiScore = new ScoreText(10, 25, HiScoreI, "High Score: ");
			
			add(score);
			add(hiScore);
			
			planet = new Entity(GC.worldWidth / 2, GC.worldHeight / 2, new Image(PLANET));
			var planetI = planet.graphic as Image;
			planetI.originX = planetI.originY = 40;
			planet.type = "planet";
			planet.setHitbox(80, 80, 40, 40);
			add(planet);
		}
		
		override public function update():void
		{
			asteroidSpawnCount--;
			
			if (asteroidSpawnCount < 0) 
			{
				spawnAsteroid();
				asteroidSpawnCount = GC.asteroidSpawnInterval;
			}
			
			super.update();
		}
		
		public function spawnAsteroid()
		{
			var a1:Number = Math.random() * 2 * Math.PI;
			var a2:Number = Math.random() * 2 * Math.PI;
			
			add(new Asteroid(ship.x + (Math.cos(a2) * GC.asteroidSpawnRadius), ship.y + (Math.sin(a2) * GC.asteroidSpawnRadius), GC.asteroidSpeed * Math.cos(a1), GC.asteroidSpeed * Math.sin(a1), 3));
		}
		
		public function scoreGet():void
		{
			scoreI += GC.asteroidScore;
			score.setScore(scoreI);
			
			if (scoreI > HiScoreI) 
			{
				HiScoreI = scoreI;
				hiScore.setScore(HiScoreI);
			}
		}
	}
}