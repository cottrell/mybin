#!/bin/bash
awk '!x[$0]++' $*
