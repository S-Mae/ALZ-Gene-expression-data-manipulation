# Data visualization with ggplot
# setwd(/Users/ZAINAB/Documents/ALZ)

# Load libraries
library(tidyverse)
library(ggplot2)

# Filtering the genes of interest from dat.long
dat.long <- dat.long %>%
  filter(gene == "MAP1B" | gene == "MAP2") %>%
  group_by(gene, samples) %>%
  summarize(FPKM) %>%
  arrange(FPKM)

# Basic format for ggplot
# ggplot(data, aes(x = variable, y = variable1)) +
# geom_x()

# 1. Bar plot
dat.long %>%
  filter(gene %in% c("MAP1B", "MAP2")) %>%
  ggplot(., aes(x = samples, y = FPKM, fill = gene)) +
  geom_col() +
  labs(y = "FPKM", x = "Samples", fill = "Gene") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1))

# 2. Density plot
dat.long %>%
  filter(gene %in% c("MAP1B", "MAP2")) %>%
  ggplot(., aes(x = FPKM, fill = gene)) +
  geom_density(alpha = 0.3)   #alpha function reduces opacity (1 - highest, 0 - lowest)

# 3. Box plot 
dat.long %>%
  filter(gene %in% c("MAP1B", "MAP2")) %>%
  ggplot(., aes(x = gene, y = FPKM)) +
  geom_boxplot()
# geom_violin()

# 4. Scatter plot A
dat.long %>%
  filter(gene %in% c("MAP1B", "MAP2")) %>%
  spread(key = gene, value = FPKM) %>%
  ggplot(., aes(x = MAP1B, y = MAP2)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) # to draw a line across the plot 

# 4. Scatter plot B (Group based on treatment; intoduces "mutate")
dat.long %>%
  filter(gene %in% c("MAP1B", "MAP2")) %>%
  spread(key = gene, value = FPKM) %>%
  mutate(Group = ifelse(grepl("siNC", samples), "Control", "Treated")) %>%
  ggplot(., aes(x = MAP1B, y = MAP2, color = Group)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE) # to draw a line across the plot

# 5. Heatmap A 

# Define genes of interest
gene.of.interest <- c("MAP1B", "MAP2") 

# Generate heatmap 
dat.long %>%
  filter(gene %in% gene.of.interest) %>%
  ggplot(., aes(x = samples, y = gene, fill = FPKM)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        panel.grid.major.x = element_blank())

# 5. Heatmap B (comparison with other genes) 

# Define genes of interest
gene.of.interest <- c("MAP1B", "MAP2", "ACTB", "A2M", "TUBB", "EEF2") 

# Open a PDF file before plotting 
pdf("heatmap_save1.pdf", width = 10, height = 8)

# Generate heatmap 
dat.long %>%
  filter(gene %in% gene.of.interest) %>%
  ggplot(., aes(x = samples, y = gene, fill = FPKM)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
        panel.grid.major.x = element_blank())

# Close the PDF file to save
dev.off()









