plot_results <- function(summary_data, sample_type, sample_lookup){
  summary_data %>%
    filter(grepl(sample_type, sample)) %>%
    mutate(week_num = as.numeric(str_extract(week, "[0-9]+"))) %>%
    left_join(sample_lookup, by = "sample") %>%
    ggplot(aes(factor(conc), mean_IL1B, colour = px_id, group = px_id)) + 
    geom_errorbar(aes(
      ymin = mean_IL1B - IL1B_sd, ymax = mean_IL1B + IL1B_sd)
    ) +
    geom_point() +
    geom_line() +
    facet_grid(~ week_num)
}