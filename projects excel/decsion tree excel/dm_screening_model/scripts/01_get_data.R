# 01_get_data.R
# Downloads NHANES August 2021–August 2023 files, then:
#   1. downloads the XPT files
#   2. saves clean CSVs (missing values = blank, not "NA")
#   3. writes a data dictionary (variable names + labels)
#
# Run from an RStudio Project so all paths land inside the project folder.

# install.packages("haven")  # first time only
library(haven)

files   <- c("DEMO_L", "DIQ_L", "BMX_L", "GHB_L", "GLU_L", "BPXO_L")
base    <- "https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/2021/DataFiles/"
raw_dir <- "data/raw"
dir.create(raw_dir, recursive = TRUE, showWarnings = FALSE)

dict <- list()

for (f in files) {
  # 1. Download the XPT file (skipped if already downloaded)
  xpt <- file.path(raw_dir, paste0(f, ".xpt"))
  if (!file.exists(xpt)) {
    download.file(paste0(base, f, ".xpt"), xpt, mode = "wb")
  }

  d <- read_xpt(xpt)

  # Save variable labels for the data dictionary
  dict[[f]] <- data.frame(
    file     = f,
    variable = names(d),
    label    = vapply(d, function(x) {
      l <- attr(x, "label")
      if (is.null(l)) "" else l
    }, character(1))
  )

  # 2. Clean CSV: missing values written as blank cells
  #    File names: DEMO_L -> demo.csv, GHB_L -> ghb.csv, etc.
  csv_name <- paste0(tolower(sub("_L$", "", f)), ".csv")
  write.csv(as.data.frame(zap_labels(d)), file.path(raw_dir, csv_name),
            row.names = FALSE, na = "")
}

# 3. Data dictionary for all files
write.csv(do.call(rbind, dict), "data/data_dictionary.csv", row.names = FALSE)

message("Done. Files saved in: ", normalizePath(raw_dir))
print(list.files(raw_dir))
