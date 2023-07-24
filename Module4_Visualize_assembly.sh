#!/usr/bin/bash

#########################################################################
#################    Visualize Assembly Sequence    #####################
#########################################################################  

# This module is for visualizing the assembly graph (Bandage) to evaluate the De novo assembly of the mitochondrial genome 


# 1.Variable
# Input
input=$1
# Output directory
output_dir=$2

# 2.Running
# Create directory to save the results from fastqc for raw data
mkdir -p $output_dir

# Print the version of GetOrganelle
conda run -n bandage Bandage -v
# Create directory to save the assembly results and run getorganelle
conda run -n bandage Bandage image $input $output_dir/visulized_graph.png --lengths --depth

echo "Complete Visualizing the assembly graph step"