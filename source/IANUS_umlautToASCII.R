IANUS_umlautToASCII <- function(aCharacterValue)
{
  aCharacterValue <- stringi::stri_trans_general(aCharacterValue, "de-ASCII; Latin-ASCII")
  
  return(aCharacterValue)
}
