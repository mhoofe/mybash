
# sourceScript "$HOME/.iterm2_shell_integration.bash"

if iterm2_home="$(findFirstDir "$HOME/.iterm2")"; then
  appendPath PATH "$iterm2_home"
fi
unset iterm2_home

