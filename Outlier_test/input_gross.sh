#!/bin/bash

tabix -h hgdp_tgp_sgdp_chr12_p.dated.vcf.gz  | glactools vcfm2acf --onlyGT --fai human_g1k_v37.fa.fai  -  | glactools meld -f panel.txt -  | glactools acf2gross --noroot - | gzip > input.gross.gz
