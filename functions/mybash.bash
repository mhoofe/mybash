#!/bin/bash

#
# Helper functions to append path elements
#
appendPath() {

    [ $# -ne 2 ] && echo "Usage: appendPath <variable> <element>" && return -1

    local variable="$1"
    local element="$2"

    # append only if available
    [ ! -e "$element" ] && return

    # init new value
    local newvalue="\${${variable}:+\$${variable}:}${element}"

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

    # init new value
    local newvalue="${element}\${${variable}:+:\$${variable}}"

    # assign a new value
    local todo="${variable}=${newvalue}"
    eval $todo

}

#
# Helper functions to remove path elements
#
removePath() {

    [ $# -ne 2 ] && echo "Usage: prependPath <variable> <element>" && return -1

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
    fi
    if [[ -d "$man_path" ]]; then
        removePath MAN_PATH "$bin_path"
        prependPath MAN_PATH "$man_path"
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
    fi
    if [[ -d "$man_path" ]]; then
        removePath MAN_PATH "$bin_path"
        appendPath MAN_PATH "$man_path"
    fi
}

