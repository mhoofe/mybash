
# Set customized prompt
if [ "$UID" -eq 0 ]; then
    if [ -n "$TERM" -a -t ]; then
        _bred="$(tput bold 2> /dev/null; tput setaf 1 2> /dev/null)"
        _sgr0="$(tput sgr0 2> /dev/null)"
    fi
    if [ -n "$_bred" -a -n "$_sgr0" ]; then
        _u="\[$_bred\]\u@\h"
        _p="#\[$_sgr0\]"
    else
        _u="\u@\h"
        _p="#"
    fi
    unset _bred _sgr0
    export IGNOREEOF=1
else
    _u="\u@\h"
    _p=">"
    export IGNOREEOF=3
fi
export PS1="${_u}:[\W] ${_p} "
export PS2="> "
unset _u _p

# Set customized terminal title
case "$TERM" in
    xterm*|color*|dtterm*|kvt*)
        PS1="\[\e]0;\u@\h [\w]\a\]$PS1"
        ;;
    *)
        ;;
esac

