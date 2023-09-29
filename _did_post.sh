#!/bin/bash -e
# dirname=~/Dropbox/misc/nogithub
dirname=~/projects/notebooks/mybin/myhome/notes
hostname=$(hostname)
filename=did_$hostname.txt
# uses the name of the (link) script in UPEPR CASE as the TAG.
# for example: ln -s _did_post.sh todo
name=$(basename $0 | tr '[:lower:]' '[:upper:]')
vim +'normal Go'  +'r!date +\%a\ \%d\ \%b\ \%Y\ \%H:\%M:\%S\ \%z; echo - '$name,$hostname',' +'normal G$A' -- $dirname/$filename
# 2023-09-29 try run things in background and disown. Consider disabling pull
# and push constantly as well now that I have partitioned by device.
(
cd $dirname && \
git pull && \
git add $dirname/$filename && \
git commit -m 'update' && \
git push
) &
disown
