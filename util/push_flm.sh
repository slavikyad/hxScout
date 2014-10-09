#!/bin/sh
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <file.flm> [<host>]" >&2
  exit 1
fi
if [ "$#" -lt 2 ]; then
 HOST="localhost"
else
 HOST=$2
fi
echo "Pushing $1 to $HOST port 7934"
nc $HOST 7934 < $1
