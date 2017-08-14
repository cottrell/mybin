#!/bin/sh
start=3000
[[ $1 ]] && start=$1
netstat -aln | awk '
  $6 == "LISTEN" {
    if ($4 ~ "[.:][0-9]+$") {
      split($4, a, /[:.]/);
      port = a[length(a)];
      p[port] = 1
    }
  }
  END {
    for (i = '$start'; i < 65000 && p[i]; i++){};
    if (i == 65000) {exit 1};
    print i
  }
'
