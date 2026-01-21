process_all_plates <- function(config) {
  files <- list.files(config$raw_dir,
   pattern = "\\.csv$",
   recursive = TRUE,
   full.names = TRUE)
  files <- files[grep("data/raw", files)]
  for (file_path in files) {
    # load data
    plate <- load_raw_data(file_path, config$plate_layout_path)
    
    # transform and normalise data
    clean_plate_data <- clean_plate_data(plate$raw_data, plate$plate_layout)
    
    # summarize data
    normalised_plate_data <- normalise_plate_data(clean_plate_data, plate$px_id, plate$week)
    
    # fit 4PL
    interpolated_plate_data <- fit_4pl_model(normalised_plate_data, config$concentrations)

    # write summary output
    out_folder <- create_processed_folder(file_path)
    out_file <- file.path(out_folder, paste0(plate$px_id, "_", plate$week, "_summary.csv"))
    write_csv(interpolated_plate_data, out_file)

  }
  
  # return compiled data for all timepoints
  #summary_df <- load_summary_data(config$raw_dir)
  #summary_df <- combine_all_data(summary_df)
  #writeout_summary_data(summary_df)

  # return the data for std curves
  #plot_stdcurve(summary_df)

  #merge all date into one file
  #summary_df <- summarise_data(config)

  #plot figures
  
}