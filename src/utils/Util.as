package utils
{
	public class Util
	{
		public function Util()
		{
		}
		public static function dec2bin(dec:uint, digits:Number=6):Array
		{
			var result:Array = new Array();
			var i:int;
			for (i = 0; i <= digits-1; i++)
			{
				result[i] = 0;
			}
			for (i=digits-1; i >= 0; i--)
			{
				if ((dec - Math.pow(2,i)) >= 0)
				{
					result[i] = 1;
					dec -=  Math.pow(2,i);
				}
			}
			return result.reverse();
		}
	}
}