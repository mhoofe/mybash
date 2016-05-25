
# Check if brew is installed
[[ -z "$(type -p brew)" ]] && return

brew_prefix="$(brew --prefix)"

# Prepend gnu paths
for gnu_path in "gnu-tar" "findutils" "coreutils"; do
  bin_path="${brew_prefix}/opt/${gnu_path}/libexec/gnubin"
  man_path="${brew_prefix}/opt/${gnu_path}/libexec/gnuman"
  prependPaths "$bin_path" "$man_path"
done
unset gnu_path

# Add brew bash completions
[[ -s "${brew_prefix}/etc/bash_completion" ]] && source "${brew_prefix}/etc/bash_completion"

# Disable broken 'cd' completion concerning spaces in filenames
complete -o nospace -d cd

unset brew_prefix

