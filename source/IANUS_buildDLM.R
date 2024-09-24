IANUS_buildDLM <- function(keywords, data_dir = "data/keywordToDLM.csv")
{
  # Assign *Data Lifecycle Management* phase based on content keywords (Inhalte)
  
  dlm_phases <- c("Data creation", "Data processing and storage", "Data usage", "Data archiving", "Data destruction")
  
  keywordToDLM <- read.csv(data_dir)
  
  DLM <- as.list(rep(NA, length(keywords)))
  for (i in 1:length(keywords))
  {
    keywordSet <- keywords[[i]]
    if (!any(is.na(keywordSet)))
    {
      DLMset <- c()
      for (keyword in keywordSet)
      {
        DLMselection <- dlm_phases[keywordToDLM[keywordToDLM$IANUS.Inhalte == keyword, -1] == "x"]
        
        DLMset <- c(DLMset, DLMselection)
      }
      
      DLM[[i]] <- unique(DLMset)
    }
  }
  
  return(DLM)
}
