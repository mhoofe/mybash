
# Check if brew is installed
[[ -z "$(type -p brew)" ]] && return

brew_prefix="$(brew --prefix)"

# Prepend gnu paths
for gnu_path in "coreutils" "findutils" "gnu-sed" "gnu-tar" "grep"; do
  bin_path="${brew_prefix}/opt/${gnu_path}/libexec/gnubin"
  man_path="${brew_prefix}/opt/${gnu_path}/libexec/gnuman"
  prependPaths "$bin_path" "$man_path"
done
unset gnu_path

# Prepend some brew opt packages
for opt_path in "curl" "curl-openssl" "qt"; do
  bin_path="${brew_prefix}/opt/${opt_path}/bin"
  man_path="${brew_prefix}/opt/${opt_path}/share/man"
  prependPaths "$bin_path" "$man_path"
done
unset opt_path

# Install command-not-found
if brew command command-not-found-init > /dev/null 2>&1; then
  eval "$(brew command-not-found-init)"
fi

# Add brew bash completions
#sourceScript "${brew_prefix}/etc/bash_completion"
sourceScript "${brew_prefix}/etc/profile.d/bash_completion.sh"

# Disable broken 'cd' completion concerning spaces in filenames
complete -o nospace -d cd

unset brew_prefix

