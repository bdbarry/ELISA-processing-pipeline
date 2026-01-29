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


    # save 4PL plot (base R)
    fit_4pl <- plot_4pl_fit(processed_data, config$concentrations)
    pl4_path <- file.path(QC_folder, paste0(px_id, "_4pl_fit.png"))
    png(filename = pl4_path, width = 800, height = 600, res = 150)
    plot(fit_4pl, main = paste0("4PL Fit: ", px_id))
    dev.off()

}
}