#!/bin/bash
type autoflake > /dev/null || /usr/bin/pip3 install autoflake
autoflake --verbose --in-place --remove-all-unused-import $*
