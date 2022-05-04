#!/bin/bash

glactools="/media/worky_ant/Seagate_Backup_Plus_Drive/glactools"
input="/media/worky_ant/Seagate_Backup_Plus_Drive/AntropoGeoSNPs/00_input/Database/hgdp_tgp_sgdp_chr12_p.dated_287.vcf"
index="/media/worky_ant/Seagate_Backup_Plus_Drive/AntropoGeoSNPs/00_input/reference/human_g1k_v37.fasta.fai"
panel="/media/worky_ant/Seagate_Backup_Plus_Drive/AntropoGeoSNPs/00_input/Database/panel.txt"
out="/media/worky_ant/Seagate_Backup_Plus_Drive/AntropoGeoSNPs/00_input/GRoSS"

$glactools/glactools vcfm2acf --onlyGT --fai $index $input | $glactools/glactools meld -f $panel - | $glactools/glactools acf2gross --noroot - | gzip > $out/"human_chr12.gross.gz"
