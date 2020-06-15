
# Set Google Cloud SDK Home
if cloudsdk_home="$(findFirstDir "$HOME/opt/google-cloud-sdk" "/usr/local/share/google/google-cloud-sdk" "/usr/lib/google-cloud-sdk" "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk")"; then
  export CLOUDSDK_HOME="$cloudsdk_home"
fi
unset cloudsdk_home

# Check if Google Cloud SDK is installed
[[ -z "$CLOUDSDK_HOME" ]] && return

# Set Google Cloud SDK paths
sourceScript "${CLOUDSDK_HOME}/path.bash.inc"

# Add Google Cloud SDK bash completions
sourceScript "${CLOUDSDK_HOME}/completion.bash.inc"

# Add shell completion to kubectl, if available
if [[ "$(type -p kubectl)" == "${CLOUDSDK_HOME}/bin/kubectl" ]]; then
  source <(kubectl completion bash)
fi

