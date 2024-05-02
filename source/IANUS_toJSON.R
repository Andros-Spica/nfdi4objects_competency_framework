source("source/IANUS_umlautToASCII.R")

IANUS_toJSON <- function(dataframe, directory, order.by = "Stadt")
{
  dir.create(file.path(".", directory), showWarnings = FALSE)
  
  for (i in 1:nrow(dataframe))
  {
    id <- dataframe[i, "id"]
    einrichtung <- dataframe[i, order.by]
    einrichtung <- IANUS_umlautToASCII(einrichtung)
    
    if (length(einrichtung) == 0) {
      einrichtung <- "0_"
    }
    
    dir.create(file.path(".", directory, einrichtung), showWarnings = FALSE)
    
    filePath <- file.path(".", directory, einrichtung, paste0(id, ".json"))
    
    dataframe_row <- dataframe[i, ]
    
    # Write the JSON to file using write_json() function
    jsonlite::write_json(dataframe_row, filePath, na = "null")
  }
}
