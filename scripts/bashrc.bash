
# Set customized bash shell options
shopt -s histappend
shopt -s nocaseglob
#shopt -s nocasematch
shopt -s no_empty_cmd_completion
#shopt -s nullglob

# Set customized shell variables
export HISTCONTROL=erasedups
export HISTFILESIZE=2000
export HISTIGNORE="[ ]*:&:bg:fg"
export HISTSIZE=2000

# Set customized colors
if [[ -n "$(type -p dircolors)" ]]; then
    for i in "$HOME/.dir_colors" "$MYBASH_HOME/defaults/dir_colors"; do
        if [[ -s "$i" ]]; then
            eval "$(dircolors "$i")"
            break
        fi
    done
    unset i
fi

# Set customized inputrc
for i in "$HOME/.inputrc" "$MYBASH_HOME/defaults/inputrc"; do
    [[ -s "$i" ]] && export INPUTRC="$i" && break
done
unset i

# Set customized vimrc
for i in "$HOME/.vimrc" "$MYBASH_HOME/defaults/vimrc"; do
    [[ -s "$i" ]] && export VIMRC="$i" && break
done
unset i

