create_processed_folder <- function(file_path) {
  out_folder <- sub("data/raw/", "data/processed/", file_path)
  out_folder <- sub("(/processed).*", "\\1", out_folder)

if (!dir.exists(out_folder)) {
    dir.create(out_folder, recursive = TRUE, showWarnings = FALSE)
    }
out_folder   
}