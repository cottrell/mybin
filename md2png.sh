#!/bin/bash
xclip -selection clipboard -o | marp --image png - - | xclip -selection clipboard -t image/png
