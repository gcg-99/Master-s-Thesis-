R
all <- read.csv("ind_list.csv")
samples <- read.csv("samples.csv", sep = "\t")

merged <- merge(all, samples, by.x = "FINAL")

write.csv(merged, "merged.csv")
	
# Here I realized some of our samples are not in the unified vcf, I wrote those in a new
# sheet within "Base datos definitiva.xlsx" called "Faltan".
