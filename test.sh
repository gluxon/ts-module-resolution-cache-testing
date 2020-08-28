#!/bin/sh

tsserverPath="/Volumes/git/TypeScript/built/local/tsserver.js"

request1='{"seq":0,"type":"request","command":"open","arguments":{"file":"/Volumes/git/ts-test-repo/packages/a/src/a.ts"}}'
request2='{"seq":0,"type":"request","command":"open","arguments":{"file":"/Volumes/git/ts-test-repo/packages/b/src/b.ts"}}'

timestamp=$(date +%s)
timestampLogFile="tsserver-$timestamp.log"

echo "$request1\n$request2" | node "$@" $tsserverPath --disableAutomaticTypingAcquisition --logFile "$timestampLogFile"

if command -v rg &> /dev/null
then
    rg ".* Finishing updateGraphWorker: Project: (.*?) .* Elapsed: (.*)" -r '$1 ($2)' < "$timestampLogFile"
fi
