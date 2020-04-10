#!/bin/bash
find . -type f -printf "%T+\t%p\n" | sort
