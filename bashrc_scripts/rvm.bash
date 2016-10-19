
# Add current path to ruby load path
appendPath RUBYLIB '.'

# Load rvm
sourceScript "${HOME}/.rvm/scripts/rvm"

# Add rvm bash completions
sourceScript "${HOME}/.rvm/scripts/completion"

