#!/usr/bin/env bash
##############################################################################
# @file cli.bash
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load msg "$TPM_SRC" # Use tmux aware msg functions
load log "$TPM_SRC" # Use updated log functions
load tpm "$TPM_SRC"
load tmux "$TPM_SRC"

##############################################################################

# prints usage for ellipsis-tpm
cli.usage() {
msg.print "\
Usage: ellipsis-tpm <command>
  Options:
    -h, --help     show help
    -v, --version  show version

  Commands:
    install    install new plugin
    update     update installed plugin
    clean      cleanup plugins"
}

##############################################################################

# prints ellipsis-tpm version
cli.version() {
    local cwd="$(pwd)"
    cd $TPM_PATH

    local sha1=$(git rev-parse --short HEAD)
    msg.print "\033[1mv$TPM_VERSION\033[0m ($sha1)"

    cd $cwd
}

##############################################################################

# run ellipsis-tpm
cli.run() {
    case "$1" in
        tmux)
            TPM_TMUX_ECHO=1
            cli.run "${@:2}"
            tmux.echo "Finished, you can now exit copy mode! (Enter/ESC)"
            ;;
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
                msg.print ellipsis-tpm: invalid command -- $1
            fi
            cli.usage
            return 1
            ;;
    esac
}

##############################################################################
