package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	
	public class ScoreText extends Entity
	{
		private var score:int;
		
		private var prefix:String;
		
		public function ScoreText(x:int, y:int, score:int, prefix:String)
		{
			this.x = x; this.y = y;
			this.prefix = prefix;
			this.score = score;
			graphic = new Text(prefix + score.toString());
		}
		
		public function setScore(s:int)
		{
			score = s;
			(graphic as Text).text = prefix + score.toString();
		}
	}
}