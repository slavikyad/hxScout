#!/bin/sh
$AIR_HOME/bin/mxmlc -debug -optimize=false -compress=false -inline -omit-trace-statements=false -advanced-telemetry +configname=air -swf-version=18 Main.as -o Main.swf
