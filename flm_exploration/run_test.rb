#!/usr/bin/ruby

require 'fileutils'

WIN = (/cygwin|mswin|mingw|bccwin|wince|emx/i =~ RUBY_PLATFORM) != nil
OSX = (/darwin/i =~ RUBY_PLATFORM) != nil
LINUX = !WIN && !OSX
raise "Windows is not currently supported" if WIN

if (ARGV.length!=3) then
  puts "usage: #{__FILE__} <test_name> <cfg_name> <cfg_path>"
  exit 1
end

test, cfg, cfg_path = ARGV

TST = test.sub(/\/$/, '')
CFG = "config/"+cfg+".telemetry.cfg"

raise "Invalid test name: #{TST}" unless File.directory?(TST)
raise "Invalid cfg name: #{cfg}" unless File.exist?(CFG)

AIR_HOME = ENV['AIR_HOME'] || ENV['AIR_SDK'] || ENV['AIR_SDK_HOME']
EXE = WIN ? '.exe' : ''
MXMLC = File.join(AIR_HOME, 'bin', 'mxmlc'+EXE);
ADL = File.join(AIR_HOME, 'bin', 'adl'+EXE);
WINE = LINUX ? 'wine ' : ''

raise "AIR_HOME environment variable not defined" unless File.directory?(AIR_HOME)
raise "mxmlc not found" unless File.executable?(MXMLC)
raise "adl not found" unless File.exists?(MXMLC)
raise "wine not found" unless (LINUX && `which wine`.length>3)

puts "Copying config #{CFG} to #{cfg_path}"
FileUtils.cp(CFG, cfg_path)

puts "Compiling #{TST}"
cmd = "cd #{TST}; #{MXMLC} -debug -optimize=false -compress=false -inline -omit-trace-statements=false -advanced-telemetry +configname=air -swf-version=18 Main.as -o Main.swf"
output = `#{cmd} 2>&1`
(puts cmd; puts output; exit 1) unless $?.success?

FLM = "capture.#{cfg}.flm"
TXT = FLM.sub(/flm$/, 'txt')

`cd #{TST}; rm -f #{FLM}`
puts "Capturing #{FLM}"
job1 = fork do
  `cd #{TST}; ../../util/capture_flm.sh #{FLM}`
  exit
end
Process.detach(job1)

puts "Simulating #{TST}"
cmd = "cd #{TST}; #{WINE+ADL} -profile extendedDesktop app.xml"
output = `#{cmd} 2>&1`

(puts cmd; puts output; raise "#{FLM} not successfully created!") unless File.exist?(File.join(TST, FLM))

puts "Converting #{FLM} to #{TXT}"
`cd #{TST}; (cat #{FLM} | neko ../../util/TraceFLM.n) > #{TXT}`

raise "#{TXT} not successfully created!" unless File.exist?(File.join(TST, TXT))

puts "Complete, output is:"
puts "-"*40
puts File.read(File.join(TST, TXT))
