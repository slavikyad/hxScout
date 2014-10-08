hxScout utils
=============

`encode_amf.rb` - Encode a JSON or YAML file into AMF

`decode_amf.rb` - Decode an AMF file into JSON

`capture_flm.sh` - Use netcat to listen on port 7934 and dump capture.flm file

`push_flm.sh` - Use netcat to push an FLM file to localhost 7934

`experimental/decode_flm.sh` - uses a modified RocketAMF deserializer.rb to dump an .flm file (which is a concatenation of AMF blobs without clearing the traits/objects cache inbetween)

