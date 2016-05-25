#!/usr/bin/bash

#echo "START USER BASHRC"

# Ensure, 'for' loops correctly over files
IFS="
"

# Source MYBASH bashrc scripts
script_link="$(readlink "$BASH_SOURCE")" || script_link="$BASH_SOURCE"
export MYBASH_HOME="$(dirname "$PWD/$script_link")"

[[ -s "$MYBASH_HOME/functions/mybash.bash" ]] && source "$MYBASH_HOME/functions/mybash.bash"

for script in "$MYBASH_HOME/bashrc.d/"*; do
    [[ -s "$script" ]] && source "$script"
done
unset script

# Add user's bashrc
[[ -s "$HOME/.my.bashrc" ]] && source "$HOME/.my.bashrc"

#echo "END USER BASHRC"

