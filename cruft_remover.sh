#!/usr/bin/env bash

read -rp "Which folder you want to scan? " FOLDER

if [[ ! -d "$FOLDER" ]]; then
  echo "Folder you type is not exists."
  exit 1
fi

read -rp "How many days files should be unmodified for to be considered cruft? " DAY

readarray -t FILES < <(find "$FOLDER" -maxdepth 1 -atime +"$DAY" -type f)

if [ "${#FILES[@]}" -eq 0 ]; then
  echo "There is no files matched."
  exit 1
fi

for FILE in "${FILES[@]}"; do
  rm "$FILE";
done

exit 0
