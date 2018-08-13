#!/bin/sh
# this is just some guys public db, missing a lot of stuff
# 00:0C:42:1F:65:E9
if [[ $# -ne 1 ]]; then
    echo usage prog bssid
    exit 1
fi
curl "https://api.mylnikov.org/geolocation/wifi?v=1.1&data=open&bssid=$1" -H 'authority: api.mylnikov.org' -H 'pragma: no-cache' -H 'cache-control: no-cache' -H 'upgrade-insecure-requests: 1' -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'accept-encoding: gzip, deflate' -H 'accept-language: en-US,en;q=0.9' | gunzip
