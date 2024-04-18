IANUS_catchKeywords <- function(ianus)
{
  # Initialize an empty list to store the results
  keyword_list <- list()
  
  # Iterate over each element in ianus$Inhalte
  for (i in 1:nrow(ianus)) {
    
    content <- ianus$Inhalte[i]
    
    # Split the content by ", " and store the result
    keywords <- strsplit(content, ", ")
    
    # Split each element in the result by ","
    for (j in seq_along(keywords)) {
      keywords[[j]] <- unlist(strsplit(keywords[[j]], ","))
    }
    
    # remove "\n"
    for (j in seq_along(keywords)) {
      # Replace line breaks ("\n") with a space (" ") only if they are not adjacent to spaces, else replace with nothing ("").
      keywords[[j]] <- gsub("(\\S)-[\r\n](\\S)", "\\1-\\2", keywords[[j]])
      keywords[[j]] <- gsub("(\\S)[\r\n](\\S)", "\\1 \\2", keywords[[j]])
      keywords[[j]] <- gsub("[\r\n]", "", keywords[[j]])
      
      # Correct typos:
      keywords[[j]] <- gsub("Softwareund", "Software und", keywords[[j]])
      keywords[[j]] <- gsub("DigitaleDatenauswertung", "Digitale Datenauswertung", keywords[[j]])
    }
    
    keywords <- sapply(keywords, function(x) x[x != ""])
    
    # Append the processed keywords to the list
    keyword_list[[i]] <- keywords
  }
  
  return(keyword_list)
}
