#!bash

#echo "START MYBASH 'bashrc'"

[[ -n "$MYBASH_LOADED_BASHRC" ]] && return

if [[ -z "$MYBASH_HOME" ]] && [[ -s "$HOME/.mybash_profile" ]]; then
    source "$HOME/.mybash_profile"
fi

# Ignore 'bashrc' for non-interactive shells
case $- in
    *i*)
        ;;
      *)
        return
        ;;
esac

if [[ -n "$MYBASH_HOME" ]]; then

    alias mybash='cd "${MYBASH_HOME}"'

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

    # Source defined 'bash' scripts
    sourceMyBashScripts 'bashrc' "$MYBASH_BASHRC"

    # Source additional custom bashrc script
    sourceScript "$HOME/.my.bashrc"

fi

MYBASH_LOADED_BASHRC=1
export MYBASH_LOADED_BASHRC

#echo "END MYBASH 'bashrc'"

