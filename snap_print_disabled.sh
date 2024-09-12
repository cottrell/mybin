#!/bin/bash
snap list --all
echo
snap list --all | awk '/disabled/{print $1, $3}' | while read snapname revision; do
  echo "sudo snap remove $snapname --revision=$revision"
done
