package
{
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.desktop.NativeApplication;
  import flash.utils.getTimer;
  import flash.utils.setTimeout;

  [SWF( width="640", height="480", backgroundColor="#ff0000", frameRate="60")]
  public class Main extends Sprite
  {
    // Exit after 4 frames
    public function Main():void
    {
      setTimeout(function():void {
        trace("Setting framerate to 30 fps");
        stage.frameRate = 30;
      }, 1000);
      setTimeout(function():void {
        trace("Setting framerate to 60 fps");
        stage.frameRate = 60;
      }, 2000);
      setTimeout(function():void {
        trace("Goodbye!");
        NativeApplication.nativeApplication.exit();
      }, 4000);

      // Work on each frame
      stage.addEventListener(Event.ENTER_FRAME,
                             function():void {
                               var sum:Number = 0;
                               var t0:Number = getTimer();
                               for (var i:int=0; i<40000; i++) {
                                 sum += Math.random();
                               }
                               trace("Calculated sum: "+sum+", took "+(getTimer()-t0)+" ms");
                             });

    }
  }
}
