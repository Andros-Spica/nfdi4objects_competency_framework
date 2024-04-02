IANUS_catchKeywords <- function(ianus)
{
  # Initialize an empty list to store the results
  keyword_list <- list()
  
  # Iterate over each element in ianus$Inhalte
  for (content in ianus$Inhalte) {
    # Split the content by ", " and store the result
    keywords <- strsplit(content, ", ")
    
    # Split each element in the result by ","
    for (i in seq_along(keywords)) {
      keywords[[i]] <- unlist(strsplit(keywords[[i]], ","))
    }
    
    # remove "\n"
    for (i in seq_along(keywords)) {
      # Replace line breaks ("\n") with a space (" ") only if they are not adjacent to spaces, else replace with nothing ("").
      keywords[[i]] <- gsub("(\\S)-[\r\n](\\S)", "\\1-\\2", keywords[[i]])
      keywords[[i]] <- gsub("(\\S)[\r\n](\\S)", "\\1 \\2", keywords[[i]])
      keywords[[i]] <- gsub("[\r\n]", "", keywords[[i]])
      
      # Correct typos:
      keywords[[i]] <- gsub("Softwareund", "Software und", keywords[[i]])
      keywords[[i]] <- gsub("DigitaleDatenauswertung", "Digitale Datenauswertung", keywords[[i]])
    }
    
    keywords <- lapply(keywords, function(x) x[x != ""])
    
    # Append the processed keywords to the list
    keyword_list <- c(keyword_list, list(keywords))
  }
  
  keywords <- do.call(rbind, keyword_list)
  keywords <- as.data.frame(keywords)
  
  rownames(keywords) <- ianus$id
  
  return(keywords)
}
