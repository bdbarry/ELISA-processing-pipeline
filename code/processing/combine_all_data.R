combine_all_data <- function(summary_data){
    
#join into one large table and select relevant columns.
summary_data <- bind_rows(summary_data, .id = "source") %>%
  dplyr::select("px_id", "week", "sample", "zero_norm", "pred_conc", "sample_flag")

#correct the predicted conc.
summary_data <- summary_data %>%
  mutate(pred_conc = case_when(is.na(pred_conc) ~ 0,
         .default = pred_conc)) %>%
  mutate(pred_conc = case_when(
    grepl("LPS", sample) ~ config$dilution_factor * pred_conc,
    .default = pred_conc)
    ) 
}