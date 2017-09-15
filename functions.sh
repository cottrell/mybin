function dir_menu {
    res=($(ls -td $1/*/ | head -40))
    len=${#res[@]}
    for i in $(seq $len); do
    	echo $i ${res[$(($i-1))]}
    done
    read -p 'selection: ' -s i
    cd ${res[$(($i-1))]}
}

alias d='dir_menu ~/dev'
alias n='dir_menu ~/projects/notebooks'
