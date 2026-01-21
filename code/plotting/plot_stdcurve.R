plot_stdcurve <- function(summary_df){

data_out_file <- file.path(config$stdcurve_dir, "std_summary.csv")
fig_out_file <- file.path(config$figs_dir, "std_plot.png")

std_data <- summary_df %>%
filter((grepl("STD", sample))) %>%
  group_by(week, sample) %>%
  summarise(mean_od = mean(OD_corrected),
            mean_conc = mean(pred_conc),
            mean_conc_sd = sd(pred_conc), .groups = "drop")

write.csv(std_data, data_out_file)

std_fig <- std_data %>%
  ggplot(aes(mean_conc, mean_od, colour = factor(week))) +
  geom_point() +
  theme_classic() +
  labs(title = "Standard curve",
       x = "Predicted Concentration",
       y = "Mean OD")

ggsave(filename = fig_out_file, plot = std_fig)

return(std_data)
}