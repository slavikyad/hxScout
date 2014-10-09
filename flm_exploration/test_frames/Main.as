package
{
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.desktop.NativeApplication;
  import flash.utils.setTimeout;

  [SWF( width="640", height="480", backgroundColor="#ff0000", frameRate="60")]
  public class Main extends Sprite
  {
    // Exit after 4 frames
    public function Main():void
    {
      var frame:int = 1;
      trace("At frame "+frame);
      stage.addEventListener(Event.ENTER_FRAME,
                             function():void {
                               frame++;
                               trace("At frame "+frame);
                               if (frame==4) {
                                 trace("Goodbye!");
                                 stage.frameRate = 0.1;
                                 setTimeout(function():void {
                                   NativeApplication.nativeApplication.exit();
                                 }, 500);
                               }
                             });
    }
  }
}
