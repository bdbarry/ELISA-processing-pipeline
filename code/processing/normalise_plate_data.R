
normalise_plate_data <- function(clean_data, px_id, week) {

  summary_data <- clean_data %>%
    mutate(OD_corrected = OD450 - OD570, 
           px_id = px_id,
           week = week)
  
  bkgd <- summary_data %>%
    filter(sample == "STD_8") %>%
    summarise(mean_OD = mean(OD_corrected, na.rm = TRUE)) %>%
    as.numeric()
  
  summary_data <- summary_data %>%
    mutate(zero_norm = pmax(OD_corrected - bkgd, 0))
}