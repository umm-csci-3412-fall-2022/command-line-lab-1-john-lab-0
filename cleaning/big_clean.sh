#!/bin/bash

# Rename the command line parameter to 'inputFile'
inputFile="$1"

# Make a temporary directory to not interfere with existing and unrelated file structures
tempDir=$(mktemp -d)

# Extract the contents of the input archive file into the temporary directory
tar -xf "$inputFile" --directory "$tempDir"

# Recursively find all files in the new directory (using grep) that contain the phrase
# "DELETE ME", and store the files matching the pattern into a list
filesToDelete=$(grep -lr "DELETE ME" "$tempDir")

# As a testing mechanism, echo all files matching the pattern above
for file in $filesToDelete
do
  echo "$file"
done

# Remove the temporary directory after completion
rm -rf "$tempDir"
