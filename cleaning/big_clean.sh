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

for file in $filesToDelete
do
  rm -f "$file"
done

# Get the base file name (without extenxtion) of the input archive file
inputFileNameWithoutExtension=$(basename "$inputFile" .tgz)

# Display the inputFileNameWithoutExtension for verification
echo "$inputFileNameWithoutExtension"

# Find the parent directory for the files we want
# (which are going to be buried in a bunch of temp folders)
# Based on the approved answer from this stackExchange post
# https://unix.stackexchange.com/questions/103528/how-do-i-search-all-subdirectories-to-find-one-with-a-certain-name
contentPath=$(find "$tempDir" -type d -name "${inputFileNameWithoutExtension}")

# Move the output files from the temporary directory into the directory ./uncompressedOutput
mv -f "$contentPath" ./"$inputFileNameWithoutExtenstion"
# Create a new archive file with the remaining files.
tar -zcf  "cleaned_${inputFile}" "$inputFileNameWithoutExtension"

# Remove the temporary folders
rm -rf "$inputFileNameWithoutExtenstion"
