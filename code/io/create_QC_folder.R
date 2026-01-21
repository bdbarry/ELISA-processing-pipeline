create_QC_folder <- function(folder){
        QC_folder <- file.path(folder, paste0("data/processed/QC"))
            if(!dir.exists(QC_folder)) {
                dir.create(QC_folder, recursive = TRUE, showWarnings = FALSE)}
QC_folder
}