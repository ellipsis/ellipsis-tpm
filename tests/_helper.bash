#!/usr/bin/env bash
##############################################################################
# @file init.bash
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

export TESTS_DIR="$BATS_TEST_DIRNAME"
export TPM_PATH="$(cd $TESTS_DIR/.. && pwd)"
export TPM_SRC="$TPM_PATH/src"
export PATH="$TPM_PATH/bin:$PATH"

##############################################################################

# Initialize ellipsis-tpm, which replaces bat's `load` function with ours.
load ../src/init

##############################################################################
