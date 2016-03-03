#!/usr/bin/env bats
##############################################################################
# @file cli.bats
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load _helper
load cli

##############################################################################

@test "cli.run without command prints usage" {
    run cli.run
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "Usage: ellipsis-tpm <command>" ]
}

@test "cli.run with invalid command prints usage" {
    run cli.run invalid_command
    [ "$status" -eq 1 ]
    [ "${lines[1]}" = "Usage: ellipsis-tpm <command>" ]
}

@test "cli.run help prints usage" {
    run cli.run help
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Usage: ellipsis-tpm <command>" ]
}

@test "cli.run --help prints usage" {
    run cli.run --help
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Usage: ellipsis-tpm <command>" ]
}

@test "cli.run -h prints usage" {
    run cli.run -h
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Usage: ellipsis-tpm <command>" ]
}

@test "cli.run version prints version" {
    run cli.run version
    [ "$status" -eq 0 ]
    [ $(expr "$output" : "v[0-9][0-9.]*") -ne 0 ]
}

@test "cli.run --version prints version" {
    run cli.run --version
    [ "$status" -eq 0 ]
    [ $(expr "$output" : "v[0-9][0-9.]*") -ne 0 ]
}

@test "cli.run -v prints version" {
    run cli.run -v
    [ "$status" -eq 0 ]
    [ $(expr "$output" : "v[0-9][0-9.]*") -ne 0 ]
}

@test "cli.run tmux fails if tmux is not running" {
    TMUX=""\
    run cli.run tmux
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "[FAIL] Tmux not running!" ]
}

@test "cli.run run fails if tmux is not running" {
    TMUX=""\
    run cli.run run
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "[FAIL] Tmux not running!" ]
}

##############################################################################
