#!/bin/bash

logMyBash() {
    [[ "$MYBASH_DEBUG" -gt 0 ]] && (>&2 echo "MYBASH_DEBUG: $@")
}

sourceMyBashFunction() {
    sourceMyBashScripts 'function' "$@"
}

#
# Sources all MyBash scripts of a certain type.
#
# In:
#   - script_type -> type of scripts
#   - script_names -> names of scripts
#
sourceMyBashScripts() {

    [ $# -ne 2 ] && echo "Usage: sourceMyBashScripts <script_type> <script_names>" && return -1

    if [[ "$MYBASH_LOGFILE" -gt 0 ]]; then
      local logFile="${HOME}/.mybash-$$.log"
      exec 4>&2 2>>"${logFile}"
    fi

    local script_type="$1"
    local script_names="$2"

    local script_dir
    local script_suffix

    case "$script_type" in
        profile)
            script_dir="profile_scripts"
            script_suffix="sh"
            ;;
        function)
            script_dir="function_scripts"
            script_suffix="bash"
            ;;
        bash|bashrc)
            script_dir="bashrc_scripts"
            script_suffix="bash"
            ;;
        *)
            echo "Unknown script_type '${script_type}'. Allowed: 'function', 'profile', 'bash'"
            return -2
            ;;
    esac

    local script
    local script_name
    local script_path

    for script_name in $script_names; do

        script_path="${script_dir}/${script_name}.${script_suffix}"
        sourceScript "$HOME/.mybash/$script_path" "$MYBASH_HOME/$script_path"
        if [[ $? -ne 0 ]]; then
            echo "Script '$script_name' of type '$script_type' was not found in either HOME or MYBASH_HOME!"
        fi

    done

    if [[ -t 4 ]]; then
      exec 2>&4
    fi

}

#
# Finds the first config file which exists and is not empty in either:
#
# - $HOME/.$config
# - $HOME/mybash/configs/$config
# - $MYBASH_HOME/configs/$config
#
# In: Name of the config to search for
# Echo: The first found config file
# Return: 0 if a config file was found
# Return: 1 if no config file was found
#
findFirstConfigFile() {

    [[ $# -ne 1 ]] && echo "Usage: findFirstConfigFile <config_name>" && return -1

    local config="$1"
    findFirstFile "$HOME/.${config}" "$HOME/mybash/configs/${config}" "$MYBASH_HOME/configs/${config}"

    return $?
}

#
# Finds the first file which exists and is not empty.
#
# In: File paths to search for
# Echo: The first found file
# Return: 0 if a file was found
# Return: 1 if no file was found
#
findFirstFile() {

    [[ $# -eq 0 ]] && echo "Usage: findFirstFile <file_paths>" && return -1

    local file_path
    for file_path in "$@"; do
        logMyBash "searching file '$file_path'"
        if [[ -s "$file_path" ]]; then
            logMyBash "found file '$file_path'"
            echo "$file_path"
            return 0
        fi
    done

    return 1
}

#
# Finds the first directory which exists.
#
# In: Directory paths to search for
# Echo: The first found directory
# Return: 0 if a directory was found
# Return: 1 if no directory was found
#
findFirstDir() {

    [[ $# -eq 0 ]] && echo "Usage: findFirstDir <dir_paths>" && return -1

    local dir_path
    for dir_path in "$@"; do
        logMyBash "searching directory '$dir_path'"
        if [[ -d "$dir_path" ]]; then
            logMyBash "found directory '$dir_path'"
            echo "$dir_path"
            return 0
        fi
    done

    return 1
}

#
# Sources the first script which exists and is not empty.
#
# In: Script paths to search for
# Return: 0 if a script was found
# Return: 1 if no script was found
#
sourceScript() {

    [[ $# -eq 0 ]] && echo "Usage: sourceScript <script_paths>" && return -1

    local script_path="$(findFirstFile "$@")"
    if [[ -n "$script_path" ]]; then
        logMyBash "sourcing script '$script_path'"
        if [[ "$MYBASH_TIMINGS" -gt 0 ]]; then
            local oldTimeformat="${TIMEFORMAT}"
            TIMEFORMAT=$'MYBASH_TIMINGS: sourcing script '$script_path' took %3lR'
            time source "$script_path" >&2
            TIMEFORMAT="${oldTimeformat}"
        else
            source "$script_path"
        fi
        return 0
    fi

    return 1
}

#
# Helper functions to append path elements
#
appendPath() {

    [ $# -ne 2 ] && echo "Usage: appendPath <variable> <element>" && return -1

    local variable="$1"
    local element="$2"

    # append only if available
    [ ! -e "$element" ] && return

    # set oldvalue and remove trailing ':' if necessary
    local oldvalue="$(echo "${!variable%%+(:)}")"

    # init new value
    local newvalue="${oldvalue:+${oldvalue}:}${element}"

    # assign a new value
    local todo="${variable}=${newvalue}"
    eval $todo

}

#
# Helper functions to prepend path elements
#
prependPath() {

    [ $# -ne 2 ] && echo "Usage: prependPath <variable> <element>" && return -1

    local variable="$1"
    local element="$2"

    # prepend only if available
    [ ! -e "$element" ] && return

    # set oldvalue and leading trailing ':' if necessary
    local oldvalue="$(echo "${!variable##+(:)}")"

    # init new value
    local newvalue="${element}${oldvalue:+:${oldvalue}}"

    # assign a new value
    local todo="${variable}=${newvalue}"
    eval $todo

}

#
# Helper functions to remove path elements
#
removePath() {

    [ $# -ne 2 ] && echo "Usage: removePath <variable> <element>" && return -1

    local variable="$1"
    local pattern="$2"

    pattern="`makeSedSave $pattern`"

    # remove leading pattern
    local newvalue="\${${variable}//\$pattern:/}"
    local todo="${variable}=${newvalue}"
    eval $todo

    # remove trailing pattern
    local newvalue="\${${variable}//:\$pattern/}"
    local todo="$variable=$newvalue"
    eval $todo

}

#
# Make string sed-save with changing all / into \/ and . into \.
#
makeSedSave() {
    echo "$@" | sed -e 's/\//\\\//g' -e 's/\./\\\./g'
}

#
# Helper function to prepend bin and man paths
#
prependPaths() {
    local bin_path="$1"
    local man_path="$2"
    if [[ -d "$bin_path" ]]; then
        removePath PATH "$bin_path"
        prependPath PATH "$bin_path"
        export PATH
    fi
    if [[ -d "$man_path" ]]; then
        removePath MANPATH "$man_path"
        prependPath MANPATH "$man_path"
        export MANPATH
    fi
}

#
# Helper function to append bin and man paths
#
appendPaths() {
    local bin_path="$1"
    local man_path="$2"
    if [[ -d "$bin_path" ]]; then
        removePath PATH "$bin_path"
        appendPath PATH "$bin_path"
        export PATH
    fi
    if [[ -d "$man_path" ]]; then
        removePath MANPATH "$man_path"
        appendPath MANPATH "$man_path"
        export MANPATH
    fi
}

mybash_loaded=1

