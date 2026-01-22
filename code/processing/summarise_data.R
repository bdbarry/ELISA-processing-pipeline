summarise_data <- function(raw_dir, dilution_factor) {
#extract summary data. 
file_paths <- list.files(raw_dir,
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

#join into one large table and select relevant columns.
summary_data <- bind_rows(summary_data, .id = "source") %>%
  dplyr::select("px_id", "week", "sample", "zero_norm", "pred_conc", "sample_flag")

#correct the predicted conc.
summary_data <- summary_data %>%
  mutate(
    pred_conc = if_else(is.nan(pred_conc), 0, pred_conc),
    pred_conc = if_else(
      grepl("LPS", sample),
      dilution_factor * pred_conc,
      pred_conc
    )
  )

# calculate the mean and SD
#mean_data <- summary_data %>%
  #group_by(px_id, ,sample, week) %>%
  #summarise(mean_IL1B = mean(pred_conc),
   #         IL1B_sd = sd(pred_conc)) 

}
