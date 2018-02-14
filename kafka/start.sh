#!/bin/sh -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

echo 'running zookeeper and kafka in background. Will kill both when ctrl-c'
bin/zookeeper-server-start.sh config/zookeeper.properties &
sleep 100 &
a=$!
bin/kafka-server-start.sh config/server.properties &
sleep 100 &
b=$!
other_commands() {
    printf "\rSIGINT caught"
    echo killing pid $a $b
    kill $a $b
}

trap 'other_commands' SIGINT
wait
