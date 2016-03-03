#!/usr/bin/env bash
##############################################################################
# @file _helper.bash
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

export TESTS_DIR="$BATS_TEST_DIRNAME"
export ELLIPSIS_PATH="$(cd $TESTS_DIR/../deps/ellipsis && pwd)"
export ELLIPSIS_SRC="$ELLIPSIS_PATH/src"
export TPM_PATH="$(cd $TESTS_DIR/.. && pwd)"
export TPM_SRC="$TPM_PATH/src"
export PATH="$TPM_PATH/bin:$PATH"

export ELLIPSIS_LOGFILE="/dev/null"

##############################################################################

# Initialize ellipsis-tpm, which replaces bat's `load` function with ours.
load ../src/init

##############################################################################

load vars
load extension

# Updated ellipsis version if not sufficient (make can't auto update)
if ! extension.is_compatible; then
    ./deps/ellipsis/bin/ellipsis update ellipsis > /dev/null 2>&1
fi

##############################################################################
