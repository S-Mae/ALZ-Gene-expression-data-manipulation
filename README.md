# ALZ Gene Expression Data Manipulation & Visualization
This repository contains R scripts for manipulation, analysis, and visualizing gene expression data from the **GSE199241** dataset. It integrates metadata with raw count data, performs essential transformations, and generates insightful visualizations using **ggplot2**.

## Features
✔️ Retrieves raw count data from GEO
✔️ Processes metadata and merges it with expression data
✔️ Formats, sorts, and filters genes based on expression
✔️ Visualizes gene expression data using ggplot2
✔️ Prepares data for differential analysis

## 📊 Data Visualization
The repository now includes multiple visualizations:

**Barplot:** Expression levels of selected genes

**Density Plot:** Distribution of gene expression

**Boxplot:** Expression variation across genes

**Scatterplot:** Correlation between genes

**Heatmap:** Comparison of multiple genes across samples

## Installation
Ensure you have R installed along with the required libraries:
**install.packages(c("dplyr", "tidyverse", "ggplot2", "GEOquery"))**

## Run the R scripts in sequence for data processing and visualization:
source("ALZ_Gene_Expression_Data_Manipulation.R")
source("ALZ_Data_Visualization_with_ggplot2.R")
