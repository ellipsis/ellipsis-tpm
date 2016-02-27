##############################################################################
# @file vars.bash
# @date January, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load msg "$TPM_SRC" # Use tmux aware msg functions
load tmux "$TPM_SRC"
load log
load path

##############################################################################

TPM_CONF="${TPM_CONF:-"/etc/tmux.conf:~/.tmux.conf"}"

##############################################################################

# Keep compatibility with TPM
local tmux_plugin_manager_path="$(tmux.get_conf_option "TMUX_PLUGIN_MANAGER_PATH" "$HOME/.tmux/plugins")"
tmux_plugin_manager_path="$(path.expand "$tmux_plugin_manager_path")"

local tpm_plugin_path="$(tmux.get_conf_option "@tpm_plugin_path" "$tmux_plugin_manager_path")"
TPM_PLUGIN_PATH="${TPM_PLUGIN_PATH:-$tpm_plugin_path}"
TPM_PLUGIN_PATH="$(path.expand "$TPM_PLUGIN_PATH")"

# This shouldn't be necesary (extra protection if the above is altered)
if [ -z "$TPM_PLUGIN_PATH" ]; then
    log.fail "Plugin path noth valid!"
    exit 1
fi

##############################################################################

# Keep compatibility with TPM
local tpm_install="$(tmux.get_conf_option "@tpm-install" "I")"

local tpm_install_key="$(tmux.get_conf_option "@tpm_install_key" "$tpm_install")"
TPM_INSTALL_KEY="${TPM_INSTALL_KEY:-$tpm_install_key}"

##############################################################################

# Keep compatibility with TPM
local tpm_update="$(tmux.get_conf_option "@tpm-update" "U")"

local tpm_update_key="$(tmux.get_conf_option "@tpm_update_key" "$tpm_update")"
TPM_UPDATE_KEY="${TPM_UPDATE_KEY:-$tpm_update_key}"

##############################################################################

# Keep compatibility with TPM
local tpm_clean="$(tmux.get_conf_option "@tpm-clean" "M-u")"

local tpm_clean_key="$(tmux.get_conf_option "@tpm_clean_key" "$tpm_clean")"
TPM_CLEAN_KEY="${TPM_CLEAN_KEY:-$tpm_clean_key}"

##############################################################################
