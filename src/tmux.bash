#!/usr/bin/env bash
##############################################################################
# @file tmux.bash
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

tmux.get_option() {
    local option="$1"
    local default_value="$2"
    local option_value="$(tmux show-option -gqv "$option")"
    if [[ -z $option_value ]]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

##############################################################################

tmux.set_key_binding() {
    tmux bind-key "$1" run-shell "$2"
}

##############################################################################

tmux.conf_contents() {
    cat /etc/tmux.conf ~/.tmux.conf 2>/dev/null
    if [ "$1" == "full" ]; then # also output content from sourced files
        local file
        for file in $(tmux.sourced_files); do
            cat $(tmux.manual_expansion "$file") 2>/dev/null
        done
    fi

}

##############################################################################

tmux.sourced_files() {
    tmux.conf_contents |\
        awk '/^ *source(-file)? +/ { gsub(/'\''/,""); gsub(/'\"'/,""); print $2 }'
}

##############################################################################

tmux.manual_expansion() {
    local path="$1"
    local expanded_tilde="${path/#\~/$HOME}"
    echo "${expanded_tilde/#\$HOME/$HOME}"
}

##############################################################################

tmux.list_plugins() {
    # lists plugins from @tpm_plugins option
    local tpm_plugins="$(tmux start-server\; show-option -gqv @tpm_plugins)"
    if [[ -n $tpm_plugins ]]; then
        echo "$tpm_plugins"
    fi

    # read set -g @plugin "tmux-plugins/tmux-example-plugin" entries
    tmux.conf_contents "full" |\
        awk '/^ *set(-option)? +-g +@plugin/ { gsub(/'\''/,""); gsub(/'\"'/,""); print $4 }'
}

##############################################################################
