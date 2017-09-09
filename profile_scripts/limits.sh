
# Update 'maxfiles' limits
set_maxfiles=65536
current_maxfiles=`ulimit -n`
if [ $set_maxfiles -gt $current_maxfiles ]; then
  ulimit -n $set_maxfiles # 2> /dev/null
fi

# Update 'maxproc' limits
set_maxproc=2049
current_maxproc=`ulimit -u`
if [ $set_maxproc -gt $current_maxproc ]; then
  ulimit -u $set_maxproc # 2> /dev/null
fi

