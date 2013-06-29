package
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Ship extends Entity
	{
		[Embed(source = '../assets/ship.png')] private const IMG:Class;
		
		public var velX:Number;
		public var velY:Number;
		
		public var a:Number;
		
		public var fireCount:int;
		
		public function Ship(x:Number, y:Number)
		{
			this.x = x; this.y = y;
			velX = velY = 0;
			a = Math.PI / 2;
			
			var i:Image = new Image(IMG);
			
			graphic = i;
			i.originX = i.originY = GC.shipSize / 2;
			
			setHitbox(GC.shipSize - 6, GC.shipSize - 6, (GC.shipSize - 4) / 2 , (GC.shipSize - 4) / 2);		
			
			type = "ship";
		}
		
		override public function update():void
		{
			//input
			if (Input.check(Key.UP))
			{
				velX -= GC.shipAcn * Math.cos(a);
				velY -= GC.shipAcn * Math.sin(a);
			}
			if (Input.check(Key.DOWN))
			{
				velX += GC.shipAcn * Math.cos(a);
				velY += GC.shipAcn * Math.sin(a);
			}
			if (Input.check(Key.LEFT))
				a -= GC.turnSpeed;
			if (Input.check(Key.RIGHT))
				a += GC.turnSpeed;
			
			if (Input.check(Key.SPACE))
				fire();
				
			fireCount--;
			
			velX *= 0.97;
			velY *= 0.97;
			
			x += velX; y += velY;
			
			GC.wrap(this);
			
			(graphic as Image).angle = 90 - GC.radiansToDegrees(a);
			
			if (collide("asteroid", x, y) || collide("planet", x, y))
			{
				FP.world = new Level((this.world as Level).HiScoreI);
			}
			
			super.update();
		}
		
		public function fire()
		{
			if (fireCount <= 0)
			{
				this.world.add(new Laser(x - Math.cos(a) * (GC.shipSize / 2), y - Math.sin(a) * (GC.shipSize / 2), -GC.laserSpeed * Math.cos(a), -GC.laserSpeed * Math.sin(a)));
				fireCount = GC.fireInterval;
			}
		}
	}
}