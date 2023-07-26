# Mini Project - MITOCHONDRIAL GENOME ANALYSIS

## Description:
This repository is build to analyze sequencing data then assemble and analyze the mitochondrial genome through the following main steps:
- Quality control for sequencing data
- Trimming and filtering sequencing data (if needed)
- De novo assembly of the mitochondrial genome 
- Annotating the assembled genome 
- Identifying the species of the wild pig using mitochondria genome sequence.

The pipeline includes 6 modules:
- Module 1: Quality control for raw data [FastQC](https://github.com/s-andrews/FastQC) ***Chỗ này hơi thừa vì Fastp đã làm nhiệm vụ QC***
- Module 2: Trimming and filtering [Fastp](https://github.com/OpenGene/fastp)
- Module 3: De novo assembly [GetOrganelle](https://github.com/Kinggerm/GetOrganelle)
- Module 4: Quality control for assembly result [Bandage](https://github.com/rrwick/Bandage)
- Module 5: Assembly sequence annotation [MITOS](http://mitos2.bioinf.uni-leipzig.de/index.py) and [GeSeq](https://chlorobox.mpimp-golm.mpg.de/geseq.html)
- Module 6: Identify target species [MEGA](https://www.megasoftware.net/) and [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome)

---
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
 - [Structure of repository](#structure-of-repository)

---
## Installation and setup:
- Conda installation (Download conda according to the instructions from the link below, if you already have conda, skip this step)
```sh 
https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html
```
- Clone this repository
```sh
git clone https://github.com/nvhphuc1206/miniproject.git
cd miniproject
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

---
## Usage:

### Module 1: Quality control by FastQC
- `Module1_QC.sh` is used to check quality of raw paired-end reads using fastqc tool and generate reports
`.html` by [FastQC](https://github.com/s-andrews/FastQC)
```sh 
bash Module1_QC.sh <input1> <input2> <output_directory>
```
- Therein:
    - `input1`: path to first input file
    - `input2`: path to second input file
    - `output_directory`: path to where you want to store the results
- **Noted**: `input1` `input2` `output_directory` must be entered in the correct order. In addition, you can change the variables directly by going to the `*.sh` file and changing the `$1,2,3,...`
- Example:
```sh 
bash Module1_QC.sh raw_data/SRR1581065_1_sub.fastq.gz raw_data/SRR1581065_2_sub.fastq.gz tool/fastqc/raw/
```
- Output will be saved in `output_directory` and the resulting file we are interested in has the extension `.html


### Module 2: Trimming and filtering sequencing data by Fastp
- `Module2_Filtering.sh` is used to trim and filter sequencing paired-end reads by [Fastp](https://github.com/OpenGene/fastp) and re-quality-control of filtered results by [FastQC](https://github.com/s-andrews/FastQC) ***Superfluous***
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
- **Noted**: `input1` `input2` `output_directory` `quality_control_output_directory` `argument` must be entered in the correct order. Additionally, you can leave up to 5 filter parameters and if the parameter has spaces, leave it in `" "`. In addition, you can change the variables directly by going to the `*.sh` file and changing the `$1,2,3,...`
- Example:
```sh 
bash Module2_Filtering.sh raw_data/SRR1581065_1_sub.fastq.gz raw_data/SRR1581065_2_sub.fastq.gz tool/fastp/test tool/fastqc/test "--cut_tail 10" "--length_limit 50"
```
- Output of Fastp will be saved in `output_directory` in the format `.gz`
- Output of FastQC reports for the Fastp results will be saved in `quality_control_output_directory` in the format `.html`


### Module 3: De novo assembly of the mitochondrial genome by GetOrganelle
- `Module3_Assembly.sh` is used for De novo assembly of the mitochondrial genome through [GetOrganelle](https://github.com/Kinggerm/GetOrganelle)
```sh 
bash Module3_Assembly.sh <input1> <input2> <output_directory>
```
- Therein:
    - `input1`: path to first input file
    - `input2`: path to second input file
    - `output_directory`: path to where you want to store the assembly result
- **Noted**: `input1` `input2` `output_directory` must be entered in the correct order. In addition, you can change the variables directly by going to the `*.sh` file and changing the `$1,2,3,...`
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
- `Module4_Visualize_assembly.sh` is used for visualizing the assembly graph by [Bandage](https://github.com/rrwick/Bandage) to evaluate the De novo assembly of the mitochondrial genome.
```sh 
bash Module4_Visualize_assembly.sh <input> <output_directory>
```
- Therein:
    - `input`: path to assembly graph file `.fastg, .gfa`
    - `output_directory`: path to where you want to store the Bandage result
- **Noted**: `input` `output_directory` must be entered in the correct order. In addition, you can change the variables directly by going to the `*.sh` file and changing the `$1,2,3,...`
- Example:
```sh 
bash Module4_Visualize_assembly.sh ~/miniproject/tool/getorganelle/raw_read/extended_spades/assembly_graph.fastg ~/miniproject/tool/bandage/test
```
- Key output files of Bandage will be saved in `output_directory` as `visulized_graph.png`. Or you can run Bandage directly with the command.
```sh
conda activate bandage
Bandage
```


### Module 5: Assembly sequence annotation by MITOS, GeSeq
- [MITOS](http://mitos2.bioinf.uni-leipzig.de/index.py) is a web server for the automatic annotation of metazoan mitochondrial genomes. In this project I will use MITOS web server because of time limit and problem while standing alone this tool. Instructions for downloading and using MITOS can be consulted from the 2 links below:
    - `http://mitos2.bioinf.uni-leipzig.de/index.py`
    - `https://gitlab.com/Bernt/MITOS`

- [GeSeq](https://chlorobox.mpimp-golm.mpg.de/geseq.html) is a web-based tool for the rapid and accurate annotation of organellar genomes, in particular chloroplast genomes. It uses a combination of homology-based and de novo methods to identify genes and other features in organellar genomes. To use GeSeq you can enter the link below:
    - `https://chlorobox.mpimp-golm.mpg.de/geseq.html`


### Module 6: Identify target species MEGA,BLAST
- To identify the target pig species, I used the MUSCLE algorithm tool included in the MEGA (MUltiple Sequence Comparison by Log- Expectation) tool to perform Multiple Sequence Alignment with the database of Suidae family `database`. From the alignment results, I draw a phylogenetic tree to find the most closely related species.
- Instructions for downloading and using MEGA can be consulted from the links below:
    - `https://www.megasoftware.net/`
- BLAST NCBI will be the tool to double check the results by blasting the assembly sequence against the database from NCBI ***Lưu ý về việc chọn database và gene marker để BLAST***
    - `https://blast.ncbi.nlm.nih.gov/Blast.cgi?PROGRAM=blastn&PAGE_TYPE=BlastSearch&LINK_LOC=blasthome`


### Mainscript: The script perform cutting, quality control and assembly steps
- The script `Mainscript.sh` will perform trimming ([Fastp](https://github.com/OpenGene/fastp)), then do evaluation ([FastQC](https://github.com/s-andrews/FastQC)) and perform assembly ([GetOrganelle](https://github.com/Kinggerm/GetOrganelle)) from the trimming file as well as provide the image file of assembly graph by ([Bandage](https://github.com/rrwick/Bandage)).
```sh 
bash Mainscript.sh <input1> <input2> <output_directory> <quality_control_output_directory> <assembly_output_directory> <bandage_output_directory> <argument1> <argument2> <argument3> <argument4> <argument5>
```
***Đây là 1 code quá nặng về parameter và ko có hướng dẫn hay đối số rõ ràng !***
- Therein:
    - `input1`: path to first input target-trimmed file
    - `input2`: path to second input target-trimmed file
    - `output_directory`: path to where you want to store the trimming results
    - `quality_control_output_directory`: path to where you want to store the FastQC reports for the trimming results. 
    - `assembly_output_directory`: path to where you want to store the assembly result
    - `bandage_output_directory`: path to where you want to store the result of visualizing assembly graph
    - `argument`: parameters you want to filter data as on module 2 introduced
- Example:
```sh 
bash Mainscript.sh raw_data/SRR1581065_1_sub.fastq.gz raw_data/SRR1581065_2_sub.fastq.gz tool/fastp/test tool/fastqc/test tool/getorganelle/test
```
- **Noted**: `input1` `input2` `output_directory` `quality_control_output_directory` `assembly_output_directory` `bandage_output_directory` `argument` must be entered in the correct order or an easier way to run the script is that you can go directly to the `*.sh` files and change the `$1,2,3,...` to the objects you want. All the **output** will be save in the respectively `output_directory`.

---
## Structure of repository:

***Một điều quan trọng đã nhắc: ko commit dữ liệu hay data nặng lên github. Nên up lên 1 nền tảng drive hay đám mây và share link***
```sh
mini_project
├── Mainscript.sh
├── Module1_QC.sh
├── Module2_Filtering.sh
├── Module3_Assembly.sh
├── Module4_Visualize_assembly.sh
├── README.md
├── create_env.sh
├── database
│   ├── Suidae cytb database
│   ├── Suidae database
│   └── Sus scrofa cytb database
├── raw_data
│   ├── SRR1581065_1_sub.fastq.gz
│   └── SRR1581065_2_sub.fastq.gz
├── tool_results
│   ├── bandage
│   ├── fastp
│   ├── fastqc
│   ├── geseq
│   ├── getorganelle
│   ├── mega
│   ├── megahit
│   ├── mitos
│   ├── spades
│   └── trimmomatic
└── yml_file
    ├── bandage.yml
    ├── fastp.yml
    ├── fastqc.yml
    ├── getorganelle.yml
    ├── megahit.yml
    ├── spades.yml
    ├── trimmomatic.yml
    └── yaml.sh
```
