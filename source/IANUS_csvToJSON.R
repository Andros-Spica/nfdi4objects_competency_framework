library(rjson)

IANUS_csvToJSON <- function(fileName, directory, order.by = "Einrichtung")
{
  LV <- read.csv(fileName)
  
  LV$id <- seq.int(nrow(LV))
  
  dir.create(file.path(".", directory), showWarnings = FALSE)
  
  for (i in 1:nrow(LV))
  {
    id <- LV[i, "id"]
    einrichtung <- LV[i, order.by]
    
    if (length(einrichtung) == 0) {
      einrichtung <- "0_"
    }
    print(file.path(".", directory, einrichtung))
    dir.create(file.path(".", directory, einrichtung), showWarnings = FALSE)
    
    filePath <- file.path(".", directory, einrichtung, paste0(id, ".json"))
    
    courseJSON <- toJSON(LV[i, ])
    
    write(courseJSON, file = filePath)
  }
}
