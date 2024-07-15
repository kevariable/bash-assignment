#!/usr/bin/env bash

# Set up a temporary test directory
TEST_DIR="tmp"
TEST_DIR_NOT_CREATED="tmp_not_created"

function set_up() {
  mkdir -p "$TEST_DIR"

  touch -d "2 days ago" "$TEST_DIR/file_1.txt" "$TEST_DIR/file_2.txt"

  touch "$TEST_DIR/file_3.txt"
}

function tear_down() {
  rm -rf "$TEST_DIR"
}

function test_files_to_be_delete_more_than_1_day() {
  local result="$(echo -e "$TEST_DIR\n1" | ./cruft_remover.sh)"

  assert_equals "$(ls $TEST_DIR)" "file_3.txt"
}

function test_files_cannot_to_be_delete_more_than_2_day() {
  local result="$(echo -e "$TEST_DIR\n2" | ./cruft_remover.sh)"

  assert_equals "$result" "There is no files matched."
}

function test_dir_not_listed() {
  local result="$(echo -e "$TEST_DIR_NOT_CREATED" | ./cruft_remover.sh)"

  assert_equals "$result" "Folder you type is not exists." 
}
