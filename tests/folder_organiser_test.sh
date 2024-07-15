#!/usr/bin/env bash

test_dir="tmp"
dir=({1..10}.jpg {1..10}.png {1..10}.doc {1..10}.docx {1..10}.pdf {1..10}.csv {1..10}.sh {1..10}.tar.bz2 {1..10}.pptx {1..10}.mp3 {1..10}.mp4 {1..10}.unknown)

function set_up() {
  mkdir "$test_dir"

  for file in "${dir[@]}"; do
    touch "$test_dir/$file"
  done
}

function tear_down() {
  for file in "${dir[@]}"; do
    rm "$test_dir/$file"
  done

  rmdir "$test_dir"
}

function test_cant_organise_unknown_files() {
  local unknown_files=($(ls "$test_dir"/*.unknown))
  assert_equals "${#unknown_files[@]}" "10"
}

function test_can_organise_images() {
  local images=($(ls "$test_dir"/*.{jpg,png}))
  assert_equals "${#images[@]}" "$((10*2))"
}

function test_can_organise_documents() {
  local docs=($(ls "$test_dir"/*.{doc,docx,pdf}))
  assert_equals "${#docs[@]}" "$((10*3))"
}

function test_can_organise_spreadsheets() {
  local csv_files=($(ls "$test_dir"/*.csv))
  assert_equals "${#csv_files[@]}" "10"
}

function test_can_organise_scripts() {
  local scripts=($(ls "$test_dir"/*.sh))
  assert_equals "${#scripts[@]}" "10"
}

function test_can_organise_archives() {
  local archives=($(ls "$test_dir"/*.tar.bz2))
  assert_equals "${#archives[@]}" "10"
}

function test_can_organise_presentations() {
  local presentations=($(ls "$test_dir"/*.pptx))
  assert_equals "${#presentations[@]}" "10"
}

function test_can_organise_audio_files() {
  local audio_files=($(ls "$test_dir"/*.mp3))
  assert_equals "${#audio_files[@]}" "10"
}

function test_can_organise_video_files() {
  local video_files=($(ls "$test_dir"/*.mp4))
  assert_equals "${#video_files[@]}" "10"
}

