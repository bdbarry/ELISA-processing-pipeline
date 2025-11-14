clean_plate_data <- function(raw_data, plate_layout) {
  
od450_start <- which(grepl("Raw Data \\(450", raw_data[[2]])) +1 
od450_end <- od450_start + 8

od570_start <- which(grepl("Raw Data \\(570", raw_data[[2]])) +1 
od570_end <- od570_start + 8

#select and rearrange the 450 values
nm450reads <- raw_data[od450_start:od450_end, 1:13]
colnames(nm450reads) <- nm450reads[1,]
nm450reads <- nm450reads[-1,]
colnames(nm450reads)[1] <- "Row"

nm450reads <- nm450reads %>%
  mutate(across(-Row, ~as.numeric(.))) %>%
  pivot_longer(cols = -Row,
               names_to =  "column",
               values_to = "OD450") %>%
  mutate(well = paste0(Row, column))

#select and rearrange the 570 values
nm570reads <- raw_data[od570_start:od570_end, 1:13]
colnames(nm570reads) <- nm570reads[1,]
nm570reads <- nm570reads[-1,]
colnames(nm570reads)[1] <- "Row"

nm570reads <- nm570reads %>%
  mutate(across(-Row, ~as.numeric(.))) %>%
  pivot_longer(cols = -Row,
               names_to =  "column",
               values_to = "OD570") %>%
  mutate(well = paste0(Row, column))

#format plate layout
colnames(plate_layout) <- c(1:12)
plate_layout$Row <- LETTERS[1:8]
plate_layout <- pivot_longer(plate_layout, 
                             cols = 1:12,
                             names_to = "column",
                             values_to = "sample") %>%
  mutate(well = paste0(Row, column))


# Merge OD data and plate layout
clean_data <- full_join(nm450reads, nm570reads, by = c("well", "Row", "column")) %>%
  left_join(plate_layout, by = c("well", "Row", "column"))
  
  clean_data
}