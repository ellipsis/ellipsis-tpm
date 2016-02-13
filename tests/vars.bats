#!/usr/bin/env bats
##############################################################################
# @file vars.bats
# @date February, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load _helper
load vars "$TPM_SRC"

##############################################################################

@test "TPM_CONF is set and non empty" {
  [ -n "$TPM_CONF" ]
}

@test "TPM_PLUGIN_PATH is set and non empty" {
  [ -n "$TPM_PLUGIN_PATH" ]
}

@test "TPM_INSTALL_KEY is set and non empty" {
  [ -n "$TPM_INSTALL_KEY" ]
}

@test "TPM_UPDATE_KEY is set and non empty" {
  [ -n "$TPM_UPDATE_KEY" ]
}

@test "TPM_CLEAN_KEY is set and non empty" {
  [ -n "$TPM_CLEAN_KEY" ]
}

##############################################################################

