#!bash

#echo "START MYBASH 'bash_profile'"

[[ -n "$MYBASH_LOADED_BASH_PROFILE" ]] && return

if [[ -z "$MYBASH_HOME" ]]; then

    # Set MyBash Home
    script_link="$(readlink "$BASH_SOURCE")" || script_link="$BASH_SOURCE"
    script_dir="${script_link%/*}"
    script_home="$(command cd -P "$script_dir" > /dev/null && pwd -P)"

    if [[ -s "$script_home/mybashrc" ]]; then
        export MYBASH_HOME="$script_home"
    else
        echo "script_link: ${script_link}"
        echo "script_dir: ${script_dir}"
        echo "script_home: ${script_home}"
        echo "Could not find 'mybashrc' in '$script_home'!"
        echo "MyBash not correctly installed!"
    fi

    unset script_link
    unset script_dir
    unset script_home

fi

if [[ -n "$MYBASH_HOME" ]]; then

    # Load mybash functions
    if [[ "$mybash_loaded" -eq 0 ]]; then
        source "$MYBASH_HOME/function_scripts/mybash.bash"
    fi
    if [[ "$mybash_loaded" -eq 0 ]]; then
        echo "Script 'mybash.bash' could not be loaded!"
        echo "MyBash not correctly installed!"
        return
    fi

    # Load mybash configuration
    eval "$(cat "$MYBASH_HOME/mybashrc")"
    [[ -s "$HOME/.mybashrc" ]] && eval "$(cat "$HOME/.mybashrc")"

    # Source defined 'profile' scripts
    sourceMyBashScripts 'profile' "$MYBASH_PROFILE"

    # Source additional custom profile script
    sourceScript "$HOME/.my.bash_profile" "$HOME/.my.profile"

    # Source bashrc
    sourceScript "$HOME/.bashrc" "$MYBASH_HOME/bashrc" "/etc/bashrc"

elif [[ -s "$HOME/.bashrc" ]]; then
    source "$HOME/.bashrc"
elif [[ -s "/etc/bashrc" ]]; then
    source "/etc/bashrc"
fi

# Add system MANPATH, unless variable is empty
if [[ -n "$MANPATH" ]]; then
    removePath MANPATH /usr/share/man
    appendPath MANPATH /usr/share/man
fi

MYBASH_LOADED_BASH_PROFILE=1
export MYBASH_LOADED_BASH_PROFILE

# Disable bash deprecation warning e.g. on macos
export BASH_SILENCE_DEPRECATION_WARNING=1

#echo "END MYBASH 'bash_profile'"

