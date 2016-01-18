#!/usr/bin/env bats
##############################################################################
# @file cli.bats
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load _helper

##############################################################################

@test "cli.run without command prints usage" {
    run ellipsis-tpm
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "Usage: ellipsis-tpm <command>" ]
}

##############################################################################
