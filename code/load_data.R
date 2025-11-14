read_plate <- function(file_path, plate_layout_path) {
  filename <- basename(file_path)
  px_id <- str_extract(filename, "^[^_]+")
  week <- str_extract(filename, "(?<=_)wk[0-9]+")
  
  raw_data <- read_csv(file_path, col_names = FALSE)
  plate_layout <- read_excel(plate_layout_path, col_names = FALSE)
  
  list(
    raw_data = raw_data,
    plate_layout = plate_layout,
    px_id = px_id,
    week = week
  )
}