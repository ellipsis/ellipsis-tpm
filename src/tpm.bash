##############################################################################
# @file tpm.bash
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load tmux
load msg
load log
load pkg
load fs

##############################################################################

tpm.list_installed_raw() {
    if ! fs.folder_empty $TPM_PLUGIN_PATH; then
        echo $TPM_PLUGIN_PATH/*
    fi
}

tpm.list_installed() {
    tpm.list_clean $(tpm.list_installed_raw)
}

##############################################################################

tpm.list_plugins() {
    tpm.list_clean $(tmux.list_plugins)
}

##############################################################################

tpm.list_clean() {
    for package in $@; do

        # split branch from package name (if possible)
        local parts=($(pkg.split_name "$package"))
        PKG_RAW="${parts[0]}"

        if [ -e "$PKG_RAW" ]; then
            PKG_URL="$PKG_RAW"
            PKG_NAME="$(pkg.name_from_url $PKG_URL)"
        else
            case "$PKG_RAW" in
                ssh://git)
                    # Set correct url by restoring first '@' coming from
                    # 'ssh://git@...'
                    PKG_URL="${parts[0]}@${parts[1]}"
                    PKG_NAME="$(pkg.name_from_url $PKG_URL)"
                ;;
                # 'ssh:*' still included because user could be handled in
                # ~/.ssh/config
                http:*|https:*|git:*|ssh:*)
                    PKG_URL="$PKG_RAW"
                    PKG_NAME="$(pkg.name_from_url $PKG_URL)"
                ;;
                */*)
                    PKG_NAME="$(pkg.name_from_shorthand $PKG_RAW)"
                ;;
                *)
                    PKG_NAME="$PKG_RAW"
                ;;
            esac
        fi
        echo "$PKG_NAME"
    done
}

##############################################################################

tpm.run() {
    tmux.or_fail

    # Set key bindings
    tmux.set_key_binding "$TPM_INSTALL_KEY" "$TPM_BIN tmux install"
    tmux.set_key_binding "$TPM_UPDATE_KEY" "$TPM_BIN tmux update"
    tmux.set_key_binding "$TPM_CLEAN_KEY" "$TPM_BIN tmux clean"

    # source plugins
    for plugin in $(tpm.list_installed_raw); do
        for tmux_file in "$plugin"/*.tmux; do
            [ -f "$tmux_file" ] || continue
            $tmux_file >/dev/null 2>&1
        done
    done
}

##############################################################################

tpm.install() {
    for package in ${@:-$(tmux.list_plugins)}; do

        # split branch from package name (if possible)
        local parts=($(pkg.split_name "$package"))
        PKG_RAW="${parts[0]}"
        PKG_BRANCH="${parts[1]}"

        if [ -e "$PKG_RAW" ]; then
            PKG_URL="$PKG_RAW"
            PKG_NAME="$(pkg.name_from_url $PKG_URL)"
        else
            case "$PKG_RAW" in
                ssh://git)
                    # Set correct url by restoring first '@' coming from
                    # 'ssh://git@...'
                    PKG_URL="${parts[0]}@${parts[1]}"
                    PKG_NAME="$(pkg.name_from_url $PKG_URL)"
                    # Set correct branch
                    PKG_BRANCH="${parts[2]}"
                ;;
                # 'ssh:*' still included because user could be handled in
                # ~/.ssh/config
                http:*|https:*|git:*|ssh:*)
                    PKG_URL="$PKG_RAW"
                    PKG_NAME="$(pkg.name_from_url $PKG_URL)"
                ;;
                */*)
                    PKG_USER="$(pkg.user_from_shorthand $PKG_RAW)"
                    PKG_NAME="$(pkg.name_from_shorthand $PKG_RAW)"
                    PKG_URL="https://github.com/$PKG_USER/$PKG_NAME"
                ;;
                *)
                    PKG_NAME="$PKG_RAW"
                    PKG_URL="https://github.com/$ELLIPSIS_USER/$PKG_NAME)"
                ;;
            esac
        fi

        PKG_PATH="$TPM_PLUGIN_PATH/$PKG_NAME"

        msg.bold "Installing $PKG_NAME"
        if [[ -d $PKG_PATH ]]; then
            msg.print "Already installed!"
        else
            if [[ -z "$PKG_BRANCH" ]]; then
                git.clone "$PKG_URL" "$PKG_PATH"
            else
                git.clone "$PKG_URL" "$PKG_PATH" --branch "$PKG_BRANCH"
            fi

            if [ "$?" -ne 0 ]; then
                log.error "Could not install $PKG_NAME"
            else
                log.ok "$PKG_NAME installed"
            fi
        fi
    done
}

##############################################################################

tpm.uninstall() {
    for pkg in "$@"; do
        msg.bold "$pkg"
        if [[ ! "$(tpm.list_installed)" =~ "$pkg" ]]; then
            msg.print "Not installed!"
            continue
        else
            rm -rf "$TPM_PLUGIN_PATH/$pkg"

            if [ "$?" -ne 0 ]; then
                log.error "Could not uninstall $pkg"
            else
                log.ok "$pkg uninstalled"
            fi
        fi
    done
}

##############################################################################

tpm.update() {
    for pkg in ${@:-$(tpm.list_installed)}; do
        if [ -d "$TPM_PLUGIN_PATH/$pkg" ]; then
            local cwd="$(pwd)"
            cd "$TPM_PLUGIN_PATH/$pkg"

            msg.bold "Updating $pkg"

            local needs_update="$(git pull --dry-run 2>&1)"
            if [ "$?" -ne 0 ]; then
                log.error "Could not get state of $pkg"
            else
                # Only log if changes should be made
                if [ -z "$needs_update" ]; then
                    msg.print "Already up to date!"
                else
                    if [ -z "$TPM_TMUX_ECHO" ]; then
                        git pull
                    else
                        git pull > /dev/null 2>&1
                    fi

                    if [ "$?" -ne 0 ]; then
                        log.error "Could not update $pkg"
                    else
                        log.ok "$pkg updated"
                    fi
                fi
            fi
            cd $cwd
        fi
    done
}

##############################################################################

tpm.clean() {
    for pkg in ${@:-$(tpm.list_installed)}; do
        msg.bold "$pkg"
        if [[ "$(tpm.list_plugins)" =~ "$pkg" ]]; then
            msg.print "Ok!"
            continue
        else
            rm -rf "$TPM_PLUGIN_PATH/$pkg"

            if [ "$?" -ne 0 ]; then
                log.error "Could not uninstall $pkg"
            else
                log.ok "$pkg uninstalled"
            fi
        fi
    done
}

##############################################################################
