#!/usr/bin/env bats
##############################################################################
# vars.bats
#
# Tests for the variables file
#
##############################################################################

load _helper
load vars

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

