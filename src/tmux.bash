##############################################################################
# @file tmux.bash
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load vars
load log
load path

##############################################################################

# Fail if tmux is nog running
tmux.or_fail() {
    if [[ -z $TMUX ]] && [[ -z $TPM_NOTMUX ]]; then
        log.fail "Tmux not running!"
        exit 1
    fi
}

##############################################################################

# Echo in tmux "window"
tmux.echo() {
    local message="$@"
    tmux run-shell "echo '$message'"
}

##############################################################################

# Get tmux option
tmux.get_tmux_option() {
    local option="$1"
    local default_value="$2"

    local option_value="$(tmux show-option -gqv "$option")"

    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

##############################################################################

# Set key-binding
tmux.set_key_binding() {
    tmux bind-key "$1" run-shell "$2"
}

##############################################################################

# Get content of tmux config files
tmux.conf_contents() {
    # Allow the usage of '~/'
    local files=(${TPM_CONF//:/ })

    for file in "${files[@]}"
    do
        file="$(path.expand "$file")"
        if [ -f "$file" ]; then
            cat "$file"
        fi
    done

    # Only one level deep!
    if [ "$1" == "full" ]; then # also output content from sourced files
        for file in $(tmux.sourced_files); do
            cat "$(path.expand "$file")" 2>/dev/null
        done
    fi
}

##############################################################################

# Get list of files sourced by tmux
tmux.sourced_files() {
    tmux.conf_contents |\
        awk '/^ *source(-file)? +/ { gsub(/'\''/,""); gsub(/'\"'/,""); print $2 }'
}

##############################################################################

# Get list of plugins from config files
tmux.list_plugins() {
    tmux.get_conf_option "@plugin"
}

##############################################################################

# Get option from config files
tmux.get_conf_option() {
    local option="$1"
    local default_value="$2"

    # the awk returns wrong results if option is empty
    if [ -z "$option" ]; then
        log.fail "Invalid config option needed"
        exit 1
    fi

    local awk_opt='/^ *set(-option)? +-g +'"$option"'/ { gsub(/'\''/,""); gsub(/'\"'/,""); print $4 }'
    local option_value="$(tmux.conf_contents "full" | awk "$awk_opt")"

    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

##############################################################################
