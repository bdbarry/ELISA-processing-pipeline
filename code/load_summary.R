load_summary <- function(config){
    files <- list.files(config$processed_dir, pattern = "\\.csv$", full.names = TRUE)
    summary_data <- list()
    
    for(file_path in files){
        filename <- basename(file_path)
        px_wk <- str_extract(filename, "(Px[0-9]+)_wk[0-9]+")
        df <- read_csv(file_path)
        summary_data[[px_wk]] <- df
        }

summary_df <-  bind_rows(summary_data, .id = "source")

summary_df <- summary_df %>%
    mutate(across(where(is.numeric), ~ replace_na(.x, 0)),
         week = as.numeric(str_extract(week, "[0-9]+")))
}