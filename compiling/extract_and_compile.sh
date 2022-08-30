#!/bin/bash

# Extract the contents of the 'NthPrime.tgz' file into the working directory
tar -xf NthPrime.tgz

# Compiles the source .c file into the desired output file
gcc ./NthPrime/*.c -o NthPrime/NthPrime
