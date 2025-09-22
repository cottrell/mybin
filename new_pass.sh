#!/bin/bash
# date +%s | sha256sum | base64 | head -c 32 ; echo
# < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
# dd if=/dev/urandom bs=1 count=32 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev
LENGTH=${1:-32}
openssl rand -base64 $LENGTH
