#!/usr/bin/bash

#echo "START USER PROFILE"

# Set MyBash Home
script_link="$(readlink "$BASH_SOURCE")" || script_link="$BASH_SOURCE"
script_dir="${script_link%/*}"
script_home="$(command cd -P "$script_dir")"

if [[ -s "$script_home/functions/mybash.bash" ]]; then
    export MYBASH_HOME="$script_home"
    source "$MYBASH_HOME/functions/mybash.bash"
else
    echo "Could not find 'mybash.bash' in '$script_home'!"
    echo "MyBash not correctly installed!"
fi

unset script_link
unset script_dir
unset script_home

if [[ -n "$MYBASH_HOME" ]]; then

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

fi

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

