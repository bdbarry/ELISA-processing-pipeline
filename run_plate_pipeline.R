# 1. Load packages
library(tidyverse)
library(readxl)
library(yaml)
library(here)
library(drc)

# 2. Load config
config <- yaml::read_yaml(here("configs", "config.yml"))

# 3. Source all code scripts
scripts <- list.files(here("code"), pattern = "\\.R$", recursive = TRUE, full.names = TRUE)
sapply(scripts, source)

# 4. Run main pipeline
process_all_plates(config$raw_dir, config$plate_layout_path)

# 5. Run QC pipeline
participant_QC(config$raw_dir)

#6. Save summary for downstream analysis
return_full_data_summary(config$raw_dir, config$dilution_factor)