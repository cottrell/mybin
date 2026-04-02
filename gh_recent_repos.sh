#!/bin/bash

TODAY=$(date +%Y-%m-%d)
DATE_ONE_YEAR_AGO=$(date -d "$TODAY - 1 year" +%Y-%m-%d)

 (
  gh api -H "Accept: application/vnd.github+json" "/search/repositories?q=user:cottrell+pushed:>=$DATE_ONE_YEAR_AGO&per_page=1000" --jq '.items[].full_name'
  gh api -H "Accept: application/vnd.github+json" "/search/repositories?q=user:cottrell+created:>=$DATE_ONE_YEAR_AGO&per_page=1000" --jq '.items[].full_name'
) | sort -u

