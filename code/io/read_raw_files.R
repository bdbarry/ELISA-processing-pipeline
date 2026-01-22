get_raw_filepaths <- function(raw_dir){
files <- list.files(raw_dir,
   pattern = "\\.csv$",
   recursive = TRUE,
   full.names = TRUE)
files <- files[grep("data/raw", files)] 
} 