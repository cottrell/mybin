#!/bin/sh
remote="origin"
old=$(git remote get-url $remote)
new=$(echo $old | sed  's|:|/|;s|git@|https://|')
echo "$remote: $old -> $new"
sleep 1
git remote set-url $remote $new
git remote show $remote
