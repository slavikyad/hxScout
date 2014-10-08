#!/bin/sh
echo "Listening on port 7934, dumping to capture.flm"
nc -l 0.0.0.0 7934 > capture.flm
