#!/usr/bin/env bash

cat << 'EOF'
tmux HELP - Most useful commands (2026 edition)

=== From outside tmux (shell) ===

Start new session                  tmux
Start named session                tmux new -s mywork    (or tmux new-session -s mywork)
List all sessions                  tmux ls    (or tmux list-sessions)
Attach to last session             tmux a     (or attach, at)
Attach to named session            tmux a -t mywork
Kill specific session              tmux kill-session -t mywork
Kill all except current            tmux kill-session -a
Kill everything (careful!)         tmux kill-server

=== Inside tmux (default prefix: Ctrl-b, then release and press key) ===

Show this list / help              Ctrl-b ?
Detach (leave running)             Ctrl-b d
List sessions                      Ctrl-b s
Rename current session             Ctrl-b $
Next session                       Ctrl-b )           Previous: Ctrl-b (

New window                         Ctrl-b c
List windows                       Ctrl-b w
Rename current window              Ctrl-b ,
Next window                        Ctrl-b n           Previous: Ctrl-b p
Kill current window                Ctrl-b &           (or exit shell)

Split pane vertically (|)          Ctrl-b %
Split pane horizontally (-)        Ctrl-b "
Next pane                          Ctrl-b o           (or arrow keys)
Kill current pane                  Ctrl-b x           (confirm y)

Copy mode (scroll/search)          Ctrl-b [           (q to quit)
Paste from buffer                  Ctrl-b ]

Reload your ~/.tmux.conf           Ctrl-b : source-file ~/.tmux.conf
Command prompt                     Ctrl-b :

Pro tip: Put 'set -g mouse on' in ~/.tmux.conf for mouse support (resize, select, scroll).
Run 'man tmux' for the full manual (tmux -h is not a valid help option).
EOF
