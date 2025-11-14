process_all_plates <- function(config) {
  files <- list.files(config$raw_dir, pattern = "\\.csv$", full.names = TRUE)
  
  for (file_path in files) {
    # Step 1: Read
    plate <- read_plate(file_path, config$plate_layout_path)
    
    # Step 2: Clean
    clean_data <- clean_plate_data(plate$raw_data, plate$plate_layout)
    
    # Step 3: Summarize
    summary_data <- summarise_plate(clean_data, plate$px_id, plate$week)
    
    # Step 4: 4PL fit
    summary_data <- fit_4pl_curve(summary_data, config$concentrations)
    
    # Step 5: Write output
    out_file <- file.path(config$processed_dir, paste0(plate$px_id, "_", plate$week, "_summary.csv"))
    write_csv(summary_data, out_file)
  }
}