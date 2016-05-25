
# Set customized aliases
if [[ "$OSTYPE" == "darwin"* ]] && [[ "$(type -p ls)" == "/bin/ls" ]]; then
    alias ls='ls -CF'
else
    alias ls='ls -CF --color=auto --time-style=locale'
fi
alias ll='ls -l'
alias la='ls -la'
alias dir='ls -A'

alias cd..='cd ..'
alias ..='cd ..'

alias cp='cp -i'
alias mv='mv -i'

alias h='history'
alias md='mkdir'
alias rd='rmdir'

alias grep='grep --color=auto'

# Use colordiff, if available
[[ -n "`type -t colordiff`" ]] && alias diff='colordiff'

alias r+='chmod a+r'
alias w+='chmod ug+w'
alias x+='chmod a+x'
alias r-='chmod go-r'
alias w-='chmod a-w'
alias x-='chmod a-x'

