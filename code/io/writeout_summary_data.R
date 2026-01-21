writeout_summary_data <- function(summary_data){
if (!dir.exists(config$summary_data_dir)) {
    dir.create(config$summary_data_dir, recursive = TRUE)
    }
write.csv(summary_data, config$summary_data_dir)    
}