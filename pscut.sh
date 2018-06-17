#!/bin/sh
# REMINDER SCRIPT
# ps aux | grep blah_blah
# you want kill all you see?
# ps aux | grep blah_blah | pscut.sh | xargs kill -9
awk '{print $2}'
