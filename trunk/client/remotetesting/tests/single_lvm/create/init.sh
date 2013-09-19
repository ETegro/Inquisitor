#!/bin/bash -ex

. $CONFIG
. $WORK_DIR/lib/functions-test.sh

run_clearing || failed "clearing failed"
run_lua single_lvm || failed "single_lvm failed"
