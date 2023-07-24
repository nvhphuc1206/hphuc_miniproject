#!/usr/bin/bash

################################################################################
#########################     Quality Control     ##############################
################################################################################   


# This module is for step 1: quality control of raw data from sequencing results

# 1.Variable
# Input
input1=$1
input2=$2
# Output
output_dir=$3

# 2.Running
# Create directory to save the results from fastqc for raw data
mkdir -p $output_dir

# Print the version of FastQC
conda run -n fastqc fastqc --version

# Run fastqc with raw data
conda run -n fastqc fastqc $input1 $input2 -o $output_dir

echo "Complete Module 1"