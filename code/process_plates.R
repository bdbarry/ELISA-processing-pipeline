process_all_plates <- function(config) {
  files <- list.files(config$main_dir,
   pattern = "\\.csv$",
   recursive = TRUE,
   full.names = TRUE)
  files <- files[grep("data/raw", files)]
  
  for (file_path in files) {
    # load data
    plate <- read_plate(file_path, config$plate_layout_path)
    
    # transform and normalise data
    clean_data <- clean_plate_data(plate$raw_data, plate$plate_layout)
    
    # summarize data
    summary_data <- summarise_plate(clean_data, plate$px_id, plate$week)
    
    # fit 4PL
    summary_data <- fit_4pl_curve(summary_data, config$concentrations)

    # write summary output
    out_file <- file.path(config$processed_dir, paste0(plate$px_id, "_", plate$week, "_summary.csv"))
    write_csv(summary_data, out_file)

  }
  
  # return compiled data for all timepoints
  summary_df <- load_summary(config)

  # return the data for std curves
  plot_stdcurve(summary_df)

  #merge all date into one file
  summary_df <- summarise_data(config)
}