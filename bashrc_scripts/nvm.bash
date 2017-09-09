
# Set nvm home directory
NVM_DIR="${HOME}/.nvm"
[[ ! -d "$NVM_DIR" ]] && return
export NVM_DIR

# Load nvm
sourceScript "${NVM_DIR}/nvm.sh"

# Add nvm bash completions
sourceScript "${NVM_DIR}/bash_completion"

