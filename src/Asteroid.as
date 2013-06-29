package
{
	import flash.events.IMEEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class Asteroid extends Entity
	{
		[Embed(source = '../assets/asteroid80.png')] private const IMG80:Class;
		[Embed(source = '../assets/asteroid40.png')] private const IMG40:Class;
		[Embed(source = '../assets/asteroid20.png')] private const IMG20:Class;
		
		public var velX:Number;
		public var velY:Number;
		
		public var size:int;
		
		public function Asteroid(x:Number, y:Number, velX:Number, velY:Number, size:int)
		{
			this.x = x; this.y = y;
			this.velX = velX;
			this.velY = velY;
			this.size = size; 
			
			var width:Number  = GC.asteroidSizes[size][0];
			var height:Number = GC.asteroidSizes[size][1];
			
			var i:Image;
			
			if (size == 3)
				i = new Image(IMG80);
			else if (size == 2)
				i = new Image(IMG40);
			else
				i = new Image(IMG20);
			
			i.originX = width / 2;
			i.originY = height / 2;
			
			graphic = i;
				
			setHitbox(width, height, width / 2, height / 2);
			
			type = "asteroid";
		}
		
		override public function update():void
		{
			x += velX; y += velY;
			
			GC.wrap(this);
			
			var b:Entity = collide("laser", this.x, this.y);
			
			if (b is Laser)
			{
				this.world.remove(b);
				(this.world as Level).scoreGet();
				split();
			}
			
			if (collide("planet", x, y)) split();
			
			super.update();
		}
		
		public function split()
		{
			this.world.remove(this);
			
			if (size > 0)
			{
				this.world.add(new Asteroid(x, y, -velX, velY, size - 1));
				this.world.add(new Asteroid(x, y, velX, -velY, size - 1));
			}
		}
	}
}