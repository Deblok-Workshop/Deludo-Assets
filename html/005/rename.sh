#!/bin/bash

index=0    # initialize index counter
mapping_file="mappings.txt"    # name of the mappings file

padding=3   # specify the desired width of the hexadecimal value (e.g., 4 for 0001, 5 for 00001)

for entry in */; do  # Iterate only through immediate directories
  entry="${entry%/}" # Remove trailing slash to get only the directory name
  if [[ -d $entry && $entry != "${0##*/}" && $entry != "$mapping_file" ]]; then    # check if it's a directory and not the script or mapping file
    printf -v new_name "%0${padding}x" $index    # generate new folder name with padding
    mv "$entry" "$new_name"    # rename the folder
    echo "$new_name -> $entry" >> "$mapping_file"    # append mapping to the mapping file
    index=$((index + 1))    # increment index counter
  fi
done
