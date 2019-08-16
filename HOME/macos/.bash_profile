# Setting PATH for Python 3.2
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.2/bin:${PATH}"
export PATH

MKL_NUM_THREADS=1
export MKL_NUM_THREADS

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/davidcottrell/google-cloud-sdk/path.bash.inc' ]; then source '/Users/davidcottrell/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/davidcottrell/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/davidcottrell/google-cloud-sdk/completion.bash.inc'; fi

PATH=/usr/local/bin:/bin:/usr/bin:$PATH
# :/usr/local/mysqlc/bin:/usr/local/mysql/bin:/usr/local/mysql-5.6.10-osx10.7-x86_64:$PATH
# PATH=/usr/texbin:$PATH
PATH=/Library/TeX/texbin:$PATH
PATH=/usr/local/go/bin:$PATH
PATH=$HOME/mybin:$PATH
PATH=~/.local/bin:$PATH
PATH=$PATH:/usr/local/scala/bin
PATH=$PATH:$HOME/go/bin
SPARK_HOME=~/dev/spark-2.4.0-bin-hadoop2.7
PATH=$PATH:$SPARK_HOME/bin
PYTHONPATH=$PYTHONPATH:$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.6-src.zip
export PYTHONPATH
### Added by the Quandl Toolbelt
PATH="/usr/local/quandl/bin:$PATH"
PATH=$HOME/torch/install/bin:$PATH  # Added automatically by torch-dist
PATH=/usr/local/Cellar/kubernetes-cli/1.11.2/bin:$PATH
# PATH=~/anaconda3/bin:$PATH

# dunno, conda node seems to be broken
PATH=/usr/local/Cellar/node/11.1.0/bin:$PATH


# PS1 before activate
export PS1="\[\033[38;5;14m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;11m\]\\$\[$(tput sgr0)\] "
. ~/mybin/activate_fast.sh 37
# export PATH

. ~/.bash_aliases
