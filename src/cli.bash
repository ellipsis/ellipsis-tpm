##############################################################################
# @file cli.bash
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load extension
load msg
load log
load tpm
load tmux
load git

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
    uninstall  uninstall plugin
    update     update installed plugin
    clean      cleanup plugins"
}

##############################################################################

# prints ellipsis-tpm version
cli.version() {
    local cwd="$(pwd)"
    cd "$TPM_PATH"

    local sha1="$(git.sha1)"
    msg.print "\033[1mv$TPM_VERSION\033[0m ($sha1)"

    cd "$cwd"
}

##############################################################################

# run ellipsis-tpm
cli.run() {
    # Check if Ellipsis version is sufficient
    if ! extension.is_compatible; then
        log.fail "Ellipsis-TPM v$TPM_VERSION needs at least Ellipsis v$ELLIPSIS_VERSION_DEP"
        msg.print "Please update Ellipsis!"
        exit 1
    fi

    case "$1" in
        tmux)
            tmux.or_fail
            TPM_TMUX_ECHO=1

            cli.run "${@:2}"

            tmux.echo "Finished, you can now exit copy mode! (Enter/ESC)"
            ;;
        run)
            tmux.or_fail
            tpm.run
            ;;
        install|in)
            tpm.install "${@:2}"
            ;;
        uninstall|remove|rm)
            tpm.uninstall "${@:2}"
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
                msg.print "ellipsis-tpm: invalid command -- $1"
            fi
            cli.usage
            return 1
            ;;
    esac
}

##############################################################################
