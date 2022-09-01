#!/bin/bash

# Rename the command line parameter to 'inputFile'
inputFile="$1"

# Make a temporary directory to not interfere with existing and unrelated file structures
tempDir=$(mktemp -d)

# Extract the contents of the input archive file into the temporary directory
tar -xf "$inputFile" --directory "$tempDir"

# For testing purposes, navigate to and  display the contents of the temporary directory
cd "$tempDir"
ls -R

# Remove the temporary directory after completion
rm -rf "$tempDir"
