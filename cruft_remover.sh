#!/usr/bin/env bash

read -rp "Which folder you want to cruft? " FOLDER

if [ ! -d "$FOLDER" ]; then
  echo "Folder you type is not exists."
  exit 1
fi

read -rp "How many days files should be unmodified for to be considered cruft? " DAY

readarray -t FILES < <(find "$FOLDER" -maxdepth 1 -atime -"$DAY" -type f)

if [ "${#FILES[@]}" -eq 0 ]; then
  echo "The folder of $FOLDER does not contains any file"
  exit 1
fi

for FILE in "${FILES[@]}"; do
  rm -i "$FILE";
done
