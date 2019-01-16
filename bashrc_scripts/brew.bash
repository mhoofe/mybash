
# Check if brew is installed
[[ -z "$(type -p brew)" ]] && return

brew_prefix="$(brew --prefix)"

# Prepend gnu paths
for gnu_path in "coreutils" "findutils" "gnu-sed" "gnu-tar"; do
  bin_path="${brew_prefix}/opt/${gnu_path}/libexec/gnubin"
  man_path="${brew_prefix}/opt/${gnu_path}/libexec/gnuman"
  prependPaths "$bin_path" "$man_path"
done
unset gnu_path

# Prepend some brew opt packages
for opt_path in "curl" "curl-openssl" "qt@5.5"; do
  bin_path="${brew_prefix}/opt/${opt_path}/bin"
  man_path="${brew_prefix}/opt/${opt_path}/share/man"
  prependPaths "$bin_path" "$man_path"
done
unset opt_path

# Add brew bash completions
sourceScript "${brew_prefix}/etc/bash_completion"

# Disable broken 'cd' completion concerning spaces in filenames
complete -o nospace -d cd

unset brew_prefix

