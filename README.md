# Mini Project: MITOCHONDRIAL GENOME ANALYSIS

## Description:
Genomic DNA of a wild pig was sequenced by researcher B using Illumina platform. The researcher 
is interested in studying the mitochondrial genome sequence of the wild pig. This repository is build
for analyzing these sequenced data and responding to the questions listed below.
- Quality control for sequencing data
- Trimming and filtering sequencing data (if needed)
- De novo assembly of the mitochondrial genome 
- Annotating the assembled genome 
- Identifying the species of the this wild pig using mitochondria genome sequence.

The pipeline includes 6 modules:
- Module 1: Quality control for raw data (FastQC)
- Module 2: Trimming and filtering (Fastp)
- Module 3: De novo assembly (GetOrganelle)
- Module 4: Quality control for assembly result (Bandage)
- Module 5: Assembly sequence annotation (MITOS)
- Module 6: Identify target species (MEGA,BLAST)


## Table of Contents:
 - [Description](#description)
 - [Table of Contents](#table-of-contents)
 - [Requirements](#requirements)
 - [Usage](#usage)
    - [Module 1](#module-1-quality-control-by-fastqc)
    - [Module 2](#module-2-trimming-and-filtering-sequencing-data-by-fastp)
    - [Module 3](#module-3-de-novo-assembly-of-the-mitochondrial-genome-by-getorganelle)
    - [Module 4](#module-4-quality-control-for-assembly-result-by-bandage)
    - [Module 5](#module-5-assembly-sequence-annotation-by-mitos)
    - [Module 6](#module-6-identify-target-species-megablast)
 - [Citation](#citation)


## Requirements:
- Conda installation (Download conda according to the instructions from the link below, if you already have conda, skip this step)
```sh 
https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
```
- Clone this repository
```sh
git clone https://github.com/nvhphuc1206/miniproject.git
```
- Create the necessary environments for the entire project in conda from .yml
```sh
bash create_env.sh
```
- In this project, the assembly tool used is GetOrganelle and it needs to load a target database to run (in this case, the target database is animal mitochondria database).
```sh
conda activate getorganelle
get_organelle_config.py --add animal_mt
```

## Usage:

### Module 1: Quality control by FastQC
- `Module1_QC.sh` is used to check quality of raw paired-end reads using fastqc tool and generate reports
`.html`
```sh 
bash Module1_QC.sh <input1> <input2> <output_directory>
```
- Therein:
    - `input1`: path to first input file
    - `input2`: path to second input file
    - `output_directory`: path to where you want to store the results
- Noted: `input1` `input2` `output_directory` must be entered in the correct order. In addition, you can change the variables directly by going to the `*.sh` file and changing the `$1,2,3,...`
- Example:
```sh 
bash Module1_QC.sh raw_data/SRR1581065_1_sub.fastq.gz raw_data/SRR1581065_2_sub.fastq.gz tool/fastqc/raw/
```
- Output will be saved in `output_directory` and the resulting file we are interested in has the extension `.html


### Module 2: Trimming and filtering sequencing data by Fastp
- `Module2_Filtering.sh` is used to trim and filter sequencing paired-end reads (Fastp) and re-quality-control of filtered results (FastQC)
```sh 
bash Module2_Filtering.sh <input1> <input2> <output_directory> <quality_control_output_directory> <argument1> <argument2> <argument3> <argument4> <argument5>
```
- Therein:
    - `input1`: path to first input file
    - `input2`: path to second input file
    - `output_directory`: path to where you want to store the trimming results
    - `quality_control_output_directory`: path to where you want to store the FastQC reports for the trimming results. 
    - `argument`: parameters you want to filter data (--trim_poly_g, --overlap_len_require, ... ). You can refer to the parameters by
`conda activate fastp
fastp -h`
- Noted: `input1` `input2` `output_directory` `quality_control_output_directory` `argument` must be entered in the correct order. Additionally, you can leave up to 5 filter parameters and if the parameter has spaces, leave it in `" "`. In addition, you can change the variables directly by going to the `*.sh` file and changing the `$1,2,3,...`
- Example:
```sh 
bash Module2_Filtering.sh raw_data/SRR1581065_1_sub.fastq.gz raw_data/SRR1581065_2_sub.fastq.gz tool/fastp/test tool/fastqc/test "--cut_tail 10" "--length_limit 50"
```
- Output of Fastp will be saved in `output_directory` in the format `.gz`
- Output of FastQC reports for the Fastp results will be saved in `quality_control_output_directory` in the format `.html`


### Module 3: De novo assembly of the mitochondrial genome by GetOrganelle
- `Module3_Assembly.sh` is used for De novo assembly of the mitochondrial genome (GetOrganelle)
```sh 
bash Module3_Assembly.sh <input1> <input2> <output_directory>
```
- Therein:
    - `input1`: path to first input file
    - `input2`: path to second input file
    - `output_directory`: path to where you want to store the assembly result
- Noted: `input1` `input2` `output_directory` must be entered in the correct order. In addition, you can change the variables directly by going to the `*.sh` file and changing the `$1,2,3,...`
- Example:
```sh 
bash Module3_Assembly.sh raw_data/SRR1581065_1_sub.fastq.gz raw_data/SRR1581065_2_sub.fastq.gz tool/getorganelle/raw
```
- Key output files of GetOrganelle will be saved in `output_directory` and include: 
    - `*.path_sequence.fasta`: each fasta file represents one type of genome structure
    -  `*.selected_graph.gfa`: the organelle-only assembly graph
    -  `get_org.log.txt`: the log file
    -  `extended_K*.assembly_graph.fastg`: the raw assembly graph


### Module 4: Quality control for assembly result by Bandage
- Bandage (a Bioinformatics Application for Navigating De novo Assembly Graphs Easily) is a tool for visualizing assembly graphs with connections. 
- Instructions for downloading and using Bandage can be consulted from the 2 links below:
    - `http://rrwick.github.io/Bandage/`
    - `https://github.com/rrwick/Bandage/wiki/Getting-started`


### Module 5: Assembly sequence annotation by MITOS
- MITOS is a web server for the automatic annotation of metazoan mitochondrial genomes. In this project I will use MITOS web server because of time limit and problem while standing alone this tool. Instructions for downloading and using MITOS can be consulted from the 2 links below:
    - `http://mitos2.bioinf.uni-leipzig.de/index.py`
    - `https://gitlab.com/Bernt/MITOS`


### Module 6: Identify target species MEGA,BLAST
- To identify the target pig species, I used the MUSCLE algorithm tool included in the MEGA (MUltiple Sequence Comparison by Log- Expectation) tool to perform Multiple Sequence Alignment with the database of Suidae family `database`. From the alignment results, I draw a phylogenetic tree to find the most closely related species.
- Instructions for downloading and using MEGA can be consulted from the links below:
    - `https://www.megasoftware.net/`
- BLAST NCBI will be the tool to double check the results by blasting the assembly sequence against the database from NCBI
    - `https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome`


### Mainscript: The script perform cutting, quality control and assembly steps
- The script `Mainscript.sh` will perform trimming (Fastp), then do evaluation (FastQC) and perform assembly from the trimming file.
```sh 
bash Mainscript.sh <input1> <input2> <output_directory> <quality_control_output_directory> <assembly_output_directory> <argument1> <argument2> <argument3> <argument4> <argument5>
```
- Therein:
    - `input1`: path to first input target-trimmed file
    - `input2`: path to second input target-trimmed file
    - `output_directory`: path to where you want to store the trimming results
    - `quality_control_output_directory`: path to where you want to store the FastQC reports for the trimming results. 
    - `assembly_output_directory`: path to where you want to store the assembly result
    - `argument`: parameters you want to filter data as on module 2 introduced
- Example:
```sh 
bash Mainscript.sh raw_data/SRR1581065_1_sub.fastq.gz raw_data/SRR1581065_2_sub.fastq.gz tool/fastp/test tool/fastqc/test tool/getorganelle/test
```
- Noted: An easier way to run the script is that you can go directly to the `*.sh` files and change the `$1,2,3,...` to the objects you want.

## Citation:
- https://github.com/s-andrews/FastQC

- Shifu Chen. 2023. Ultrafast one-pass FASTQ data preprocessing, quality control, and deduplication using fastp. iMeta 2: e107. https://doi.org/10.1002/imt2.107

- Shifu Chen, Yanqing Zhou, Yaru Chen, Jia Gu; fastp: an ultra-fast all-in-one FASTQ preprocessor, Bioinformatics, Volume 34, Issue 17, 1 September 2018, Pages i884–i890, https://doi.org/10.1093/bioinformatics/bty560

- SPAdes: [Bankevich, A., S. Nurk, D. Antipov, A. A. Gurevich, M. Dvorkin, A. S. Kulikov, V. M. Lesin, S. I. Nikolenko, S. Pham, A. D. Prjibelski, A. V. Pyshkin, A. V. Sirotkin, N. Vyahhi, G. Tesler, M. A. Alekseyev and P. A. Pevzner. 2012. SPAdes: a new genome assembly algorithm and its applications to single-cell sequencing. Journal of Computational Biology 19: 455-477.](https://www.liebertpub.com/doi/abs/10.1089/cmb.2012.0021)

- Bowtie2: [Langmead, B. and S. L. Salzberg. 2012. Fast gapped-read alignment with Bowtie 2. Nature Methods 9: 357-359.](https://www.nature.com/articles/nmeth.1923)

- BLAST+: [Camacho, C., G. Coulouris, V. Avagyan, N. Ma, J. Papadopoulos, K. Bealer and T. L. Madden. 2009. BLAST+: architecture and applications. BMC Bioinformatics 10: 421.](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/1471-2105-10-421)

- Bandage: [Wick, R. R., M. B. Schultz, J. Zobel and K. E. Holt. 2015. Bandage: interactive visualization of de novo genome assemblies. Bioinformatics 31: 3350-3352.](https://academic.oup.com/bioinformatics/article/31/20/3350/196114)

