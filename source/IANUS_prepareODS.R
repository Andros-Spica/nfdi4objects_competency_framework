library(readODS)
library(rjson)

IANUS_prepareOds <- function(fileName)
{
  dataframe <- read_ods(fileName)
  
  dataframe$id <- seq.int(nrow(dataframe))
  
  return(dataframe)
}
