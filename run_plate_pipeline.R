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
process_all_plates(config)