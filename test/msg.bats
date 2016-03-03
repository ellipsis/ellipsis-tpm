#!/usr/bin/env bats
##############################################################################
# @file msg.bats
# @date February, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load _helper
load msg

##############################################################################

# Overwrite tmux.echo for testing
tmux.echo() {
    echo "tmux: $@"
}

##############################################################################

@test "msg.print shows message" {
    ELLIPSIS_FORCE_COLOR=1\
    run msg.print "\033[1mTest print message\033[0m"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "[1mTest print message[0m" ]
}

@test "msg.print shows message colorless (non interactive)" {
    run msg.print "\033[1mTest print message (colored)\033[0m"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Test print message (colored)" ]
}

@test "msg.print shows message using tmux echo when TPM_TMUX_ECHO is set" {
    TPM_TMUX_ECHO=1\
    run msg.print "Test print message"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "tmux: Test print message" ]
}

##############################################################################

