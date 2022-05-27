# install packages
install.packages("dplyr")
install.packages("glue")
install.packages("tidyverse")

# import libraries 
library(dplyr)
library(glue)
library(ggplot2)

# set working directory
getwd()
setwd("D:/ALICIA/TRAYECTORIA PROFESIONAL/BIOINFORMÁTICA/MÁSTER BIOLOGÍA COMPUTACIONAL/UPM/TFM Y PRÁCTICAS/TFM/GRoSS/OUTPUTS")
dir()

#### read and check dimensions of TSV files #### 

# table 1 phylogeny 1
tabletsv1 <- read.csv("human_chr12_11KG_CLM_PUR_FRN_SAR_ADY_RUS_ESN_MZB_HZP_KLS_MAN_MSL_IBS_BAS_PEL_PTH_CEU_MXL.tsv", sep = '\t', header = TRUE)
head(tabletsv1)
count(tabletsv1)
nrow(tabletsv1)
ncol(tabletsv1)

# table 2 phylogeny 2
tabletsv2 <- read.csv("human_chr12_21KG_CLM_PUR_FRN_SAR_ADY_RUS_ESN_MZB_HZP_KLS_MAN_MSL_IBS_BAS_PEL_PTH_CEU_MXL.tsv", sep = '\t', header = TRUE)
head(tabletsv2)
count(tabletsv2)
nrow(tabletsv2)
ncol(tabletsv2)



#### create vectors with outlier counts by branch ####

# find out the number of columns of interest 
which(colnames(tabletsv1)=="Pval_a_r" ) # the same positions in tsv2
which(colnames(tabletsv1)=="Pval_RUS_n")

# vector for TSV1 
# create an empty vector to include the outlier counts by branch
outliers_branch_1 <- c()
outliers_branch_1
typeof(outliers_branch_1)

# iterate over each branch column 
range <- 38:ncol(tabletsv1)
range
length(range)

for (i in range)
{
  # append counts of outliers by branch to the empty vector
  outliers_branch_1[i-37] <- sum(tabletsv1[,i] < 0.00001)
}

# check vector content and length
outliers_branch_1
length(outliers_branch_1)


# vector for TSV2
# create an empty vector to include the outlier counts by branch
outliers_branch_2 <- c()
outliers_branch_2
typeof(outliers_branch_2)

# iterate over each branch column 
range <- 38:ncol(tabletsv2)
range
length(range)

for (i in range)
{
  # append counts of outliers by branch to the empty vector
  outliers_branch_2[i-37] <- sum(tabletsv2[,i] < 0.00001)
}

# check vector content and length
outliers_branch_2
length(outliers_branch_2)

#### make vector with branch names ####

# find out the range position of columns of interest 
which(colnames(tabletsv1)=="a_r" )
which(colnames(tabletsv1)=="RUS_n")

# create a vector with the names of branches 
names_branches <- colnames(tabletsv1)[4:37]
names_branches
as.vector(names_branches)
class(names_branches)



#### create dataframe 1 with data of phylogeny 1 ####
dataframe1 <- data.frame(names_branches, outliers_branch_1)
dataframe1

# add lable to values 
dataframe1$Phylogeny <- 'Phylogeny 1'
dataframe1

# change the name of the first column 
colnames(dataframe1)[1] <- "Branches"
colnames(dataframe1)[2] <- "Number_outliers"
dataframe1



#### create dataframe 2 with data of phylogeny 2 ####
dataframe2 <- data.frame(names_branches, outliers_branch_2)
dataframe2

# add lable to values 
dataframe2$Phylogeny <- 'Phylogeny 2'
dataframe2

# change the name of the first column 
colnames(dataframe2)[1] <- "Branches"
colnames(dataframe2)[2] <- "Number_outliers"
dataframe2




#### join two dataframes ####  
dataframe_all <- rbind(dataframe1, dataframe2)
dataframe_all



#### plot data ####
ggplot(dataframe_all, aes(x=Branches, y=Number_outliers, fill=Phylogeny)) + geom_bar(stat ="identity", position = "dodge", colour="black") + scale_fill_manual(values = c("#E7298A", "#66A61E")) + geom_text(aes(label=Number_outliers), vjust=-0.2, position = position_dodge(.9), size=3) + theme(axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)), axis.text.x = element_text(angle = 90, vjust = 0.5))
