class Test {

	static var FILE = Sys.args()[0];

	static function main() {
		var f = sys.io.File.read(FILE,true);
		read(f);
	}

	static function read( i ) {
		var r = new amf.io.Amf3Reader(i);
		var data:Map<String, Dynamic>;
    try
      {
        while (true) {
          data = r.read();
          trace(data);
        }
      } catch( ex:haxe.io.Eof )  {}

		i.close();
	}

}