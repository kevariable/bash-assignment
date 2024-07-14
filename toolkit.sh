#!/usr/bin/env bash

EXCLUDE="$(basename $0)"
DIR="$(dirname $0)"

PS3="Which utility do you want to run?: "
select SCRIPT in $(ls -I $EXCLUDE $DIR); do
  if [ -x "${DIR}/$SCRIPT" ]; then
    "${DIR}/$SCRIPT"
    break
  else
    echo "$SCRIPT is not executable yet."
  fi
done
