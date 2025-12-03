
fit_4pl_curve <- function(summary_data, concentrations) {
  
  std_curve <- summary_data %>%
  filter(grepl("STD", sample)) %>%
  group_by(sample) %>%
  summarise(mean_od = mean(zero_norm),
            sd_od = sd(zero_norm)) %>%
  mutate(conc = config$std_concentrations)
  
  fit_4pl <- drm(mean_od ~ conc, data = std_curve, fct = LL.4())

  sample_conc <- ED(fit_4pl, summary_data$zero_norm, type = "absolute")
  
  max_OD <- filter(std_curve, sample == "STD_1")$mean_od

  summary_data <- summary_data %>%
    mutate(pred_conc = sample_conc[,1],
    sample_flag = zero_norm > max_OD)



  
}