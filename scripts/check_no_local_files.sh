#!/bin/bash

# For testing
# files=$(ls)

files=$(grep -ER "\"~" --include={*.R,*.Rmd} | egrep -v "doc/xtableGallery.R")

if [[ -n $files ]]; then 
  echo "Local file created:" 
  echo "$files"
  exit 1
fi

