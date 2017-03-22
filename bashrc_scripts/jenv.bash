
# Check if jenv is installed
[[ -z "$(type -p jenv)" ]] && return

# Add jenv to path
appendPath PATH "$HOME/.jenv/bin"

# Enable shims and autocompletion
eval "$(jenv init -)"

