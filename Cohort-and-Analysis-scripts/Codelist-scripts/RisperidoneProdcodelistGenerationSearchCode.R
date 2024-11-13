################################################################################
##Prodcode lists for Pancreatic Enzyme Replacement therapy

.libPaths("C:/Users/rh530/OneDrive - University of Exeter/R/win-library/4.1")

library(readr) 
library(tidyverse) 
install.packages("vroom")
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
rm(list=ls())

#Load product dictionary
CPRDAurumProduct <- read_delim("CPRDAurumProduct.txt", 
                               "\t", escape_double = FALSE, col_types = cols(ProdCodeId = col_character(), dmdid = col_character(),Release = col_character()),trim_ws = TRUE) %>%
  rename(Term.from.EMIS = 'Term from EMIS')

###############################################################################################################################
################################# risperidone #################################################################################


#Define terms to search (you will probably want something to inform this e.g. a read code list)
terms =str_to_lower(c("risperidone", "Risperdal", "Okedi", "Perseris", "Rykindo", "Uzedy", "risperidal", "risp consta", "risperdal consta", "risperdol consta", "risperidal consta", "risperidone consta", "risperlet", "Risperdal M-Tab",  "Zepidone" ))
print(terms)
#Search for these terms in the prodcode dictionary, select relevant columns and find distinct prodcodes
prodcodelist <- CPRDAurumProduct[grep(paste(terms, collapse='|'),CPRDAurumProduct$Term.from.EMIS, ignore.case=TRUE),]
prodcodelist <- prodcodelist %>% select(ProdCodeId, dmdid, Term = Term.from.EMIS) %>% distinct(ProdCodeId, .keep_all = TRUE)



#Save as csv file
prodcodelist$ProdCodeId <- paste0(prodcodelist$ProdCodeId, "#")
prodcodelist$dmdid <- paste0(prodcodelist$dmdid, "#")
#Save as text file
write.table (prodcodelist, "RisperidoneCodelist.txt", quote=FALSE, sep = "\t", row.names=FALSE, col.names=TRUE)
write_csv(prodcodelist, "RisperidoneCodelist.csv")
view(prodcodelist)



