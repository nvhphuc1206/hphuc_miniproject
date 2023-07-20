#!/usr/bin/bash

# This module is for step 1: quality control of raw data from sequencing results

# Create directory to save the results from fastqc for raw data
mkdir -p ~/hphuc_miniproject_organelleseq/tool/fastqc/raw 

# Run fastqc with raw data
conda run -n fastqc fastqc ~/hphuc_miniproject_organelleseq/raw_data/SRR1581065_1_sub.fastq.gz ~/hphuc_miniproject_organelleseq/raw_data/SRR1581065_2_sub.fastq.gz -o ~/hphuc_miniproject_organelleseq/tool/fastqc/raw