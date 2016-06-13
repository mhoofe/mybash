
unset prefix
[[ -n "$(type -p brew)" ]] && prefix="$(brew --prefix)/opt"
[[ -z "$prefix" ]] && prefix="/usr/local"

# Set bash git prompt Home
if gitprompt_home="$(findFirstDir "$HOME/opt/bash-git-prompt" "${prefix}/bash-git-prompt/share")"; then
    export GITPROMPT_HOME="$gitprompt_home"
fi
unset gitprompt_home

# Check if bash git prompt is installed
[[ -z "$GITPROMPT_HOME" ]] && return

# Create git prompt
NORMAL_PROMPT="$PS1"
setGitPrompt() {

    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_FETCH_REMOTE_STATUS=0
    GIT_PROMPT_SHOW_UNTRACKED_FILES="normal"

    sourceScript "${GITPROMPT_HOME}/gitprompt.sh"

}
setNormalPrompt() {
    unset PROMPT_COMMAND
    export PS1="${NORMAL_PROMPT}"
}

case "$TERM" in
    xterm*|color*|dtterm*|kvt*)
        setGitPrompt
        ;;
    *)
        ;;
esac

