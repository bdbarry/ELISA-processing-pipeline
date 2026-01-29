plot_4pl_fit <- function(summary_data, concentrations) {

#create a dataframe containting the avg for each of the std's
  std_curve <- summary_data %>%
  filter(grepl("STD", sample)) %>%
  group_by(sample) %>%
  summarise(mean_od = mean(zero_norm),
            sd_od = sd(zero_norm)) %>%
  mutate(conc = config$std_concentrations)
  
#fit the 4pl model to the data
  fit_4pl <- drm(mean_od ~ conc, data = std_curve, fct = LL.4())

}