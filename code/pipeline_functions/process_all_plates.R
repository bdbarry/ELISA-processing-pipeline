process_all_plates <- function(raw_dir, plate_layout_path) {
files <- get_raw_filepaths(raw_dir)
  for (file_path in files) {
    # load data
    plate <- load_raw_data(file_path, plate_layout_path)
    
    # transform and normalise data
    clean_plate_data <- clean_plate_data(plate$raw_data, plate$plate_layout)
    
    # summarize data
    normalised_plate_data <- normalise_plate_data(clean_plate_data, plate$px_id, plate$week)
    
    # fit 4PL
    interpolated_plate_data <- fit_4pl_model(normalised_plate_data, config$concentrations)

    # write summary output
    processed_folder <- create_processed_folder(file_path)
    processed_file <- file.path(processed_folder, paste0(plate$px_id, "_", plate$week, "_summary.csv"))
    write_csv(interpolated_plate_data, processed_file)
  }
  
}