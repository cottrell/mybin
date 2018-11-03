#!/bin/sh
xidel $1 -e '//tr / join(td, ",")'
