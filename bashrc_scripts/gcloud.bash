
unset prefix
[[ -n "$(type -p brew)" ]] && prefix="$(brew --prefix)/opt"
[[ -z "$prefix" ]] && prefix="/usr/local"

# Set Google Cloud SDK Home
if cloudsdk_home="$(findFirstDir "$HOME/opt/google-cloud-sdk" "${prefix}/share/google/google-cloud-sdk")"; then
    export CLOUDSDK_HOME="$cloudsdk_home"
fi
unset cloudsdk_home

# Check if Google Cloud SDK is installed
[[ -z "$CLOUDSDK_HOME" ]] && return

# Set Google Cloud SDK paths
sourceScript "${CLOUDSDK_HOME}/path.bash.inc"

# Add Google Cloud SDK bash completions
sourceScript "${CLOUDSDK_HOME}/completion.bash.inc"

