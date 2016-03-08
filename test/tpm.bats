#!/usr/bin/env bats
##############################################################################
# tpm.bats
#
# Tests for the main TPM functions
#
##############################################################################

load _helper
load tpm

##############################################################################

setup() {
    mkdir -p /tmp/ellipsis-tpm-test
    TPM_TMP="/tmp/ellipsis-tpm-test"

    ln -s $TESTS_DIR/conf/* /tmp/ellipsis-tpm-test

    mkdir -p /tmp/ellipsis-tpm-test/plugins
    mkdir -p /tmp/ellipsis-tpm-test/plugins/p1
    mkdir -p /tmp/ellipsis-tpm-test/plugins/p2
    mkdir -p /tmp/ellipsis-tpm-test/plugins/p3
    export TPM_PLUGIN_PATH=/tmp/ellipsis-tpm-test/plugins
}

teardown() {
    rm -rf /tmp/ellipsis-tpm-test
}

##############################################################################

@test "tpm.list_installed_raw lists installed plugins including path" {
    run tpm.list_installed_raw
    [ "$status" -eq 0 ]
    [ "$output" = "$TPM_PLUGIN_PATH/p1 $TPM_PLUGIN_PATH/p2 $TPM_PLUGIN_PATH/p3" ]
}

@test "tpm.list_installed lists installed plugins without path" {
    run tpm.list_installed
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "p1" ]
    [ "${lines[1]}" = "p2" ]
    [ "${lines[2]}" = "p3" ]
}

@test "tpm.list_plugins lists plugins in config without path" {
    TPM_CONF="$TESTS_DIR/conf/conf.tmux"\
    run tpm.list_plugins
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "tmux-plugin-cpu" ]
    [ "${lines[1]}" = "tmux-plugin-mem" ]
    [ "${lines[2]}" = "tmux-plugin-battery" ]
}

@test "tpm.list_clean removes path from raw list" {
    run tpm.list_clean "$TPM_TMP/plugins/p1 https://test.com/org/p2 org/p3"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "p1" ]
    [ "${lines[1]}" = "p2" ]
    [ "${lines[2]}" = "p3" ]
}

@test "tpm.run adds key bindings and sources plugins" {
    if [ -z "$TMUX" ]; then
        skip "Tmux not running"
    fi

    skip "No test implementation"
}

@test "tpm.install installs plugins" {
    TPM_CONF="$TESTS_DIR/conf/install.tmux"\
    run tpm.install
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "Installing dot-test" ]
    [ -f $TPM_PLUGIN_PATH/dot-test/README.md ]
    [ -f $TPM_PLUGIN_PATH/dot-test2/README.md ]
}

@test "tpm.uninstall uninstalls plugins" {
    run tpm.uninstall "p1"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "p1" ]
    [ "${lines[1]}" = "[ ok ] p1 uninstalled" ]
    [ ! -d $TPM_PLUGIN_PATH/p1 ]
}

@test "tpm.update updates plugins" {
    skip "No test implementation"
}

@test "tpm.clean cleans plugins" {
    TPM_CONF="$TESTS_DIR/conf/clean.tmux"\
    run tpm.clean
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "p1" ]
    [ "${lines[1]}" = "[ ok ] p1 uninstalled" ]
    [ ! -d $TPM_PLUGIN_PATH/p1 ]
    [ "${lines[2]}" = "p2" ]
    [ "${lines[3]}" = "[ ok ] p2 uninstalled" ]
    [ ! -d $TPM_PLUGIN_PATH/p2 ]
    [ "${lines[4]}" = "p3" ]
    [ "${lines[5]}" = "Nothing to be done!" ]
    [ -d $TPM_PLUGIN_PATH/p3 ]
}

##############################################################################

