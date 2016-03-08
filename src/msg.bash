# msg.bash
#
# Overwrite msg functions to use tmux echo
#
##############################################################################

# Source the original functions
source "$ELLIPSIS_SRC/msg.bash"

##############################################################################

load tmux

##############################################################################

msg.print() {
    if [ -n "$TPM_TMUX_ECHO" ]; then
        tmux.echo "$(msg.log "$@")"
    elif [ -t 1 ] || [ -n "$ELLIPSIS_FORCE_COLOR" ]; then
        echo -e "$(msg.tabs)$@"
    else
        msg.log "$(msg.tabs)$@"
    fi
}

##############################################################################
