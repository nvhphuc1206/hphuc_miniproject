set -e
true
true
/Users/huy/mambaforge-pypy3/envs/unicycler/bin/spades-hammer /Users/huy/Downloads/Organelle/results/corrected/configs/config.info
/Users/huy/mambaforge-pypy3/envs/unicycler/bin/python /Users/huy/mambaforge-pypy3/envs/unicycler/share/spades/spades_pipeline/scripts/compress_all.py --input_file /Users/huy/Downloads/Organelle/results/corrected/corrected.yaml --ext_python_modules_home /Users/huy/mambaforge-pypy3/envs/unicycler/share/spades --max_threads 10 --output_dir /Users/huy/Downloads/Organelle/results/corrected --gzip_output
true
true
/Users/huy/mambaforge-pypy3/envs/unicycler/bin/spades-core /Users/huy/Downloads/Organelle/results/K39/configs/config.info
/Users/huy/mambaforge-pypy3/envs/unicycler/bin/spades-core /Users/huy/Downloads/Organelle/results/K59/configs/config.info
/Users/huy/mambaforge-pypy3/envs/unicycler/bin/spades-core /Users/huy/Downloads/Organelle/results/K89/configs/config.info
/Users/huy/mambaforge-pypy3/envs/unicycler/bin/python /Users/huy/mambaforge-pypy3/envs/unicycler/share/spades/spades_pipeline/scripts/copy_files.py /Users/huy/Downloads/Organelle/results/K89/before_rr.fasta /Users/huy/Downloads/Organelle/results/before_rr.fasta /Users/huy/Downloads/Organelle/results/K89/assembly_graph_after_simplification.gfa /Users/huy/Downloads/Organelle/results/assembly_graph_after_simplification.gfa /Users/huy/Downloads/Organelle/results/K89/final_contigs.fasta /Users/huy/Downloads/Organelle/results/contigs.fasta /Users/huy/Downloads/Organelle/results/K89/first_pe_contigs.fasta /Users/huy/Downloads/Organelle/results/first_pe_contigs.fasta /Users/huy/Downloads/Organelle/results/K89/strain_graph.gfa /Users/huy/Downloads/Organelle/results/strain_graph.gfa /Users/huy/Downloads/Organelle/results/K89/scaffolds.fasta /Users/huy/Downloads/Organelle/results/scaffolds.fasta /Users/huy/Downloads/Organelle/results/K89/scaffolds.paths /Users/huy/Downloads/Organelle/results/scaffolds.paths /Users/huy/Downloads/Organelle/results/K89/assembly_graph_with_scaffolds.gfa /Users/huy/Downloads/Organelle/results/assembly_graph_with_scaffolds.gfa /Users/huy/Downloads/Organelle/results/K89/assembly_graph.fastg /Users/huy/Downloads/Organelle/results/assembly_graph.fastg /Users/huy/Downloads/Organelle/results/K89/final_contigs.paths /Users/huy/Downloads/Organelle/results/contigs.paths
true
/Users/huy/mambaforge-pypy3/envs/unicycler/bin/python /Users/huy/mambaforge-pypy3/envs/unicycler/share/spades/spades_pipeline/scripts/breaking_scaffolds_script.py --result_scaffolds_filename /Users/huy/Downloads/Organelle/results/scaffolds.fasta --misc_dir /Users/huy/Downloads/Organelle/results/misc --threshold_for_breaking_scaffolds 3
true
