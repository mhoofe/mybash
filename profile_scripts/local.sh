
# Move /usr/local paths to front
prependPaths "/usr/local/sbin"
prependPaths "/usr/local/bin" "/usr/local/share/man"

# Ensure all default manpaths are set, if any
for manpath_file in /etc/manpaths /etc/manpaths.d/*; do
  [[ ! -r "${manpath_file}" ]] && continue
  for manpath in `cat $manpath_file`; do
    appendPath MANPATH ${manpath}
  done
done
unset manpath_file manpath

