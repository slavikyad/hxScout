package
{
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.desktop.NativeApplication;
  import flash.utils.getTimer;
  import flash.utils.setTimeout;
  import flash.geom.Rectangle;

  [SWF( width="640", height="480", backgroundColor="#ff0000", frameRate="60")]
  public class Main extends Sprite
  {
    // Exit after 4 frames
    public function Main():void
    {
      setTimeout(function():void {
        trace("Goodbye!");
        NativeApplication.nativeApplication.exit();
      }, 4000);

      var refs:Array = [];

      // Work on each frame
      var frame:int = 0;
      stage.addEventListener(Event.ENTER_FRAME,
                             function():void {
                               frame++;
                               var t0:Number = getTimer();
                               for (var i:int=0; i<2000; i++) {
                                 refs.push(new Rectangle(Math.random(),
                                                         Math.random(),
                                                         Math.random(),
                                                         Math.random()));
                               }
                               if (frame%10==0) refs.length = 0; // release!
                             });

    }
  }
}
