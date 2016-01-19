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

@test "cli.run with invalid command prints usage" {
  run ellipsis-tpm invalid_command
  [ "$status" -eq 1 ]
  [ "${lines[1]}" = "Usage: ellipsis-tpm <command>" ]
}

@test "cli.run --help prints usage" {
  run ellipsis-tpm --help
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "Usage: ellipsis-tpm <command>" ]
}

@test "cli.run --version prints version" {
  run ellipsis-tpm --version
  [ "$status" -eq 0 ]
  [ $(expr "$output" : "v[0-9][0-9.]*") -ne 0 ]
}

##############################################################################
