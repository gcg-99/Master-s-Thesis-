# Master's Thesis
**ENVIRONMENTAL ASSOCIATION MODELLING WITH LOCI UNDER SELECTION TO INFER ADAPTIVE THRESHOLDS IN THE HUMAN GENOME** 

This Master's Thesis is made in the basis of a greater project.
The main objective is to infer the range of environmental occupation of the human species taking into account only its genetic adaptability mechanisms. Moreover, we would like to find the optimal genotypes adapted to some particular environmental conditions. For that purpose, we have followed the next steps:

# Selection of samples
'samples.csv' file, 331. 

# Building the database 
1. Download a dataset with unified, inferred tree sequences built from the 1000 Genomes phase 3, Human Genome Diversity, and Simons Genome Diversity Projects (Wohns *et al*., 2022) from https://zenodo.org/record/5495535#.Yk1V8jyxVH4 and unzip it with *tsunzip* command. From the whole genome, only genomic data from the p arm of chromosome 12 was selected arbitrarily to perform the analysis: *hgdp_tgp_sgdp_chr12_p.dated.trees* file.

In order to know the correspondence of sample ID between those that were previously selected from HGDP/1000Genomes databases and those contained in this new database (Wohns *et al*., 2022), the following steps are necessary:

2. Get metadata from *hgdp_tgp_sgdp_chr12_p.dated.trees* file with python3, tskit and json (and sys to save it) with *metadata.py* script. It will create a TXT (*out.txt*) file containing metadata from each sample (3754 samples in total). This file can be imported in Excel, in a comma-delimited format, to have metadata in columns (one of these fields is *'sample'*, which corresponds to the ID in HGDP/1000Genomes databases). The number of the row +1 corresponds to the ID in the new database (Wohns *et al*., 2022). In this way, the data of interest is the column of *'samples'* and the number of rows +1, which is tranferred to other file (*ind_list.csv*), where each sample ID of Wohns *et al*., 2022 database have its exact correspondence sample ID of HGDP/1000Genomes databases.

3. Merge *ind_list.csv* and *samples.csv* files by the *FINAL* column (i.e. by the HGDP/1000Genomes ID) with *merge_metadata.R* script. A total of 44 samples are not in the Wohns et al., 2022 database. For that reason, our number of samples descend from 350 to 306. 

4. Convert sequences from TREES to VCF format with python3 (tskit) with *tree2vcf.sh* script.

5. Filter final individuals in the VCF file with *filter_ind.sh* script. Our final VCF is *hgdp_tgp_sgdp_chr12_p.dated_287.vcf*, with 287 samples. In order to run vcftools to filter individuals, a file must be provided as an input, containing the 287 samples to be kept: *samples.txt* file. Notice that the name ID in the Wohns et al., 2022 database starts by 'tsk_', followed by the number ID (e.g. tsk_1316). 

# Finding the phylogeny among samples (before running outlier test) 
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

In addition, with the help of an expert in Anthropology, another phylogenetic tree topology was configured. This will allow running the outlier test twice and assess how powerful the program is. 

In summary, we have two phylogenetic tree topologies: the one obtained through Treemix and the one built with an expert help. 

# Outlier test with GRoSS 
Before the performance of the genotype-environment association analysis, is crucial to previously identify *loci* under positive selection. For that purpose, an outlier test is implemented through the Graph-aware Retrieval of Selective Sweeps software (GRoSS) (Refoyo-Martínez et al. 2019). We are running GRoSS twice. In order to run it, the following files are needed:
1. VCF2GRoSS. An input file with the reference and alternative allele counts per SNP and population, obtained with *vcf2GRoSS.sh* script. To run this script, 3 files are needed: 1) the VCF file (*hgdp_tgp_sgdp_chr12_p.dated_287.vcf*); 2) the reference genome (*human_g1k_v37.fasta.fai*) and a popfile (*panel.txt*). The generated output is provided (*human_chr12.gross*). This file works as the same input for each time GRoSS is run. 
2. A graph file. To write this file (by hand) letters must first be assigned to each node of the tree. Afterwards, the labels of the populations must be written, followed by the tree topology, written as the union between node-node or node-population, through the branches that make it up. As we are running GRoSS twice, we have two graph files: *human_chr12_1.graph* and *human_chr12_2.graph*.

We run the outlier test twice through the *GRoSS.sh* script, using the *GRoSS.R* script provided in https://github.com/FerRacimo/GRoSS. Moreover, the *LoadFiles.R* and *MultiBranchFunc.R* scripts (also from https://github.com/FerRacimo/GRoSS) must be in the same folder in order to run GRoSS.  

After running GRoSS, two TSV files are generated: *human_chr12_1.tsv* and *human_chr12_1.tsv*. We provide the 3 first lines of the files, due to their huge size. 

To visualize the results, the *Plotting_and_Windowing.txt* R script provided in https://github.com/FerRacimo/GRoSS is used (renamed here as *visualize_outliers_1.R* and *visualize_outliers_2.R*, each to plot the results of each TSV file). The name of the files are previously changed to *human_chr12_11KG_CLM_PUR_FRN_SAR_ADY_RUS_ESN_MZB_HZP_KLS_MAN_MSL_IBS_BAS_PEL_PTH_CEU_MXL.tsv* and *human_chr12_21KG_CLM_PUR_FRN_SAR_ADY_RUS_ESN_MZB_HZP_KLS_MAN_MSL_IBS_BAS_PEL_PTH_CEU_MXL.tsv*, respectively, so they could be read according to the R scripts. 

Finally, the outlier test plots are *human_chr12_1.png* and *human_chr12_2.png*.

