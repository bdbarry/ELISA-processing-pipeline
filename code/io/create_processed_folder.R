create_processed_folder <- function(file_path) {
  processed_folder <- sub("data/raw/", "data/processed/", file_path)
  processed_folder <- sub("(/processed).*", "\\1", processed_folder)
if (!dir.exists(processed_folder)) {
    dir.create(processed_folder, recursive = TRUE, showWarnings = FALSE)
    }
processed_folder
}