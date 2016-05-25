
unset prefix
[[ -n "$(type -p brew)" ]] && prefix="$(brew --prefix)/opt"
[[ -z "$prefix" ]] && prefix="/usr/local"

# Set Google Cloud SDK Home
for i in "$HOME/opt/google-cloud-sdk" "${prefix}/share/google/google-cloud-sdk"; do
    [[ -s "$i" ]] && export CLOUDSDK_HOME="$i" && break
done
unset i
unset prefix

# Check if Google Cloud SDK is installed
[[ -z "$CLOUDSDK_HOME" ]] && return

# Set Google Cloud SDK paths
[[ -s "${CLOUDSDK_HOME}/path.bash.inc" ]] && source "${CLOUDSDK_HOME}/path.bash.inc"

# Add Google Cloud SDK bash completions
[[ -s "${CLOUDSDK_HOME}/completion.bash.inc" ]] && source "${CLOUDSDK_HOME}/completion.bash.inc"

