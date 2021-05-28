
# Set customized bash shell options
shopt -s cdable_vars
shopt -s direxpand
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
    if dircolors="$(findFirstConfigFile "dir_colors")"; then
        eval "$(dircolors "$dircolors")"
    fi
    unset dircolors
fi

# Set customized inputrc
if inputrc="$(findFirstConfigFile "inputrc")"; then
    export INPUTRC="$inputrc"
fi
unset inputrc

# Set customized vimrc
if vimrc="$(findFirstConfigFile "vimrc")"; then
    export VIMRC="$vimrc"
    export VIMINIT="source \$VIMRC"
fi
unset vimrc

