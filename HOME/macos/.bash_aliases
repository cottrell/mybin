if [[ $(uname) = "Darwin" ]]; then
    alias docker_bash='docker run -t -i ubuntu /bin/bash'
    alias ds='du -s * | sort -g'

    alias grep='grep --color=auto'
    alias egrep='egrep --color=auto'
    alias fgrep='fgrep --color=auto'

    alias g='git'
    alias l='ls -CF'
    alias la='ls -a'
    alias ll='ls -lG'
    alias ls='ls -G'
    alias preview='open -a Preview.app'
    alias py27='source activate py27'
    alias pyspark_ipython='~/projects/notebooks/env.sh pyspark_ipython'
    alias python2='~/anaconda3/envs/py27_electrum/bin/python'

    alias d='dir_menu ~/dev'
    alias n='dir_menu ~/projects/notebooks'
    alias notes='vi ~/projects/notebooks/hugo/hugoblog/content/notes'
elif [[ $(uname) = "Linux" ]]; then
    alias xopen='xdg-open'
fi

# both
alias h='history'
alias lr='ls -lrt'
alias cdl='cd $(ls -d * -t | head -1)'
alias dap='cd ~/projects && ls'
alias dapd='cd ~/dev && ls'
alias dapda='cd ~/projects/notebooks/data && ls'
alias dapm='cd ~/mybin && ls'
alias dapn='cd ~/projects/notebooks && ls'
alias dapno='cd ~/projects/notes.hugo && ls'
alias dapnog='cd ~/Dropbox/misc/nogithub && ls'
alias daph='cd ~/projects/notebooks/hugo/hugoblog'
alias daps='cd ~/projects/scrap'
alias dape='cd ~/projects/notebooks/extractors/extractors'
alias dapg='cd ~/projects/notebooks/my-gym && ls'
alias dh='cd ~/projects/notebooks/data/datahub'
alias rl='cd ~/projects/notebooks/rl && conda activate rl'
alias jup='~/projects/notebooks/notebook.sh'
alias post='~/projects/notebooks/hugo/hugoblog/post.sh'
alias tdlist='~/Dropbox/misc/nogithub/didlist.py todo'
alias pyspark_ipython='PYSPARK_DRIVER_PYTHON=ipython pyspark'
type vim >/dev/null && alias vi=$(type -P vim)

alias gcu="git commit -m 'update' -a"

alias pyspark_ipython='PYSPARK_DRIVER_PYTHON=ipython pyspark'
alias ENIGMA_API_KEY=$(sed -e 's/.*"APIKEY"[ :"]*\(.*\)".*$/\1/' ~/.cred/enigma/cred.json)
alias s='screen'

alias bb='connect.sh bb'
alias mb='connect.sh mb'
