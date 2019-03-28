
# Check if pyenv is installed
[[ -z "$(type -p pyenv)" ]] && return

# Enable shims and autocompletion
eval "$(pyenv init -)"

