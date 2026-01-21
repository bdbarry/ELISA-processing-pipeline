load_summary_data <- function(base_dir){

#extract summary data. 
file_paths <- list.files(base_dir,
           pattern = "^Px[0-9]+_wk[0-9]+_summary\\.csv$",
           recursive = TRUE,
           full.names = TRUE)

# create an empty list.
summary_data <- list()

# write a for loop to pull the data into the list.
for(file in file_paths){
  data <- read_csv(file)
  px <- basename(file)
  summary_data[[px]] <- data
}
}