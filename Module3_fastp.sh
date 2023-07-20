#!/usr/bin/bash

# This module is for step 2 and 3: Trimming and filtering sequencing data (Trimmomatic and Fastp) and quality control of filtered results (FastQC)

# Fastp + FastQC
# Create directory to save the fastp results 
mkdir -p ~/hphuc_miniproject_organelleseq/tool/fastp/cuttail15_minlen50
# Run fastp with target arguments
conda run -n fastp fastp \
-i ~/hphuc_miniproject_organelleseq/raw_data/SRR1581065_1_sub.fastq.gz \
-I ~/hphuc_miniproject_organelleseq/raw_data/SRR1581065_2_sub.fastq.gz \
-o ~/hphuc_miniproject_organelleseq/tool/fastp/cuttail15_minlen50/out_SRR1581065_1_sub.fastq.gz \
-O ~/hphuc_miniproject_organelleseq/tool/fastp/cuttail15_minlen50/out_SRR1581065_2_sub.fastq.gz \
--cut_tail 15 \
--length_required 50


# Create directory to save the results from fastqc for fastp data
mkdir -p ~/hphuc_miniproject_organelleseq/tool/fastqc/mod/fastp_result/cuttail15_minlen50
# Run fastqc with fastp data
conda run -n fastqc fastqc \
~/hphuc_miniproject_organelleseq/tool/fastp/cuttail15_minlen50/out_SRR1581065_1_sub.fastq.gz \
~/hphuc_miniproject_organelleseq/tool/fastp/cuttail15_minlen50/out_SRR1581065_2_sub.fastq.gz \
-o ~/hphuc_miniproject_organelleseq/tool/fastqc/mod/fastp_result/cuttail15_minlen50