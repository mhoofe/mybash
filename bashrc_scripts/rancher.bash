
# Set nvm home directory
RANCHER_DIR="${HOME}/.rd"
[[ ! -d "$RANCHER_DIR" ]] && return
export RANCHER_DIR

# Add rancher bin to path
appendPath PATH "${RANCHER_DIR}/bin"

# Set DOCKER_HOST socket
export DOCKER_HOST="unix://${RANCHER_DIR}/docker.sock"

