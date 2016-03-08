#!/usr/bin/env bats
##############################################################################
# msg.bats
#
# Tests for the message functions
#
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

@test "msg.print shows message indented (nested)" {
    # 1 level, 4 spaces
    ELLIPSIS_LVL=2\
    run msg.print "Test print message indented"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "    Test print message indented" ]
    # 2 levels, 8 spaces
    ELLIPSIS_LVL=3\
    run msg.print "Test print message indented"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "        Test print message indented" ]
}

@test "msg.print shows message using tmux echo when TPM_TMUX_ECHO is set" {
    TPM_TMUX_ECHO=1\
    run msg.print "Test print message"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "tmux: Test print message" ]
}

##############################################################################

