package;

class Server {
  static function main() {
    var s = new sys.net.Socket();
    s.bind(new sys.net.Host("localhost"),7934); // Default Scout port
    s.listen(1);
    trace("Starting server...");
    while( true ) {
      var socket : sys.net.Socket = s.accept();
      trace(" --- Client connected ---");
      //var output:FileOutput = File.write("server.flm", false);
      var r = new amf.io.Amf3Reader(socket.input);
      //var w = new amf.io.Amf3Writer(socket.output);
      while( true ) {
        try {
          var data:Map<String, Dynamic> = r.read();
          trace(data);
        } catch( ex:haxe.io.Eof )  { trace(" --- Client disconnected ---"); break; }
      }
    }
  }
}
