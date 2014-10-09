hxScout FLM Exploration
=======================

These tests are quick AIR apps that perform a few certain tasks and exit,
hopefully allowing some triage of relatively small FLM dumps.

To run a testcase, capture FLM output, and convert FLM to a text file (JSON objects):

    ./run_test.rb test_frames sampler ~/.wine/drive_c/users/jward/.telemetry.cfg

Where `test_frames` is the testcase to run, `sampler` is the config (see
various config names in `./config/`, and `~/.wine/drive_c/users/jward/.telemetry.cfg`
is the location of your `.telemetry.cfg` file.

The test runner copies the given telemetry config, compiles and simulates the
testcase, and captures the .flm and .txt output in the test directory.

You could also push this FLM to hxScout or Adobe Scout using netcat (to localhost or IP address):

    nc localhost 7934 < flm_exploration/test_x/capture.flm

If you get a rouge server or nc process listening to 7934 (and you get
errors binding to port 7934) you can find it using
`netstat -lpunt | grep :7934`, e.g.

    tcp  0  0  127.0.0.1:7934  0.0.0.0:*  LISTEN  32183/neko      

So then: `kill 32183` or slightly more dangerously, `killall nc`
