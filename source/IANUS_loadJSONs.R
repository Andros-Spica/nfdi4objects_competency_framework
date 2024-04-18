library(jsonlite)

IANUS_loadJSONs <- function(directory)
{
  fileNames <- list.files(path = file.path(".", directory, "/"), pattern = "*.json", recursive = TRUE)
  fileNames <- paste0("./", directory, "/", fileNames)
  
  ianus_json <- lapply(fileNames, fromJSON, flatten = FALSE)
  
  ianus_field_names <- sort(unique(unlist(lapply(ianus_json, names))))
  
  # replace special characters with "." (to match the default behaviour in data frame names)
  ianus_field_names <- gsub("/", ".", ianus_field_names)
  
  ianus_dataframe <- setNames(data.frame(matrix(ncol = length(ianus_field_names), nrow = 0)), ianus_field_names)
  
  for (jsonfile in ianus_json)
  {
    rowData <- c()
    for (field_name in ianus_field_names)
    {
      fieldData <- NA
      if (field_name %in% names(jsonfile))
      {
        fieldData <- jsonfile[field_name]
      }
      rowData[field_name] <- fieldData
    }
    
    ianus_dataframe <- rbind(ianus_dataframe, rowData)
    
  }
  
  return(ianus_dataframe)
}
