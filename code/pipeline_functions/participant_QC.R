participant_QC <- function(raw_dir){
    folders <- load_summary_folders(raw_dir)
for(folder in folders) {
   # load data 
  filename <- basename(folder)
  px_id <- str_extract(filename, "^[^_]+")
  processed_data <- load_summary_data(folder)

   # summarise stds
   std_data <- summarise_std(processed_data)

   #plot std curve
   std_curve <- plot_stdcurve(std_data)
   
   #save data
   QC_folder <- create_QC_folder(folder)
   std_table_path <- file.path(QC_folder, paste0(px_id, "_", "std.csv"))
   std_curve_path <- file.path(QC_folder, paste0(px_id, "_", "std_curve.png"))
   write.csv(std_data, std_table_path)
   ggsave(std_curve_path, std_curve)

}
}