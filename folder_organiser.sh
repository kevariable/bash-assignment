#!/usr/bin/env bash

getopts ":v" OPTION

while read -r FILE; do
  DIR=""

  case "$FILE" in
    *.jpg|*.jpeg|*.png) DIR="images";;
    *.doc|*.docx|*.txt|*.pdf) DIR="documents";;
    *.xls|*.xlsx|*.csv) DIR="spreadsheets";;
    *.sh) DIR="scripts";;
    *.zip|*.tar.gz|*.tar.bz2|*.tar) DIR="archives";;
    *.ppt|*.pptx) DIR="presentations";;
    *.mp3) DIR="audio";;
    *.mp4) DIR="video";;
    \?);;
  esac

  if [ -n "$DIR" ] && [ -f $FILE ]; then
    [ -d "$DIR" ] || mkdir "$DIR" 

    
    if [ "${OPTION}" = 'v' ]; then
      echo "Move $FILE to $DIR"
    fi

    mv "$FILE" "$DIR"
  fi
done < <(ls)
