#!/bin/bash
#
# File:         java_functions
# Author:       Markus Hoofe <mhoofe@gmail.com>
#
# Description:  Set of functions to set JAVA related variables
#

# Function to set java paths
setjava() {

    local javahome
    local bindir
    local model="$1"

#    # Remove -
#    model="${model##*-}"
#    model="${model:+-${model}}"

    # Check for java installation
    unset javahome
    for i in "/opt/java/jdk${model}" "/opt/tools/jdk${model}" "/opt/jdk${model}"; do
        [[ -d "$i" ]] && javahome="$i" && break
    done
    unset i

    if [ -z "$javahome" ]; then
        echo "No java home found!"
        return 1
    fi

    # Unset old java location
    if [ -n "$JAVA_HOME" ]; then
        bindir="$JAVA_HOME/bin"
        libdir="$JAVA_HOME/_lib"
        removePath PATH "$bindir"
#        removePath LD_LIBRARY_PATH "$libdir"
    fi

    # Unset old java variables
    unset JAVA_BINDIR
    unset JAVA_ROOT
    unset JDK_HOME
    unset JRE_HOME

    # Set new java location
    bindir="$javahome/bin"
    libdir="$javahome/_lib"
    export JAVA_HOME="$javahome"
    removePath PATH "$bindir"
    prependPath PATH "$bindir"
#    removePath LD_LIBRARY_PATH "$libdir"
#    prependPath LD_LIBRARY_PATH "$libdir"

}

