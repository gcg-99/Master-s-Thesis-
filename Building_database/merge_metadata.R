#!/usr/bin/env Rscript

all <- read.csv("ind_list.csv")
samples <- read.csv("samples.csv", sep = "\t")

merged <- merge(all, samples, by.x = "FINAL")

write.csv(merged, "merged.csv")
