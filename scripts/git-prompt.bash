
unset prefix
[[ -n "$(type -p brew)" ]] && prefix="$(brew --prefix)/opt"
[[ -z "$prefix" ]] && prefix="/usr/local"

# Set bash git prompt Home
for i in "$HOME/opt/bash-git-prompt" "${prefix}/bash-git-prompt/share"; do
    [[ -d "$i" ]] && export GITPROMPT_HOME="$i" && break
done
unset i
unset prefix

# Check if bash git prompt is installed
[[ -z "$GITPROMPT_HOME" ]] && return

# Create git prompt
NORMAL_PROMPT="$PS1"
setGitPrompt() {

    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_FETCH_REMOTE_STATUS=0

    [[ -s "${GITPROMPT_HOME}/gitprompt.sh" ]] && source "${GITPROMPT_HOME}/gitprompt.sh"

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

