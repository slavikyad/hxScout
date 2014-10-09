#!/bin/sh
if [ "$#" -ne 1 ]; then
 FILE="capture.flm"
else
 FILE=$1
fi
echo "Listening on port 7934, dumping to $FILE"
nc -l 0.0.0.0 7934 > $FILE
