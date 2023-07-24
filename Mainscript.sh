#!/usr/bin/bash


########################  Trimming and filtering  ########################
## Fastp 
# 1.Variable
# Input
input1=$1
input2=$2
# Output directory and output
output_dir=$3
output1=$output_dir"/output1.fastq.gz"
output2=$output_dir"/output2.fastq.gz"
# Arguments filter
arg1=$6
arg2=$7
arg3=$8
arg4=$9
arg5=$10

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

echo "Complete trimming step"

########################  Re-Quality Control  ########################
## FastQC 
# 1.Variable
fastqc_output_dir=$4

# 2.Running 
bash Module1_QC.sh $output1 $output2 $fastqc_output_dir

echo "Complete re-quality control step"

########################  Assembly  ########################
## GetOrganelle
# 1.Variable
assembly_output_dir=$5

# 2.Running
bash Module3_Assembly.sh $output1 $output2 $assembly_output_dir

echo "Complete assembly step"

echo "Pipeline is finished"