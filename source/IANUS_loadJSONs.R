library(jsonlite)

IANUS_loadJSONs <- function(directory)
{
  fileNames <- list.files(path = file.path(".", directory, "/"), pattern = "*.json", recursive = TRUE)
  fileNames <- paste0("./", directory, "/", fileNames)
  
  ianus_json <- lapply(fileNames, fromJSON, flatten = TRUE)
  
  ianus_dataframe <- do.call("rbind", ianus_json)
  
  return(ianus_dataframe)
}
