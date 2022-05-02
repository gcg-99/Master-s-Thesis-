#!/bin/bash

# run GRoSS with the phylogenetic tree topology obtained with Treemix
Rscript GRoSS.R -e $input -r chr12_0.05.graph -o chr12_0.05.tsv

# run GRoSS with the phylogenetic tree topology built with an expert help
Rscript GRoSS.R -e $input -r chr12_0.05_2.graph -o chr12_0.05_2.tsv
