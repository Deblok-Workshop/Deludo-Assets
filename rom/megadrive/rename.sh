#!/bin/bash

index=0    # initialize index counter
mapping_file="mappings.txt"    # name of the mappings file

padding=3   # specify the desired width of the hexadecimal value (e.g., 4 for 0001, 5 for 00001)

for file in *; do
  if [[ -f $file && $file != "${0##*/}" && $file != "$mapping_file" ]]; then    # check if it's a regular file and not the script or mapping file
    extension="${file##*.}"    # extract the extension
    printf -v new_filename "%0${padding}x.%s" $index $extension    # generate new filename with padding
    mv "$file" "$new_filename"    # rename the file
    echo "$new_filename -> $file" >> "$mapping_file"    # append mapping to the mapping file
    index=$((index + 1))    # increment index counter
  fi
done
