write_summary_folder <- function(raw_dir){
    summary_folder <- sub("IL1B_ELISA/raw", "IL1B_ELISA/processed", raw_dir)
if (!dir.exists(summary_folder)) {
    dir.create(summary_folder, recursive = TRUE)
    }  
summary_folder
}