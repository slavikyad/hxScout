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
      setTimeout(do_perlin, 200);
    }

    private var b:ByteArray;
    private var bd:BitmapData;

    private function do_perlin():void
    {
      var t0:Number = getTimer();
      bd = new BitmapData(1024,1024,true,0x0);
      bd.perlinNoise(64,64,7,12345,false,true);
      trace("Perlin took "+(getTimer()-t0)+" ms");

      t0 = getTimer();
      bd.histogram();
      trace("Histogram took "+(getTimer()-t0)+" ms");

      setTimeout(function():void {
        addChild(new Bitmap(bd));
      }, 100);

      setTimeout(function():void {
        b = new ByteArray();
        for (var i:int=0; i<10000; i++) {
          b.writeInt(i);
        }
        trace("Bytearray length is: "+b.length);
      }, 200);

      setTimeout(exit, 300);
    }

    private function exit():void {
      NativeApplication.nativeApplication.exit();
    }
  }
}
