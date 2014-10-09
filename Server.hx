package;

class Server {
  static function main() {
    var frames:Array<Frame> = [];
    var cur_frame = new Frame(0);
    var delta:Int = 0;

    var s = new sys.net.Socket();
    s.bind(new sys.net.Host("localhost"),7934); // Default Scout port
    s.listen(1);
    trace("Starting server...");
    while( true ) {
      var socket : sys.net.Socket = s.accept();
      trace(" --- Client connected ---");
      var r = new amf.io.Amf3Reader(socket.input);
      var connected = true;
      while( connected ) {

        // Read next event blob. TODO: r.eof? socket.eof? instead of try/catch
        var data:Map<String, Dynamic> = null;
        try {
          data = r.read();
        } catch( ex:haxe.io.Eof )  { connected = false; }

        if (data!=null) {
          // TODO: Only using delta so far - figure out what span/delta actually are
          if (data['delta']!=null) {
            cur_frame.duration.total += data['delta'];
            if (cast(data['name'], String).indexOf(".as.")==0) cur_frame.duration.as += data['delta'];
            if (cast(data['name'], String).indexOf(".gc.")==0) cur_frame.duration.gc += data['delta'];
          }
          //if (data['name']!=".enter") cur_frame.events.push(data); // kepp all events?
          if (data['name']==".enter") {
            Sys.stdout().writeString(cur_frame.to_json()+",\n");
            frames.push(cur_frame);
            cur_frame = new Frame(cur_frame.id+1);
            cur_frame.events.push(data);
          }
        }
      }
    }
  }
}

class Frame {
  public var id(default,null):Int;
  public var duration(default,default):Dynamic;
  public var events(default,null):Array<Dynamic>;

  public function new(frame_id:Int) {
    id = frame_id;
    duration = {};
    duration.total = 0;
    duration.as = 0;
    duration.gc = 0;
    events = [];
  }

  public function to_json():String
  {
    return haxe.Json.stringify({
      id:id,
      duration:duration
    });
  }
}
