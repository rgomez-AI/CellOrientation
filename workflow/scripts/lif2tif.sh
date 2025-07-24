#!/bin/bash

# Check if correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 bf.sh <source_dir> <destination_dir>"
    exit 1
fi

BF_SCRIPT="$1"
SRC_DIR="$2"
DEST_DIR="$3"

# Resolve absolute paths
BF_SCRIPT="$(realpath "$BF_SCRIPT")"
SRC_DIR="$(realpath "$SRC_DIR")"
DEST_DIR="$(realpath "$DEST_DIR")"

# Check if bf.sh exists and is executable
if [ ! -x "$BF_SCRIPT" ]; then
    echo "Error: $BF_SCRIPT is not found or not executable"
    exit 1
fi

# Check if source directory exists
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory '$SRC_DIR' does not exist"
    exit 1
fi

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Loop through all *.lif files in the source directory
shopt -s nullglob
for file in "$SRC_DIR"/*.lif; do
    # Call bf.sh with the full path to the .lif file and the destination directory
    filename=$(basename "$file")
    name="${filename%.*}"
    "$BF_SCRIPT" "$file" "$DEST_DIR"/"$name"_S%s.tif
done

