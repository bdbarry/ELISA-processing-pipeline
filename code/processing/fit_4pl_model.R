
fit_4pl_model <- function(summary_data, concentrations) {

#create a dataframe containting the avg for each of the std's
  std_curve <- summary_data %>%
  filter(grepl("STD", sample)) %>%
  group_by(sample) %>%
  summarise(mean_od = mean(zero_norm),
            sd_od = sd(zero_norm)) %>%
  mutate(conc = config$std_concentrations)
  
#fit the 4pl model to the data
  fit_4pl <- drm(mean_od ~ conc, data = std_curve, fct = LL.4())

#interpolate from the STD curve
  sample_conc <- ED(fit_4pl, summary_data$zero_norm, type = "absolute")

#calculate the mean_od of the top STD
  max_OD <- filter(std_curve, sample == "STD_1")$mean_od

#create a summary data table containing the predicted concentration and a flag
#if the sample is too high. 
  summary_data <- summary_data %>%
    mutate(pred_conc = sample_conc[,1],
    sample_flag = zero_norm > max_OD)

}