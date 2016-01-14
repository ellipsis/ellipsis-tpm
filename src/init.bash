#!/usr/bin/env bash
##############################################################################
# @file init.bash
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

# Utility to load other modules. Uses a tiny bit of black magic to ensure each
# module is only loaded once.
load() {
    # Use indirect expansion to reference dynamic variable which flags this
    # module as loaded.
    local loaded="__loaded_$1"

    # Only source modules once
    if [[ -z "${!loaded}" ]]; then
        # Mark this module as loaded, prevent infinite recursion, ya know...
        eval "$loaded=1"

        local path=${2:-"$ELLIPSIS_PATH/src"}
        source $path/$1.bash
    fi
}

# Load version info.
load version "$TPM_SRC"

# Load variables and tmux options
load vars "$TPM_SRC"

# Set flag that we've been sourced already.
TPM_INIT=1

##############################################################################
