#!/bin/bash

USER=${1:-cottrell}
TODAY=$(date +%Y-%m-%d)
DATE_ONE_YEAR_AGO=$(date -d "$TODAY - 1 year" +%Y-%m-%d)

gh repo list "$USER" --limit 1000 --json nameWithOwner,visibility,pushedAt,createdAt,sshUrl | \
  jq -r --arg date "$DATE_ONE_YEAR_AGO" '
    [
      .[] |
      select((.pushedAt // .createdAt // "1970-01-01T00:00:00Z")[0:10] >= $date)
    ] |
    sort_by(.pushedAt // .createdAt) |
    reverse |
    .[] |
    "\((.pushedAt // .createdAt // "") | .[0:16] | sub("T"; " "))\t\(.nameWithOwner)\t\(.visibility | ascii_downcase)\t\(.sshUrl)"
  ' | column -t -s $'\t'
