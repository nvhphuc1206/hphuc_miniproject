#!/usr/bin/bash

# This module is for step 2 and 3: Trimming and filtering sequencing data (Trimmomatic and Fastp) and quality control of filtered results (FastQC)

# Trimmomatic + FastQC 
# Create directory to save the trimmomatic results 
mkdir -p ~/hphuc_miniproject_organelleseq/tool/trimmomatic/trailinng15_minlen80
# Run trimmomatic with target arguments
conda run -n miniproject trimmomatic PE -phred33 -threads 16 ~/hphuc_miniproject_organelleseq/raw_data/SRR1581065_1_sub.fastq.gz ~/hphuc_miniproject_organelleseq/raw_data/SRR1581065_2_sub.fastq.gz ~/hphuc_miniproject_organelleseq/tool/trimmomatic/trailinng15_minlen80/raw1_trimmed_paired.fastq.gz ~/hphuc_miniproject_organelleseq/tool/trimmomatic/trailinng15_minlen80/raw1_trimmed_unpaired.fastq.gz ~/hphuc_miniproject_organelleseq/tool/trimmomatic/trailinng15_minlen80/raw2_trimmed_paired.fastq.gz ~/hphuc_miniproject_organelleseq/tool/trimmomatic/trailinng15_minlen80/raw2_trimmed_unpaired.fastq.gz TRAILING:15 MINLEN:80
# Create directory to save the results from fastqc for trimmomatic data
mkdir -p ~/hphuc_miniproject_organelleseq/tool/fastqc/mod/trimmomatic_result/trailinng15_minlen80
# Run fastqc with trimmomatic data
conda run -n fastqc fastqc ~/hphuc_miniproject_organelleseq/tool/trimmomatic/trailinng15_minlen80/raw1_trimmed_paired.fastq.gz ~/hphuc_miniproject_organelleseq/tool/trimmomatic/trailinng15_minlen80/raw2_trimmed_paired.fastq.gz -o ~/hphuc_miniproject_organelleseq/tool/fastqc/mod/trimmomatic_result/trailinng15_minlen80


# Fastp + FastQC
# Create directory to save the fastp results 
mkdir -p ~/hphuc_miniproject_organelleseq/tool/fastp/cuttail15_minlen80
# Run fastp with target arguments
conda run -n fastp fastp \
-i ~/hphuc_miniproject_organelleseq/raw_data/SRR1581065_1_sub.fastq.gz \
-I ~/hphuc_miniproject_organelleseq/raw_data/SRR1581065_2_sub.fastq.gz \
-o ~/hphuc_miniproject_organelleseq/tool/fastp/cuttail15_minlen80/out_SRR1581065_1_sub.fastq.gz \
-O ~/hphuc_miniproject_organelleseq/tool/fastp/cuttail15_minlen80/out_SRR1581065_2_sub.fastq.gz \
--cut_tail 15 \
--length_required 80

# Create directory to save the results from fastqc for fastp data
mkdir -p ~/hphuc_miniproject_organelleseq/tool/fastqc/mod/fastp_result/cuttail15_minlen80
# Run fastqc with fastp data
conda run -n fastqc fastqc \
~/hphuc_miniproject_organelleseq/tool/fastp/cuttail15_minlen80/out_SRR1581065_1_sub.fastq.gz \
~/hphuc_miniproject_organelleseq/tool/fastp/cuttail15_minlen80/out_SRR1581065_2_sub.fastq.gz \
-o ~/hphuc_miniproject_organelleseq/tool/fastqc/mod/fastp_result/cuttail15_minlen80