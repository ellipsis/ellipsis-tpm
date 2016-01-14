#!/usr/bin/env bash
##############################################################################
# @file cli.bash
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load tpm
load vars

##############################################################################

# prints usage for ellipsis-tpm
cli.usage() {
    cat <<-EOF
Usage: ellipsis-tpm <command>
  Options:
    -h, --help     show help
    -v, --version  show version

  Commands:
    install    install new plugin
    update     update installed plugin
    clean      cleanup plugins
	EOF
}

##############################################################################

# prints ellipsis-tpm version
cli.version() {
    local cwd="$(pwd)"
    cd $TPM_PATH

    local sha1=$(git rev-parse --short HEAD)
    echo -e "\033[1mv$TPM_VERSION\033[0m ($sha1)"

    cd $cwd
}

##############################################################################

# run ellipsis-tpm
cli.run() {
    case "$1" in
        run)
            tpm.run
            ;;
        install|in)
            tpm.install "${@:2}"
            ;;
        update|up)
            tpm.update "${@:2}"
            ;;
        clean)
            tpm.clean
            ;;
        help|--help|-h)
            cli.usage
            ;;
        version|--version|-v)
            cli.version
            ;;
        *)
            if [ $# -gt 0 ]; then
                echo ellipsis-tpm: invalid command -- $1
            fi
            cli.usage
            return 1
            ;;
    esac
}

##############################################################################
