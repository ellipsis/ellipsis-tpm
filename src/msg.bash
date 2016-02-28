##############################################################################
# @file msg.bash
# @date February, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################
#
# Overwrite msg functions to use tmux echo
#
##############################################################################

load tmux

##############################################################################

# Source the original functions
source "$ELLIPSIS_SRC/msg.bash"

##############################################################################

msg.print() {
    if [ -n "$TPM_TMUX_ECHO" ]; then
        tmux.echo "$(msg.log "$@")"
    elif [ -t 1 ] || [ -n "$ELLIPSIS_FORCE_COLOR" ]; then
        echo -e "$@"
    else
        msg.log "$@"
    fi
}

##############################################################################
