#!/bin/sh
ip=$(cat ~/resiliosync/external_ip.txt)
echo ssh -t cottrell@$ip -p 2142 tmux -CC
