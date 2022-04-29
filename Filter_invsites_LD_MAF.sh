#!/bin/bash

common_dir="/media/worky_ant/Seagate_Backup_Plus_Drive/AntropoGeoSNPs/00_input/Database"
outputs=$common_dir/"Outputs_ok"



#filter invariant sites 
bcftools view --min-ac=1 --no-update $common_dir/hgdp_tgp_sgdp_chr12_p.dated.vcf.gz > $outputs/hgdp_tgp_sgdp_chr12_p_invsites.vcf

#convert vcf into ped and map files 
vcftools --vcf $outputs/hgdp_tgp_sgdp_chr12_p_invsites.vcf --plink --out $outputs/hgdp_tgp_sgdp_chr12_p_invsites


list=(0.05 0.025)

for MAF in ${list[@]}
do
#filter MAF and LD sites 
plink1.9 --file $outputs/hgdp_tgp_sgdp_chr12_p_invsites --maf $MAF --indep-pairwise 50 5 0.5 --recode --out $outputs/hgdp_tgp_sgdp_chr12_p_invsites_MAF${MAF}_LD

#new prune file
plink1.9 --file $outputs/hgdp_tgp_sgdp_chr12_p_invsites_MAF${MAF}_LD --extract $outputs/hgdp_tgp_sgdp_chr12_p_invsites_MAF${MAF}_LD.prune.in --make-bed --out $outputs/hgdp_tgp_sgdp_chr12_p_invsites_MAF${MAF}_LD_pruned

#convert to vcf
plink1.9 --bfile $outputs/hgdp_tgp_sgdp_chr12_p_invsites_MAF${MAF}_LD_pruned --recode vcf --out $outputs/hgdp_tgp_sgdp_chr12_p_invsites_MAF${MAF}_LD_pruned
done




