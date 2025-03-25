# ALZ Gene Expression Data Manipulation 

This repository contains R scripts for processing and analyzing gene expression data from the **GSE199241** dataset. It integrates metadata with raw count data and performs essential transformations using `tidyverse` and `dplyr`.

## 📌 Features  
✔️ Retrieves raw count data from GEO  
✔️ Processes metadata and merges it with expression data  
✔️ Formats, sorts, and filters genes based on expression  
✔️ Prepares data for visualization and differential analysis  

## 🔧 Installation  
Ensure you have R installed along with the required libraries:

```r
install.packages(c("dplyr", "tidyverse", "GEOquery"))
