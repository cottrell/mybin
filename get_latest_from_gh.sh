#!/bin/bash
# https://stackoverflow.com/questions/10649814/get-last-git-tag-from-a-remote-repo-without-cloning/12704727
if [[ $# != 1 ]]; then
    echo "usage: prog org/repo"
    exit 1
fi
org_repo=$1
# git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' https://github.com/$org_repo.git
git -c 'versionsort.suffix=-' ls-remote --exit-code --refs --sort='version:refname' --tags https://github.com/$org_repo.git '*.*.*' | tail -1 | cut -d'/' -f3
