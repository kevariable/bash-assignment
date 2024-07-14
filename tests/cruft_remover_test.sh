#!/usr/bin/env bash

# Set up a temporary test directory
TEST_DIR="./tmp"

function set_up() {
  mkdir -p "$TEST_DIR"

  touch -d "10 days ago" "$TEST_DIR/file_1.txt"

  touch "$TEST_DIR/file_3.txt"
}

function teat_down() {
  rm -rf "$TEST_DIR"
}

function test_files_to_be_delete() {
  local result
  result=$(echo -e "$TEST_DIR\n9" | ./cruft_remover.sh)

  assert_not_contains $result "The folder of $TEST_DIR does not contains any file"
  assert_contains "$(ls $TEST_DIR)" "file_3.txt"
}
