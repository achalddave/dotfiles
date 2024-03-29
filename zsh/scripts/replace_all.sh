#!/bin/bash
# Replace strings in all files, with a confirmation dialog for each replacement.

if [[ "$#" -ne 2 ]]; then
    echo "Usage: $0 <search_text> <replacement_text>"
    return 1
fi

search_text="$1"
replacement_text="$2"

# Check if ripgrep is installed
if ! command -v rg &> /dev/null; then
    echo "Ripgrep is not installed. Please install it and try again."
    return 1
fi

# Find all files containing the target text using ripgrep
files=$(rg -l "$search_text")

# Iterate over the files
for file in $files; do
    # Show the differences between the original and the proposed replacement
    echo
    echo "=== $file ==="
    echo
    sed -n "s/$search_text/$replacement_text/gp" "$file"

    # Ask for confirmation
    read -p "Confirm replacement in file $file (y/n)? " choice
    case "$choice" in
        y|Y) 
            # Replace the text in the file
            sed -i "s/$search_text/$replacement_text/g" "$file"
            echo "Replacement made in $file"
            ;;
        n|N) 
            echo "Skipping $file"
            ;;
        *) 
            echo "Invalid choice, skipping $file"
            ;;
    esac
done
