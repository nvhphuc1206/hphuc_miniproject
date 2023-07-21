#!/usr/bin/bash

# # This module is for step 1: quality control of raw data from sequencing results
# #source /home/hphuc/hphuc_miniproject_organelleseq/Module1_qualitycontrol/module1config.sh
# source ./module1config.sh
# # Create directory to save the results from fastqc for raw data
# mkdir -p $result_dir 

# # Run fastqc with raw data
# conda run -n fastqc fastqc $s1 $s2 -o $result_dir
result_dir="/home/hphuc/hphuc_miniproject_organelleseq/tool/fastqc/raw/"
input_dir="


bash module1config.sh $result_dir "AA"