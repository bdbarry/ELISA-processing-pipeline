load_summary_data <- function(file_path){
#extract summary data. 
processed_csvs <- list.files(file_path,
           pattern = "^Px[0-9]+_wk[0-9]+_summary\\.csv$",
           recursive = TRUE,
           full.names = TRUE)

# create an empty list.
processed_data <- list()
# write a for loop to pull the data into the list.
for(csv in processed_csvs){
  data <- read_csv(csv)
  px <- basename(csv)
  processed_data[[csv]] <- data
}
#join into one large table and select relevant columns.
processed_data  <- bind_rows(processed_data, .id = "source") %>%
  dplyr::select("px_id", "week", "sample", "zero_norm", "pred_conc", "sample_flag")
}