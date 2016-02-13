#!/usr/bin/env bats
##############################################################################
# @file tmux.bats
# @date February, 2016
# @author G. Roggemans <g.roggemans@grog.be>
# @copyright Copyright (c) GROG [https://grog.be] 2016, All Rights Reserved
# @license MIT
##############################################################################

load _helper
load tmux "$TPM_SRC"

##############################################################################

setup() {
    mkdir -p /tmp/ellipsis-tpm-test
    export ELLIPSIS_LOGFILE=/tmp/ellipsis-tpm-test/log
    ln -s $TESTS_DIR/conf/* /tmp/ellipsis-tpm-test
}

teardown() {
    rm -rf /tmp/ellipsis-tpm-test
}

##############################################################################

@test "tmux.or_fail fails if tmux is not running" {
    TMUX=""\
    run tmux.or_fail
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "[FAIL] Tmux not running!" ]
}

@test "tmux.or_fail does nothing if tmux is running" {
    TMUX="1"\
    run tmux.or_fail
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "tmux.echo prints a message in tmux copy mode" {
    if [ -z "$TMUX" ]; then
        skip "Tmux not running"
    fi

    skip "No test implementation"
}

@test "tmux.set_key_binding adds a key binding" {
    if [ -z "$TMUX" ]; then
        skip "Tmux not running"
    fi

    skip "No test implementation"
}

@test "tmux.conf_contents returns config contents" {
    TPM_CONF="$TESTS_DIR/conf/conf_contents1.tmux"\
    run tmux.conf_contents
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "content1" ]
    [ "${lines[1]}" = "source /tmp/ellipsis-tpm-test/conf_contents2.tmux" ]
}

@test "tmux.conf_contents full returns all config contents" {
    TPM_CONF="$TESTS_DIR/conf/conf_contents1.tmux"\
    run tmux.conf_contents "full"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "content1" ]
    [ "${lines[1]}" = "source /tmp/ellipsis-tpm-test/conf_contents2.tmux" ]
    [ "${lines[2]}" = "source /tmp/ellipsis-tpm-test/conf_contents3.tmux" ]
    [ "${lines[3]}" = "content2" ]
    [ "${lines[4]}" = "content3" ]
}

@test "tmux.sourced_files lists all sourced files" {
    TPM_CONF="$TESTS_DIR/conf/conf_contents1.tmux"\
    run tmux.sourced_files
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "/tmp/ellipsis-tpm-test/conf_contents2.tmux" ]
    [ "${lines[1]}" = "/tmp/ellipsis-tpm-test/conf_contents3.tmux" ]
}

@test "tmux.manual_expansion expands '~/' to '\$HOME'" {
    run tmux.manual_expansion "~/test:~/expansion"
    [ "$status" -eq 0 ]
    [ "$output" = "$HOME/test:$HOME/expansion" ]
}

@test "tmux.get_conf_option returns config option values" {
    TPM_CONF="$TESTS_DIR/conf/install.tmux"\
    run tmux.get_conf_option "@plugin"
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "grog/tmux-plugin-cpu" ]
    [ "${lines[1]}" = "grog/tmux-plugin-mem" ]
    [ "${lines[2]}" = "grog/tmux-plugin-battery" ]
}

##############################################################################

