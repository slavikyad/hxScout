package
{
  import flash.desktop.NativeApplication;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.geom.Rectangle;
  import flash.utils.ByteArray;
  import flash.utils.getTimer;
  import flash.utils.setTimeout;

  [SWF( width="640", height="480", backgroundColor="#ff0000", frameRate="60")]
  public class Main extends Sprite
  {
    // Do some long computation, then exit
    public function Main():void
    {
      trace("Begin");
      setTimeout(do_perlin_1, 167);
    }

    private var b:ByteArray;
    private var bd:BitmapData;

    private function do_perlin_1():void
    {
      var t0:Number = getTimer();
      bd = new BitmapData(256,256,true,0x0);
      bd.perlinNoise(32,32,7,12345,false,true);
      trace("perlin_1 took "+(getTimer()-t0)+" ms");

      t0 = getTimer();
      for (var i:int=0; i<10; i++) {
        do_perlin_2(bd);
      }
      trace("set of 10x perlin_2 took "+(getTimer()-t0)+" ms");

      setTimeout(exit, 167);
    }

    private function do_perlin_2(bd:BitmapData):void
    {
      var t0:Number = getTimer();
      bd.perlinNoise(16,16,7,12345,false,true);
      trace("perlin_2 took "+(getTimer()-t0)+" ms");
      trace("Got sum: "+calc_sum(bd));
    }

    private function calc_sum(bd:BitmapData):int
    {
      var t0:Number = getTimer();
      var sum:int = 0;
      for (var y:int=0; y<bd.height; y++) {
        for (var x:int=0; x<bd.width; x++) {
          sum += bd.getPixel(x, y);
        }
      }
      trace("sum ("+sum+") took "+(getTimer()-t0)+" ms");
      return sum;
    }


    private function exit():void {
      NativeApplication.nativeApplication.exit();
    }
  }
}
