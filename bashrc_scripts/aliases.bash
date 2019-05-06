
# Use diff with colors, if available
[[ -n "$(type -t colordiff)" ]] && alias diff='colordiff'

# Use grep with colors
alias grep='grep --color=auto'

# Use ls with colors, if available
if [[ "$OSTYPE" == "darwin"* ]] && [[ "$(type -p ls)" == "/bin/ls" ]]; then
    alias ls='ls -CF'
else
    alias ls='ls -CF --color=auto --time-style=locale'
fi

alias ll='ls -l'
alias la='ls -la'
alias dir='ls -A'
#alias l.='ls -d .[[:alpha:]]*'

alias cd..='cd ..'
alias ..='cd ..'
alias up='cd ..'

alias cp='cp -i'
alias mv='mv -i'
#alias rm='rm -i'

alias cls=clear
alias h='history'
alias md='mkdir'
alias rd='rmdir'

alias r+='chmod a+r'
alias w+='chmod ug+w'
alias x+='chmod a+x'
alias r-='chmod go-r'
alias w-='chmod a-w'
alias x-='chmod a-x'

alias df='df -h'
alias du='du -h'

mkcdir() {
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}
alias mcd='mkcdir'

