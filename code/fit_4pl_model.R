
fit_4pl_curve <- function(summary_data, concentrations) {
  std_curve <- summary_data %>%
  filter(grepl("STD", sample)) %>%
  group_by(sample) %>%
  summarise(mean_od = mean(zero_norm),
            sd_od = sd(zero_norm)) %>%
  mutate(conc = config$concentrations)

print(std_curve)
str(std_curve$conc)
  
  fit_4pl <- drm(mean_od ~ conc, data = std_curve, fct = LL.4())

  sample_conc <- ED(fit_4pl, summary_data$zero_norm, type = "absolute")
  
  summary_data <- summary_data %>%
    mutate(pred_conc = sample_conc[,1])
  
  summary_data <- summary_data %>%
    group_by(sample) %>%
    summarise(mean_conc = mean(pred_conc),
              sd_conc = sd(pred_conc))
    
  summary_data
}