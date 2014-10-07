#!/usr/bin/env ruby
# Utility to convert .json or .yaml files to .amf
 
require 'json'
require 'yaml'
require 'rocketamf'
 
infile = ARGV[0]
outfile = ARGV[1]
 
if (infile==nil || outfile==nil) then
  puts "usage: to_amf.rb <json_or_yaml_file> <outfile.amf>"
  exit
end
 
if (infile.match(/\.yaml$/)) then
  File.open(outfile, 'wb') { |file| file.write RocketAMF.serialize(YAML.load(IO.read(infile)), 3) }
elsif (infile.match(/\.json$/)) then
  File.open(outfile, 'wb') { |file| file.write RocketAMF.serialize(JSON.parse(IO.read(infile)), 3) }
end
