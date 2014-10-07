#!/usr/bin/env ruby
 
require 'rocketamf'
require 'stringio'
 
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
  puts "usage: print_amf.rb <infile.amf>"
  exit
end
 
# And a little command-line utility for printing AMF as JSON
require 'json'
 
puts JSON.pretty_generate RocketAMF.deserialize(File.read(ARGV[0]), 3)
