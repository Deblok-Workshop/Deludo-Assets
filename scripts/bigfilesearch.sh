#!/bin/bash

# Function to search for large files recursively
search_large_files() {
    local directory="$1"
    local min_size="24M"

    # Use find command to search for files larger than the specified size
    find "$directory" -type f -size +"$min_size"
}

# Main function
main() {
    local search_dir="${1:-.}"  # Use current directory if no directory is provided
    search_large_files "$search_dir"
}

# Run the main function
main

