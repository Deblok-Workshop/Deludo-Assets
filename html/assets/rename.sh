#!/bin/bash

index=0    # initialize index counter
mapping_file="mappings.txt"    # name of the mappings file

padding=3   # specify the desired width of the hexadecimal value (e.g., 4 for 0001, 5 for 00001)

for entry in *; do
  if [[ -d $entry && $entry != "${0##*/}" && $entry != "$mapping_file" ]]; then    # check if it's a directory and not the script or mapping file
    printf -v new_name "%0${padding}x" $index    # generate new folder name with padding
    mv "$entry" "$new_name"    # rename the folder
    echo "$new_name -> $entry" >> "$mapping_file"    # append mapping to the mapping file
    index=$((index + 1))    # increment index counter
  elif [[ -f $entry && $entry != "${0##*/}" && $entry != "$mapping_file" ]]; then    # check if it's a regular file and not the script or mapping file
    extension="${entry##*.}"    # extract the extension
    printf -v new_filename "%0${padding}x.%s" $index $extension    # generate new filename with padding
    mv "$entry" "$new_filename"    # rename the file
    echo "$new_filename -> $entry" >> "$mapping_file"    # append mapping to the mapping file
    index=$((index + 1))    # increment index counter
  fi
done
