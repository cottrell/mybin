#!/bin/bash

export EDITOR=/usr/bin/vim

# export CONDA_PREFIX=$HOME/anaconda3/envs/363
# export CONDA_DEFAULT_ENV=363

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [[ -e ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

alias bb='ssh -t cottrell@192.168.1.9 tmux -CC attach'
alias bbe='ssh -t cottrell@146.199.108.39 -p 2142 tmux -CC attach'
alias bx='bitchx dc_not_dc chat.freenode.net'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# MacPorts Installer addition on 2009-01-26_at_10:45:43: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH

export QUANDL_AUTH='GMs5ZwtAzsTP6MAHoyCH'

export LD_LIBRARY_PATH=$HOME/torch/install/lib:$LD_LIBRARY_PATH  # Added automatically by torch-dist
export DYLD_LIBRARY_PATH=$HOME/torch/install/lib:$DYLD_LIBRARY_PATH  # Added automatically by torch-dist

export export LIBFM_PATH=$HOME/dev/libfm/bin

# export PARQUET_HOME=$HOME/anaconda
export ARROW_HOME=$HOME/local

# NOTES:
# openssl des3 -in file.txt -out encrypted.txt
# openssl des3 -d -in encrypted.txt -out normal.txt

. $HOME/.bash_profile
# go here if unhappy http://bashrcgenerator.com/

. ~/mybin/functions.sh


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. ~/anaconda3/etc/profile.d/conda.sh
