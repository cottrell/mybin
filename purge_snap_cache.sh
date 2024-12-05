#!/bin/bash
sudo systemctl stop snapd
for x in $(sudo ls /var/lib/snapd/cache/); do sudo rm /var/lib/snapd/cache/$x; done
sudo systemctl start snapd
