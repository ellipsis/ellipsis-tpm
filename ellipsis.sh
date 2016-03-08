#!/usr/bin/env bash
##############################################################################

pkg.link() {
    # Link ellipsis-tpm in the Ellipsis bin folder
    fs.link_file "$PKG_PATH/bin/ellipsis-tpm" "$ELLIPSIS_PATH/bin/ellipsis-tpm"
}

##############################################################################

pkg.unlink() {
    # Remove ellipsis-tpm link from the Ellipsis bin folder
    rm "$ELLIPSIS_PATH/bin/ellipsis-tpm"
}

##############################################################################
