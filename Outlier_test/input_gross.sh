#!/bin/bash

tabix -h ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr2.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 2:136486829-136653337  |glactools vcfm2acf --onlyGT --fai human_g1k_v37.fasta.fai  -  |glactools meld -f panel.txt -  | glactools acf2gross --noroot -  |gzip > input.gross.gz
