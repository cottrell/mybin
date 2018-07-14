#!/bin/sh -e
if [[ "$#" -ne 1 ]]; then
    echo prog.sh user
    exit 1
fi
curl https://api.github.com/users/$1/repos > curl.json
cat curl.json | python -c "import sys, json; d = json.loads(sys.stdin.read()); [print(','.join([str(x['fork']), x['git_url']])) for x in d]" > git_url.csv
git init
[[ -d forks ]] || mkdir -p forks
cd forks
for x in $(grep '^True' ../git_url.csv | cut -d, -f2); do
    git submodule add $x
done
for x in $(grep '^False' ../git_url.csv | cut -d, -f2); do
    git submodule add $x
done
cd -
