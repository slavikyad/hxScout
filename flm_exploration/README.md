hxScout FLM Exploration
=======================

These tests are quick AIR apps that perform a few certain tasks and exit,
hopefully allowing some triage of relatively small FLM dumps.

To run a testcase and capture the FLM with netcat:

    cd flm_exploration/test_x
    ./compile.sh
    ../../util/capture_flm.sh & ./simulate.sh

Verify your .flm file got captured:

    > ls -la capture.flm
    -rw-rw-r-- 1 jward jward 25980 Oct  7 22:53 capture.flm

To push that flm to hxScout (from hxScout directory):

    Terminal 1> ./server.sh > flm_exploration/test_x/capture.txt
    Terminal 2> util/push_flm.sh flm_exploration/test_x/capture.flm

Then break the first command after running the second -- `Server.hx` currently
does not exit after a single connection.

You could also push this FLM to Adobe Scout using netcat (to localhost or IP address):

    nc localhost 7934 < flm_exploration/test_x/capture.flm

If you get a rouge server or nc process listening to 7934 (and you get
errors binding to port 7934) you can find it using
`netstat -lpunt | grep :7934`, e.g.

    tcp  0  0  127.0.0.1:7934  0.0.0.0:*  LISTEN  32183/neko      

So then: `kill 32183`
