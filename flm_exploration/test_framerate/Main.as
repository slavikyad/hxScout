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
      setTimeout(function():void {
        trace("Setting framerate to 30 fps");
        stage.frameRate = 30;
      }, 500);
      setTimeout(function():void {
        trace("Setting framerate to 10 fps");
        stage.frameRate = 10;
      }, 1000);
      setTimeout(function():void {
        trace("Setting framerate to 2 fps");
        stage.frameRate = 2;
      }, 1500);
      setTimeout(function():void {
        trace("Setting framerate to 60 fps");
        stage.frameRate = 60;
      }, 3500);
      setTimeout(function():void {
          trace("Goodbye!");
          NativeApplication.nativeApplication.exit();
      }, 4000);
    }
  }
}
