function dir_menu {
    res=($(ls -td $1/*/ | head -40))
    len=${#res[@]}
    for i in $(seq $len); do
    	echo $i ${res[$(($i-1))]}
    done
    echo 'q quit'
    read -p 'selection: ' i
    if [[ "$i" -eq 'q' ]]; then
        return
    fi
    cd ${res[$(($i-1))]}
}

alias d='dir_menu ~/dev'
alias n='dir_menu ~/projects/notebooks'

function file_menu {
    res=($(ls -t $1/* | head -40))
    len=${#res[@]}
    for i in $(seq $len); do
    	echo $i ${res[$(($i-1))]}
    done
    echo 'q quit'
    read -p 'selection: ' i
    if [[ "$i" -eq 'q' ]]; then
        return
    fi
    filename=${res[$(($i-1))]}
    dir=$(dirname $filename)
    filename=$(basename $filename)
    cd $dir
    vi $filename
    cd -
}

alias no='file_menu ~/projects/notes.hugo/content/post'
