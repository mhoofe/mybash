#!bash

#echo "START MYBASH 'bashrc'"

# Ignore 'bashrc' for non-interactive shells
case $- in
    *i*)
        ;;
      *)
        return
        ;;
esac

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

    # Source defined 'bash' scripts
    sourceMyBashScripts 'bashrc' "$MYBASH_BASHRC"

    # Source additional custom bashrc script
    sourceScript "$HOME/.my.bashrc"

fi

#echo "END MYBASH 'bash_profile'"

