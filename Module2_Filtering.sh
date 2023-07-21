#!/usr/bin/bash

# This module is for step 2 and 3: Trimming and filtering sequencing data (Fastp) and quality control of filtered results (FastQC)

## Fastp 
# 1.Variable
# Input
input1=$1
input2=$2
# Output directory and output
output_dir=$3
output1=$output_dir"/out_SRR1581065_1_sub.fastq.gz"
output2=$output_dir"/out_SRR1581065_2_sub.fastq.gz"
# Arguments filter
arg1=$5
arg2=$6
arg3=$7
arg4=$8
arg5=$9

# 2.Running
# Create directory to save the fastp results 
mkdir -p $output_dir
# Print the version of Fastp
conda run -n fastp fastp --version
# Run fastp with target arguments
conda run -n fastp fastp \
-i $input1 \
-I $input2 \
-o $output1 \
-O $output2 \
$arg5 \
$arg6 \
$arg7 \
$arg8 \
$arg9


## FastQC 
# 1.Variable
fastqc_output_dir=$4

# 2.Running 
bash Module1_QC.sh $output1 $output2 $fastqc_output_dir