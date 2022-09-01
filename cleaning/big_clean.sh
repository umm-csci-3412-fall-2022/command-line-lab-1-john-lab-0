#!/bin/bash

# Rename the command line parameter to 'inputFile'
inputFile="$1"

# Make a temporary directory to not interfere with existing and unrelated file structures
tempDir=$(mktemp -d)

# Extract the contents of the input archive file into the temporary directory
tar -xf "$inputFile" --directory "$tempDir"

# Recursively find all files in the new directory (using grep) that contain the phrase
# "DELETE ME", and store the files matching the pattern into a list.
# Because the pattern to be matched is a string literal, rather than a regex pattern,
# the -F flag can be used to increase the run performance.
filesToDelete=$(grep -F -lr "DELETE ME" "$tempDir")

# Loop over the files in 'filesToDelete', then remove them one at a time
# using the '-v' flag as a verification measure, displaying the flags as they are removed.

for file in $filesToDelete
do
  rm -vf "$file"
done
