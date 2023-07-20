#!/usr/bin/bash

# This module is for step 4: De novo assembly of the mitochondrial genome by GetOrganelle

# Add the animal mitochondrial database for the environment
conda run -n getorganelle get_organelle_config.py --add animal_mt
# Create directory to save the results from getorganelle
# Run GetOrganelle toolkit 
conda run -n getorganelle get_organelle_from_reads.py \
-1 ~/hphuc_miniproject_organelleseq/raw_data/SRR1581065_1_sub.fastq.gz \
-2 ~/hphuc_miniproject_organelleseq/raw_data/SRR1581065_2_sub.fastq.gz \
-F animal_mt \
-o ~/hphuc_miniproject_organelleseq/tool/getorganelle \
-R 10

get_organelle_from_reads.py \
-1 ~/hphuc_miniproject_organelleseq/tool/fastp/default/out_SRR1581065_1_sub.fastq.gz \
-2 ~/hphuc_miniproject_organelleseq/tool/fastp/default/out_SRR1581065_2_sub.fastq.gz \
-F animal_mt \
-o ~/hphuc_miniproject_organelleseq/tool/getorganelle/fastp_default \
-R 10