package;

class TraceFLM {
  static function main() {
    var r = new amf.io.Amf3Reader(Sys.stdin());
    while (true) {
      try {
        var data:Map<String, Dynamic> = r.read();
        Sys.stdout().writeString(haxe.Json.stringify(data)+"\n");
      } catch( ex:haxe.io.Eof ) { break; }
    }
  }
}
