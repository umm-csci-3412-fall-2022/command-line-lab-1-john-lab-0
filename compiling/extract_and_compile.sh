#!/bin/bash

# Rename the first command line  argument into 'primeIndex'
primeIndex="$1"

# Extract the contents of the 'NthPrime.tgz' file into the working directory
tar -xf NthPrime.tgz

# Compiles the source .c file into the desired output file
gcc ./NthPrime/*.c -o NthPrime/NthPrime

# Run the newly created NthPrime/NthPrime.out file with the argument passed into this script
./NthPrime/NthPrime "$primeIndex"
