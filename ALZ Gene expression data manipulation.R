# data manipulation for gene expression analysis 
# setwd("~/ALZ")

# load libraries
library(dplyr)
library(tidyverse)
library(GEOquery) 

# read in the data 
dat <- read.csv(file = "GSE199241_raw_counts.csv")

# data dimensions retrieval
dim(dat)

# get metadata from GEO
gse <- getGEO(GEO = "GSE199241", GSEMatrix = TRUE)

# to display 
gse
metadata <- pData(phenoData (gse[[1]]))
head(metadata)

# process metadata
metadata.modified <- metadata %>%
  select(1,10,11,12) %>%
  rename(`cell type` = characteristics_ch1) %>%
  rename(`cell line` = characteristics_ch1.1) %>%
  rename(treatment = characteristics_ch1.2) %>%
  mutate(`cell type` = gsub("cell type:", "", `cell type`)) %>%
  mutate(`cell line` = gsub("cell line:", "", `cell line`)) %>%
  mutate(treatment = gsub("treatment:", "", treatment)) 

#to determine the label of the gene column 
gene_col <- colnames(dat)[1]

#if the gene column is not properly labelled
#run this dat.long <- dat %>%
          #rename(gene = X) %>%
          #gather (key = "samples", value = "FPKM", -gene) %>%
          #head()                                               
#otherwise gather without renaming              

#reshaping data using tidyverse 
dat.long <- dat %>%
  gather (key = "samples", value = "FPKM", -gene) %>%
  head()

#check for sample name mismatches between dat.long and metadata.modified before proceeding to join
setdiff(trimws(unique(dat.long$samples)), trimws(unique(metadata.modified$title)))
setdiff(trimws(unique(metadata.modified$title)), trimws(unique(dat.long$samples)))

#if mismatches exist, format with gsub 
#this is done to format the datasets in dat.long and metadata.modified for conformity
dat.long$samples <- gsub("\\.", "-", dat.long$samples)

#join dataframes = dat.long + metadata.modified
dat.long <- dat.long %>%
  left_join(metadata.modified, by = c("samples" = "title")) 

#sort in ascending order
dat.long.sorted <- dat.long %>% arrange(FPKM)

#sort in descending order
dat.long.sorted <- dat.long %>% arrange(desc(FPKM))

#filter based on relevance
dat.long.filtered <- dat.long %>% filter(FPKM > 0)








