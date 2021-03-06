#!/bin/bash
# dirname=~/Dropbox/misc/nogithub
dirname=~/projects/notebooks/mybin/myhome/notes
filename=did.txt
# uses the name of the (link) script in UPEPR CASE as the TAG.
# for example: ln -s _did_post.sh todo
name=$(basename $0 | tr '[:lower:]' '[:upper:]')
vim +'normal Go'  +'r!date +\%a\ \%d\ \%b\ \%Y\ \%H:\%M:\%S\ \%z; echo - '$name',' +'normal G$A' -- $dirname/$filename
cd $dirname
git pull
git add $dirname/$filename
git commit -m 'update'
