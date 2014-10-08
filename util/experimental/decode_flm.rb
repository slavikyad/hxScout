#!/usr/bin/env ruby
 
require 'rocketamf'
require 'stringio'

# .flm is a concatenation of .amf-encoded objects without the
# traits and object cache reset, so we need to continuously
# read the file until eof

# Monkey patch for RocketAMF (0.2.1 gem) that handles IExrternalizable types
# in the input, storing their type as "__as3_type" parameter:
module RocketAMF
  module Values #:nodoc:
    class TypedHash
 
      def externalized_data= obj
        obj.each { |k,v|
          self[k] = v
        }
        self["__as3_type"] = @type
      end
 
    end
  end
end

if (ARGV.length==0) then
  puts "usage: print_amf.rb <infile.flm>"
  exit
end

require 'json'
require 'stringio'

data = File.read(ARGV[0])
$last_source = StringIO.new(data)

puts "["
while (!$last_source.eof?) do
  #puts "At #{$last_source.pos} of #{$last_source.length}"
  deser = RocketAMF.deserialize($last_source, 3) # Use AMF3 encoding to serialize
  puts JSON.generate(deser) + ","
end
puts "]"
