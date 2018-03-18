function dir_menu {
    res=($(ls -td $1/*/ | head -40))
    len=${#res[@]}
    for i in $(seq $len); do
    	echo $i ${res[$(($i-1))]} $i
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
    	echo $i ${res[$(($i-1))]} $i
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

function assert_defined {
    var=$1
    if [ -z ${!var+x} ]; then
        echo "$var is unset"
    else
        echo "$var is set to '${!var}'"
    fi

}


alias no='file_menu ~/projects/notes.hugo/content/post'
