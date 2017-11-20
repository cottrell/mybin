#!/bin/sh -e
# http://veithen.github.io/2014/11/16/sigterm-propagation.html

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

echo 'running zookeeper and kafka in background. Will kill both when ctrl-c'
trap 'kill -TERM $PID' TERM INT
bin/zookeeper-server-start.sh config/zookeeper.properties &
PID=$!
bin/kafka-server-start.sh config/server.properties &
PID2=$!
wait $PID $PID2
trap - TERM INT
