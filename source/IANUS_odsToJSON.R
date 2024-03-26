library(readODS)
library(rjson)

IANUS_prepareOds <- function(fileName)
{
  dataframe <- read_ods(fileName)
  
  dataframe$id <- seq.int(nrow(dataframe))
  
  return(dataframe)
}

IANUS_toJSON <- function(dataframe, directory, order.by = "Stadt")
{
  dir.create(file.path(".", directory), showWarnings = FALSE)
  
  for (i in 1:nrow(dataframe))
  {
    id <- dataframe[i, "id"]
    einrichtung <- dataframe[i, order.by]
    
    if (length(einrichtung) == 0) {
      einrichtung <- "0_"
    }
    
    dir.create(file.path(".", directory, einrichtung), showWarnings = FALSE)
    
    filePath <- file.path(".", directory, einrichtung, paste0(id, ".json"))
    
    courseJSON <- toJSON(dataframe[i, ])
    
    write(courseJSON, file = filePath)
  }
}
