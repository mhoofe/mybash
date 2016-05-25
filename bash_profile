#!/usr/bin/bash

#echo "START USER PROFILE"

# Ensure, 'for' loops correctly over files
IFS="
"

# Source MYBASH profile scripts
script_link="$(readlink "$BASH_SOURCE")" || script_link="$BASH_SOURCE"
export MYBASH_HOME="${script_link%/*}"

[[ -s "$MYBASH_HOME/functions/mybash.bash" ]] && source "$MYBASH_HOME/functions/mybash.bash"

for script in "$MYBASH_HOME/profile.d/"*; do
    [[ -s "$script" ]] && source "$script"
done
unset script

# Source user's custom profile
for i in "$HOME/.my.bash_profile" "$HOME/.my.profile"; do
    if [[ -s "$i" ]]; then
        source "$i"
        break
    fi
done
unset i

# Source bashrc
if [ "${BASH-no}" != "no" ]; then
    for i in "$HOME/.bashrc" "$MYBASH_HOME/bashrc" "/etc/bashrc"; do
        if [[ -s "$i" ]]; then
            source "$i"
            break
        fi
    done
fi

#echo "END USER PROFILE"

