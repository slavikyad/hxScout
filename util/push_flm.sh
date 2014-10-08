#!/bin/sh
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <file.flm>" >&2
  exit 1
fi
nc localhost 7934 < $1
