return_full_data_summary <- function(raw_dir, dilution_factor){
    summarised_data <- summarise_data(raw_dir, dilution_factor)
    summary_folder <- write_summary_folder(raw_dir)
    processed_file_path <- file.path(summary_folder, paste("summary_data.csv"))
    write.csv(summarised_data, processed_file_path)

}