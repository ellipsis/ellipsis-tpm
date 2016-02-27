##############################################################################
# @file tmsg.bash
# @date February, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################
#
# Overwrite msg functions to use tmux echo
#
##############################################################################

load tmux "$TPM_SRC"

# Force loading the original functions, we only need to overwrite 'msg.print'
__loaded_msg=''
load msg

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
