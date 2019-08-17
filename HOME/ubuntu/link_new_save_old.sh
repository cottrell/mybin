#!/bin/bash -e
DIR="$( cd "$(dirname "$0")" ; pwd -P )"

cd $DIR
files=$(ls -d $(echo -e "$(\ls)\n$(\ls -A)" | sort | uniq -u) | grep -v '\.swp$')
cd -

echo will link $files ... kill now if this looks wrong!
sleep 1

cd ~
pwd
for x in $files; do
    if [[ -e $x ]] || [[ -L $x ]]; then
        mv -v $x $x.$(date +%Y%m%d%H%M%S)
    fi
    echo ln -s $DIR/$x
    ln -s $DIR/$x
done
cd -

x=~/.ssh/config
if [[ -e $x ]] || [[ -L $x ]]; then
    mv -v $x $x.$(date +%Y%m%d%H%M%S)
fi
ln -s $DIR/ssh/config ~/.ssh/config
