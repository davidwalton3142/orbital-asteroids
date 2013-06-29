package
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	public class Laser extends Entity
	{
		[Embed(source = '../assets/laser.png')] private const IMG:Class;
		
		public var velX:Number;
		public var velY:Number;
		
		public function Laser(x:Number, y:Number, velX:Number, velY:Number)
		{
			this.x = x; this.y = y;
			this.velX = velX; this.velY = velY;
			
			var i:Image = new Image(IMG);
			i.originX = i.originY = GC.laserSize / 2;
			
			setHitbox(GC.laserSize, GC.laserSize, GC.laserSize / 2, GC.laserSize / 2);
			
			graphic = i;
			
			type = "laser";
		}
		
		override public function update():void
		{
			x += velX;
			y += velY;
			
			var fromCentre:Point = new Point(x - (GC.worldWidth / 2), y - (GC.worldHeight / 2));
			fromCentre.normalize(GC.gravity);
			
			velX -= fromCentre.x;
			velY -= fromCentre.y;
			
			if (x < 0 || x > GC.worldWidth || y < 0 || y > GC.worldHeight)
				if (this.world is World) this.world.remove(this);
				
			if (collide("planet", x, y)) this.world.remove(this);
				
			super.update();
		}
	}
}