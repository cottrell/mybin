#!/usr/bin/env bash

set -euo pipefail

usage() {
    cat <<'EOF'
Usage: terminal_session.sh [path] [hostname]

If one argument is given, it is treated as a hostname unless it looks like a path.

Examples:
  terminal_session.sh
  terminal_session.sh bleepblop
  terminal_session.sh '$HOME/dev/planistan'
  terminal_session.sh '$HOME/dev/planistan' bleepblop
EOF
}

hostname=bleepblop
target=

case "${1:-}" in
    -h|--help|help)
        usage
        exit 0
        ;;
esac

if [ "$#" -gt 2 ]; then
    echo "Expected at most 2 arguments: [path] [hostname]" >&2
    usage >&2
    exit 1
fi

if [ "$#" -eq 1 ]; then
    case "$1" in
        /*|./*|../*|~|~/*|\$HOME|\$HOME/*)
            target=$1
            ;;
        *)
            hostname=$1
            ;;
    esac
elif [ "$#" -eq 2 ]; then
    target=$1
    hostname=$2
fi

if [ -n "$target" ]; then
    target="${target/#\~/\$HOME}"
fi

shell_quote() {
    printf "'%s'" "${1//\'/\'\\\'\'}"
}

remote_cd_command() {
    if [ -z "$target" ]; then
        return 1
    fi

    case "$target" in
        '$HOME')
            printf 'cd -- "$HOME"'
            ;;
        '$HOME'/*)
            local suffix=${target#\$HOME}
            printf 'cd -- "$HOME"%s' "$(shell_quote "$suffix")"
            ;;
        *)
            printf 'cd -- %s' "$(shell_quote "$target")"
            ;;
    esac
}

launch_cmd=(et "$hostname")
if [ -n "$target" ]; then
    remote_cmd=$(remote_cd_command)
    launch_cmd=(
        et
        -c
        "$remote_cmd"
        -e
        "$hostname"
    )
fi

gnome-terminal --tab --title="A" -- "${launch_cmd[@]}"
