##############################################################################
# @file msg.bash
# @date February, 2016
# @author Z. Kelling <hi@zeekay.io>
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) Ellipsis [http://ellipsis.sh] 2016, All Rights Reserved
# @license MIT
##############################################################################
#
# Logging utilities.
#
##############################################################################

load msg "$TPM_SRC" # Use tmux aware msg functions

##############################################################################

# Print log message and store to logfile
log.store() {
    msg.print "$@"

    local msg="$(msg.log "$@")"
    local timestamp="$(date +"%y/%m/%d %H:%M:%S")"
    echo "$timestamp: $msg" >> ${ELLIPSIS_LOGFILE:-"/tmp/ellipsis.log"}
}

##############################################################################

# Log success
log.ok() {
    log.store "[\033[32m ok \033[0m] $@"
}

##############################################################################

# Log info
log.info() {
    log.store "[\033[36minfo\033[0m] $@"
}

##############################################################################

# Log warning
log.warn() {
    log.store "[\033[33mwarn\033[0m] $@"
}

##############################################################################

# Log error
log.error() {
    log.store "[\033[31m err\033[0m] $@"
}

##############################################################################

# Log failure
log.fail() {
    log.store "[\033[31mFAIL\033[0m] $@"
}

##############################################################################

# Deprecated; use msg.dim
log.dim() {
    msg.dim "$@"
}

##############################################################################
