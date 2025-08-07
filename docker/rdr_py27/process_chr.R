#!/usr/bin/env Rscript

# Load required libraries
library(data.table)

# Read file directly with data.table (very efficient for large files)
rdr <- fread("sprinter.input.tsv.gz", sep = "\t", header = FALSE)

# Remove rows with "X" in the first column (much faster in data.table)
rdr <- rdr[!grepl("X", as.character(V1))]

# Check if the first column already has "chr" prefix and add if needed
if (!any(grepl("^chr", as.character(rdr$V1[1])))) {
  rdr[, V1 := paste0("chr", V1)]
}

# Write output (faster with data.table's fwrite)
fwrite(rdr, "chr_sprinter.input.tsv", sep = "\t", col.names = FALSE)

# Compress the file
system("gzip -f chr_sprinter.input.tsv")

# Print summary of what was done
cat("Processed", nrow(rdr), "rows\n")
cat("Output saved to chr_sprinter.input.tsv.gz\n")