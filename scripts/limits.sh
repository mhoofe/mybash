
# Update limits
set_maxfiles=65536
[[ $set_maxfiles -gt $(ulimit -n) ]] && ulimit -n $set_maxfiles
set_maxproc=2048
[[ $set_maxproc -gt $(ulimit -u) ]] && ulimit -u $set_maxproc

