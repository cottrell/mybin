#!/bin/bash
DIR="$( cd "$(dirname "$0")" ; pwd -P )"
mkdir -p $DIR/log
DATE=`/bin/date +\%Y-\%m-\%dT\%H:\%M:\%S`
LOGFILE=$DIR/log/inotify_watch_raw_$DATE.log
ERRFILE=$DIR/log/inotify_watch_raw_$DATE.err
ln -fs $LOGFILE $DIR/inotify_watch_raw_latest.log
ln -fs $ERRFILE $DIR/inotify_watch_raw_latest.err

HEADER="ts,path,events"
echo $HEADER > $LOGFILE
inotifywait -mrq --timefmt '%Y-%m-%dT%H:%M:%S' --format '%T,%w%f,%|e' \
-e attrib \
-e close_write \
-e moved_to \
-e moved_from \
-e move_self \
-e create \
-e delete \
-e delete_self \
-e unmount \
$DIR/raw \
-o $LOGFILE 2>$ERRFILE
