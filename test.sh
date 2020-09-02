#!/bin/sh

if [ $# -eq 0 ]; then
  echo "Please provide a path to tsserver.js as the first argument"
  exit 1
fi

tsserverPath="$1"

if [ ! -f "$1" ]; then
  echo "File at given path for tsserver.js does not exist"
  exit 1
fi

dir=$(pwd)

request1="{\"seq\":0,\"type\":\"request\",\"command\":\"open\",\"arguments\":{\"file\":\"$dir/packages/a/src/a.ts\"}}"
request2="{\"seq\":0,\"type\":\"request\",\"command\":\"open\",\"arguments\":{\"file\":\"$dir/packages/b/src/b.ts\"}}"

timestamp=$(date +%s)
timestampLogFile="tsserver-$timestamp.log"

echo "$request1\n$request2" | node "${@:2}" $tsserverPath --disableAutomaticTypingAcquisition --logFile "$timestampLogFile"

if command -v rg &> /dev/null
then
    rg ".* Finishing updateGraphWorker: Project: (.*?) .* Elapsed: (.*)" -r '$1 ($2)' < "$timestampLogFile"
fi
