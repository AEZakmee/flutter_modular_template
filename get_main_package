#!/bin/bash

# Find the path of the .metadata file that contains "project_type: app"
metadata_path=$(find . -type f -name .metadata -exec grep -q "project_type: app" {} \; -print -quit)

if [ -z "$metadata_path" ]; then
    echo "No .metadata file found that contains 'project_type: app' in the current directory and its subdirectories"
    exit 1
fi

# Extract the directory path of the .metadata file
metadata_dir=$(dirname "$metadata_path")

echo "$metadata_dir"