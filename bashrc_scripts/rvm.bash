
# Set vvm home directory
RVM_DIR="${HOME}/.rvm"
[[ ! -d "$RVM_DIR" ]] && return
export RVM_DIR

# Load rvm
sourceScript "${RVM_DIR}/scripts/rvm"

# Add rvm bash completions
sourceScript "${RVM_DIR}/scripts/completion"

