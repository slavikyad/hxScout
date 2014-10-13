hxScout
=======

A Haxe Scout Alternative

What
----
hxScout aims to be a free, cross-platform alternative to Adobe Scout providing
much the same capability - that is, it will display telemetry, debug, and memory
usage data from a Flash Player runtime.

Why?
----
Because Adobe Scout is limited to Windows or OSX and requires a CC account,
and I'm a linux and OSS fan.

Status
------

Pre-alpha proof of concept - there is a socket server and AMF reader proof
of concept. It currently only tracks frame durations, and doesn't do it
quite correctly, but it's on the right track.

I've also setup a number of [flm_exploration](https://github.com/jcward/hxScout/tree/master/flm_exploration) testcases
that run various AS3 AIR app tests, capturing the .flm output with a variety of telemetry
configuration options (basic, sampler, cpu, allocations, etc).

I've piped [a testcase](https://github.com/jcward/hxScout/tree/master/flm_exploration/test_wastealloc) output through the Server.hx to create a summary of
frames timing and memory usage, and I've hard-coded the output frame duration data into a [prototype web client
view](https://github.com/jcward/hxScout/tree/master/proto_client) just for a visual sanity check.  This testcase makes useless allocations to see the garbage collector at work, and voila, something reasonable and familiar:

# ![hxScout client PoC](https://raw.githubusercontent.com/jcward/hxScout/master/screenshots/client_sanity.png)

Goal / Vision
-------------
The idea is to have the Haxe server read the Scout telemetry data stream,
store stateful data, and deliver that data to some GUI. The GUI may be a
web-based GUI client, may use haxenode.

TODO / Help
-----------
Figure out what all the telemetry info means so we can display useful
info similar to [Adobe Scout](http://wwwimages.adobe.com/content/dam/Adobe/en/devnet/flashruntimes/adobe-scout-getting-started/adobe-scout-getting-started-fig10.png).  Feel free to fork this project, tinker, file issues, 
or contact me ([@jeff__ward](https://twitter.com/jeff__ward) or various social links at [jcward.com](http://jcward.com/)) if you can help.

Usage
-----
1) Run the `server.sh` script to start the server, which listens on port 7934

2) On the machine running flash (may be a mobile device, a separate computer,
or the same computer), ensure there is a telemetry.cfg file (see links below)

Here's an example same same-computer, wine/AIR app at `~/.wine/drive_c/users/<username>/.telemetry.cfg` (may need the IP address of the server host instead of localhost):

    DisplayObjectCapture = false
    SamplerEnabled = true
    TelemetryAddress = localhost:7934
    Stage3DCapture = false
    CPUCapture = true
    ScriptObjectAllocationTraces = true

3) Run the Flash app (whether SWF, AIR app, or mobile app), and watch the
server print out the telemetry data, e.g.:

    Server.hx:17: {name => callstack, delta => 236, span => 165}
    Server.hx:17: {name => .sampler.medianInterval, delta => 1}
    Server.hx:17: {name => .sampler.averageInterval, delta => 28, span => 21}
    Server.hx:17: {name => .sampler.maxInterval, value => 0}
    Server.hx:17: {name => .3d.resource.drawCalls, value => 1}
    Server.hx:17: {name => [object Function], delta => 3817, span => 3791, value => .player.cpu}
    Server.hx:17: {name => .tlm.doplay, delta => 7, span => 3810}
    Server.hx:17: {name =>  - seed=1506269906, delta => 22, span => 10}
    Server.hx:17: {name => [object BitmapData], delta => 576, span => 539}
    Server.hx:17: {name => .swftags, delta => 5, span => 561, value => {name => null, modified => false, ymin => 0, ymax => 768, xmin => 0, xmax => 1024, symbolname => null}}
    Server.hx:17: {name => .rend.display.mode, delta => 715, span => 1}
    Server.hx:17: {name => fullscreen, delta => 20, span => 5189}
    Server.hx:17: {name => .memory.newObject, value => {stackid => 0, size => 40, type => [object AVM1Movie$], time => 705633, id => 216931352}}
    Server.hx:17: {name => .memory.newObject, value => {stackid => 412, size => 56, type => [class String], time => 705743, id => 293804592}}

Resources
---------

Adobe Dev Articles:

http://www.adobe.com/devnet/scout/articles/adobe-scout-getting-started.html
http://www.adobe.com/devnet/scout/articles/adobe-scout-data.html
http://www.adobe.com/devnet/scout/articles/adobe-scout-custom-telemetry.html

https://github.com/claus/Pfadfinder - Claus Wahlers' similar project

http://renaun.com/blog/2012/12/enable-advanced-telemetry-on-flex-or-old-swfs-with-swf-scount-enabler/ - Renaun's AIR app to enable telemetry tag in SWFs
