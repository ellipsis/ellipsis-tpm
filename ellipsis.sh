#!/usr/bin/env bash
##############################################################################
# @file ellipsis.sh
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

pkg.link() {
    # Link ellipsis-tpm in the Ellipsis bin folder
    ln -s bin/ellipsis-tpm ${PKG_PATH}/../../bin/ellipsis-tpm
}

##############################################################################

pkg.unlink() {
    # Remove ellipsis-tpm link from the Ellipsis bin folder
    rm ${PKG_PATH}/../../bin/ellipsis-tpm
}

##############################################################################
