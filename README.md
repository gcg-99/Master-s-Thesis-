# Master-s-Thesis-
Master's Thesis called "ENVIRONMENTAL ASSOCIATION MODELLING WITH LOCI UNDER SELECTION TO INFER ADAPTIVE THRESHOLDS IN THE HUMAN GENOME" in the basis of a greater project.
The main objective is to infer the range of environmental occupation of the human species taking into account only its genetic variability. Moreover, we would like to find the optimal genotypes adapted to some particular environmental conditions. For that purpose, we have followed the next steps:

# Selection of samples


# Building the database 
1. We downloaded a dataset with unified, inferred tree sequences built from the 1000 Genomes phase 3, Human Genome Diversity, and Simons Genome Diversity Projects (Wohns et al., 2021) from https://zenodo.org/record/5495535#.Yk1V8jyxVH4 and unzip it with 'tsunzip' command. From the whole genome, only genomic data from chromosome 12 was selected by random to perform the analysis. 'hgdp_tgp_sgdp_chr12_p.dated.trees' file.
2. Get metadata from 'hgdp_tgp_sgdp_chr12_p.dated.trees' file with python3, tskit and json (and sys to save it) with 'metadata.sh' script.
3. Merge metadata with our samples with 'merge_metadata.R' script.
4. Convert sequence tree to vcf with python3 (tskit). 'trees2vcf.py' script.
5. Filter the VCF file by selected individuals with 'filter_ind.sh' script. 
