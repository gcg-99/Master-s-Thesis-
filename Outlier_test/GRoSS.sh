#!/bin/bash

gross_dir="/media/worky_ant/Seagate_Backup_Plus_Drive/AntropoGeoSNPs/00_input/GRoSS"
input="$gross_dir/human_chr12.gross"
output="$gross_dir/output_GRoSS"


# for Treemix topology
Rscript GRoSS.R -e human_chr12.gross -r human_chr12_1.graph -o $output/"human_chr12_1.tsv"

# for our topology
Rscript GRoSS.R -e human_chr12.gross -r human_chr12_2.graph -o $output/"human_chr12_2.tsv"
