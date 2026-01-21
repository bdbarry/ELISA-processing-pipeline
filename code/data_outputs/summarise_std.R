summarise_std <- function(processed_data){
std_data <- processed_data %>%
filter((grepl("STD", sample))) %>%
  group_by(week, sample) %>%
  summarise(mean_od = mean(zero_norm),
            mean_conc = mean(pred_conc),
            mean_conc_sd = sd(pred_conc), .groups = "drop")
}
