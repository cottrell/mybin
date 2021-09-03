#!/bin/bash
# https://askubuntu.com/questions/868186/how-to-kill-all-tmux-sessions-or-at-least-multiple-sessions-from-the-cli
tmux list-sessions | grep -v attached | awk 'BEGIN{FS=":"}{print $1}' | xargs -n 1 tmux kill-session -t || echo No sessions to kill
