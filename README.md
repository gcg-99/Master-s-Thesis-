# Master-s-Thesis-
Master's Thesis called "ENVIRONMENTAL ASSOCIATION MODELLING WITH LOCI UNDER SELECTION TO INFER ADAPTIVE THRESHOLDS IN THE HUMAN GENOME" in the basis of a greater project.
The main objective is to infer the range of environmental occupation of the human species taking into account only its genetic variability. Moreover, we would like to find the optimal genotypes adapted to some particular environmental conditions. For that purpose, we have followed the next steps:

# Selection of samples


# Building the database 
1. We downloaded a dataset with unified, inferred tree sequences built from the 1000 Genomes phase 3, Human Genome Diversity, and Simons Genome Diversity Projects (Wohns et al., 2021) from https://zenodo.org/record/5495535#.Yk1V8jyxVH4 and unzip it with 'tsunzip' command. From the whole genome, only genomic data from chromosome 12 was selected by random to perform the analysis. 'hgdp_tgp_sgdp_chr12_p.dated.trees' file.
2. Get metadata from 'hgdp_tgp_sgdp_chr12_p.dated.trees' file with python3, tskit and json (and sys to save it) with 'metadata.sh' script.
3. Merge metadata with our samples with 'merge_metadata.R' script.
4. Convert sequence tree to vcf with python3 (tskit). 'trees2vcf.py' script.
5. Filter the VCF file by selected individuals with 'filter_ind.sh' script. Our final VCF is 'hgdp_tgp_sgdp_chr12_p.dated.vcf.gz'.

# Finding the phylogeny among samples (before running outlier test) with Treemix
To build the phylogeny we are using Treemix software (treemix-1.13). To run this program, an input file with alternative and reference allele counts of each SNP, per population, must be used. SNPs are filtered by invariant sites, linkage disequilibrium (LD) and MAF < 0.05.
1. Filter the VCF file by invariant sites and linkage disequilibrium (LD), performed with bcftools, vcftools and Plink (PLINK 1.9). 'Filter_invsites_LD.sh' script. 
2. Obtaining alternative allele frequencies per population with Plink (PLINK 2.0). 'Allele_freq.sh' script. An output file per population is generated. We upload one as example (allele-freq_chr12.CLM.afreq). Falta meter el popfile2.txt. 
3. Join data from all populations in the same CSV file: SNPs as raws and populations as columns, filled with alternative frequency data and observed counts. 
4. Filter SNPs by MAF < 0.05 with R. 'Filter_MAF_0.05.R' script. 10045 SNPs remained. 
5. Calculate with Excel the reference allele frequency (1-alternative allele frequency), alternative allele counts (alternative allele frequency * observed counts) and reference allele counts (reference allele counts * observed counts). 
6. Create another file: header with a space-delimited list of the names of populations, followed by lines containing the alternative and reference allele counts at each SNP separated by a comma. The final file is provided 'input_treemix_chr12_0.05.prn'.
7. Compress the file 'input_treemix_chr12_0.05.prn' with 'gzip' command (Treemix requires a compressed file as input). This file is also provided 'input_treemix_chr12_0.05.prn.gz'.
8. Run Treemix with 'run_treemix.sh' script. The root option is not specified because there are 3 African populations. For that reason, an unrooted tree will be generated. Different outputs are obtained. Among them, 'chr12_0.05.treeout.gz' is the one used for visualization. Decompress it with 'gunzip' command. 
9. Visualization of the tree with 'visualize_tree.R' script. The generated image is 'chr12_0.05.png'. 
10. Script to root the tree using the midpoint rooting method: 'midpoint_rooting.py'. 
11. To visualize the rooted tree, run in Bash $ python midpoint_rooting.py chr12_0.05.treeout | ete3 view --text
12. In addition, with the help of an expert in Anthropology, another phylogenetic tree topology was configured. This will allow running the outlier test twice and assess how powerful the program is.
13. In summary, we have two phylogenetic tree topologies: the one obtained through Treemix and the one built with an expert help. 

# Outlier test with GRoSS 
Before the performance of the genotype-environment association analysis, is crucial to previously identify *loci* under positive selection. For that purpose, an outlier test is implemented through the Graph-aware Retrieval of Selective Sweeps software (GRoSS) (Refoyo-Martínez et al. 2019). We are running GRoSS twice. In order to run it, the following files are needed:
1. An input file with the reference and alternative allele counts per SNP and population, obtained with 'input_gross.sh' script. Falta meter el archivo obtenido y el panel.txt. This input file is the same for the two times that GRoSS is run. 
2. A graph file. To write this file (by hand) letters must first be assigned to each node of the tree. Afterwards, the labels of the populations must be written, followed by the tree topology, written as the union between node-node or node-population, through the branches that make it up. The two graph files used to run GRoSS (one at a time) are 'chr12_0.05.graph' and (falta meter el otro graph file).
We run the outlier test twice through the 'GRoSS.sh' script, using the 'GRoSS.R' script provided in https://github.com/FerRacimo/GRoSS. After running GRoSS, two TSV files were generated: 'chr12_0.05.tsv' and 'chr12_0.05_2.tsv'. To visualize the results, we used the 'Plotting_and_Windowing.txt' R script provided in https://github.com/FerRacimo/GRoSS. We had to change the name of the files to 'chr12_0.051KG_CLM_PUR_FRN_SAR_ADY_RUS_ESN_MZB_HZP_KLS_MAN_MSL_IBS_BAS_PEL_PTH_CEU_MXL.tsv' and 'chr12_0.05_21KG_CLM_PUR_FRN_SAR_ADY_RUS_ESN_MZB_HZP_KLS_MAN_MSL_IBS_BAS_PEL_PTH_CEU_MXL.tsv', respectively, so they could be read according to the 'Plotting_and_Windowing.txt' script. Finally, the outlier test results are 

