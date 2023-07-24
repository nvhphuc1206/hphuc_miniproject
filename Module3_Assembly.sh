#!/usr/bin/bash

#########################################################################
#########################     Assembly     ##############################
#########################################################################  


# This module is for De novo assembly of the mitochondrial genome (GetOrganelle)

# 1.Variable
# Input
input1=$1
input2=$2
# Output directory
output_dir=$3

# 2.Running
# Print the version of GetOrganelle
conda run -n getorganelle get_organelle_from_reads.py -v
# Create directory to save the assembly results and run getorganelle
conda run -n getorganelle get_organelle_from_reads.py \
-1 $input1 \
-2 $input2 \
-o $output_dir \
-F animal_mt \
-R 10

echo "Complete Module 3"